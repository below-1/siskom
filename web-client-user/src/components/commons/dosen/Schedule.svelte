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
        let raws = [];
        result.data.schedule.nodes.forEach(it => {
          const _schedule = formatScheduleDayTime({
            hari: it.hariKul,
            jam: it.waktuKul,
            totalMenit: it.totalMenit
          });
          const [ day, ..._withoutDay ] = _schedule.split(',')
          const result = {
            _schedule: _withoutDay.join(','),
            ...it
          }
          for (let i = 0; i < raws.length; i++) {
            let raw = raws[i];
            if (raw.hariKul > result.hariKul) {
              raws.splice(i, 0, result);
              return;
            }
          }
          raws.push(result);
        });
        items = [];
        raws.forEach(item => {
          if (items.length == 0) {
            // if empty list, push day of this item
            const itemDay = formatDay(item.hariKul);
            items.push({
              separator: true,
              text: itemDay,
              nodeId: itemDay // fake id for iteration key
            })
            items.push(item);
            return;
          }
          // if day of last item is different from current item,
          // add separator
          const n = items.length;
          const prevItem = items[n - 1];
          const prevItemDay = formatDay(prevItem.hariKul);
          const currentItemDay = formatDay(item.hariKul);
          if (prevItemDay != currentItemDay) {
            items.push({
              separator: true,
              text: currentItemDay,
              nodeId: currentItemDay // fake id for iteration key
            })
          }
          items.push(item);
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
      {#each items as item (item.nodeId)}
        {#if item.separator}
          <li class="font-bold mt-8 text-2xl">{item.text}</li>
        {:else}
          <li class="p-4 border-b-2 border-dashed border-gray-400 w-full">
            <div class="flex">
              <div class="flex flex-col">
                <div class="text-lg">
                  <a href={`/#/app/ilkom/mks/${item.kelas.mk.id}`} class="font-bold underline mr-4">{item.kelas.mk.nama}</a>
                  <a class="mr-4 font-semibold underline" href={`/#/app/ilkom/kelas/${item.kelas.id}/schedule`}>kelas {item.kelas.label}</a>, 
                </div>
                <div>{item._schedule}, {item.ruangan}</div>
              </div>
            </div>
          </li>
        {/if}
      {/each}
    </ul>
  </div>
</JoAsyncContent>
