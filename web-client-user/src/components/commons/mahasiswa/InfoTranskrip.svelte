<script>
  export let sks;
  export let sksd;
  export let sksn;
  export let ip;
</script>

<div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
  <div>Total SKS</div>
  <div>{sks}</div>
</div>
<div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
  <div>SKSD</div>
  <div>{sksd}</div>
</div>
<div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
  <div>SKSN</div>
  <div>{sksn.toFixed(3)}</div>
</div>
<div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
  <div>IP</div>
  <div>{ip.toFixed(3)}</div>
</div>