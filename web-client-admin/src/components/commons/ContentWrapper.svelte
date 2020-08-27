<script>
  import Router from 'svelte-spa-router';

  export let routes;
  export let prefix;
  export let image;
  export let label;
</script>

<div class="h-full">

  <div class="border-b border-gray-300 bg-white">
    <div class="flex items-center px-12 py-4">
      <img src={image} height={24} width={24} class="mr-4" />
      <span class="font-bold text-lg">{label}</span>
    </div>
  </div>

  <div class="mx-12 my-4">
    <Router {prefix} {routes} />
  </div>
</div>
