<script>
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { pop as popRoute } from 'svelte-spa-router';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';
  import {
    JoAsyncContent,
    JoInput,
    JoSelect,
    JoButton,
    allIsNull
  } from 'siskom-web-commons';
  import { notification } from 'siskom-web-admin/stores/index.js';
  import GQLUpdateDosen from 'siskom-web-admin/graphql/UpdateDosen.js';

  const GQLUpdateData = gql`
    query FetchUpdate($id: Int!) {
      dosenById(id: $id) {
        id
        nama
        nip
        sex
        status
      }
    }
  `;

  export let params = {};
  
  let sex = 'PEREMPUAN';
  let nama = '';
  let nip = '';
  let status = 'AKTIF';
  let networkStatus = 'loading';

  $: errors = {
    nama: isEmpty(nama) ? 'nama tidak boleh kosong' : null,
    nip: isEmpty(nip) ? 'nip tidak boleh kosong' : null,
    sex: isEmpty(sex) ? 'sex tidak boleh kosong' : null
  };
  $: invalid = !allIsNull(errors);
  $: id = params.id ? parseInt(params.id) : null;

  function onSave() {
    const payload = {
      sex,
      nama,
      nip,
      status
    };
    const variables = {
      payload,
      id
    };
    const mutateResult = apolloClient.mutate({
      mutation: GQLUpdateDosen,
      variables
    });
    networkStatus = 'loading';
    return mutateResult
      .then(result => {
        networkStatus = 'success';
        popRoute();
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
        notification.show({
          type: 'error',
          message: 'gagal mengubah data dosen'
        })
      });
  }

  function loadData () {
    networkStatus = 'loading';
    apolloClient.query({
      query: GQLUpdateData,
      variables: {
        id
      }
    })
      .then(result => {
        const item = result.data.dosenById;
        sex = item.sex;
        nama = item.nama;
        nip = item.nip;
        status = item.status;
        networkStatus = 'ready';
      })
      .catch(err => {
        console.log(err);
        notification.show({
          type: 'error',
          message: 'gagal mengambil data dosen'
        });
        networkStatus = 'error';
      });
  }

  onMount(loadData);
</script>

<style>
  input[type="radio"].jo-radio {
    transition: background .2s,
        transform .2s;
  }

  input[type="radio"]:checked.jo-radio {
    background: #4299E1;
  }
</style>

<div>
  <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
    Update Data Dosen
  </div>
  <JoAsyncContent {networkStatus}>
    <div 
      slot="ready"
      class="mx-auto my-12 px-4 w-1/3 py-6 border border-gray-400"
    >
      <form>
        <div class="mb-6 flex flex-col">
          <label class="text-sm">Nama</label>
          <JoInput bind:value={nama} placeholder="nama dosen" />
          {#if errors.nama}
          <p class="text-red-700 font-semibold text-xs">
            {errors.nama}
          </p>
          {/if}
        </div>
        <div class="mb-6 flex flex-col">
          <label class="text-sm">NIP</label>
          <JoInput bind:value={nip} placeholder="NIP dosen" />
          {#if errors.nip}
          <p class="text-red-700 font-semibold text-xs">
            {errors.nip}
          </p>
          {/if}
        </div>
        <div class="mb-6 flex flex-col text-sm">
          <label class="mb-1 text-sm">Jenis Kelamin</label>
          <div class="flex items-center text-gray-800 mb-1">
            <input 
              bind:group={sex}
              type="radio"
              value="LAKI_LAKI"
              class="jo-radio appearance-none rounded-full border-2 border-gray-600 p-2 mr-2"
            />
            <label>Laki - Laki</label>
          </div>
          <div class="flex items-center text-gray-800">
            <input 
              bind:group={sex}
              type="radio"
              value="PEREMPUAN"
              class="jo-radio appearance-none rounded-full border-2 border-gray-600 p-2 mr-2" 
            />
            <label>Perempuan</label>
          </div>
          {#if errors.sex}
          <p class="text-red-700 font-semibold text-xs">
            {errors.sex}
          </p>
          {/if}
        </div>
        <div>
          <JoButton
            dark={true}
            color="blue"
            action={onSave}
            disabled={invalid}
            label="simpan"
          />
        </div>
      </form>
    </div>
  </JoAsyncContent>
</div>
