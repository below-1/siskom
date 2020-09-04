<script>
  import DetailMk from 'siskom/components/commons/mk/detail.svelte';
  
  export let params = {};

  $: idMk = params.id ? parseInt(params.id) : null;
</script>

<Detail {idMk} />