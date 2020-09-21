<script>
  import { setContext } from 'svelte';
  import { writable } from 'svelte/store';
  import Router from 'svelte-spa-router';
  import apolloClient from 'siskom-web-user/apolloClient.js';

  import {
    JoAsyncContent,
    JoNameAvatar,
    formatPeriode
  } from 'siskom-web-commons';
  import GQLKelasDetail from 'siskom-web-user/graphql/KelasDetail.js';
  import ScheduleMembers from './ScheduleMembers.svelte';
  import Schedule from './Schedule.svelte';
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
        query: GQLKelasDetail,
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

<h2 class="text-3xl font-black my-6">Detail Kelas</h2>
<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="my-6 flex items-center">
      <JoNameAvatar name={$kelas.mk.nama} size='3xl' cls="w-20 mr-4" />
      <div>
        <div class="font-semibold text-lg">Kelas {$kelas.label}</div>
        <div class="font-semibold text-lg">{$kelas.mk.nama}</div>
        <div class="font-semibold">{formatPeriode($kelas.periode)}</div>
      </div>
    </div>

    <div class="flex items-center bg-gray-100 border-dashed border-2 border-gray-400">
      {#each menus as menu (menu.label)}
        <a
          href={menu.path}
          class="py-3 px-4 flex items-center justify-center text-lg font-semibold border-r border-gray-300"
        >
          {menu.label}
        </a>
      {/each}
    </div>

    <Router {routes} {prefix} />
  </div>
</JoAsyncContent>
