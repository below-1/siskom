<script>
  import { onMount } from 'svelte';
  import Router, { push } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import App from './app/index.svelte';
  import Login from './auth/Login.svelte';
  import { 
    JoAsyncContent,
    JoNotification,
    JoWarning,
    notification,
    warning
  } from 'siskom-web-commons';
  import CurrentUser from 'siskom-web-user/graphql/CurrentUser.js';
  import updateSession from 'siskom-web-user/services/updateSession.js';

  let initDone = false;
  const routes = {
    '/': Login,
    '/app': App,
    '/app/*': App
  }


  onMount(async () => {

    let user = null;

    try {
      const result = await apolloClient.query({
        query: CurrentUser
      })
      const { currentAppUser } = result.data;
      user = currentAppUser;
    } catch (err) {
      console.log(err.message)
      alert('terjadi kesalahan')
      // loading forever
      return
    }

    if (user) {
      await updateSession();
    }
    initDone = true;
  });
</script>

{#if initDone}
<JoNotification {notification}></JoNotification>
<JoWarning {warning}></JoWarning>
<Router {routes}></Router>
{:else}
<div>loading...</div>
{/if}
