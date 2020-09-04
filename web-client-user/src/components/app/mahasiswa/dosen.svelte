<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';

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
  }

  onMount(loadDosen);
</script>

<div class="bg-gray-200 py-4 px-4 border-gray-300">
  <div class="text-center text-lg font-bold">Daftar Dosen</div>
  <JoInput cls="my-3 w-full" bind:value={keyword} placeholder="keyword..." />
</div>
<JoAsyncContent {networkStatus}>
  <ul slot="success">
    {#each items as item (item.id)}
      <li 
        class="py-3 px-4 border-b border-gray-300 w-full"
        on:click={() => {
          pushRoute('/mahasiswa/detail-dosen/' + item.id)
        }}
      >
        <div class="flex items-center text-sm">
          <div class="w-8 h-8 mr-3" style={`background: url(${avatarUrl(item.nip)})`}>
          </div>
          <div class="flex flex-col flex-grow">
            <span class="font-semibold">{item.nama}</span>
            <div class="text-xs font-bold">{item.nip}</div>
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
