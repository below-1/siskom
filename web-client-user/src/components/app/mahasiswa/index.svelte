<script>
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js'
  import { load as loadStorage, set as setStorage } from 'siskom/commons/storage.js';
  import RespLayout from 'siskom/components/commons/resp-layout.svelte';
  import Routes from './routes.svelte';

  let showMenu = false;
  let nama = 'jordan meta';
  let nim = '1306082024';

  $: firstName = nama.split(' ')[0];

  const avSize = 24;
  const avUrl = `https://api.adorable.io/avatars/${avSize}/${firstName}@adorable.png`
  const menus = [
    { header: true, label: 'personal' },
    { label: 'Info', path: '/#/mahasiswa/me/info' },
    { label: 'Jadwal', path: '/#/mahasiswa/me/schedule' },
    { label: 'Transkrip Nilai', path: '/#/mahasiswa/me/transkrip' },
    { label: 'KRS', path: '/#/mahasiswa/me/krs' },
    { label: 'KHS', path: '/#/mahasiswa/me/khs' },
    { header: true, label: 'ilkom' },
    { label: 'Dosen', path: '/#/mahasiswa/ilkom/dosens' },
    { label: 'Mata Kuliah', path: '/#/mahasiswa/ilkom/mks' },
    { header: true, label: 'lainnya' },
    { label: 'Bantuan', path: '/#/mahasiswa/help' },
    { label: 'Logout', path: '/#/mahasiswa/logout' }
  ];

  const LoadMahasiswaGQL = gql`
    query LoadMahasiswaById($id: Int!) {
      mahasiswaById(id: $id) {
        id
        idPa
        nama
        nim
        nodeId
        sex
        tahunMasuk
      }
    }
  `;

  onMount(() => {
    const user = loadStorage('siskom.user');
    const { targetId } = user;
    if (!targetId) {
      throw new Error(`invalid targetId: ${targetId}`);
    }

    apolloClient.query({
      query: LoadMahasiswaGQL,
      variables: {
        id: parseInt(targetId)
      }
    })
      .then(result => {
        setStorage('siskom.mahasiswa', result.data.mahasiswaById);
        // pushRoute('/mahasiswa/me');
      });
  });
</script>


<RespLayout
  {menus}
>
  <a 
    slot="profile-section"
    href="/#/mahasiswa/me" class="flex items-center w-full h-full p-4"
  >
    <img src={avUrl} class="mr-2" />
    <div>
      <div class="font-bold text-sm">{nama}</div>
      <div class="font-bold text-xs"> {nim}</div>
    </div>
  </a>
  <div slot="content">
    <Routes />
  </div>
</RespLayout>