<script>
  import { onMount } from 'svelte';
  import Router, { push } from 'svelte-spa-router';
  import App from './app/index.svelte';
  import Login from './auth/Login.svelte';
  import { 
    JoAsyncContent,
    JoNotification,
    JoWarning,
    notification,
    warning
  } from 'siskom-web-commons';
  import updateSession from 'siskom-web-user/services/updateSession.js';

  let initDone = false;
  const routes = {
    '/': Login,
    '/app': App,
    '/app/*': App
  }

  onMount(async () => {
    const token = localStorage.getItem('siskom.token');
    if (token) {
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
