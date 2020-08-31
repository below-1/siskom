<script>
  import { createEventDispatcher } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import {
    JoLink,
    JoInput,
    JoSelect,
    JoButton,
    JoDialog,
    JoAsyncContent
  } from 'siskom-web-commons';

  const dispatch = createEventDispatcher();
  const GQLCreate = gql`
    mutation CreatePrasyarat($payload: PrasyaratMkInput!) {
      createPrasyaratMk (input: {
        prasyaratMk: $payload
      }) {
        prasyaratMk {
          idParent
          idChild
        }
      }
    }
  `;

  const GQLFindMk = gql`
    query MkByKeyword ($keyword: String!, $idParent: Int!) {
      allMataKuliahs(first: 5, filter: {
        or: [
          { nama: { likeInsensitive: $keyword } },
          { kode: { likeInsensitive: $keyword } }
        ],
        id: {
          notEqualTo: $idParent
        }
      }) {
        nodes {
          id
          kode
          nama
          tipeMk
        }
      }
    }
  `;

  export let idParent;
  let networkStatus = 'loading';
  let keyword = '';
  let items = [];

  $: findMkByKeyword(keyword);

  function findMkByKeyword (keyword) {
    const variables = {
      keyword: keyword + '%',
      idParent
    }
    networkStatus = 'loading';
    return apolloClient.query({
      query: GQLFindMk,
      variables
    })
      .then(result => {
        items = result.data.allMataKuliahs.nodes;
        console.log(items);
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  }

  function onChoose (id) {
    networkStatus = 'loading';
    return apolloClient.mutate({
      mutation: GQLCreate,
      variables: {
        payload: {
          idParent,
          idChild: id
        }
      }
    })
      .then(result => {
        console.log(result);
        networkStatus = 'success';
        dispatch('done');
      })
      .catch(err => {
        networkStatus = 'error';
        console.log(err);
        alert('Gagal menambah data prasyarat');
      });
  }
</script>

<JoInput
  bind:value={keyword}
  placeholder="cari mata kuliah..."
/>
<JoAsyncContent
  {networkStatus}
>
  <ul slot="success" class="items-list">
    {#each items as mk (mk.id)}
      <li class="border-b border-gray-300 p-2 flex items-center justify-between">
        <div class="lowercase">
          <div class="text-sm font-medium">{mk.nama}</div>
          <div class="text-xs">{mk.kode}</div>
        </div>
        <JoButton
          cls="text-xs"
          action={() => onChoose(mk.id)}
          label="pilih"
        />
      </li>
    {/each}
  </ul>
</JoAsyncContent>
