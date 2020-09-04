<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom/apollo-client.js';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';
  import GQL_list_mahasiswa from 'siskom/graphql/list-mahasiswa.gql';
  import GQL_list_years from 'siskom/graphql/list-years.gql';
  import { periode } from 'siskom/stores/index.js';
  import avatar_url from 'siskom/commons/avatar.js';

  // states
  let networkStatus = 'loading';
  let items = [];
  let optionsTahunMasuk = [];
  let tahunMasuk = 2007;
  let keyword = '';
  let take = 10;
  let canNext = false;

  $: loadMahasiswa({ keyword, take, tahunMasuk });

  async function loadMahasiswa ({ keyword, tahunMasuk, take }) {
    if (!tahunMasuk) return;
    if (!take) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_list_mahasiswa,
        variables: {
          keyword: `${keyword}%`,
          tahunMasuk,
          take
        }
      });
      const data = result.data;
      items = data.allMahasiswas.nodes.map(it => {
        return {
          ...it,
          avatar: avatar_url(it.nim, 24)
        }
      });
      canNext = data.allMahasiswas.pageInfo.hasNextPage;
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
  }

  async function loadPeriode () {
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_list_years
      });
      optionsTahunMasuk = result.data.allYears.nodes.map(y => ({
        value: y,
        label: y
      }));
      tahunMasuk = $periode.tahun;
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
  }

  onMount(loadPeriode);
</script>

<div class="p-4 bg-white mb-2">
  <div class="text-lg font-bold">Daftar Mahasiswa</div>
  <div class="flex items-center">
    <JoSelect 
      label="tahun masuk" 
      emptyLabel="pilih tahun masuk" 
      bind:value={tahunMasuk} 
      options={optionsTahunMasuk} 
      cls="mr-2"
    />
    <JoInput placeholder="keyword..." bind:value={keyword} />
  </div>
</div>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <ul class="bg-white">
      {#each items as item (item.id)}
        <li class="border-b border-gray-300 p-4 flex items-center px-6">
          <div style="max-width: 2.8rem; min-width: 2.8rem; width: 2.8rem;">
            <img src={item.avatar} />
          </div>
          <div class="ml-2">
            <a class="font-semibold underline" href={`/#/app/ilkom/mahasiswas/${item.id}/info`}>{item.nama}</a>
            <div ></div>
            <div class="text-sm">{item.sex.toLowerCase()}, {item.nim}</div>
          </div>
        </li>
      {/each}
    </ul>

  </div>
</JoAsyncContent>