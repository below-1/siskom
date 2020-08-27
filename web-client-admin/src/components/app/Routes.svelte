<script>
  import Router from 'svelte-spa-router';
  import Data from './data/index.svelte';

  const routes = {
    '/data': Data,
    '/data/*': Data
  };

  const prefix = '/admin';
</script>

<Router {routes} {prefix} />

