<script>
  export let avatar;
  export let name;
  export let subtitle;
  export let menus;
  export let avatarSize = 36;
</script>

<ul class="">
  <li class="bg-gray-200 hover:bg-gray-300">
    <a href='/#/app/me_mhs' class="flex items-center w-full h-full py-4 px-4">
      <img src={avatar} height={avatarSize} width={avatarSize} class="mr-2" />
      <div class="text-sm">
        <div class="font-bold">{name}</div>
        <div class="text-xs font-semibold">{subtitle}</div>
      </div>
    </a>
  </li>
  {#each menus as menu (menu.label)}
    {#if (menu.header)}
      <li>
        <div class="flex items-center w-full h-full py-2 px-4 text-sm font-black text-gray-600 capitalize">
          {menu.label}
        </div>
      </li>
    {:else}
      <a href={menu.path} class="hover:bg-gray-300 flex items-center pl-6 py-4 text-sm">
        <div class="h-5 w-5 mr-2 text-gray-600">
          <svelte:component this={menu.icon}></svelte:component>
        </div>
        <div class="text-gray-600 hover:text-gray-800 font-semibold">
          {menu.label}
        </div>
      </a>
    {/if}
  {/each}
</ul>