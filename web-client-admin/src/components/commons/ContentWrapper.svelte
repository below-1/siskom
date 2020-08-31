<script>
  import Router from 'svelte-spa-router';

  export let routes;
  export let prefix;
  export let image;
  export let label;
</script>

<div class="h-full">

  <div class="border-b border-gray-300 bg-white h-16 fixed top-0 right-0" style="left: 14rem;">
    <div class="flex items-center px-12 h-full">
      <img src={image} height={24} width={24} class="mr-4" />
      <span class="font-bold text-lg">{label}</span>
    </div>
  </div>

  <div class="mx-12 mt-16 py-4">
    <Router {prefix} {routes} />
  </div>
</div>
