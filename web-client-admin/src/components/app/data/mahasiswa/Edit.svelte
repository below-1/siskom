<script>
  import { gql } from '@apollo/client/core';
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
  import GQLUpdate from 'siskom-web-admin/graphql/UpdateMahasiswa.js';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';

  export let params = {};

  const GQLUpdateData = gql`
    query MahasiswaById($id: Int!) {
      allYears {
        nodes
      }
      allDosens(filter: {status: {equalTo: AKTIF}}) {
        nodes {
          id
          nama
          nip
        }
      }
      mahasiswa: mahasiswaById(id: $id) {
        biodata
        id
        idPa
        nim
        nama
        sex
        tahunMasuk
        nodeId
        pa: dosenByIdPa {
          id
          nama
          nip
        }
      }
    }
  `;

  $: id = params.id ? parseInt(params.id) : null;
  let tahunAjaranOptions = [];
  let dosenPaOptions = [];
  let sex = 'LAKI_LAKI';
  let nama = '';
  let nim = '';
  let tahunMasuk = 2007;
  let idPa = null;
  let networkStatus = 'ready';

  $: errors = {
    nama: isEmpty(nama) ? 'nama tidak boleh kosong' : null,
    nim: isEmpty(nim) ? 'nim tidak boleh kosong' : null,
    tahunMasuk: !tahunMasuk ? 'tahun masuk tidak boleh kosong' : null,
    idPa: !idPa ? 'PA tidak boleh kosong' : null
  };
  $: invalid = !allIsNull(errors);

  $: loadUpdateData({ id });

  function onSave () {
    const payload = {
      sex,
      nama,
      nim,
      tahunMasuk,
      idPa
    };
    const variables = {
      payload,
      id
    };
    const mutateResult = apolloClient.mutate({
      mutation: GQLUpdate,
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

  function loadUpdateData ({ id }) {
    if (!id) return;
    const queryResult = apolloClient.query({
      query: GQLUpdateData,
      variables: {
        id
      }
    })
    networkStatus = 'loading';
    return queryResult
      .then(result => {
        const { mahasiswa, allYears, allDosens } = result.data;
        sex = mahasiswa.sex;
        nama = mahasiswa.nama;
        nim = mahasiswa.nim;
        tahunMasuk = mahasiswa.tahunMasuk;
        idPa = mahasiswa.idPa;

        tahunAjaranOptions = allYears.nodes.map(year => ({
          value: year,
          label: `Tahun Ajaran ${year}/${year+1}`
        }));

        dosenPaOptions = allDosens.nodes.map(dosen => ({
          value: dosen.id,
          label: `${dosen.nama} - ${dosen.nip}`
        }));

        networkStatus = 'ready';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      });
  }
</script>

<div>
  <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
    Input Data Mahasiswa
  </div>
  <div class="mx-auto my-12 px-4 w-1/3 py-6 border border-gray-400">
    <form>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Nama</label>
        <JoInput bind:value={nama} placeholder="nama mahasiswa..." />
        {#if errors.nama}
        <p class="text-red-700 font-semibold text-xs">
          {errors.nama}
        </p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">NIM</label>
        <JoInput bind:value={nim} placeholder="NIM..." />
        {#if errors.nim}
        <p class="text-red-700 font-semibold text-xs">
          {errors.nim}
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
      </div>

      <div class="mb-6 flex flex-col">
        <label class="text-sm">Tahun Masuk</label>
        <JoSelect bind:value={tahunMasuk} options={tahunAjaranOptions} />
        {#if errors.tahunMasuk}
        <p class="text-red-700 font-semibold text-xs">
          {errors.tahunMasuk}
        </p>
        {/if}
      </div>

      <div class="mb-6 flex flex-col text-sm">
        <label class="text-sm">Dosen PA</label>
        <JoSelect bind:value={idPa} options={dosenPaOptions} />
        {#if errors.idPa}
        <p class="text-red-700 font-semibold text-xs">
          {errors.idPa}
        </p>
        {/if}
      </div>

      <div>
        <JoButton 
          dark 
          color='blue' 
          action={onSave}
          disabled={invalid}
        >
          simpan
        </JoButton>
      </div>
    </form>
  </div>
</div>