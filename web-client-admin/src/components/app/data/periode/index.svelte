<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import Router from 'svelte-spa-router';
  import List from './List.svelte';
  import Create from './Create.svelte';
  import Edit from './Edit.svelte';
  import Logo from 'siskom-web-admin/icons/calendar.svg';

  const prefix = '/admin/data/periode';
  const routes = {
    '/': List,
    '/create': Create,
    '/edit/:id': Edit
  }
</script>

<ContentWrapper
  image={Logo}
  label="Periode"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
