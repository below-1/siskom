<script>
  let menuItems = [
    { label: 'mahasiswa', path: 'mahasiswa' },
    { label: 'dosen', path: 'dosen' },
    { label: 'mata kuliah', path: 'mk' },
    { label: 'kelas', path: 'kelas' },
    { label: 'periode', path: 'periode' },
    { label: 'ruangan', path: 'room' }
  ];
</script>

<nav class="w-full bg-gray-800 text-white mx-auto border-b border-gray-300">
  <div class="mx-4 flex items-stretch">
    {#each menuItems as item (item.path)}
      <a 
        class="font-semibold tracking-wide hover:text-white text-gray-300  px-2 py-3 mr-4 text-sm"
        href={`#/admin/data/${item.path}`}
      >
        {item.label}
      </a>
    {/each}
  </div>
</nav>