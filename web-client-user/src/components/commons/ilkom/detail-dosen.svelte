<script>
  import DetailDosen from 'siskom-web-user/components/commons/dosen/Detail.svelte';

  export let params = {};
  $: id = params ? parseInt(params.id) : null;
  $: prefix = `/app/ilkom/dosens/${id}`
</script>

<DetailDosen {id} {prefix} showAvatar />
