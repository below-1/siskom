<script>
  import { fade, slide } from 'svelte/transition';
  import MdMoreHoriz from 'svelte-icons/md/MdMoreHoriz.svelte';
  import RespMenu from './RespMenu.svelte';
  import RespSideInfo from './RespSideInfo.svelte';

  export let menus = [];
  export let avatar;
  export let title = '';
  export let subtitle = '';
  export let meHref = '';

  let showMenu = false;
</script>

<style>
  .mobile-menu {
    position: fixed;
    right: 0;
    left: 0;
    bottom: 0;
    top: 4rem;
  }
</style>

<div class="flex items-center px-4 bg-black text-white h-16 fixed top-0 right-0 left-0">
  <div class="logo mr-2">
    <Logo />
  </div>
  <div class="font-bold text-xl">siskom</div>
  <input class="appearance-none bg-gray-800 rounded mx-2 px-2 font-bold text-gray-200" placeholder="keyword..." />
  <div class="flex-grow"></div>
  <div class="flex items-center justify-end font-semibold text-sm md:hidden">
    <button 
      class="p-2 h-10 w-10 font-semibold"
      on:click={() => {
        showMenu = !showMenu
      }}
    >
      <MdMoreHoriz />
    </button>
  </div>
</div>
{#if showMenu}
  <div class="mobile-menu bg-white shadow-xl" transition:slide>
    <ul class="w-full">
      <li class="hover:bg-gray-200">
        <slot name="profile-section"></slot>
      </li>
      {#each menus as menu (menu.label)}
        {#if (menu.header)}
          <li>
            <div class="flex items-center w-full h-full py-2 px-4 font-semibold">
              {menu.label}
            </div>
          </li>
        {:else}
          <li class="border-b border-gray-300 hover:bg-gray-200">
            <a href={menu.path} class="flex items-center w-full h-full py-2 px-4 text-sm">
              {menu.label}
            </a>
          </li>
        {/if}
      {/each}
    </ul>
  </div>
{/if}
<div class="notification">
</div>
<div class="flex flex-col bg-gray-300 mt-16">
  <div class="flex-grow flex">
    <div class="hidden md:block md:w-1/5 p-4">
      <RespMenu {menus} {title} {avatar} {subtitle} {meHref} />
    </div>
    <div class="w-full md:w-3/5 md:px-4 md:py-4">
      <slot name="content"></slot>
    </div>
    <div class="hidden md:block w-1/5 p-4">

      <RespSideInfo />

      <div class="bg-white">
        <div class="font-black text-gray-800 text-lg p-2">Notifikasi</div>
        <ul class="w-full text-gray-800">
          <li class="flex flex-col px-4 py-2 border-b border-gray-300">
            <div class="font-medium text-sm">fase penginputan krs dimulai</div>
            <div class="font-light text-xs">3 hari yang lalu</div>
          </li>
          <li class="flex flex-col px-4 py-2 border-b border-gray-300">
            <div class="font-medium text-sm">kelas IMK A dibuka</div>
            <div class="font-light text-xs">5 hari yang lalu</div>
          </li>
          <li class="flex flex-col px-4 py-2 border-b border-gray-300">
            <div class="font-medium text-sm">Nilai Kecerdasan Buatan</div>
            <div class="font-light text-xs">1 minggu yang lalu</div>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <footer class="px-4 py-6 bg-gray-200 border-t border-gray-300 flex flex-col items-center justify-center text-gray-700 text-center">
    <div class="font-semibold text-xs">Sistem Informasi Akademik Ilmu Komputer Nusa Cendana</div>
    <div class="text-xs">
      Periode 2007/2008, Semester 1
    </div>
  </footer>
</div>
