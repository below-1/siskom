<script>
  import { periode, phase } from 'siskom-web-admin/stores/index.js';

  $: tahun = $periode ? $periode.tahun : 2007;
  $: semester = $periode ? $periode.semester : 1;
  $: currentPhase = $phase ? $phase : 'registration';
</script>

<div class="py-2 bg-white border-b border-gray-300 text-xs font-bold">
  <div class="flex items-center mx-4">
    <div>Sistem Informasi Akademik Ilmu Komputer</div>
    <div class="flex-grow"></div>
    <div>Periode 
      {tahun} / 
      {tahun + 1}, 
      semester {semester}</div>
    <div class="ml-2 text-white bg-teal-600 font-bold px-2">
      phase: {currentPhase}
    </div>
  </div>
</div>