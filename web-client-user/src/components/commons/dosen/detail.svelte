<script>
  import { setContext } from 'svelte';
  import { writable } from 'svelte/store';
  import Router from 'svelte-spa-router';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoLink from 'siskom/components/commons/JoLink.svelte';
  import AvatarScope from './avatar-scope.svelte';
  import formatScheduleDayTime from 'siskom/commons/formatScheduleDayTime.js';
  import * as context_key from './context';
  import avatar_url from 'siskom/commons/avatar.js';
  import GQL_dosen_by_id from 'siskom/graphql/dosen-by-id.gql';
  import Pa from './pa.svelte';
  import Schedule from './schedule.svelte';
  import Info from './info.svelte';

  const dosen = writable(null);
  const routes = {
    '/info': Info,
    '/pas': Pa,
    '/schedules': Schedule
  };
  setContext(context_key.dosen, dosen);

  // States
  let networkStatus = 'loading';
  let totalActivePa = 0;
  let totalSchedule = 0;
  let periode = null;
  let schedules = [];
  let bimbinganPa = [];

  // Computed
  $: avatarUrl = !dosen ? undefined : `https://api.adorable.io/avatars/128/${dosen.nip}.png`;

  // Prop
  export let id;
  export let prefix;
  export let showAvatar = false;
  setContext(context_key.prefix, prefix);

  // Function
  function mahasiswaAvatar (nim) {
    return `https://api.adorable.io/avatars/128/${nim}.png`;
  }

  async function getDetailDosen ({ id }) {
    const result = await apolloClient.query({
      query: GQL_DetailDosen,
      variables: { id }
    })
    return result.data;
  }

  // Methods
  async function onIdChange({ id }) {
    if (!id) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_dosen_by_id,
        variables: {
          id
        }
      });
      console.log(result);
      dosen.set(result.data.dosen);
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
  }

  $: onIdChange({ id });
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    {#if showAvatar}
      <AvatarScope dosen={$dosen} />
    {/if}
    <Router {routes} {prefix} />
  </div>
</JoAsyncContent>