<script>
  import DosenListCommon from 'siskom/components/commons/dosen/list.svelte';
  import { push as pushRoute } from 'svelte-spa-router';

  function onDetail (item) {
    pushRoute('/dosen/detail-dosen/' + item.id);
  }
</script>

<DosenListCommon
  {onDetail}
/>