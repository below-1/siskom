<script type="text/javascript">
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { push as pushRoute } from 'svelte-spa-router';
  import isEmpty from 'validator/es/lib/isEmpty';
  import isAfter from 'validator/es/lib/isAfter';
  import {
    allIsNull,
    JoAsyncContent,
    JoInput,
    JoDate,
    JoNumber,
    JoSelect,
    JoButton
  } from 'siskom-web-commons';

  const GQLAllDosens = gql`
    query CreateDataQuery {
      allDosens {
        nodes {
          id
          nama
        }
      }
    }
  `;

  const GQLCreate = gql`
    mutation CreatePeriode($payload: PeriodeInput!) {
      createPeriode(input: { periode: $payload }) {
        periode {
          id
        }
      }
    }
  `;

  let tahun = 2018;
  let semester = 1;
  let awal = '2018-01-12';
  let akhir = '2018-06-12';
  let idKetua = null;
  let idSekretaris = null;
  let networkStatus = 'loading';
  let optionsDosen = [];

  let errors = {
    tahun: null,
    semester: null,
    awal: null,
    akhir: null,
    idKetua: null,
    idSekretaris: null
  };

  $: disabled = !allIsNull(errors);

  function validate (trigs) {
    if (isEmpty(awal)) {
      errors.awal = 'Tanggal Mulai tidak boleh kosong';
    } else {
      errors.awal = null;
    }
    if (isEmpty(akhir)) {
      errors.akhir = 'Tanggal Berakhir tidak boleh kosong';
    } else {
      errors.akhir = null;
    }
    if (isAfter(awal, akhir)) {
      errors.awal = 'Tanggal Mulai dan Berakhir tidak valid';
      errors.akhir = 'Tanggal Mulai dan Berakhir tidak valid';
    }

    if (!tahun) {
      errors.tahun = 'tahun tidak boleh kosong';
    } else {
      errors.tahun = null;
    }

    if (!semester) {
      errors.semester = 'semester tidak boleh kosong';
    } else {
      errors.semester = null;
    }
  }

  $: validate({ awal, akhir, idSekretaris, idKetua, tahun, semester });

  async function onSave () {
    let payload = {
      tahun,
      semester,
      awal,
      akhir,
      idKetua,
      idSekretaris
    };
    networkStatus = 'loading';
    try {
      await apolloClient.mutate({
        mutation: GQLCreate,
        variables: {
          payload
        }
      });
      pushRoute('/admin/periode');
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
      alert('gagal menambah data periode');
    }
  }

  async function loadData () {
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLAllDosens
      });
      const { allDosens } = result.data;
      optionsDosen = allDosens.nodes.map(it => {
        return {
          value: it.id,
          label: it.nama
        }
      });
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
  }

  onMount(loadData);
</script>

<div>
  <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
    Input Data Periode
  </div>
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success" class="mx-auto my-12 px-4 w-1/3 py-6 border border-gray-400">
    <form>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Tahun</label>
        <JoNumber placeholder="Tahun" bind:value={tahun} min={2007} />
        {#if errors.tahun}
          <p class="text-red-600 font-bold text-xs">{errors.tahun}</p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Semester</label>
        <JoNumber placeholder="Tahun" bind:value={semester} min={1} max={2} />
        {#if errors.semester}
          <p class="text-red-600 font-bold text-xs">{errors.semester}</p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Awal</label>
        <JoDate placeholder="Awal" bind:value={awal} />
        {#if errors.awal}
          <p class="text-red-600 font-bold text-xs">{errors.awal}</p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Akhir</label>
        <JoDate placeholder="Awal" bind:value={akhir} />
        {#if errors.akhir}
          <p class="text-red-600 font-bold text-xs">{errors.akhir}</p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Ketua Prodi</label>
        <JoSelect label="pilih dosen" options={optionsDosen} bind:value={idKetua} />
        {#if errors.idKetua}
          <p class="text-red-600 font-bold text-xs">{errors.idKetua}</p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Sekretaris Prodi</label>
        <JoSelect label="pilih dosen" options={optionsDosen} bind:value={idSekretaris} />
        {#if errors.idSekretaris}
          <p class="text-red-600 font-bold text-xs">{errors.idSekretaris}</p>
        {/if}
      </div>
      <div class="mb-6">
        <JoButton 
          {disabled}
          label="Simpan" 
          dark 
          color="blue"
          action={onSave}
        />
      </div>
    </form>
  </div>
</JoAsyncContent>
