<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoLink from 'siskom/components/commons/JoLink.svelte';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import formatPeriode from 'siskom/commons/formatPeriode.js';
  import formatScheduleDayTime from 'siskom/commons/formatScheduleDayTime.js';

  const GQL_Required = gql`
    query ScheduleRequired {
      allPeriodes {
        nodes {
          id
          tahun
          semester
        }
      }
      currentSetting {
        currentPeriode {
          id
        }
      }
    }
  `;

  const GQL_Kelas = gql`
    query ListKelas($keyword: String!, $idPeriode: Int!, $first: Int!, $after: Cursor) {
      kelas: filteredKelas(_idPeriode: $idPeriode, _keyword: $keyword, first: $first, after: $after) {
        edges {
          cursor
          node {
            id
            idPeriode
            label
            idMk
            nodeId
            mk: mataKuliahByIdMk {
              id
              scheduled
              nama
              kode
              tipeMk
              scheduled
            }
            schedule: scheduledKelaByIdKelas {
              hariKul
              kapasitas
              ruangan
              totalMenit
              waktuKul
              dosen: dosenByIdDosen {
                nama
                nip
                id
              }
            }
          }
        }
      }
    }
  `;

  const first = 5;

  let networkStatus = 'loading';
  let items = [];
  let optionsPeriode = [];
  let idPeriode = null;
  let after = null;
  let keyword = '';

  function getRequired () {
    networkStatus = 'loading';
    apolloClient.query({
      query: GQL_Required
    })
      .then(result => {
        optionsPeriode = result.data.allPeriodes.nodes.map(it => {
          return {
            label: formatPeriode(it),
            value: it.id
          }
        })
        idPeriode = result.data.currentSetting.currentPeriode.id;
        networkStatus = 'success';
      })
      .catch(err => {
        networkStatus = 'error';
        console.log(err);
      })
  }

  function getKelas ({ idPeriode, keyword, first, after }) {
    return apolloClient.query({
      query: GQL_Kelas,
      variables: {
        first,
        idPeriode,
        after,
        keyword
      }
    })
      .then(result => {
        const { kelas } = result.data;
        return kelas.edges.map(e => {
          if (!e.node.mk.scheduled) return e;

          const _schedule = formatScheduleDayTime({
            hari: e.node.schedule.hariKul,
            jam: e.node.schedule.waktuKul,
            totalMenit: e.node.schedule.totalMenit
          });
          return {
            ...e,
            _schedule
          }
        });
      })
  }

  function reload ({ idPeriode, keyword }) {
    if (!idPeriode) return;
    networkStatus = 'loading';
    getKelas({ keyword, idPeriode, first, after: null })
      .then(_items => {
        items = _items;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      });
  }

  function loadNext ({ after }) {
    if (!after) return;
    networkStatus = 'loading';
    getKelas({ idPeriode, first, after, keyword })
      .then(_items => {
        items = [ ...items, ..._items ];
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      }); 
  }

  function onDetail (id) {
    pushRoute(`/dosen/detail-kelas/${id}`);
  }

  onMount(getRequired);

  $: reload ({ idPeriode, keyword });
  $: loadNext ({ after });
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="px-6 py-4 border-b border-gray-300 bg-gray-100 flex flex-col items-center justify-center">
      <div class="text-lg text-center font-semibold">Daftar Kelas</div>
      <div class="flex items-center justify-center flex-wrap">
        <JoSelect label="periode" cls="my-2" bind:value={idPeriode} options={optionsPeriode} />
        <JoInput cls="my-2" bind:value={keyword} placeholder="keyword.." />
      </div>
    </div>
    <section class="my-6 mx-6">
      <ul>
        {#each items as item (item.cursor)}
          <li 
            class="border-b border-gray-300 py-4 flex items-center text-sm"
          >
            <div>
              <div class="font-semibold">
                <a href={`/#/dosen/detail-mk/${item.node.mk.id}`} class="underline">
                  {item.node.mk.nama}
                </a> 
                <a href={`/#/dosen/detail-kelas/${item.node.id}`} class="ml-2 underline">
                  kelas {item.node.label}
                </a> 
              </div>
              <div class="text-xs">{item.node.mk.tipeMk.toLowerCase()} {item.node.mk.kode}</div>
              {#if item.node.mk.scheduled}
                <div class="text-xs">{item._schedule} {item.node.schedule.ruangan}</div>
              {/if}
            </div>
          </li>
        {/each}
      </ul>
      <JoButton
        action={() => {
          if (!items.length) return;
          const n = items.length;
          const it = items[n - 1];
          after = it.cursor;
        }}
        label="selanjutnya"
      />
    </section>
  </div>
</JoAsyncContent>
