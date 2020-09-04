<script>
  export let menus = [];
  export let avatar;
  export let title = '';
  export let subtitle = '';
  export let meHref = '';
</script>

<ul class="w-full text-gray-600 border border-gray-300">
  <li class="bg-white mb-2">
    <a 
      href={meHref} 
      class="flex items-center w-full h-full p-4"
    >
      <img src={avatar} class="mr-2" />
      <div>
        <div class="font-black text-lg">{title}</div>
        <div class="font-black text-sm"> {subtitle}</div>
      </div>
    </a>
  </li>
  {#each menus as menu (menu.label)}
    {#if (menu.header)}
      <li class="bg-white">
        <div class="flex items-center w-full h-full py-3 px-4 font-black text-lg text-gray-800">
          {menu.label}
        </div>
      </li>
    {:else}
      <li class="hover:bg-gray-300 bg-white">
        <a href={menu.path} class="flex items-center w-full h-full py-3 px-4 text-sm font-bold">
          {menu.label}
        </a>
      </li>
    {/if}
  {/each}
</ul>