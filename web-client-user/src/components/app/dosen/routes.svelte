<script>
  import Router, { push as pushRoute } from 'svelte-spa-router';
  import Me from './me.svelte';
  import Logout from 'siskom/components/commons/logout.svelte';
  import Schedule from './schedule.svelte';
  import Kelas from './kelas.svelte';
  import MahasiswaPA from './mahasiswa-pa.svelte';
  import DosenList from './dosen-list.svelte';
  import DetailDosen from './detail-dosen.svelte';
  import DetailKelas from './detail-kelas.svelte';
  import AnggotaKelas from './anggota-kelas.svelte';
  import ListMk from 'siskom/components/commons/mk/list.svelte';
  import DetailMk from './detail-mk.svelte';

  const routes = {
    '/me': Me,
    '/logout': Logout,
    '/schedule': Schedule,
    '/kelas': Kelas,
    '/detail-kelas/:id': DetailKelas,
    '/pa': MahasiswaPA,
    '/dosens': DosenList,
    '/detail-dosen/:id': DetailDosen,
    '/anggota-kelas/:id': AnggotaKelas,
    '/mks': ListMk,
    '/detail-mk/:id': DetailMk
  };
</script>

<Router {routes} prefix='/dosen' />
