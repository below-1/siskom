<script>
  import { onMount } from 'svelte';
  // import { load as loadStorage } from 'siskom/commons/storage.js';
  // import DetailMahasiswa from 'siskom/components/commons/mahasiswa/detail.svelte';

  let id = null;
  onMount(() => {
    const userRaw = localStorage.getItem('siskom.user');
    const user = userRaw ? JSON.parse(userRaw) : null;
    id = user.targetId;
  });
</script>

<h1>Detail Mahasiswa</h1>

<!-- <DetailMahasiswa {id} prefix="/app/me_mhs">
</DetailMahasiswa> -->
