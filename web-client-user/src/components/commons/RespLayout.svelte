<script>
  import { fade, slide } from 'svelte/transition';
  import MdMoreHoriz from 'svelte-icons/md/MdMoreHoriz.svelte';
  import RespMenu from './RespMenu.svelte';
  import RespSideInfo from './RespSideInfo.svelte';
  import logo from 'siskom-web-user/icons/abstract.svg';

  export let menus = [];
  export let avatar;
  export let title = '';
  export let subtitle = '';
  export let meHref = '';

  let showMenu = false;
  let logoSize = 24;
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

<nav class="bg-gray-900 text-white">
  <div class="px-4 md:px-0 md:mx-auto md:w-2/3 flex items-center h-12">
    <div class="flex items-center">
      <img class="mr-2" src={logo} height={logoSize} width={logoSize} />
      <span class="font-bold tracking-wider">siskom</span>
    </div>
    <div class="flex-grow"></div>
    <a href="/#/about" class="mr-8 font-bold">
      about
    </a>
    <button class="flex items-center appearance-none border-none">
      <img src={avatar} height={logoSize} width={logoSize} class="mr-2" />
      <span class="font-bold">jordan meta</span>
    </button>
  </div>
</nav>

<div class="px-4 bg-gray-100 h-12 border-b border-gray-300 flex items-center justify-center md:h-8 md:px-0">
  <div class="text-sm font-bold mr-4 md:h-8">periode 2019/2020, semester 12</div>
  <div class="h-10 bg-blue-700 text-white px-4 font-bold flex items-center text-sm md:h-6">fase: input mata kuliah</div>
</div>

<div class="flex flex-col" style="min-height: calc(100vh - 3rem);">

  <div class="md:w-2/3 md:mx-auto my-12">
    <slot name="content"></slot>
  </div>

  <footer class="px-4 py-6 bg-gray-200 border-t border-gray-300 flex flex-col items-center justify-center text-gray-700 text-center">
    <div class="font-semibold text-xs">Sistem Informasi Akademik Ilmu Komputer Nusa Cendana</div>
    <div class="text-xs">
      Periode 2007/2008, Semester 1
    </div>
  </footer>
</div>

<!-- <div class="flex items-center px-4 bg-black text-white h-16 fixed top-0 right-0 left-0">
  <div class="logo mr-2">
    <img src={logo} height={logoSize} width={logoSize} />
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
<nav class="w-64 fixed left-0 bottom-0" style="top: 4rem;">
  <RespMenu {menus} {title} {avatar} {subtitle} {meHref} />
</nav>
<div class="flex flex-col bg-gray-300 mt-16 ml-64">
  <div class="flex-grow flex">
    <div class="w-full md:w-4/5 md:px-4 md:py-4">
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
</div> -->
