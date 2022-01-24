<script>
  import { onMount } from 'svelte';
  import { createPopper } from '@popperjs/core';
  import logo from 'siskom-web-admin/icons/triangle.svg';
  import Logo from 'siskom-web-admin/components/commons/Logo.svelte';
  import { periode, phase, user } from 'siskom-web-admin/stores/index.js';
  import FaCogs from 'svelte-icons/fa/FaCogs.svelte'
  import FaBox from 'svelte-icons/fa/FaBox.svelte';

  import FaBookReader from 'svelte-icons/fa/FaBookReader.svelte'
  import FaChalkboardTeacher from 'svelte-icons/fa/FaChalkboardTeacher.svelte'
  import FaArchive from 'svelte-icons/fa/FaArchive.svelte'
  import FaEdit from 'svelte-icons/fa/FaEdit.svelte'
  import FaCalendarAlt from 'svelte-icons/fa/FaCalendarAlt.svelte'
  import FaChessRook from 'svelte-icons/fa/FaChessRook.svelte'
  import FaBezierCurve from 'svelte-icons/fa/FaBezierCurve.svelte'
  import FaUserCog from 'svelte-icons/fa/FaUserCog.svelte'

  import {
    JoInput
  } from 'siskom-web-commons';

  let logoSize = 24;

  let menuItems = [
    { label: 'pengaturan', path: 'setting', icon: FaCogs  }
  ];
  const dataMenuItems = [
    { label: 'mahasiswa', path: 'data/mahasiswa', icon: FaBookReader },
    { label: 'dosen', path: 'data/dosen', icon: FaChalkboardTeacher },
    { label: 'mata kuliah', path: 'data/mk', icon: FaArchive },
    { label: 'kelas', path: 'data/kelas', icon: FaEdit },
    { label: 'periode', path: 'data/periode', icon: FaCalendarAlt },
    { label: 'ruangan', path: 'data/room', icon: FaChessRook },
    { label: 'pengaturan', path: 'setting', icon: FaCogs  },
    { label: 'penjadwalan', path: 'scheduler', icon: FaBezierCurve  },
    { label: 'akun', path: 'account', icon: FaUserCog  },
  ];

  let keyword = '';
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

  svg {
    fill: currentColor;
  }
</style>

<nav 
  class="fixed top-0 left-0 right-0 h-12 flex items-center bg-white px-8" 
  style="left: 14rem;">
  <button class="appearance-none rounded-full h-6 w-6 text-gray-900 mr-2">
    <FaCogs/>
  </button>
  <div class="text-white px-2 py-1 text-xs font-bold rounded bg-indigo-700 mr-2">periode 2021/2022, semester 1</div>
  <div class="text-white px-2 py-1 text-xs font-bold rounded bg-indigo-700">fase penjadwalan</div>
  <div class="flex-grow"></div>
  <JoInput bind:value={keyword} placeholder="Cari..." />
</nav>

<nav class="fixed top-0 left-0 bottom-0 w-56 flex flex-col bg-gray-900 text-white shadow-xl">

  <div class="flex items-center p-4">
    <div class="logo p-2 rounded-full bg-gray-100 border border-gray-300 mr-2">
      <Logo size={32} />
    </div>
    <div>
      <span class="text-xl text-blue-100 font-bold mb-0">siskom / admin</span>
      <span class="text-sm">olah data akademik</span>
    </div>
  </div>

  <div class="border-t border-gray-800"></div>

  <ul 
    class="text-sm flex flex-col"
  >
    {#each dataMenuItems as menu (menu.path)}
      <li>
        <a 
          class="block p-4 hover:bg-indigo-700 font-bold visited:text-gray-100 flex items-center" 
          href={`/#/admin/${menu.path}`}
        >
          {#if menu.icon}
            <div class="w-4 h-4 mr-4 text-gray-200">
              <svelte:component this={menu.icon} />
            </div>
          {/if}
          <span>{menu.label}</span>
        </a>
      </li>
    {/each}
  </ul>
</nav>
