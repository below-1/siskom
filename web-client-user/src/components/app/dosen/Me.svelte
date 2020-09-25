<script>
	import { onMount } from 'svelte';
  import DetailDosen from 'siskom-web-user/components/commons/dosen/Detail.svelte';
  import {
  	user
  } from 'siskom-web-commons';

  $: id = $user.targetId;
 </script>

<DetailDosen {id} prefix="/app/me_dos" showAvatar>
</DetailDosen>
