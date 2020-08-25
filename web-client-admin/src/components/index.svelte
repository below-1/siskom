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

  const routes = {
    '/': Login,
    '/admin': App,
    '/admin/*': App
  }
</script>

<style type="text/css">
body {
  margin: 0 !important;
  overflow-x: hidden !important;
}
</style>

<JoNotification {notification}></JoNotification>
<JoWarning {warning}></JoWarning>
<Router {routes}></Router>
