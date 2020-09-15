<script>
  import { setContext } from 'svelte';
  import { writable } from 'svelte/store';
  import Router, { location } from 'svelte-spa-router';
  import {
    JoAsyncContent
  } from 'siskom-web-commons';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import GQLDetailMahasiswa from 'siskom-web-user/graphql/DetailMahasiswa.js';
  import Schedule from './Schedule.svelte';
  import Transkrip from './Transkrip.svelte';
  import KRS from './Krs.svelte';
  import KHS from './Khs.svelte';
  import Info from './Info.svelte';
  import IPChart from './IPChart.svelte';
  import IPTable from './IPTable.svelte';
  import * as context_key from './context.js';

  export let id;
  export let prefix;
  export let ilkomBasePath;
  export let showAvatar = false;

  let networkStatus = 'loading';
  const mahasiswa = writable({
    id: 0,
    nama: 'jordan l. u. meta',
    nim: '1306082024',
    pa: {
      nama: '',
      nip: '',
      id: 0
    }
  });
  const attendedPeriode = writable([]);
  $: load_mahasiswa({ id });

  setContext(context_key.mahasiswa, mahasiswa);
  setContext(context_key.attendedPeriode, attendedPeriode);
  setContext(context_key.ilkomBasePath, ilkomBasePath);
  setContext(context_key.prefix, prefix);

  const menus = [
    { label: 'info', path: 'info' },
    { label: 'jadwal', path: 'schedule' },
    { label: 'transkrip', path: 'transkrip' },
    { label: 'krs', path: 'krs' },
    { label: 'khs', path: 'khs' },
    { label: 'akm', path: 'akm' },
    { label: 'ip dan ipk', path: 'ip' }
  ];

  const routes = {
    '/info': Info,
    '/schedule': Schedule,
    '/transkrip': Transkrip,
    '/krs': KRS,
    '/khs': KHS,
    '/ip-table': IPTable,
    '/ip-chart': IPChart
  };

  async function load_mahasiswa ({ id }) {
    if (!id) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLDetailMahasiswa,
        variables: {
          id
        }
      });
      mahasiswa.set(result.data.mahasiswaById);
      attendedPeriode.set(result.data.attendedPeriode.nodes);
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }
</script>

<style>
</style>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <Router {routes} {prefix} />
  </div>
</JoAsyncContent>