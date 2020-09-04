<script>
  import avatar_url from 'siskom/commons/avatar.js';

  export let mahasiswa;

  $: avatar = mahasiswa ? avatar_url(mahasiswa.nim, 64) : null;
</script>

<div class="bg-white p-4 flex">
  <div>
    <img src={avatar} />
  </div>
  <div class="text-left ml-2">
    <div class="font-semibold text-2xl">{mahasiswa.nama}</div>
    <div class="font-semibold text-sm">
      {mahasiswa.nim}, 
      {mahasiswa.sex.toLowerCase()}
    </div>
  </div>
</div>