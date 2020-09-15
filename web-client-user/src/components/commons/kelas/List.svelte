<script>
  import { onMount } from 'svelte';
  import { push as pushRoute, location } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoButton,
    JoLink,
    JoSelect,
    JoInput,
    JoAsyncContent,
    JoNameAvatar,
    formatPeriode,
    formatScheduleDayTime
  } from 'siskom-web-commons';

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

<div class="text-3xl font-black">Daftar Kelas</div>
<div class="flex flex-wrap items-center justify-start">
  <JoSelect 
    label="periode" 
    cls="my-2 mr-2 w-64" 
    bind:value={idPeriode} 
    options={optionsPeriode} 
  />
  <JoInput 
    cls="my-2" 
    bind:value={keyword} 
    placeholder="keyword.." 
  />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">
    <section class="my-2 bg-white">
      <ul>
        {#each items as item (item.cursor)}
          <li 
            class="border-b border-gray-300 py-4 flex items-center hover:bg-gray-100"
          >
            <JoNameAvatar name={item.node.mk.nama} size='base' cls='w-12 mr-4' />
            <div class="flex items-center flex-grow">

              <div class="md:w-1/2">

                <div class="font-bold text-base">
                  <a href={`/#/app/ilkom/mks/${item.node.mk.id}`} class="underline">
                    {item.node.mk.nama}
                  </a> 
                  <a href={`/#/app/ilkom/kelas/${item.node.id}`} class="ml-2 underline">
                    kelas {item.node.label}
                  </a> 
                </div>

                <div class="text-sm">{item.node.mk.tipeMk.toLowerCase()} {item.node.mk.kode}</div>

                {#if item.node.mk.scheduled}
                <div class="text-sm md:hidden">{item._schedule} {item.node.schedule.ruangan}</div>
                {/if}
              </div>

              {#if item.node.mk.scheduled}
              <div class="hidden md:block md:w-1/4 text-left">
                {item._schedule}
              </div>

              <div class="hidden md:block md:w-1/4 text-right">
                {item.node.schedule.ruangan}
              </div>
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
        cls="my-2 mx-4"
      />
    </section>
  </div>
</JoAsyncContent>
