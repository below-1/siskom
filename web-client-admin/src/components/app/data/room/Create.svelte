<script type="text/javascript">
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

  const GQLCreate = gql`
    mutation CreateRoom($payload: RoomInput!) {
      createRoom(input:  { room: $payload }) {
        room {
          id
          nama
          kapasitas
        }
      }
    }
  `;

  let nama = '';
  let kapasitas = 40;

  let networkStatus = "success";

  let errors = {
    nama: null,
    kapasitas: null
  };

  $: disabled = !allIsNull(errors);

  async function onSave () {
    let payload = {
      nama,
      kapasitas
    };
    networkStatus = 'loading';
    try {
      await apolloClient.mutate({
        mutation: GQLCreate,
        variables: {
          payload
        }
      });
      pushRoute('/admin/data/room');
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
      alert('gagal menambah data ruangan');
    }
  }
</script>

<div>
  <div class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
    Input Data Ruangan
  </div>
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success" class="mx-auto my-12 px-4 w-1/3 py-6 border border-gray-400">
    <form>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Nama</label>
        <JoInput placeholder="Tahun" bind:value={nama} />
        {#if errors.nama}
          <p class="text-red-600 font-bold text-xs">{errors.nama}</p>
        {/if}
      </div>
      <div class="mb-6 flex flex-col">
        <label class="text-sm">Kapasitas</label>
        <JoNumber placeholder="Tahun" bind:value={kapasitas} min={1} />
        {#if errors.kapasitas}
          <p class="text-red-600 font-bold text-xs">{errors.kapasitas}</p>
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
