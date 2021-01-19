<script>
  import { onMount } from 'svelte';
  import FaSpinner from 'svelte-icons/fa/FaSpinner.svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import axios from 'siskom-web-admin/services/axios.js';

  function deleteCookies() { 
      document.cookie.split(";").forEach(function(c) { document.cookie = c.replace(/^ +/, "").replace(/=.*/, "=;expires=" + new Date().toUTCString() + ";path=/"); });

  } 

  onMount(async () => {    
    const resp = await axios.get("/auth/logout");    
    console.log('document.cookie');
    console.log(document.cookie);
    deleteCookies();
    pushRoute('/');
  });
</script>

<div class="jo-spinner w-full h-full m-auto flex flex-col justify-center items-center">
  <div class="text-indigo-600 spinner w-24 h-24">
    <FaSpinner />
  </div>
  <div class="my-3 font-semibold text-lg text-center">sampai jumpa lagi...</div>
</div>
