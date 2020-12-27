<script>
	import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import FaRegCircle from 'svelte-icons/fa/FaRegCircle.svelte'
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import GQLKelasDetail from 'siskom-web-user/graphql/KelasDetail.js';
  import GQLKelasSchedule from 'siskom-web-user/graphql/KelasSchedule.js';
  import {
    formatScheduleDayTime
  } from 'siskom-web-commons';

  const ScheduleAndMk = gql`
    query ScheduleAndMk($idKelas: Int!, $idMk: Int!) {
      schedule: scheduledKelaByIdKelas(idKelas: $idKelas) {
        idKelas
        kapasitas
        hariKul
        totalMenit
        waktuKul
        ruangan
        dosen: dosenByIdDosen {
          id
          nama
          nip
          sex
          status
        }
      }
    }
  `

  export let kelas;
  export let passed = false;

  let networkStatus = 'loading';
  let schedule = null;
  let color = 'gray-600';
  $: id = kelas ? kelas.id : null;

  $: getKelasSchedule(id);

  async function getKelasSchedule (id) {
    if (!id) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLKelasSchedule,
        variables: {
          idKelas: id
        }
      });
      const sc = result.data.schedule;
      const formatted = formatScheduleDayTime({
        hari: sc.hariKul,
        jam: sc.waktuKul,
        totalMenit: sc.totalMenit
      })
      schedule = {
        ...sc,
        formatted
      };

      networkStatus = 'done';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  onMount(async () => {
    getKelasSchedule(id);
    if (passed) {
      color = 'green-600';
    }
  })
</script>

{#if networkStatus == 'done'}
  <div class="flex items-center py-4 border-b border-gray-300">
    <div 
      class={`mr-4 text-center p-1 rounded bg-${color} text-white`}
    >
      <div class="font-bold">{kelas.label}</div>
      <div class="text-xs font-bold">12/24 </div>
    </div>
    <div class="flex-grow">
      <div class="font-bold">{kelas.mk.nama}</div>
      {#if schedule}
        <div class="text-sm text-gray-800">
          <div class="font-medium">{schedule.formatted}</div>
          <div class="font-medium">{schedule.dosen.nama}</div>
        </div>
      {/if}
    </div>
    <div class="p-2">
      <button class="appearance-none w-6 h-6 text-gray-500">
        <FaRegCircle />
      </button>
    </div>
  </div>
{:else if networkStatus = 'loading'}
  <div class="">None</div>
{:else}
  <div>Error</div>
{/if}