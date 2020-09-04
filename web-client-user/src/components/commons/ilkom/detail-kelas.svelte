<script>
  import DetailKelas from 'siskom/components/commons/kelas/detail.svelte';

  export let params = {};
  $: id = params ? parseInt(params.id) : null;
  $: prefix = `/app/ilkom/kelas/${id}`
</script>

<DetailKelas {id} {prefix} />
