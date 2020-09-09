<script>
  import { onMount } from 'svelte';
  // import { load as loadStorage } from 'siskom/commons/storage.js';
  // import DetailMahasiswa from 'siskom/components/commons/mahasiswa/detail.svelte';
  import IoIosCube from 'svelte-icons/io/IoIosCube.svelte'
  import IoIosContact from 'svelte-icons/io/IoIosContact.svelte'
  import IoIosCalendar from 'svelte-icons/io/IoIosCalendar.svelte'
  import FaCheckDouble from 'svelte-icons/fa/FaCheckDouble.svelte'
  import FaFileExport from 'svelte-icons/fa/FaFileExport.svelte'
  import FaFileImport from 'svelte-icons/fa/FaFileImport.svelte'

  const personalMenus = [
    { label: 'Info', path: '/#/app/me_mhs/info', icon: IoIosContact },
    { label: 'IPK', path: '/#/app/me_mhs/schedule', icon: IoIosCube },
    { label: 'Jadwal', path: '/#/app/me_mhs/schedule', icon: IoIosCalendar },
    { label: 'Transkrip Nilai', path: '/#/app/me_mhs/transkrip', icon: FaCheckDouble },
    { label: 'KRS', path: '/#/app/me_mhs/krs', icon: FaFileExport },
    { label: 'KHS', path: '/#/app/me_mhs/khs', icon: FaFileImport }
  ]

  const ilkomMenus = [
  ]

  let id = null;
  onMount(() => {
    const userRaw = localStorage.getItem('siskom.user');
    if (userRaw) {
      const user = JSON.parse(userRaw);
      id = user.targetId;
    }
  });
</script>

<h2 class="text-3xl text-gray-700 font-black mb-4 text-center">Data Personal</h2>
<div class="grid grid-cols-2 gap-3 mb-8 p-4 md:p-0 md:grid-cols-3">
  {#each personalMenus as menu (menu.label)}
    <a 
      href={menu.path}
      class="p-8 bg-gray-100 rounded flex flex-col items-center justify-center font-bold text-gray-600 hover:text-gray-900"
    >
      <div class="h-20 w-20">
        <svelte:component this={menu.icon}></svelte:component>
      </div>
      <div class="text-2xl my-2">{menu.label}</div>
    </a>
  {/each}
</div>
<h2 class="text-3xl text-gray-700 font-black mb-4 text-center">Jurusan</h2>

<!-- <DetailMahasiswa {id} prefix="/app/me_mhs">
</DetailMahasiswa> -->
