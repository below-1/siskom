<script>
  import { setContext } from 'svelte';
  import { writable } from 'svelte/store';
  import Router, { location } from 'svelte-spa-router';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import AvatarScope from './avatar-scope.svelte';
  import apollo_client from 'siskom/apollo-client.js';
  import GQL_detail_mahasiswsa from 'siskom/graphql/detail-mahasiswa.gql';
  import Schedule from './schedule.svelte';
  import Transkrip from './transkrip.svelte';
  import KRS from './krs.svelte';
  import KHS from './khs.svelte';
  import Info from './info.svelte';
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
    { label: 'akm', path: 'akm' }
  ];

  const routes = {
    '/info': Info,
    '/schedule': Schedule,
    '/transkrip': Transkrip,
    '/krs': KRS,
    '/khs': KHS
  };

  async function load_mahasiswa ({ id }) {
    if (!id) return;
    networkStatus = 'loading';
    try {
      const result = await apollo_client.query({
        query: GQL_detail_mahasiswsa,
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
    <!-- Show avatar at me_mhs/info -->
    {#if showAvatar || $location == '/app/me_mhs/info'}
      <AvatarScope mahasiswa={$mahasiswa} />
    {/if}
    <Router {routes} {prefix} />
  </div>
</JoAsyncContent>