<script>
  import { onMount } from 'svelte';
  import { fade, slide } from 'svelte/transition';
  import MdMoreHoriz from 'svelte-icons/md/MdMoreHoriz.svelte';
  import FaBars from 'svelte-icons/fa/FaBars.svelte'
  import RespMenu from './RespMenu.svelte';
  import RespSideInfo from './RespSideInfo.svelte';
  import logo from 'siskom-web-user/icons/abstract.svg';
  import {
    user,
    mahasiswa,
    dosen,
    periode
  } from 'siskom-web-commons';

  export let menus = [];
  export let avatar;

  $: name = $user.tipeUser == 'MAHASISWA' ? $mahasiswa.nama : $dosen.nama;
  $: tahun = $periode.tahun;
  $: semester = $periode.semester;
  $: subtitle = $user.tipeUser == 'MAHASISWA' ? $mahasiswa.nim : $dosen.nip;

  let showMenu = false;
  let logoSize = 24;
  const body = document.getElementsByTagName('body')[0];

  function toggleMenu () {
    showMenu = !showMenu;
    if (showMenu) {
      body.style.position = 'fixed';
    } else {
      body.style.position = 'static';
    }
  }
</script>

<style>
  .mobile-menu {
    position: fixed;
    right: 0;
    left: 0;
    bottom: 0;
    top: 3.5rem;
    z-index: 100;
    overflow-y: scroll;
  }
</style>

<nav class="bg-black text-white fixed top-0 left-0 right-0 text-sm">
  <div class="px-4 flex items-center h-16">
    <div class="flex items-center">
      <img alt="logo" class="mr-2" src={logo} height={logoSize} width={logoSize} />
      <span class="font-bold tracking-wider text-xl">siskom</span>
    </div>
    <div class="flex-grow"></div>
    <a href="/#/about" class="hidden md:block mr-8 font-bold">
      jadwal
    </a>
    <a href="/#/about" class="hidden md:block mr-8 font-bold">
      about us
    </a>
    <button 
      on:click={toggleMenu}
      class="appearance-none border-none text-white p-2 h-8 w-10 ml-2 md:hidden"
    >
      <FaBars />
    </button>
  </div>
</nav>

{#if showMenu}
  <nav
    class="fixed bottom-0 left-0 right-0 overflow-y-scroll bg-gray-100"
    style="top: 3rem;"
  >
    <RespMenu
      {avatar}
      {name}
      {subtitle}
      {menus}
      avatarSize={logoSize + 12}
    />
  </nav>
{/if}

<!--
<nav
  class="hidden md:block w-64 border-r border-gray-400 fixed bottom-0 left-0 overflow-y-scroll bg-gray-100"
  style="top: 2.5rem;"
>
  <RespMenu
    {avatar}
    {name}
    {subtitle}
    {menus}
    avatarSize={logoSize + 12}
  />
</nav>
-->

<section 
  class="mt-16" 
  style="background: linear-gradient(to bottom, rgb(245, 245, 245), #fff 400px)"
>
  <div class="px-4 bg-gray-100 h-12 border-b border-gray-300 flex items-center justify-center mt-12 md:h-8 md:mt-0 md:px-0">
    <div class="text-sm font-bold mr-4">periode {tahun}/{tahun + 1}, semester {semester}</div>
    <div class="h-10 bg-blue-700 text-white px-4 font-bold flex items-center text-sm md:h-6">fase: input mata kuliah</div>
  </div>

  <div class="flex flex-col" style="min-height: calc(100vh - 3rem);">
    <div class="my-12 md:px-24">
      <slot name="content"></slot>
    </div>

    <footer class="px-4 py-6 bg-gray-200 border-t border-gray-300 flex flex-col items-center justify-center text-gray-700 text-center">
      <div class="font-semibold text-xs">Sistem Informasi Akademik Ilmu Komputer Nusa Cendana</div>
      <div class="text-xs">
        Periode 2007/2008, Semester 1
      </div>
    </footer>
  </div>
</section>

