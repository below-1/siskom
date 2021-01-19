<script>
  import { onMount } from 'svelte';
  import { createPopper } from '@popperjs/core';
  import logo from 'siskom-web-admin/icons/triangle.svg';
  import Logo from 'siskom-web-admin/components/commons/Logo.svelte';
  import { periode, phase, user } from 'siskom-web-admin/stores/index.js';
  import FaCogs from 'svelte-icons/fa/FaCogs.svelte';
  import FaUserCog from 'svelte-icons/fa/FaUserCog.svelte';
  import FaBox from 'svelte-icons/fa/FaBox.svelte';

  let logoSize = 24;

  let menuItems = [
    { label: 'pengaturan', path: 'setting', icon: FaCogs  }
  ];
  const dataMenuItems = [
    { label: 'mahasiswa', path: 'mahasiswa' },
    { label: 'dosen', path: 'dosen' },
    { label: 'mata kuliah', path: 'mk' },
    { label: 'kelas', path: 'kelas' },
    { label: 'periode', path: 'periode' },
    { label: 'ruangan', path: 'room' }
  ];

  let user_dropdown;
  let user_button;
  let userDropdownHide = true;
  $: tahun = $periode ? $periode.tahun : 2007;
  $: semester = $periode ? $periode.semester : 1;
  $: currentUserId = $user ? $user.id : null;
  $: currentPhase = $phase ? $phase : 'REGISTRATION';

  $: userMenus = [
    { label: 'daftar user', path: '/#/admin/users' },
    { label: 'ganti password', path: `/#/admin/users/${currentUserId}/change-password` },
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

<nav class="fixed left-0 top-0 bottom-0 w-56 flex flex-col bg-indigo-800 text-white">
  <div class="flex items-center p-4 bg-indigo-900">
    <div class="logo mr-2">
      <Logo />
    </div>
    <div>
      <span class="text-xl font-bold">siskom</span>
      <span class="text-xl">/admin</span>
    </div>
  </div>

  <ul 
    class="bg-indigo-800 text-sm text-white flex flex-col"
  >
      <li class="text-lg font-black text-gray-400 p-4">Data</li>
    {#each dataMenuItems as menu (menu.path)}
      <li>
        <a 
          class="block p-4 py-2 hover:bg-indigo-700 font-bold visited:text-gray-100" 
          href={`/#/admin/data/${menu.path}`}
        >{menu.label}</a>
      </li>
    {/each}
  </ul>

  <a 
    class="block p-4 py-3 hover:bg-indigo-700 font-bold visited:text-gray-100 text-sm" 
    href='/#/admin/scheduler'
  >penjadwalan</a>

  <a 
    class="block p-4 py-3 hover:bg-indigo-700 font-bold visited:text-gray-100 text-sm" 
    href='/#/admin/setting'
  >pengaturan</a>

  <a 
    class="block p-4 py-3 hover:bg-indigo-700 font-bold visited:text-gray-100 text-sm" 
    href='/#/admin/logout'
  >logout</a>
</nav>
