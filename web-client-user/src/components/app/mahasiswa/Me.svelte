<script>
  import { onMount } from 'svelte';
  import DetailMahasiswa from 'siskom-web-user/components/commons/mahasiswa/detail.svelte';
  import { user } from 'siskom-web-commons';

  $: id = $user ? $user.id : null;
</script>

<DetailMahasiswa {id} prefix="/app/me_mhs">
</DetailMahasiswa>
