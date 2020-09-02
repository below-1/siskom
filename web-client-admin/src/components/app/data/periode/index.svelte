<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import Router from 'svelte-spa-router';
  import List from './List.svelte';
  import Logo from 'siskom-web-admin/icons/calendar.svg';

  const prefix = '/admin/data/periode';
  const routes = {
    '/': List
  }
</script>

<ContentWrapper
  image={Logo}
  label="Periode"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
