<script>
  import Router, { push as pushRoute } from 'svelte-spa-router';
  // import Schedule from './schedule.svelte';
  // import Transkrip from './transkrip.svelte';
  // import KRS from './krs.svelte';
  // import KHS from './khs.svelte';
  // import DetailKelas from './detail-kelas.svelte';
  import Dosen from './dosen.svelte';
  import DetailDosen from './detail-dosen.svelte';
  // import Me from './me.svelte';
  import Me2 from './me2.svelte';
  import Mk from 'siskom/components/commons/mk/list.svelte';
  import DetailMk from './detail-mk.svelte';
  import Logout from 'siskom/components/commons/logout.svelte';
  import Ilkom from './ilkom.svelte';
  // import DetailMahasiswa from 'siskom/components/commons/mahasiswa/detail.svelte';

  const routes = {
    '/me': Me2,
    '/me/*': Me2,
    '/logout': Logout,
    '/ilkom': Ilkom,
    '/ilkom/*': Ilkom
  };
</script>

<Router {routes} prefix='/mahasiswa' />
