<script>
  import { onMount } from 'svelte';
  import { push as pushRoute, location } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoAsyncContent,
    JoInput
  } from 'siskom-web-commons';

  export let onDetail;

  const DosenGQL = gql`
    query AllDosens {
      allDosens {
        nodes {
          id
          nama
          nip
          sex
          status
        }
      }
    }`;

  let networkStatus = 'loading';
  let keyword = '';
  let items = [];
  const avatarUrl = (key) => `https://api.adorable.io/avatars/24/${key}.png`

  async function loadDosen () {
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: DosenGQL
      });
      items = result.data.allDosens.nodes;
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
    console.log($location);
  }

  onMount(loadDosen);
</script>

<div class="text-3xl font-black my-6">Daftar Dosen</div>
<JoInput cls="my-2 w-64" bind:value={keyword} placeholder="keyword..." />
<JoAsyncContent {networkStatus}>
  <ul slot="success" class="bg-white">
    {#each items as item (item.id)}
      <li class="py-4 border-b-2 border-dashed border-gray-400">

        <div class="flex items-center text-sm">
          <div 
            class="w-10 h-10 mr-3" 
            style={`background: url(${avatarUrl(item.nip)})`}
          >
          </div>
          <div class="flex flex-col flex-grow text-lg">
            <a 
              href={'/#' + $location + '/' + item.id + '/info'}
              class="appearance-none font-black underline text-left"
            >{item.nama}</a>
            <div class="text-sm">{item.nip}</div>
          </div>

          <div>
            {#if item.status == 'AKTIF'}
              <span class="px-2 bg-green-600 text-white text-xs font-bold">{item.status.toLowerCase()}</span>
            {:else}
              <span class="px-2 bg-orange-600 text-white text-xs font-bold">inaktif</span>
            {/if}
          </div>
        </div>
      </li>
    {/each}
  </ul>
</JoAsyncContent>
