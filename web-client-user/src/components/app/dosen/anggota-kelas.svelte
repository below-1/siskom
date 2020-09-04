<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';

  const GQL_AnggotaKelas = gql`
    query AnggotaKelas($id: Int!) {
      currentDosen {
        id
      }
      kelas: kelaById(id: $id) {
        id
        label
        periode: periodeByIdPeriode {
          semester
          tahun
        }
        anggota: mahasiswaKelasByIdKelas {
          total: totalCount
          nodes {
            nilai
            nodeId
            mahasiswa: mahasiswaByIdMhs {
              nama
              nim
              sex
              tahunMasuk
              status
            }
          }
        }
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
      }
    }
  `;

  export let params = {};
  $: id = params.id ? parseInt(params.id) : null;
  let networkStatus = 'loading';
  let item = null;
  let idDosen = null;
  let anggota = [];
  let mk = null;
  let label = null;
  let periode = null;
  let keyword = '';

  function avatarUrl (key) {
    return `https://api.adorable.io/avatars/24/${key}.png`
  }

  function getAnggotaKelas ({ id }) {
    if (!id) return;
    networkStatus = 'loading';
    apolloClient.query({
      query: GQL_AnggotaKelas,
      variables: {
        id
      }
    })
      .then(result => {
        const { data } = result;
        const { kelas, currentDosen } = data;
        idDosen = currentDosen.id;
        label = kelas.label;
        anggota = kelas.anggota.nodes;
        periode = kelas.periode;
        mk = kelas.mk;
        console.log(kelas);
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  }

  $: getAnggotaKelas({ id });
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="px-6 py-4 border-b border-gray-300 bg-gray-100">
      <div class="font-semibold text-lg text-center">{mk.nama}</div>
      <div class="font-semibold text-sm text-center">{label}, {periode.tahun}/{periode.tahun + 1} semester {periode.semester}</div>
    </div>
    <div class="mx-6">
      <div class="my-3 font-medium">total {anggota.length}</div>
      <JoInput cls="my-1" bind:value={keyword} placeholder="Keyword..." />
      <!-- {JSON.stringify(item.anggota.nodes)} -->
      <ul>
        {#each anggota as ang (ang.nodeId)}
          <li 
            class="py-3 border-b border-gray-300 w-full"
          >
            <div class="flex items-center text-sm">
              <div class="w-8 h-8 mr-3" style={`background: url(${avatarUrl(ang.mahasiswa.nim)})`}>
              </div>
              <div class="flex flex-col flex-grow">
                <span class="font-semibold">{ang.mahasiswa.nama}</span>
                <div class="text-xs">{ang.mahasiswa.nim}</div>
              </div>
              <button class="font-bold text-center px-2 bg-gray-100 appearance-none border border-gray-400 rounded">
                {ang.nilai.toFixed(2)}
              </button>
            </div>
          </li>
        {/each}
      </ul>
    </div>
  </div>
</JoAsyncContent>
