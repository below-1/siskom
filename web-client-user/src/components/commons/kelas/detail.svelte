<script>
  import { setContext } from 'svelte';
  import { writable } from 'svelte/store';
  import Router from 'svelte-spa-router';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoNameAvatar from 'siskom/components/commons/JoNameAvatar.svelte';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import formatPeriode from 'siskom/commons/formatPeriode.js';
  import GQL_kelas_detail from 'siskom/graphql/kelas-detail.gql';
  import ScheduleMembers from './schedule-members.svelte';
  import Schedule from './schedule.svelte';
  import * as context_key from './context.js';

  export let id;
  export let prefix;

  // state
  const kelas = writable(null);
  let networkStatus = 'loading';

  setContext(context_key.id, id);
  setContext(context_key.kelas, kelas);

  // computed
  $: scheduled = $kelas && $kelas.mk.scheduled;
  $: ({ menus, routes } = buildMenusAndRoutes({ scheduled, prefix }));

  $: loadKelas({ id });

  async function loadKelas ({ id }) {
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_kelas_detail,
        variables: {
          id
        }
      });
      kelas.set(result.data.kelas);
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  function buildMenusAndRoutes ({ scheduled, prefix }) {
    let menus = [
      { label: 'peserta', path: `/#${prefix}/members` }
    ];
    let routes = {
      '/members': ScheduleMembers
    };
    if (scheduled) {
      menus = [
        { label: 'jadwal', path: `/#${prefix}/schedule` },
        ...menus
      ];
      routes['/schedule'] = Schedule;
    }
    return { menus, routes };
  }
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="bg-white px-4 py-6 mb-2 flex items-center">
      <JoNameAvatar name={$kelas.mk.nama} size='3xl' cls="w-20 mr-4" />
      <div>
        <div class="font-bold text-xl uppercase">kelas {$kelas.label}</div>
        <div class="font-semibold text-lg lowercase">{$kelas.mk.nama}</div>
        <div class="text-sm">{formatPeriode($kelas.periode)}</div>
      </div>
    </div>

    <div class="flex items-center bg-white">
      {#each menus as menu (menu.label)}
        <a
          href={menu.path}
          class="p-2 px-4 flex items-center justify-center text-lg font-semibold border-r border-gray-300"
        >
          {menu.label}
        </a>
      {/each}
    </div>
    <Router {routes} {prefix} />
  </div>
</JoAsyncContent>
