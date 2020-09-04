<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';

  const GQL_Required = gql`
    query DosenMahasiswaPaRequired {
      allPeriodes {
        nodes {
          tahun
          semester
        }
      }
      currentSetting {
        currentPeriode {
          tahun
        }
      }
    }
  `;

  const GQL_AllMahasiswas = gql`
    query AllMahasiswas(
      $first: Int!,
      $keyword: String
      $after: Cursor
      $tahunMasuk: ThAjar!
      $idDosen: Int!
    ) {
      allMahasiswas (
        first: $first,
        after: $after,
        filter: {
          and: { 
            tahunMasuk: { equalTo: $tahunMasuk }
            idPa: { equalTo: $idDosen }
            nama: { likeInsensitive: $keyword }
          }
        }
      ) {
        edges {
          cursor
          node {
            id
            nama
            nim
            sex
            status
          }
        }
      }
    }
  `;

  const first = 10;
  const avatarUrl = 'https://api.adorable.io/avatars';

  let networkStatus = 'loading';
  let items = [];
  let optionsTahunMasuk = [];
  let tahunMasuk = null;
  let after = null;
  let idDosen = null;
  let keyword = '';

  function getRequired () {
    networkStatus = 'loading';
    apolloClient.query({
      query: GQL_Required
    })
      .then(result => {
        let temp_tahun_masuk = [];
        result.data.allPeriodes.nodes.forEach(it => {
          if (!temp_tahun_masuk.includes(it.tahun)) {
            temp_tahun_masuk.push(it.tahun)
          }
        });

        optionsTahunMasuk = temp_tahun_masuk.map(thn => ({
          label: 'tahun ' + thn,
          value: thn
        }));

        const dosen = loadStorage('siskom.dosen');
        idDosen = dosen.id;

        tahunMasuk = result.data.currentSetting.currentPeriode.tahun;

        networkStatus = 'success';
      })
      .catch(err => {
        networkStatus = 'error';
        console.log(err);
      })
  }

  function getMahasiswa (options) {
    return apolloClient.query({
      query: GQL_AllMahasiswas,
      variables: {
        ...options,
        keyword: `${options.keyword}%`
      }
    })
      .then(result => result.data.allMahasiswas.edges)
  }

  function reload ({ tahunMasuk, keyword, idDosen  }) {
    if (!idDosen) return;
    if (!tahunMasuk) return;
    networkStatus = 'loading';
    const variables = {
      tahunMasuk,
      keyword,
      idDosen,
      after: null,
      first
    };
    getMahasiswa(variables)
      .then(_items => {
        items = _items;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      });
  }

  onMount(getRequired);

  $: reload({ tahunMasuk, keyword, idDosen });
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="px-6 py-6 border-b border-gray-300 bg-gray-200">
      <div class="text-base text-center font-semibold my-2">Daftar Mahasiswa Bimbingan Akademik</div>
      <JoSelect emptyLabel="pilih periode" bind:value={tahunMasuk} options={optionsTahunMasuk} />
    </div>
    <ul class="my-6">
      {#each items as item (item.cursor)}
        <li class="border-b border-gray-300 py-2 flex items-center text-sm px-6">
          <div style="max-width: 2.5rem; min-width: 2.5rem; width: 2.5rem;">
            <img src={`${avatarUrl}/64/${item.node.nim}.png`} />
          </div>
          <div class="ml-2">
            <div class="font-semibold">{item.node.nama}</div>
            <div class="text-xs">{item.node.sex.toLowerCase()}, {item.node.nim}</div>
          </div>
        </li>
      {/each}
    </ul>
  </div>
</JoAsyncContent>
