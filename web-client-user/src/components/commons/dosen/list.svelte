<script>
  import { onMount } from 'svelte';
  import { push as pushRoute, location } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';

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

<div class="py-4 px-4 bg-white mb-2">
  <div class="text-center text-lg font-bold">Daftar Dosen</div>
  <JoInput cls="my-3 w-full" bind:value={keyword} placeholder="keyword..." />
</div>
<JoAsyncContent {networkStatus}>
  <ul slot="success" class="bg-white">
    {#each items as item (item.id)}
      <li class="py-3 border-b border-gray-300 w-full px-4">
        <div class="flex items-center text-sm">
          <div class="w-8 h-8 mr-3" style={`background: url(${avatarUrl(item.nip)})`}>
          </div>
          <div class="flex flex-col flex-grow">
            <a 
              href={'/#' + $location + '/' + item.id + '/info'}
              class="appearance-none font-semibold underline text-left"
            >{item.nama}</a>
            <div class="text-xs">{item.nip}</div>
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
