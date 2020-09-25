<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoSelect,
    JoAsyncContent,
    JoInput,
    periode,
    formatJk
  } from 'siskom-web-commons';
  import GQLListMahasiswa from 'siskom-web-user/graphql/ListMahasiswa.js';
  import GQLAllPeriode from 'siskom-web-user/graphql/AllPeriode.js';
  import buildAvatar from 'siskom-web-user/commons/buildAvatar.js';

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
        query: GQLListMahasiswa,
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
          avatar: buildAvatar(it.nim, 24)
        }
      });
      console.log(items);
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
        query: GQLAllPeriode
      });
      let uniqueYears = [];
      result.data.allPeriodes.nodes.forEach(p => {
        if (uniqueYears.includes(p.tahun)) {
          return;
        }
        uniqueYears.push(p.tahun);
      });
      optionsTahunMasuk = uniqueYears.map(t => ({
        value: t,
        label: t
      }))
      tahunMasuk = $periode.tahun;
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
  }

  onMount(loadPeriode);
</script>

<div>
  <div class="text-3xl font-black my-6">Daftar Mahasiswa</div>
  <div class="flex flex-wrap items-center my-4">
    <JoSelect 
      label="tahun masuk" 
      emptyLabel="pilih tahun masuk" 
      bind:value={tahunMasuk} 
      options={optionsTahunMasuk} 
      cls="mr-2 my-2"
    />
    <JoInput placeholder="keyword..." bind:value={keyword} />
  </div>
</div>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <ul class="bg-white">
      {#each items as item (item.id)}
        <li class="border-b-2 border-gray-400 border-dashed py-4 flex items-center">
          <div style="max-width: 2.8rem; min-width: 2.8rem; width: 2.8rem;">
            <img src={item.avatar} />
          </div>
          <div class="ml-2">
            <a class="text-lg font-medium underline" href={`/#/app/ilkom/mahasiswas/${item.id}/info`}>{item.nama}</a>
            <div>{formatJk(item.sex)}, {item.nim}</div>
          </div>
        </li>
      {/each}
    </ul>

  </div>
</JoAsyncContent>