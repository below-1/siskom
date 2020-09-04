<script>
  export let nama = 'user mahasiswa';
  export let nim;

  $: firstName = nama.split(' ')[0];
  const avSize = 24;
  const avUrl = `https://api.adorable.io/avatars/${avSize}/${firstName}@adorable.png`
</script>

<div class="mobile-menu bg-gray-100 shadow-xl">
  <ul class="w-full">
    <li class="border-b border-gray-300 hover:bg-gray-200">
      <a href="/#/mahasiswa/me" class="flex items-center w-full h-full p-4">
        <img src={avUrl} class="mr-2" />
        <div>
          <div class="font-bold text-sm">{nama}</div>
          <div class="font-bold text-xs"> {nim}</div>
        </div>
      </a>
    </li>
  </ul>
</div>