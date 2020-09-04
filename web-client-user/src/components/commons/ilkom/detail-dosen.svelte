<script>
  import DetailDosen from 'siskom/components/commons/dosen/detail.svelte';

  export let params = {};
  $: id = params ? parseInt(params.id) : null;
  $: prefix = `/app/ilkom/dosens/${id}`
</script>

<DetailDosen {id} {prefix} showAvatar />
