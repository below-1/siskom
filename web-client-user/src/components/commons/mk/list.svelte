<script>
  import { onMount } from 'svelte';
  import { push as pushRoute, location } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoNameAvatar from 'siskom/components/commons/JoNameAvatar.svelte';

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

<div class="py-3 px-4 md:px-6 mb-2 bg-white">
  <div class="font-black text-xl">Daftar Mata Kuliah</div>
  <div class="flex items-center flex-wrap">
    <JoSelect label="tipe mata kuliah" cls="my-2" options={optionsTipeMk} bind:value={tipeMk} emptyLabel="semua" />
    <JoInput cls="my-2 mx-2" bind:value={keyword} placeholder="keyword.." />
  </div>
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success" class="bg-white">
    <ul class="w-full">
      {#each items as mk (mk.cursor)}
        <li class="py-2 px-4 md:px-6 border-b border-gray-300 flex items-center">
          <JoNameAvatar name={mk.node.nama} size='base' cls='mr-4 px-2 w-12' />
          <div>
            <a href={"/#" + $location + '/' + mk.node.id} class="font-bold underline">{mk.node.nama}</a>
            <div>{mk.node.tipeMk.toLowerCase()} {mk.node.kode}, {mk.node.sks} sks</div>
          </div>
        </li>
      {/each}
    </ul>
    <div class="flex justify-center items-center py-3">
      <JoButton 
        label="selanjutnya" 
        action={loadNext}
      />
    </div>
  </div>
</JoAsyncContent>
