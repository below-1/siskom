<script>
  import DetailDosenCommon from 'siskom/components/commons/dosen/detail.svelte';

  export let params = {};
  $: id = params.id ? parseInt(params.id) : null;
</script>

<DetailDosenCommon {id} />