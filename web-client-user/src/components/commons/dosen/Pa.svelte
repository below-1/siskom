<script>
  import { onMount, getContext } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoSelect,
    JoAsyncContent,
    periode
  } from 'siskom-web-commons';
  import GQLDosenMahasiswaPa from 'siskom-web-user/graphql/DosenMahasiswaPa.js';
  import * as context_key from './context';

  const dosen = getContext(context_key.dosen);
  $: idDosen = $dosen ? $dosen.id : null;

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
      query: GQLDosenMahasiswaPa,
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
    <div class="my-6">
      <div class="text-2xl font-black">Daftar Mahasiswa Bimbingan Akademik</div>
      <JoSelect emptyLabel="pilih periode" bind:value={tahunMasuk} options={optionsTahunMasuk} cls="w-64" />
    </div>
    <ul class="my-4">
      {#each items as item (item.cursor)}
        <li class="border-b border-gray-300 py-4 flex items-center">
          <div style="max-width: 2.5rem; min-width: 2.5rem; width: 2.5rem;">
            <img src={`${avatarUrl}/64/${item.node.nim}.png`} />
          </div>
          <div class="ml-2">
            <a href={`/#/app/ilkom/mahasiswas/${item.node.id}/info`} class="text-lg font-bold underline">{item.node.nama}</a>
            <div>{item.node.sex.toLowerCase()}, {item.node.nim}</div>
          </div>
        </li>
      {/each}
    </ul>
  </div>
</JoAsyncContent>
