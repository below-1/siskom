<script>
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoLink from 'siskom/components/commons/JoLink.svelte';

  export let params = {};
  $: id = params.id ? parseInt(params.id) : null;

  let networkStatus = 'loading';
  let item = null;
  let idDosen = null;

  $: showMembers = (idDosen && item && item.kelas) && item.kelas.schedule.idDosen == idDosen;

  const GQL_KelasById = gql`
    query DetailKelas($id: Int!) {
      kelas: kelaById(id: $id) {
        id
        idMk
        idPeriode
        label
        mk: mataKuliahByIdMk {
          id
          kode
          minSks
          nama
          nodeId
          openIn
          prefSchedule
          scheduled
          sks
          tipeMk
        }
        nodeId
        schedule: scheduledKelaByIdKelas {
          hariKul
          idKelas
          idDosen
          kapasitas
          nodeId
          ruangan
          totalMenit
          waktuKul
          dosen: dosenByIdDosen {
            id
            nama
            nip
            sex
          }
        }
        periode: periodeByIdPeriode {
          id
          semester
          tahun
        }
      }
      currentDosen {
        id
        nama
        nip
        nodeId
        sex
        status
      }
    }
  `;

  function getDetailKelas ({ id }) {
    if (!id) return;
    networkStatus = 'loading';
    return apolloClient.query({
      query: GQL_KelasById,
      variables: {
        id
      }
    })
      .then(result => {
        item = result.data.kelas;
        idDosen = result.data.currentDosen.id;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  }

  $: getDetailKelas({ id });
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="border-b border-gray-300 bg-gray-200 w-full py-4 text-center text-gray-800">
      <div class="text-lg font-semibold">{item.mk.nama}</div>
      <div class="text-sm">kelas {item.label}</div>
    </div>
    <ul class="mx-6">
      <li class="py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Mata Kuliah:</span>
        <span>{item.mk.nama}</span>
      </li>
      <li class="py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Tipe MK:</span>
        <span>{item.mk.tipeMk.toLowerCase()}</span>
      </li>
      <li class="py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Kode:</span>
        <span>{item.mk.kode}</span>
      </li>
      <li class="py-2 border-b border-gray-300 flex items-center justify-between">
        <span>SKS:</span>
        <span>{item.mk.sks}</span>
      </li>
      <li class="py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Periode:</span>
        <span>semester {item.periode.semester}, {item.periode.tahun}/{item.periode.tahun + 1}</span>
      </li>
      <li class="py-2 border-b border-gray-300 flex items-center justify-start font-bold">
        Dosen
      </li>
      {#if item.mk.scheduled}
        <li class="py-2 border-b border-gray-300 flex items-center justify-between">
          <span>Nama:</span>
          <span>{item.schedule.dosen.nama}</span>
        </li>
        <li class="py-2 border-b border-gray-300 flex items-center justify-between">
          <span>NIP:</span>
          <span>{item.schedule.dosen.nip}</span>
        </li>
        <li class="py-2 border-b border-gray-300 flex items-center justify-between">
          <span>jenis kelamin:</span>
          <span>{item.schedule.dosen.sex.toLowerCase()}</span>
        </li>
      {/if}
    </ul>
    <JoLink
      label="daftar mahasiswa" 
      to={`/#/dosen/anggota-kelas/${item.id}`}
      cls="mx-6 my-3"
    />
  </div>
</JoAsyncContent>