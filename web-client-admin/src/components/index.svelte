<script>
  import { onMount } from 'svelte';
  import Router from 'svelte-spa-router';
  import App from './app/index.svelte';
  import Login from './auth/Login.svelte';
  import { 
    JoAsyncContent,
    JoNotification,
    JoWarning
  } from 'siskom-web-commons';
  import { 
    notification,
    warning
  } from 'siskom-web-admin/stores/index.js';
  import updateSession from 'siskom-web-admin/services/updateSession.js';

  const routes = {
    '/': Login,
    '/admin': App,
    '/admin/*': App
  }

  onMount(async () => {
    try {
      await updateSession();
    } catch (err) {
      console.log('error updating session');
      console.log(err);
    }
  });
</script>

<JoNotification {notification}></JoNotification>
<JoWarning {warning}></JoWarning>
<Router {routes}></Router>
