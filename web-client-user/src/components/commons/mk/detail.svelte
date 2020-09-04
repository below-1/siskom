<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoNameAvatar from 'siskom/components/commons/JoNameAvatar.svelte';

  // props
  export let idMk;

  // state
  let networkStatus = 'loading';
  let mk = null;
  let currentPeriode = null;

  // computed
  $: idPeriode = currentPeriode ? currentPeriode.id : null;

  // GQL
  const DetailMkGQL = gql`
    query DetailMk(
      $idMk: Int!
      $idPeriode: Int!
    ) {
      mk: mataKuliahById(id: $idMk) {
        id
        kode
        minSks
        nama
        openIn
        prefSchedule
        scheduled
        sks
        tipeMk
        prasyarat: prasyaratMksByIdParent {
          nodes {
            mk: mataKuliahByIdChild {
              id
              kode
              minSks
              nama
              tipeMk
              sks
              nodeId
            }
          }
        }
        kelas: kelasByIdMk(filter: {idPeriode: {equalTo: $idPeriode}}) {
          nodes {
            id
            label
            schedule: scheduledKelaByIdKelas {
              hariKul
              ruangan
              totalMenit
              waktuKul
              dosen: dosenByIdDosen {
                id
                nama
              }
            }
          }
        }
      }
    }
  `;

  const CurrentPeriodeGQL = gql`
    query CurrentPeriode {
      currentPeriode {
        id
        semester
        tahun
      }
    }
  `;

  async function loadDetailMk ({ idMk, idPeriode }) {
    if (!idMk) return;
    if (!idPeriode) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: DetailMkGQL,
        variables: {
          idMk,
          idPeriode
        }
      });
      console.log(result.data);
      mk = result.data.mk;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  async function loadCurrentPeriode () {
    const result = await apolloClient.query({
      query: CurrentPeriodeGQL
    });
    return result.data.currentPeriode;
  }

  $: loadDetailMk({ idMk, idPeriode });

  onMount(async () => {
    currentPeriode = await loadCurrentPeriode();
  });
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="bg-white p-4 flex items-center">
      <JoNameAvatar name={mk.nama} size='3xl' cls="mr-2" />
      <div>
        <div class="font-bold text-xl">{mk.nama}</div>
        <div class="text-sm">
          <span>{mk.tipeMk.toLowerCase()} </span>
          <span>{mk.kode}</span>
        </div>
      </div>
    </div>

    <div class="bg-white mt-2">
      <ul>
        <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
          <span>Mata Kuliah:</span>
          <span>{mk.nama}</span>
        </li>
        <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
          <span>Tipe MK:</span>
          <span>{mk.tipeMk.toLowerCase()}</span>
        </li>
        <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
          <span>Kode:</span>
          <span>{mk.kode}</span>
        </li>
        <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
          <span>SKS:</span>
          <span>{mk.sks}</span>
        </li>
      </ul>

      <h3 class="mt-6 font-semibold px-4">prasyarat</h3>
      {#if mk.prasyarat.nodes.length}
        <ul class="my-3">
          {#each mk.prasyarat.nodes as node (node.mk.nodeId)}
            <li class="py-2 border-b border-gray-300">
              <div>
                <a href={"/#/dosen/detail-mk/" + node.mk.id} class="font-semibold underline">{node.mk.nama}</a>
                <div class="text-sm">{node.mk.tipeMk.toLowerCase()} {node.mk.kode}, {node.mk.sks} sks</div>
              </div>
            </li>
          {/each}
        </ul>
      {:else}
        <div class="bg-gray-200 p-8 text-center font-bold my-2">
          Tidak Ada Prasyarat
        </div>
      {/if}

      <h3 class="mt-6 font-semibold px-4">kelas</h3>
      <ul>
        {#each mk.kelas.nodes as node (node.id)}
          <li class="py-2 border-b border-gray-300 px-4">
            <div>
              <div class="flex items-center">
                <a href={"/#/app/ilkom/kelas/" + node.id} class="font-semibold underline text-sm">
                  kelas {node.label}
                </a>

                {#if mk.scheduled}
                <a href={`/#/app/ilkom/dosens/${node.schedule.dosen.id}/info`} class="font-semibold underline text-sm ml-2">
                  {node.schedule.dosen.nama}
                </a>
                {/if}
              </div>
              {#if mk.scheduled}
                <div class="text-sm">{node.schedule.ruangan}</div>
              {/if}
            </div>
          </li>
        {/each}
      </ul>
    </div>


  </div>
</JoAsyncContent>
