<script>
  import DetailKelas from 'siskom/components/commons/kelas/mahasiswa-kelas.svelte';
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import formatNilai from 'siskom/commons/formatNilai.js';

  export let params = {};

  $: idKelas = params.idKelas ? parseInt(params.idKelas) : null;
  let idMahasiswa = null;

  onMount(() => {
    const user = loadStorage('siskom.user');
    idMahasiswa = user.targetId;
  });
</script>

<DetailKelas {idKelas} {idMahasiswa} />
