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
  import * as context_key from './context.js';
  import 'siskom-web-user/styles/jo-table.css';

  const mahasiswa = getContext(context_key.mahasiswa);
  const attendedPeriode = getContext(context_key.attendedPeriode);

  $: idMahasiswa = $mahasiswa.id;
  $: idPeriode = $periode.id;

  let items = [];
  let choosenIds = [];
  let passedMkIds = [];
  let networkStatus = 'loading';
  let keyword = '';

  $: loadData({ idPeriode, idMahasiswa });

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

      let listScheduledIds = data.map(kelas => kelas.mk.id);      
      const schedules = await getSchedulesByIds(listScheduledIds);
      data = data.map((kelas, index) => {
        const schedule = schedules[index];
        const formattedDayTime = formatScheduleDayTime({
          hari: schedule.hariKul,
          jam: schedule.waktuKul,
          totalMenit: schedule.totalMenit
        });
        console.log(formattedDayTime);
        return {
          ...kelas,
          schedule: {
            ...schedule,
            formattedDayTime
          }
        }
      })
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
        idMahasiswa
      }
    })
    console.log(passedMks)
    return passedMks.data.allMahasiswaKelas.nodes.map(it => it.kelas.idMk);
  }
</script>

<div class="text-left text-3xl font-black my-6">Pilih Kelas</div>
<div class="text-left text-xl font-bold my-3">Periode 2019/2020, Semester 1</div>

<JoAsyncContent {networkStatus}>
  <div slot="ready">

    <JoInput
      bind:value={keyword}
      placeholder="keyword..."
    />

    <table class="jo-table text-base">
      <tbody>
        {#each items as item (item.id)}
          <tr>
            <td class="hidden md:table-cell">
              
            </td>
            <td class="flex flex-col py-4 md:table-cell">
              <a
                href={`/#/app/ilkom/mks/${item.mk.id}`}
                class="font-black mr-4"
              >
                {item.mk.nama}
              </a>
              <a
                href={`/#/app/ilkom/kelas/${item.id}`}
                class="font-black md:hidden"
              >
                kelas {item.label}
              </a>
            </td>
            <td class="hidden md:table-cell">
              kelas {item.label}
            </td>
            <td class="hidden md:table-cell">
              {item.schedule.formattedDayTime}
            </td>
            <td class="hidden md:table-cell">
              {item.schedule.ruangan}
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
</JoAsyncContent>
