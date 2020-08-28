<script>
  import Router from 'svelte-spa-router';
  import Mahasiswa from './mahasiswa/index.svelte';
  import Dosen from './dosen/index.svelte';
  import Mk from './mk/index.svelte';
  import Kelas from './kelas/index.svelte';

  const routes = {
    '/mahasiswa': Mahasiswa,
    '/mahasiswa/*': Mahasiswa,
    '/dosen': Dosen,
    '/dosen/*': Dosen,
    '/mk': Mk,
    '/mk/*': Mk,
    '/kelas': Kelas,
    '/kelas/*': Kelas
  };

  const prefix = '/admin/data';
</script>

<Router {routes} {prefix} />
