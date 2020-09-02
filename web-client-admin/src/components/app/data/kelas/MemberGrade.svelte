<script>
  import { onMount, createEventDispatcher } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import {
    JoDialog,
    JoButton,
    JoNumber
  } from 'siskom-web-commons';
  import { notification } from 'siskom-web-admin/stores/index.js';
  import updateGradeCache from 'siskom-web-admin/services/updateGradeCache.js';

  const GQLChangeGrade = gql`
    mutation ChangeGrade($idMahasiswa: Int!, $idKelas: Int!, $grade: Float!) {
      changeNilai(input: {_idMahasiswa: $idMahasiswa, _idKelas: $idKelas, _nilai: $grade}) {
        integer
      }
    }
  `;

  const dispatch = createEventDispatcher();

  export let currentGrade;
  export let idKelas;
  export let idMahasiswa;
  export let id;
  export let show = false;
  let grade = currentGrade;

  $: {
    grade = show ? currentGrade : 0;
  };

  async function save () {
    try {
      const result = await apolloClient.mutate({
        mutation: GQLChangeGrade,
        variables: {
          idKelas,
          idMahasiswa,
          grade
        }
      })
      updateGradeCache({ 
        client: apolloClient,
        grade,
        id
      })
      dispatch('done');
    } catch (err) {
      console.log(err);
      notification.show({
        message: 'gagal mengubah nilai',
        type: 'error'
      })
    }
  }
</script>

<JoDialog
  bind:show={show}
  title="Ubah Nilai Mahasiswa"
>
  <div>
    <JoNumber step={0.01} bind:value={grade} placeholder="Nilai mahasiswa" />
    <JoButton action={save} label="simpan" dark color="blue" cls="mt-2" />
  </div>
</JoDialog>