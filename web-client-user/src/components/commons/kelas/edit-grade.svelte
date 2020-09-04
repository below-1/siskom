<script>
  import { createEventDispatcher } from 'svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoDialog from 'siskom/components/commons/JoDialog.svelte';
  import JoNumber from 'siskom/components/commons/JoNumber.svelte';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import apolloClient from 'siskom/apollo-client.js';
  import GQL_update_nilai from 'siskom/graphql/update-nilai.gql';
  import GQL_frag_mahasiswa_kelas from 'siskom/graphql/fragments/mahasiswa-kelas.gql';

  const dispatch = createEventDispatcher();
  export let id = null;
  export let nama = '';
  export let nilai = 0;
  let networkStatus = 'ready';

  $: title = 'Ubah Nilai ' + nama;

  async function updateNilai () {
    networkStatus = 'loading';
    try { 
      const result = await apolloClient.mutate({
        mutation: GQL_update_nilai,
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
    <JoNumber 
      min={0}
      max={100}
      step={0.01}
      bind:value={nilai} 
      cls="mb-6" 
    />
    <JoButton 
      label="simpan" 
      action={updateNilai}
      cls="bg-blue-800 text-white font-bold"
    />
  </div>
</JoAsyncContent>