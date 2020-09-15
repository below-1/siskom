<script>
  import DetailMk from 'siskom-web-user/components/commons/mk/Detail.svelte';

  export let params = {};
  $: idMk = params ? parseInt(params.id) : null;
</script>

<DetailMk {idMk} />
