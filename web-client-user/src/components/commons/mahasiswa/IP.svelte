<script>
  import { onMount, getContext } from 'svelte';
  import Router, { push as pushRoute, location } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import IPChart from './IPChart.svelte';
  import IPTable from './IPTable.svelte';

  const routes = {
    '/': IPTable,
    '/chart': IPChart,
    '/table': IPTable
  };
  $: prefix = ($location).endsWith('/') ? $location : $location + '/';
</script>

<div>{prefix}</div>
<Router {routes} {prefix} />