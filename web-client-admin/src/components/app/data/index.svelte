<script>
  import Router from 'svelte-spa-router';
  import Mahasiswa from './mahasiswa/index.svelte';
  import Dosen from './dosen/index.svelte';

  const routes = {
    '/mahasiswa': Mahasiswa,
    '/mahasiswa/*': Mahasiswa,
    '/dosen': Dosen,
    '/dosen/*': Dosen
  };

  const prefix = '/admin/data';
</script>

<Router {routes} {prefix} />
