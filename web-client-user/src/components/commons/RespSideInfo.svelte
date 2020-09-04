<script>
  import { periode, phase } from 'siskom-web-commons';

  $: ketua = $periode.id ? $periode.ketua : {}; 
  $: sekretaris = $periode.id ? $periode.sekretaris : {}; 
</script>

<div class="bg-white p-4 mb-2">
  <div class="font-bold">Periode {$periode.tahun}/{$periode.tahun + 1}</div>
  <div>Semester Ganjil</div>
</div>

<div class="bg-white p-4 mb-2">
  <div class="font-bold">Fase Registrasi</div>
</div>

<a  
  href={`/#/app/ilkom/dosens/${ketua.id}/info`}
  class="bg-white p-4 mb-2 flex items-center"
>
  <img class="mr-2" src="https://api.adorable.io/avatars/48/meiton@adorable.png"/>
  <div>
    <div class="font-bold">Ketua</div>
    <div class="font-bold">{ketua.nama}</div>
  </div>
</a>

<a  
  href={`/#/app/ilkom/dosens/${sekretaris.id}/info`}
  class="bg-white p-4 mb-2 flex items-center"
>
  <img class="mr-2" src="https://api.adorable.io/avatars/48/tiwuk@adorable.png"/>
  <div>
    <div class="font-bold">Sekretaris</div>
    <div class="font-bold">{sekretaris.nama}</div>
  </div>
</a>