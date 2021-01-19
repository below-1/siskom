<script>
  import Router from 'svelte-spa-router';
  import Data from './data/index.svelte';
  import Setting from './Setting.svelte';
  import Scheduler from './Scheduler.svelte';
  import Logout from '../auth/Logout.svelte';

  const routes = {
    '/data': Data,
    '/data/*': Data,
    '/setting': Setting,
    '/scheduler': Scheduler,
    '/logout': Logout
  };

  const prefix = '/admin';
</script>

<Router {routes} {prefix} />

