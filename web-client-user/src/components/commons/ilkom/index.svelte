<script>
  import Router, { location } from 'svelte-spa-router';
  import Dosens from '../dosen/List.svelte';
  import DetailDosen from './detail-dosen.svelte';
  import Mk from '../mk/List.svelte';
  import DetailMk from './detail-mk.svelte';
  import Kelas from '../kelas/List.svelte';
  // import DetailKelas from './detail-kelas.svelte';
  // import Mahasiswas from '../mahasiswa/list.svelte';
  // import DetailMahasiswa from './detail-mahasiswa.svelte';

  export let prefix;

  const routes = {
    '/dosens': Dosens,
    '/dosens/:id': DetailDosen,
    '/dosens/:id/*': DetailDosen,
    '/mks': Mk,
    '/mks/:id': DetailMk,
    '/kelas': Kelas,
    // '/kelas/:id': DetailKelas,
    // '/kelas/:id/*': DetailKelas,
    // '/mahasiswas': Mahasiswas,
    // '/mahasiswas/:id': DetailMahasiswa,
    // '/mahasiswas/:id/*': DetailMahasiswa
  };
</script>

<Router {routes} {prefix} />
