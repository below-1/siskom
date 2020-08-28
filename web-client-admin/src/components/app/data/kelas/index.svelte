<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import List from './List.svelte';
  import Create from './create/index.svelte';
  import Logo from 'siskom-web-admin/icons/work.svg';

  const prefix = '/admin/data/kelas';
  const routes = {
    '/': List,
    '/create': Create
  }
</script>

<ContentWrapper
  image={Logo}
  label="Kelas"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
