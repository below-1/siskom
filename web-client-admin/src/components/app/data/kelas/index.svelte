<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import List from './List.svelte';
  import Create from './create/index.svelte';
  import EditSchedule from './EditSchedule.svelte';
  import ErrorClashes from './ErrorClashes.svelte';
  import Members from './Members.svelte';
  import Logo from 'siskom-web-admin/icons/work.svg';

  const prefix = '/admin/data/kelas';
  const routes = {
    '/': List,
    '/create': Create,
    '/create/*': Create,
    '/schedule/:id': EditSchedule,
    '/error-clashes': ErrorClashes,
    '/members/:id': Members
  }
</script>

<ContentWrapper
  image={Logo}
  label="Kelas"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
