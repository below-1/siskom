<script>
  import { onMount } from 'svelte'
  import { pop as popRoute } from 'svelte-spa-router'
  import { CLASHES } from './commons'
  import MdWarning from 'svelte-icons/md/MdWarning.svelte'
  import 'siskom-web-admin/styles/jo-table.css';

  let clashes = [];

  onMount(() => {
    const rawClashes = localStorage.getItem(CLASHES);
    if (!rawClashes) return;
    clashes = JSON.parse(rawClashes);
  })
</script>

<div class="flex items-center bg-gray-300 p-4 my-4">
  <div class="w-16 h-16 text-gray-600 mr-2">
    <MdWarning />
  </div>
  <div class="flex-grow">
    <div class="text-xl font-bold text-red-700">Terjadi Kesalahan</div>
    <div class="font-semibold text-gray-700">Tidak bisa menyimpan data karena akan terjadi tabrakan.</div>
  </div>
  <button 
    class="appearance-none px-3 py-1 bg-blue-600 text-white font-bold mr-2 text-lg"
    on:click={() => {
      removeStorage(CLASHES)
      popRoute()
    }}
  >
    Ulangi
  </button>
</div>
<table class="jo-table">
  <thead>
    <tr>
      <th>Mata Kuliah</th>
      <th>Label</th>
      <th>Dosen</th>
      <th>Waktu</th>
      <th>Ruangan</th>
      <th>Peserta</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    {#each clashes as item (item.id)}
      <tr>
        <td>
          <div class="font-semibold">{item.mkNama}</div>
          <div class="font-medium text-gray-900 text-xs">
            {item.tipeMk}, {item.mkKode}
          </div>
        </td>
        <td>{item.label}</td>
        <td>{item.dosenNama}</td>
        <td>{item.hariKul}, {item.waktuKul}</td>
        <td>{item.ruangan}</td>
        <td>{item.kapasitas}</td>
        <td>
          <button 
            class="appearance-none px-3 py-1 bg-gray-200 mr-2">
            jadwal
          </button>
        </td>
      </tr>
    {/each}
  </tbody>
</table>
