<script>
  import { createEventDispatcher } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoAsyncContent,
    JoDialog,
    JoNumber,
    JoButton
  } from 'siskom-web-commons';

  const GQLUpdateNilai = gql`
    mutation UpdateNilai ($idMahasiswaKelas: Int!, $nilai: Float) {
      updateMahasiswaKelaById(
        input: {
          mahasiswaKelaPatch: {nilai: $nilai}, 
          id: $idMahasiswaKelas
        }
      ) {
        mahasiswaKela {
          id
          idMhs
          idKelas
          nilai
        }
      }
    }
  `;

  const dispatch = createEventDispatcher();
  export let id = null;
  export let nama = '';
  export let nilai = 0;
  let networkStatus = 'ready';

  $: invalidNilai = isNaN(nilai);

  $: title = 'Ubah Nilai ' + nama;

  async function updateNilai () {
    networkStatus = 'loading';
    try { 
      const result = await apolloClient.mutate({
        mutation: GQLUpdateNilai,
        variables: {
          idMahasiswaKelas: id,
          nilai
        }
      });
      networkStatus = 'ready';
      dispatch('done');
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
  }
</script>

<JoAsyncContent {networkStatus}>
  <div slot="ready">
    <div class="flex flex-col mb-6">
      <JoNumber 
        min={0}
        max={100}
        step={0.01}
        bind:value={nilai} 
      />
      {#if invalidNilai}
        <div class="text-red-500 text-sm">nilai Tidak Valid</div>
      {/if}
    </div>
    <JoButton 
      label="simpan" 
      action={updateNilai}
      cls="bg-blue-800 text-white font-bold"
    />
  </div>
</JoAsyncContent>