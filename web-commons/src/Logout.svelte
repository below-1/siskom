<script>
  import { onMount } from 'svelte';
  import FaSpinner from 'svelte-icons/fa/FaSpinner.svelte';
  import { push as pushRoute } from 'svelte-spa-router';

  onMount(() => {    
    setTimeout(() => {
      localStorage.removeItem('siskom.token');
      localStorage.removeItem('siskom.user');
      localStorage.removeItem('siskom.mahasiswa');
      localStorage.removeItem('siskom.dosen');
      pushRoute('/');
    }, 3000);
  });
</script>

<div class="jo-spinner w-full h-full m-auto flex flex-col justify-center items-center">
  <div class="text-indigo-600 spinner w-24 h-24">
    <FaSpinner />
  </div>
  <div class="my-3 font-semibold text-lg text-center">sampai jumpa lagi...</div>
</div>
