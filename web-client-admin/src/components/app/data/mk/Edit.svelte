<script>
  import { onMount } from 'svelte';
  import { pop as popRoute } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';
  import GQLMkById from 'siskom-web-admin/graphql/MkById.js';
  import GQLUpdateMk from 'siskom-web-admin/graphql/UpdateMk.js';
  import prefScheduleIsValid from './prefScheduleIsValid';
  import {
    allIsNull,
    JoInput,
    JoNumber,
    JoSelect,
    JoButton,
    JoRadioGroup,
    JoAsyncContent
  } from 'siskom-web-commons';

  export let params = {};
  let kode = '';
  let minSks = 0;
  let nama = '';
  let openIn = 'ALL';
  let prefSchedule = 1;
  let sks = 3;
  let tipeMk = 'WAJIB';
  let scheduled = true;
  let networkStatus = 'loading';
  $: id = params.id ? parseInt(params.id) : null;

  const optionsTipeMk = [
    { value: 'WAJIB', label: 'Wajib' },
    { value: 'PILIHAN', label: 'Pilihan' },
    { value: 'UMUM', label: 'Umum' }
  ]

  const optionsOpenIn = [
    { value: 'ALL', label: 'Semua' },
    { value: 'GANJIL', label: 'Ganjil' },
    { value: 'GENAP', label: 'Genap' }
  ]

  $: errors = {
    nama: isEmpty(nama) ? 'Nama tidak boleh kosong' : null,
    kode: isEmpty(kode) ? 'Kode tidak boleh kosong' : null,
    minSks: isNaN(minSks) ? 'Minimum SKS tidak valid' : null,
    sks: isNaN(sks) ? 'SKS tidak valid' : null,
    prefSchedule: prefScheduleIsValid(prefSchedule, openIn)
  };

  $: invalid = !allIsNull(errors);

  function onSave() {
    if (!id) {
      throw new Error('id is empty');
    }
    networkStatus = 'loading';
    apolloClient.mutate({
      mutation: GQLUpdateMk,
      variables: {
        id,
        payload: {
          kode: trim(kode),
          nama: trim(nama),
          openIn,
          prefSchedule,
          tipeMk,
          sks
        }
      }
    })
      .then(result => {
        console.log(result);
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
        alert('Gagal mengubah data mata kuliah');
      })
  }

  onMount(() => {
    networkStatus = 'loading';
    apolloClient.query({
      query: GQLMkById,
      variables: {
        id
      }
    })
      .then(result => {
        const item = result.data.mataKuliahById;
        kode = item.kode;
        minSks = item.minSks;
        nama = item.nama;
        openIn = item.openIn;
        prefSchedule = item.prefSchedule;
        sks = item.sks;
        tipeMk = item.tipeMk;
        scheduled = item.scheduled;
        networkStatus = 'ready';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
        alert('Gagal mengambil data mata kuliah');
      });
  });
</script>

<JoAsyncContent 
  {networkStatus}
>
  <div slot="ready">
    <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-400">
      Update Data Mata Kuliah
    </div>
    <div class="mx-auto my-12 px-4 w-1/3 py-6 border border-gray-400">
      <form>
        <div class="mb-6 flex flex-col">
          <label class="text-sm">Nama</label>
          <JoInput bind:value={nama} />
          {#if errors.nama}
            <p class="text-red-700 text-xs">{errors.nama}</p>
          {/if}
        </div>
        <div class="mb-6 flex flex-col">
          <label class="text-sm">Kode</label>
          <JoInput bind:value={kode} />
          {#if errors.kode}
            <p class="text-red-700 text-xs">{errors.kode}</p>
          {/if}
        </div>      
        <div class="mb-6 flex flex-col">
          <label class="text-sm">SKS</label>
          <JoNumber bind:value={sks} min="1"/>
          {#if errors.sks}
            <p class="text-red-700 text-xs">{errors.sks}</p>
          {/if}
        </div>

        <label class="mb-1 text-sm">Tipe Mata Kuliah</label>
        <JoRadioGroup
          cls="mb-6"
          options={optionsTipeMk}
          bind:group={tipeMk}
        />

        <label class="mb-1 text-sm">Dibuka Pada Semester</label>
        <JoRadioGroup
          cls="mb-6"
          options={optionsOpenIn}
          bind:group={openIn}
        />

        <div class="mb-6 flex flex-col">
          <label class="text-sm">Minimum SKS Prasyarat</label>
          <JoNumber bind:value={minSks} min={0}/>
          {#if errors.minSks}
            <p class="text-red-700 text-xs">{errors.minSks}</p>
          {/if}
        </div>

        <div class="mb-6 flex flex-col">
          <label class="text-sm">dijadwalkan untuk semester</label>
          <JoNumber bind:value={prefSchedule} min={0}/>
          {#if errors.prefSchedule}
            <p class="text-red-700 text-xs">{errors.prefSchedule}</p>
          {/if}
        </div>
        <div class="mb-6 flex items-center">
          <label class="font-bold">mata kuliah mempunyai jadwal?</label>
          <input 
            bind:checked={scheduled} 
            type="checkbox"
            class="ml-4"
          />
        </div>
        <div>
          <button
            type="button"
            class="appearance-none bg-blue-600 text-white p-2 text-sm rounded font-bold disabled:opacity-50"
            on:click={onSave}
            disabled={invalid}
          >
            simpan
          </button>
        </div>
      </form>
    </div>
  </div>
  <div slot="success" class="flex flex-col items-center justify-center">
    <div class="text-center my-12 font-bold text-xl">Sukses mengubah data mata kuliah</div>
    <JoButton 
      action={() => {
        popRoute();
      }}
      label="kembali"
    />
  </div>
</JoAsyncContent>
