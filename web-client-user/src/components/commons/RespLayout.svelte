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
  let logoSize = 28;
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

<nav class="bg-gray-900 text-white fixed top-0 left-0 right-0 md:static">
  <div class="px-4 md:px-0 md:mx-auto md:w-2/3 flex items-center h-12">
    <div class="flex items-center">
      <img alt="logo" class="mr-2" src={logo} height={logoSize} width={logoSize} />
      <span class="text-xl font-bold tracking-wider">siskom</span>
    </div>
    <div class="flex-grow"></div>
    <a href="/#/about" class="hidden md:block mr-8 font-bold">
      about
    </a>
    <button class="flex items-center appearance-none border-none">
      <img src={avatar} height={logoSize} width={logoSize} class="mr-2" />
      <span class="font-bold hidden md:block">{name}</span>
    </button>
    <button 
      on:click={toggleMenu}
      class="appearance-none border-none text-white p-2 h-10 w-12 ml-2 md:hidden"
    >
      <FaBars />
    </button>
  </div>
</nav>

{#if showMenu}
  <div class="mobile-menu bg-white shadow-xl">
    <ul class="w-full">
      <li class="hover:bg-gray-200">
        <a href='/#/app/me_mhs' class="flex items-center w-full h-full py-2 px-4">
          <img src={avatar} height={logoSize + 20} width={logoSize + 20} class="mr-2" />
          <div class="text-lg">
            <div class="font-semibold">{name}</div>
            <div class="text-sm">{subtitle}</div>
          </div>
        </a>
      </li>
      {#each menus as menu (menu.label)}
        {#if (menu.header)}
          <li>
            <div class="flex items-center w-full h-full py-2 px-4 text-xl font-black text-gray-800 capitalize">
              {menu.label}
            </div>
          </li>
        {:else}
          <a href={menu.path} class="border-b-2 border-dashed border-gray-400 hover:bg-gray-200 flex items-center pl-8 py-2">
            <div class="h-10 w-10 p-2 rounded-full bg-gray-100 mr-2 text-gray-700">
              <svelte:component this={menu.icon}></svelte:component>
            </div>
            <div class="text-gray-800 font-bold">
              {menu.label}
            </div>
          </a>
        {/if}
      {/each}
    </ul>
  </div>
{/if}

<div class="px-4 bg-gray-100 h-12 border-b border-gray-300 flex items-center justify-center mt-12 md:h-8 md:mt-0 md:px-0">
  <div class="text-sm font-bold mr-4">periode {tahun}/{tahun + 1}, semester {semester}</div>
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

