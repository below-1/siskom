<script>
  import DetailMk from 'siskom/components/commons/mk/detail.svelte';

  export let params = {};
  $: idMk = params ? parseInt(params.id) : null;
</script>

<DetailMk {idMk} />
