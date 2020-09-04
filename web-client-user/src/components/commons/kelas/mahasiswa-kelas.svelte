<script>
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import formatNilai from 'siskom/commons/formatNilai.js';

  export let idKelas;
  export let idMahasiswa;

  const DetailKelasGQL = gql`
    query DetailKelas($idKelas: Int!, $idMahasiswa: Int!) {
      detail: kelasOfMahasiswa(_idKelas: $idKelas, _idMhs: $idMahasiswa) {
        nilai
        kelas: kelaByIdKelas {
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
          periode: periodeByIdPeriode {
            id
            semester
            tahun
          }
          schedule: scheduledKelaByIdKelas {
            dosen: dosenByIdDosen {
              id
              nama
              nip
              sex
              status
            }
            hariKul
            kapasitas
            ruangan
            totalMenit
            waktuKul
          }
        }
      }
      attendedPeriode (_idMahasiswa: $idMahasiswa) {
        nodes {
          id
          tahun
          semester
        }
      }
    }
  `;

  async function getDetailKelas ({ idKelas, idMahasiswa }) {
    if (!idKelas) return;
    if (!idMahasiswa) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: DetailKelasGQL,
        variables: {
          idKelas,
          idMahasiswa
        }
      });
      item = result.data.detail;
      console.log(item);
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
    }
  }

  $: getDetailKelas({ idKelas, idMahasiswa });

  let networkStatus = 'loading';
  let item = {};
  let periode = null;
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="border-b border-gray-300 w-full py-4 text-center text-gray-700">
      <div class="font-semibold">{item.kelas.mk.nama}</div>
      <div class="text-sm">kelas {item.kelas.label}</div>
    </div>
    <ul class="w-full text-sm">
      <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between font-bold">
        <span>Nilai:</span>
        <span>{item.nilai} / {formatNilai(item.nilai).huruf}</span>
      </li>
      <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Mata Kuliah:</span>
        <span>{item.kelas.mk.nama}</span>
      </li>
      <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Tipe MK:</span>
        <span>{item.kelas.mk.tipeMk.toLowerCase()}</span>
      </li>
      <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Kode:</span>
        <span>{item.kelas.mk.kode}</span>
      </li>
      <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
        <span>SKS:</span>
        <span>{item.kelas.mk.sks}</span>
      </li>
      <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
        <span>Periode:</span>
        <span>semester {item.kelas.periode.semester}, {item.kelas.periode.tahun}/{item.kelas.periode.tahun + 1}</span>
      </li>
      <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-start font-bold">
        Dosen
      </li>
      {#if item.kelas.schedule}
        <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
          <span>Nama:</span>
          <span>{item.kelas.schedule.dosen.nama}</span>
        </li>
        <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
          <span>NIP:</span>
          <span>{item.kelas.schedule.dosen.nip}</span>
        </li>
        <li class="px-4 py-2 border-b border-gray-300 flex items-center justify-between">
          <span>jenis kelamin:</span>
          <span>{item.kelas.schedule.dosen.sex.toLowerCase()}</span>
        </li>
      {/if}
    </ul>
  </div>
</JoAsyncContent>
