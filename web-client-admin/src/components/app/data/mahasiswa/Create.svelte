<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { push as pushRoute, pop as popRoute } from 'svelte-spa-router';
  import {
    JoAsyncContent,
    JoInput,
    JoSelect,
    JoButton,
    allIsNull
  } from 'siskom-web-commons';
  import { notification } from 'siskom-web-admin/stores/index.js';
  import GQLAllYears from 'siskom-web-admin/graphql/AllYears.js';
  import GQLCreateMahasiswa from 'siskom-web-admin/graphql/CreateMahasiswa.js';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';

  let tahunAjaranOptions = [];
  let _sex = 'PEREMPUAN';
  let _nama = '';
  let _nim = '';
  let _thMasuk = 2007;
  let networkStatus = 'ready';

  $: errors = {
    _nama: isEmpty(_nama) ? 'nama tidak boleh kosong' : null,
    _nim: isEmpty(_nim) ? 'nim tidak boleh kosong' : null,
    _thMasuk: !_thMasuk ? 'tahun masuk tidak boleh kosong' : null
  };
  $: invalid = !allIsNull(errors);

  function save () {
    networkStatus = 'loading';
    const payload = {
      _sex,
      _nama,
      _nim,
      _thMasuk
    };
    const variables = { payload };
    const mutationResult = apolloClient.mutate({
      mutation: GQLCreateMahasiswa,
      variables
    });
    return mutationResult
      .then(result => {
        networkStatus = 'success';
        notification.show({
          type: 'info',
          message: 'sukses menambah mahasiswa'
        })
        pushRoute('/admin/mahasiswa');
      })
      .catch(err => {
        console.log(err);
        notification.show({
          type: 'error',
          message: 'gagal menambah mahasiswa'
        });
        networkStatus = 'error';
      });
  }

  function loadAllYears () {
    const queryResult = apolloClient.query({
      query: GQLAllYears
    });
    return queryResult
      .then(result => {
        tahunAjaranOptions = result.data.allYears.nodes.map(year => ({
          value: year,
          label: `Tahun Ajaran ${year}/${year+1}`
        }));
      })
      .catch(err => {
        console.log(err);
        notification.show({
          type: 'error',
          message: 'gagal memuat data periode'
        });
        popRoute();
      });
  }

  onMount(loadAllYears);
</script>

<div>
  <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
    Input Data Mahasiswa
  </div>
  <div class="mx-auto my-12 px-4 w-1/3 py-6 border border-gray-400">
    <form>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Nama</label>
        <JoInput bind:value={_nama} placeholder="nama mahasiswa..." />
        {#if errors._nama}
        <p class="text-red-700 font-semibold text-xs">
          {errors._nama}
        </p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">NIM</label>
        <JoInput bind:value={_nim} placeholder="NIM..." />
        {#if errors._nim}
        <p class="text-red-700 font-semibold text-xs">
          {errors._nim}
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
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Tahun Masuk</label>
        <JoSelect bind:value={_thMasuk} options={tahunAjaranOptions} />
        {#if errors._thMasuk}
        <p class="text-red-700 font-semibold text-xs">
          {errors._thMasuk}
        </p>
        {/if}
      </div>
      <div>
        <JoButton 
          dark 
          color='blue' 
          action={save}
          disabled={invalid}
        >
          simpan
        </JoButton>
      </div>
    </form>
  </div>
</div>