<script>
  import { setContext } from 'svelte';
  import { writable } from 'svelte/store';
  import { gql } from '@apollo/client/core';
  import Router from 'svelte-spa-router';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoAsyncContent,
    JoButton,
    JoLink,
    formatScheduleDayTime
  } from 'siskom-web-commons';
  import AvatarScope from './AvatarScope.svelte';
  import * as context_key from './context';
  import buildAvatar from 'siskom-web-user/commons/buildAvatar.js';
  // import Pa from './pa.svelte';
  // import Schedule from './schedule.svelte';
  import Info from './Info.svelte';

  const GQLDetail = gql`
    query DetailDosen($id: Int!) {
      dosen: dosenById (id: $id) {
        id
        nama
        nip
        nodeId
        sex
        status
      }
    }
  `;

  const dosen = writable(null);
  const routes = {
    '/info': Info,
    // '/pas': Pa,
    // '/schedules': Schedule
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
      query: GQLDetail,
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
        query: GQLDetail,
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