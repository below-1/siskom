<script>
  import { onMount, getContext } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoAsyncContent,
    JoSelect,
    formatPeriode,
    formatDay,
    formatScheduleDayTime,
    periode
  } from 'siskom-web-commons';
  import GQLAllPeriode from 'siskom-web-user/graphql/AllPeriode.js';
  import GQLDosenSchedule from 'siskom-web-user/graphql/DosenSchedule.js';
  import * as context_key from './context.js';

  const dosen = getContext(context_key.dosen);

  let items = [];
  let networkStatus = 'loading';
  let optionsPeriode = [];
  let selectedIdPeriode = null;

  $: defIdPeriode = $periode.id;
  $: idPeriode = !selectedIdPeriode ? defIdPeriode : selectedIdPeriode;
  $: idDosen = $dosen ? $dosen.id : null;

  $: getSchedules({ idPeriode, idDosen });

  onMount(getRequired);

  function getRequired () {
    networkStatus = 'loading';
    return apolloClient.query({
      query: GQLAllPeriode
    })
      .then(result => {
        optionsPeriode = result.data.allPeriodes.nodes.map(it => {
          return {
            label: formatPeriode(it),
            value: it.id
          }
        });
        networkStatus = 'success';
      })
      .catch(err => {
        networkStatus = 'error';
        console.log(err);
      })
  }

  function getSchedules ({ idDosen, idPeriode }) {
    apolloClient.query({
      query: GQLDosenSchedule,
      variables: {
        idPeriode,
        idDosen
      }
    })
      .then(result => {
        const raws = result.data.schedule.nodes.map(it => {
          const _schedule = formatScheduleDayTime({
            hari: it.hariKul,
            jam: it.waktuKul,
            totalMenit: it.totalMenit
          });
          const [ day, ..._withoutDay ] = _schedule.split(',')
          return {
            _schedule: _withoutDay.join(','),
            ...it
          }
        });
        items = [];
        raws.forEach(item => {
          const hari = formatDay(item.hariKul);
          let group = items.find(gr => gr.hari == hari);
          if (!group) {
            group = {
              hari,
              items: []
            };
            items.push(group);
          }
          group.items.push(item);
        });
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  }
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="my-6">
      <div class="font-black text-2xl">Jadwal Perkuliahan</div>
      <JoSelect 
        label="periode" 
        bind:value={selectedIdPeriode} 
        options={optionsPeriode} 
        cls="w-64"
      />
    </div>
    <ul class="my-4">
      {#each items as group (group.hari)}
        <li class="py-4 flex my-6">
          <div class="font-semibold w-16 ">{group.hari}</div>
          <ul class="ml-2 pl-2 border-l-2 border-teal-600">
            {#each group.items as item (item.nodeId)}
              <li class="pl-4 py-4 border-b border-gray-300 w-full">
                <div class="flex">
                  <div class="flex flex-col">
                    <a
                      href={`/#/app/ilkom/mks/${item.kelas.mk.id}`}
                      class="font-semibold underline"
                    >{item.kelas.mk.nama}</a>
                    <a
                      href={`/#/app/ilkom/kelas/${item.kelas.id}`}
                      class="font-semibold underline"
                    >kelas {item.kelas.label}</a>
                    <div class="text-sm">{item._schedule}, {item.ruangan}</div>
                  </div>
                </div>
              </li>
            {/each}
          </ul>
        </li>
      {/each}
    </ul>
  </div>
</JoAsyncContent>