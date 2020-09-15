<script>
  import DetailKelas from 'siskom-web-user/components/commons/kelas/Detail.svelte';

  export let params = {};
  $: id = params ? parseInt(params.id) : null;
  $: prefix = `/app/ilkom/kelas/${id}`
</script>

<DetailKelas {id} {prefix} />
