<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import {
    JoInput,
    JoSelect,
    JoButton,
    JoAsyncContent,
    allIsNull
  } from 'siskom-web-commons';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';
  import GQLCreateDosen from 'siskom-web-admin/graphql/CreateDosen.js';

  let tahunAjaranOptions = [];
  let _sex = 'PEREMPUAN';
  let _nama = '';
  let _nip = '';
  let networkStatus = 'ready';

  $: errors = {
    _nama: isEmpty(_nama) ? 'nama tidak boleh kosong' : null,
    _nip: isEmpty(_nip) ? 'nip tidak boleh kosong' : null,
    _sex: isEmpty(_sex) ? 'sex tidak boleh kosong' : null
  };

  $: invalid = !allIsNull(errors);

  async function onSave () {
    let payload = {
      _nama,
      _nip,
      _sex,
      _inActivePeriode: true
    };
    const mutateResult = apolloClient.mutate({
      mutation: GQLCreateDosen,
      variables: {
        payload
      }
    });
    networkStatus = 'loading';
    return mutateResult
      .then(() => {
        pushRoute('/admin/data/dosen');
      })
      .catch(err => {
        networkStatus = 'error';
        notification.show({
          type: 'error',
          message: 'gagal menambah dosen'
        })
      })
  }
</script>

<div>
  <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
    Input Data Dosen
  </div>
  <JoAsyncContent {networkStatus}>
    <div 
      slot="ready" 
      class="mx-auto my-12 px-4 w-1/3 py-6 border border-gray-400"
    >
      <form>
        <div class="mb-6 flex flex-col">
          <label class="text-sm">Nama</label>
          <JoInput bind:value={_nama} placeholder="nama dosen" />
          {#if errors._nama}
          <p class="text-red-700 font-semibold text-xs">
            {errors._nama}
          </p>
          {/if}
        </div>
        <div class="mb-6 flex flex-col">
          <label class="text-sm">NIP</label>
          <JoInput bind:value={_nip} placeholder="NIP dosen" />
          {#if errors._nip}
          <p class="text-red-700 font-semibold text-xs">
            {errors._nip}
          </p>
          {/if}
        </div>
        <div class="mb-6 flex flex-col text-sm">
          <label class="mb-1 text-sm">Jenis Kelamin</label>
          <div class="flex items-center text-gray-800 mb-1">
            <input 
              bind:group={_sex}
              type="radio"
              value="LAKI_LAKI"
              class="jo-radio appearance-none rounded-full border-2 border-gray-600 p-2 mr-2"
            />
            <label>Laki - Laki</label>
          </div>
          <div class="flex items-center text-gray-800">
            <input 
              bind:group={_sex}
              type="radio"
              value="PEREMPUAN"
              class="jo-radio appearance-none rounded-full border-2 border-gray-600 p-2 mr-2" 
            />
            <label>Perempuan</label>
          </div>
          {#if errors._sex}
          <p class="text-red-700 font-semibold text-xs">
            {errors._sex}
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
