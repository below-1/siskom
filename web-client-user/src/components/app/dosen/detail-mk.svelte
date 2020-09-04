<script>
  import DetailMkCommon from 'siskom/components/commons/mk/detail.svelte';

  export let params = {};

  $: idMk = params.id ? parseInt(params.id) : null;
</script>

<DetailMkCommon {idMk} />
