<script>
  import DetailMahasiswa from 'siskom/components/commons/mahasiswa/detail.svelte';

  export let params = {};
  $: id = params ? parseInt(params.id) : null;
  $: prefix = `/app/ilkom/mahasiswas/${id}`
</script>

<DetailMahasiswa {id} {prefix} showAvatar />
