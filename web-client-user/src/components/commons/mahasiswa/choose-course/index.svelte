<script>
	import { getContext } from 'svelte';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import { gql } from '@apollo/client/core';
  import {
    JoButton,
    JoLink,
    JoInput,
    JoSelect,
    JoNameAvatar,
    JoAsyncContent,
    periode,
    formatScheduleDayTime,
  } from 'siskom-web-commons';
  import GQLKelasInPeriode from 'siskom-web-user/graphql/KelasInPeriode.js';
  import GQLPassedMks from 'siskom-web-user/graphql/PassedMks.js';
  import GQLSchedulesByIds from 'siskom-web-user/graphql/SchedulesByIds.js';
  import * as context_key from '../context.js';
  import KelasFreeRow from './KelasFreeRow.svelte';

  const mahasiswa = getContext(context_key.mahasiswa);
  const attendedPeriode = getContext(context_key.attendedPeriode);

  $: idMahasiswa = $mahasiswa.id;
  $: idPeriode = $periode.id;

  let items = [];
  let choosenIds = [];
  let passedMkIds = [];
  let networkStatus = 'loading';
  let keyword = '';
  let take = 5;
  let after = null;

  const notes = [
    { color: 'blue-600', message: 'fresh' },
    { color: 'green-600', message: 'telah lulus' },
    { color: 'red-600', message: 'sebelumnya tidak lulus' },
    { color: 'yellow-600', message: 'tidak memenuhi prasyarat' }
  ]

  $: loadData({ idPeriode, idMahasiswa });
  $: filteredItems = items.slice(0, take);

  async function loadData ({ idPeriode, idMahasiswa }) {
    if (!idPeriode) return;
    if (!idMahasiswa) return;
    networkStatus = 'loading';
    try {
      const listKelasInPeriode = await getKelasInPeriode({ idPeriode });
      const listPassedMks = await getPassedMks({ idMahasiswa });
      let data = listKelasInPeriode.map(kelas => {
        let passed = listPassedMks.includes(kelas.mk.id);
        return {
          ...kelas,
          passed
        }
      });

      passedMkIds = listPassedMks;
      items = data;
      networkStatus = 'ready';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  async function getSchedulesByIds (ids) {
    if (!ids || !ids.length) {
      throw new Error('[ChooseCourse.getSchedulesByIds] invalid ids');
    }
    const schedules = await apolloClient.query({
      query: GQLSchedulesByIds,
      variables: {
        ids
      }
    });
    return schedules.data.allScheduledKelas.nodes;
  }

  async function getKelasInPeriode ({ idPeriode }) {
    if (!idPeriode) {
      throw new Error('[ChooseCourse.getKelasInPeriode] invalid idPeriode');
    }
    const kelasInPeriode = await apolloClient.query({
      query: GQLKelasInPeriode,
      variables: {
        idPeriode
      }
    });
    return kelasInPeriode.data.periodeById.kelas.nodes;
  }

  async function getPassedMks ({ idMahasiswa }) {
    if (!idMahasiswa) {
      throw new Error('[ChooseCourse.getPassedMks] invalid idMahasiswa');
    }
    const passedMks = await apolloClient.query({
      query: GQLPassedMks,
      variables: {
        id: idMahasiswa
      }
    })
    return passedMks.data.allMahasiswaKelas.nodes.map(it => it.kelas.idMk);
  }

  function loadMore () {
    if (take < items.length) {
      take += 5;
    }
  }
</script>

<div class="text-left text-3xl font-black my-6">Pilih Kelas</div>

<ul>
  {#each notes as note (note.color)}
    <li class="flex items-center mb-2">
      <div 
        class={`rounded-full w-6 h-6 mr-6 bg-${note.color}`}
      >
      </div>
      <div>
        {note.message}
      </div>
    </li>
  {/each}
</ul>

<div class="text-left text-xl font-bold mt-4 mb-2">Periode 2019/2020, Semester 1</div>

<JoAsyncContent {networkStatus}>
  <div slot="ready">

    <JoInput
      bind:value={keyword}
      placeholder="keyword..."
    />

    <div>
      {#each filteredItems as item (item.id)}
        <KelasFreeRow
          kelas={item}
          passed={item.passed}
        />
      {/each}
    </div>

    <div class="my-2 text-center">
      <JoButton
        label="more"
        cls="bg-gray-200 font-bold"
        action={loadMore}
      />
    </div>
  </div>
</JoAsyncContent>
