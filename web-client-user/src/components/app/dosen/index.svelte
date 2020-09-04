<script>
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js'
  import { load as loadStorage, set as setStorage } from 'siskom/commons/storage.js';
  import RespLayout from 'siskom/components/commons/resp-layout.svelte';
  import Routes from './routes.svelte';

  let nama = 'tiwuk widiastuti';
  let nim = '123232323';

  $: firstName = nama.split(' ')[0];
  let avSize = 24;
  let avUrl = `https://api.adorable.io/avatars/${avSize}/${firstName}@adorable.png`;

  const DosenByIdGQL = gql`
    query DosenById($id: Int!) {
      dosenById(id: $id) {
        nama
        nip
        sex
        status
        id
        nodeId
      }
    }
  `;

  const menus = [
    { header: true, label: 'personal' },
    { label: 'Jadwal', path: '/#/dosen/schedule' },
    { label: 'Bimbingan Akademik', path: '/#/dosen/pa' },
    { header: true, label: 'ilkom' },
    { label: 'Kelas', path: '/#/dosen/kelas' },
    { label: 'Dosen', path: '/#/dosen/dosens' },
    { label: 'Mata Kuliah', path: '/#/dosen/mks' },
    { label: 'Mahasiswa', path: '/#/dosen/dosens' },
    { header: true, label: 'lainnya' },
    { label: 'Bantuan', path: '/#/dosen/help' },
    { label: 'Logout', path: '/#/dosen/logout' }
  ];

  onMount(() => {
    const user = loadStorage('siskom.user');
    const { targetId } = user;
    if (!targetId) {
      throw new Error(`invalid targetId: ${targetId}`);
    }

    apolloClient.query({
      query: DosenByIdGQL,
      variables: {
        id: parseInt(targetId)
      }
    })
      .then(result => {
        setStorage('siskom.dosen', result.data.dosenById);
        // pushRoute('/mahasiswa/me');
      });
  });
</script>

<RespLayout
  {menus}
>
  <a 
    slot="profile-section"
    href="/#/dosen/me" class="flex items-center w-full h-full p-4"
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