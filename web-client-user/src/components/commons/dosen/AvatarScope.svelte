<script>
  import buildAvatar from 'siskom-web-user/commons/buildAvatar.js';

  export let dosen;

  $: avatar = dosen ? buildAvatar(dosen.nip, 124) : null;
</script>

<div class="flex items-center my-6">
  <img src={avatar} class="mr-4 rounded-full" />
  <div>
    <div class="font-semibold text-lg">{dosen.nama}</div>
    <div class="font-semibold text-sm">
      {dosen.nip}, 
      {#if dosen.status == 'AKTIF'}
        <span class="px-2 bg-green-600 text-white text-xs font-bold">aktif</span>
      {:else}
        <span class="px-2 bg-orange-600 text-white text-xs font-bold">inaktif</span>
      {/if}
    </div>
  </div>
</div>