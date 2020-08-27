<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import List from './List.svelte';
  import Logo from 'siskom-web-admin/icons/book.svg';

  const prefix = '/admin/data/mk';
  const routes = {
    '/': List
  }
</script>

<ContentWrapper
  image={Logo}
  label="Mata Kuliah"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
