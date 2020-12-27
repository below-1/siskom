<script>
  import buildAvatar from 'siskom-web-user/commons/buildAvatar.js';

  export let mahasiswa;

  $: avatar = mahasiswa ? buildAvatar(mahasiswa.nim, 256) : null;
</script>

<div class="flex items-center border-b border-gray-400 py-4">
  <div>
    <img class="rounded-full" src={avatar} />
  </div>
  <div class="text-left ml-2">
    <div class="font-semibold text-lg">{mahasiswa.nama}</div>
    <div class="font-semibold text-sm">
      {mahasiswa.nim}, 
      {mahasiswa.sex.toLowerCase()}
    </div>
  </div>
</div>