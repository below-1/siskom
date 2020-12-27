<script>
  import { onMount } from 'svelte';
  import Router from 'svelte-spa-router';
  import RespLayout from 'siskom-web-user/components/commons/RespLayout.svelte';
  import * as common_menus  from 'siskom-web-user/commons/menus.js';
  import { 
    user,
    mahasiswa,
    dosen
  } from 'siskom-web-commons';
  import build_avatar from 'siskom-web-user/commons/buildAvatar.js';
  import SelfDosen from './dosen/Me.svelte';
  import HomeDosen from './dosen/Home.svelte';
  import HomeMahasiswa from './mahasiswa/Home.svelte';
  import SelfMahasiswa from './mahasiswa/Me.svelte';
  import Ilkom from './ilkom.svelte';
  import Logout from "siskom-web-user/components/auth/Logout.svelte";

  function getDataFromSession ({ user, mahasiswa, dosen }) {
    let menus = [];
    let title = '';
    let subtitle = '';
    let avatar = '';
    let prefix = '';
    let SelfComponent = null;

    if (user) {
      if (user.tipeUser == 'MAHASISWA') {
        menus = common_menus.mahasiswa;
        title = mahasiswa.nama;
        subtitle = mahasiswa.nim;
        avatar = build_avatar(mahasiswa.nim, 32);
        prefix = '/mahasiswa';
        SelfComponent = HomeMahasiswa;
      } else if (user.tipeUser == 'DOSEN') {
        menus = common_menus.dosen;
        title = dosen.nama;
        subtitle = dosen.nip;
        avatar = build_avatar(dosen.nip, 64);
        prefix = '/dosen';
        SelfComponent = SelfDosen;
      }
    }

    console.log(menus);
    return {
      menus,
      subtitle,
      avatar,
      title,
      SelfComponent,
      prefix
    }
  }

  let showMenu = false;
  $: ({ 
    prefix, 
    menus, 
    avatar, 
    title, 
    subtitle,
    SelfComponent
  } = getDataFromSession({
    user: $user,
    mahasiswa: $mahasiswa,
    dosen: $dosen
  }));
  const routes = {
    '/auth/logout': Logout,
    '/ilkom': Ilkom,
    '/ilkom/*': Ilkom,
    '/me_dos': HomeDosen,
    '/me_dos/*': SelfDosen,
    '/me_mhs': HomeMahasiswa,
    '/me_mhs/*': SelfMahasiswa
  };

  onMount(() => {
    console.log('app/index.svelte');
  })
</script>


<RespLayout
  {menus}
  {title}
  {subtitle}
  {avatar}
  meHref="/#/app/me_mhs/info"
>
  <div slot="content" class="px-4 md:px-0">
    <Router {routes} prefix="/app" />
  </div>
</RespLayout>