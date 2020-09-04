<script>
  import { onMount } from 'svelte';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import Transkrip from 'siskom/components/commons/mahasiswa/transkrip.svelte';

  let idMahasiswa = null;

  onMount(() => {
    const user = loadStorage('siskom.user');
    idMahasiswa = user.targetId;
  });
</script>

<Transkrip {idMahasiswa} />
