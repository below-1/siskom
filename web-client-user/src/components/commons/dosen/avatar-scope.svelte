<script>
  import avatar_url from 'siskom/commons/avatar.js';

  export let dosen;

  $: avatar = dosen ? avatar_url(dosen.nip, 64) : null;
</script>

<div class="bg-white p-4 flex items-center mb-2">
  <img src={avatar} class="mr-2" />
  <div>
    <div class="font-semibold text-2xl">{dosen.nama}</div>
    <div class="font-semibold text-sm">
      {dosen.nip}, 
      {dosen.sex.toLowerCase()}
      {#if dosen.status == 'AKTIF'}
        <span class="px-2 bg-green-600 text-white text-xs font-bold">aktif</span>
      {:else}
        <span class="px-2 bg-orange-600 text-white text-xs font-bold">inaktif</span>
      {/if}
    </div>
  </div>
</div>