<script>
  import { push as pushRoute } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';
  import { 
    notification 
  } from 'siskom-web-admin/stores/index.js';
  import prefScheduleIsValid from './prefScheduleIsValid.js';
  import GQLCreate from 'siskom-web-admin/graphql/CreateMk.js';
  import {
    JoInput,
    JoNumber,
    JoSelect,
    JoButton,
    JoRadioGroup,
    allIsNull
  } from 'siskom-web-commons';

  let kode = '';
  let minSks = 0;
  let nama = '';
  let openIn = 'ALL';
  let prefSchedule = 1;
  let sks = 3;
  let tipeMk = 'WAJIB';
  let scheduled = true;

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

  async function onSave() {
    let payload = {
      kode: trim(kode),
      minSks,
      nama: trim(nama),
      openIn,
      prefSchedule,
      sks,
      tipeMk,
      scheduled
    };
    try {
      await apolloClient.mutate({
        mutation: GQLCreate,
        variables: {
          payload
        }
      });
      notification.show({ type: 'info', message: 'sukses menambah data' });
      pushRoute('/admin/mk');
    } catch (err) {
      console.log(err);
      notification.show({ type: 'danger', message: 'gagal menambah data' });
    }
  }
</script>

<div>
  <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-400">
    Input Data Mata Kuliah
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
