<script>
  import Router from 'svelte-spa-router';

  export let routes;
  export let prefix;
  export let image;
  export let label;
</script>

<div class="h-full">
  <div class="mx-8 mt-12 py-4">
    <Router {prefix} {routes} />
  </div>
</div>
