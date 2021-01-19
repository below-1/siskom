<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import Router from 'svelte-spa-router';
  import Create from './Create.svelte';
  import List from './List.svelte';
  import Logo from 'siskom-web-admin/icons/room.svg';

  const prefix = '/admin/data/room';
  const routes = {
    '/create': Create,
    '/': List
  }
</script>

<ContentWrapper
  image={Logo}
  label="Ruangan"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
