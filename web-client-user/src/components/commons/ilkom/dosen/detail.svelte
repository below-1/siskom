<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import formatScheduleDayTime from 'siskom/commons/formatScheduleDayTime.js';

  export let params = {};
  let networkStatus = 'loading';
  let dosen = null;
  let schedules = [];
  let totalSchedules = 0;
  let takeSchedule = 5;
  let idPeriode = null;

  $: idDosen = params.id ? parseInt(params.id) : null;
  $: avatarUrl = !dosen ? undefined : `https://api.adorable.io/avatars/128/${dosen.nip}.png`;

  $: loadData({ idDosen, idPeriode, takeSchedule });

  const CurrentPeriodeGQL = gql`
    query CurrentPeriode {
      currentPeriode {
        akhir
        awal
        id
        semester
        tahun
      }
    }`;

  const DetailDosenGQL = gql`
    query DetailDosen($idDosen: Int!, $idPeriode: Int!, $takeSchedule: Int!) {
      dosen: dosenById (id: $idDosen) {
        nama
        nip
        status
        sex
      }
      schedule: kelasDosen (
        _idDosen: $idDosen
        _idPeriode: $idPeriode
        first: $takeSchedule
      ) {
        nodes {
          hariKul
          kapasitas
          ruangan
          totalMenit
          waktuKul
          kelas: kelaByIdKelas {
            id
            label
            mk: mataKuliahByIdMk {
              kode
              nama
              id
              tipeMk
              sks
            }
          }
        }
        totalCount
      }
    }
  `;

  async function loadPeriode () {
    let networkStatus = 'loading';
    try {
      const periodeResult = await apolloClient.query({
        query: CurrentPeriodeGQL
      });
      idPeriode = periodeResult.data.currentPeriode.id;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  async function loadData ({ idDosen, idPeriode, takeSchedule }) {
    if (!idDosen) return;
    if (!idPeriode) return;
    networkStatus = 'loading';
    try {
      const detailResult = await apolloClient.query({
        query: DetailDosenGQL,
        variables: {
          idDosen,
          idPeriode,
          takeSchedule
        }
      });
      dosen = detailResult.data.dosen;
      const schedule = detailResult.data.schedule;
      schedules = schedule.nodes.map(it => ({
        ...it,
        formatSchedule: formatScheduleDayTime({
          hari: it.hariKul,
          jam: it.waktuKul,
          totalMenit: it.totalMenit
        })
      }));
      totalSchedules = schedule.totalCount;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  onMount(loadPeriode);
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="p-4 text-center flex flex-col items-center justify-center border-b border-gray-400 bg-gray-100">
      <img src={avatarUrl} class="my-3 rounded-full" />
      <div class="font-semibold text-2xl">{dosen.nama}</div>
      <div class="font-semibold text-gray-700 text-sm">
        {dosen.nip}, 
        {dosen.sex.toLowerCase()}
        {#if dosen.status == 'AKTIF'}
          <span class="px-2 bg-green-600 text-white text-xs font-bold">aktif</span>
        {:else}
          <span class="px-2 bg-orange-600 text-white text-xs font-bold">inaktif</span>
        {/if}
      </div>
    </div>
    <div class="my-6">
      <div class="flex items-center justify-between py-3 border-b border-gray-300 px-4">
        <div class="font-semibold">Kelas Yang Diampu {dosen.nama}</div>
        <div>{totalSchedules}</div>
      </div>
      <ul>
        {#each schedules as item (item.kelas.id)}
          <li 
            class="py-3 px-4 border-b border-gray-300 w-full"
            on:click={() => {
              pushRoute('/mahasiswa/kelas/' + item.kelas.id)
            }}
          >
            <div class="flex items-center justify-between text-sm">
              <div class="flex flex-col flex-grow">
                <span class="font-semibold">{item.kelas.mk.nama}</span>
                <div class="text-sm">{item.kelas.mk.tipeMk.toLowerCase()} {item.kelas.mk.kode}, {item.kelas.mk.sks} sks</div>
                <div class="text-sm">{item.ruangan}, {item.formatSchedule}</div>
              </div>
              <div class="flex flex-col items-center w-12 text-xs bg-gray-200 p-2">
                <div class="flex-grow text-lg font-bold">{item.kapasitas}</div>
                <div class="bg-gray-200">peserta</div>
              </div>
            </div>
          </li>
        {/each}
      </ul>
    </div>
  </div>
</JoAsyncContent>
