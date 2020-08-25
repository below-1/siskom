<script>
  import { onMount } from 'svelte';
  import { createPopper } from '@popperjs/core';
  import logo from 'siskom-web-admin/icons/triangle.svg';
  import { periode, phase, user } from 'siskom-web-admin/stores/index.js';
  import FaCogs from 'svelte-icons/fa/FaCogs.svelte';
  import FaUserCog from 'svelte-icons/fa/FaUserCog.svelte';
  import FaBox from 'svelte-icons/fa/FaBox.svelte';

  let logoSize = 24;

  let menuItems = [
    { label: 'pengaturan', path: 'settings', icon: FaCogs  }
  ];

  let user_dropdown;
  let user_button;
  let userDropdownHide = true;
  $: current_user_id = $user ? $user.id : null;

  $: userMenus = [
    { label: 'daftar user', path: '/#/admin/users' },
    { label: 'ganti password', path: `/#/admin/users/${current_user_id}/change-password` },
    { label: 'logout', path: '/#/admin/logout' }
  ];

  onMount(() => {
    createPopper(user_button, user_dropdown, {
      placement: 'bottom-start',
      strategy: 'fixed'
    });
  });
</script>

<style>
  .userDropdownHide {
    visibility: hidden;
    pointer-events: none;
  }
</style>

<nav class="pl-4 flex items-stretch bg-black text-white fixed top-0 left-0 right-0 h-12">
  <div class="flex items-center">
    <div class="logo mr-2">
      <Logo />
    </div>
    <span class="text-xl font-bold">siskom</span>
    <span class="text-xl">/admin</span>
  </div>
  <div class="flex-grow">
  </div>
  <div class="flex justify-end items-stretch pr-4 text-gray-100">
    <a href="#/admin/data/kelas" class="p-3 flex items-center">
      <span class="w-6">
        <FaBox />
      </span>
    </a>
    <button 
      bind:this={user_button}
      on:click={() => {
        userDropdownHide = !userDropdownHide;
      }}
      class="p-3 flex items-center"
    >
      <span class="w-6">
        <FaUserCog />
      </span>
    </button>
    <ul 
      bind:this={user_dropdown} 
      class="bg-indigo-900 text-sm text-white shadow-xl"
      class:userDropdownHide
    >
      {#each userMenus as menu}
        <li class="p-2 border-b border-gray-300">
          <a class="w-full h-full" href={menu.path}>
            {menu.label}
          </a>
        </li>
      {/each}
    </ul>
    <a href="#/admin/settings" class="p-3 flex items-center">
      <span class="w-6">
        <FaCogs />
      </span>
    </a>
  </div>
  <div class="flex items-center bg-gray-900 px-2 pr-4 py-1 text-xs font-semibold">
    <div>Periode 
      {$periode.tahun} / 
      {$periode.tahun + 1}, 
      semester {$periode.semester}</div>
    <div class="ml-2 text-white bg-teal-600 font-bold px-2">
      phase: {$phase.toLowerCase()}
    </div>
  </div>
</nav>
