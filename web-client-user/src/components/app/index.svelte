<script>
  import Router from 'svelte-spa-router';
  import RespLayout from 'siskom-web-user/components/commons/RespLayout.svelte';
  import * as common_menus  from 'siskom-web-user/commons/menus.js';
  import { 
    user,
    mahasiswa,
    dosen,
    Logout
  } from 'siskom-web-commons';
  import build_avatar from 'siskom-web-user/commons/buildAvatar.js';
  // import SelfDosen from './dosen/me-two.svelte';
  import SelfMahasiswa from './mahasiswa/me.svelte';
  // import Ilkom from './ilkom.svelte';

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
        SelfComponent = SelfMahasiswa;
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
    // '/ilkom': Ilkom,
    // '/ilkom/*': Ilkom,
    // '/me_dosen': SelfDosen,
    // '/me_dosen/*': SelfDosen,
    '/me_mhs': SelfMahasiswa,
    '/me_mhs/*': SelfMahasiswa,
  };
</script>


<RespLayout
  {menus}
  {title}
  {subtitle}
  {avatar}
  meHref="/#/app/me_mhs/info"
>
  <div slot="content">
    <Router {routes} prefix="/app" />
  </div>
</RespLayout>