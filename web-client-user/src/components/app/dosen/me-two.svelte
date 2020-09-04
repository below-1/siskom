<script>
  import { onMount } from 'svelte';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import DetailDosen from 'siskom/components/commons/dosen/detail.svelte';

  let id = null;
  onMount(() => {
    const user = loadStorage('siskom.user');
    id = user.targetId;
  });
</script>

<DetailDosen {id} prefix="/app/me_dosen" showAvatar>
</DetailDosen>
