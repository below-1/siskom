<script>
  import Router, { push as pushRoute } from 'svelte-spa-router';
  import avatar_url from 'siskom/commons/avatar.js';
  import apollo_client from 'siskom/apollo-client.js';
  import GQL_detail_mahasiswsa from 'siskom/graphql/detail-mahasiswa.gql';
  import Schedule from './schedule.svelte';
  import Transkrip from './transkrip.svelte';
  import KRS from './krs.svelte';
  import KHS from './khs.svelte';

  export let id;

  let networkStatus = 'loading';
  let mahasiswa = {
    id: 3,
    nama: 'jordan l. u. meta',
    nim: '1306082024'
  };

  $: avatar = avatar_url(64, mahasiswa.nim);
  $: load_mahasiswa({ id });

  const menus = [
    { label: 'jadwal', path: 'schedule' },
    { label: 'transkrip', path: 'transkrip' },
    { label: 'krs', path: 'krs' },
    { label: 'khs', path: 'khs' },
    { label: 'akm', path: 'akm' }
  ];

  const routes = {
    '/schedule': Schedule,
    '/transkrip': Transkrip,
    '/krs': Krs,
    '/khs': Khs
  };

  async function load_mahasiswa ({ id }) {
    if (!id) return;
    networkStatus = 'loading';
    try {
      const result = await apollo_client.query({
        query: GQL_detail_mahasiswsa,
        variables: {
          id
        }
      });
      mahasiswa = result.data.mahasiswaById;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }
</script>

<div class="py-4 px-4 border-b border-gray-300 flex items-center">
  <img src={avatar} class="h-16 w-16 rounded my-2 mr-4" />
  <div>
    <div class="font-black text-lg">{mahasiswa.nama}</div>
    <div class="font-medium text-sm">{mahasiswa.nim}, aktif</div>
  </div>
</div>
<ul class="flex border-b border-gray-300 ">
  {#each menus as menu (menu.path)}
    <li class="flex-grow">
      <a class="block px-4 py-3 font-medium text-center text-lg  hover:font-bold" href={`/#/mahasiswa/me/${menu.path}`}>
        {menu.label}
      </a>
    </li>
  {/each}
</ul>

