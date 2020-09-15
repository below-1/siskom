<script>
  import { onMount } from 'svelte';
  import { push as pushRoute, location } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoAsyncContent,
    JoSelect,
    JoInput,
    JoButton,
    JoNameAvatar
  } from 'siskom-web-commons';

  let networkStatus = 'loading';
  let items = [];
  let first = 10;
  let tipeMk = null;
  let keyword = '';
  let optionsTipeMk = [
    { label: 'wajib', value: 'WAJIB' }, 
    { value: 'PILIHAN', label: 'pilihan'}, 
    { value: 'UMUM', label: 'umum' }
  ];

  $: after = (items && items.length > 0) ? items[items.length - 1].cursor : null;

  $: reload({ keyword, tipeMk });

  const MkGQL = gql`
    query MkList(
      $first: Int!
      $after: Cursor
      $keyword: String!
      $tipeMk: MkType
    ) {
      allMataKuliahs(
        first: $first
        after: $after
        filter: { 
          tipeMk: { 
            equalTo: $tipeMk
          },
          nama: { 
            likeInsensitive: $keyword
          } 
        }
      ) {
        edges {
          cursor
          node {
            id
            kode
            nama
            openIn
            scheduled
            sks
            tipeMk
          }
        }
      }
    }`;

  async function getMk ({ first, after, tipeMk, keyword }) {
    // if (!keyword) throw new Error(`keyword invalid [${keyword}]`);
    const result = await apolloClient.query({
      query: MkGQL,
      variables: {
        first,
        after,
        tipeMk,
        keyword: `${keyword}%`
      }
    });
    return result.data.allMataKuliahs.edges;
  }

  async function reload ({ tipeMk, keyword }) {
    networkStatus = 'loading';
    try {
      items = await getMk({ first, after: null, tipeMk, keyword });
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
    }
  }

  async function loadNext () {
    networkStatus = 'loading';
    try {
      let newItems = await getMk({ first, after, tipeMk, keyword });
      items = [...items, ...newItems];
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  onMount(async () => {
    await reload({ tipeMk, keyword });
  })
</script>

<div class="font-black text-3xl my-6">Daftar Mata Kuliah</div>
<div class="flex items-center flex-wrap my-6">
  <JoSelect 
    label="tipe mata kuliah" 
    cls="my-2 w-64 mr-2" 
    options={optionsTipeMk} 
    bind:value={tipeMk} 
    emptyLabel="semua"  />
  <JoInput cls="my-2" bind:value={keyword} placeholder="keyword.." />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">
    <ul>
      {#each items as mk (mk.cursor)}
        <li class="py-3 border-b border-gray-300 flex items-center">
          <JoNameAvatar name={mk.node.nama} size='base' cls='mr-4 w-12' />
          <div>
            <a href={"/#" + $location + '/' + mk.node.id} class="font-bold text-lg underline">{mk.node.nama}</a>
            <div>{mk.node.tipeMk.toLowerCase()} {mk.node.kode}, {mk.node.sks} sks</div>
          </div>
        </li>
      {/each}
    </ul>
    <JoButton 
      label="selanjutnya" 
      action={loadNext}
    />
  </div>
</JoAsyncContent>
