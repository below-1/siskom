<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import List from './List.svelte';
  import Create from './Create.svelte';
  import Edit from './Edit.svelte';
  import StudentSVG from 'siskom-web-admin/icons/student.svg';

  const prefix = '/admin/data/mahasiswa';
  const routes = {
    '/': List,
    '/create': Create,
    '/edit/:id': Edit
  }
</script>

<ContentWrapper
  image={StudentSVG}
  label="Mahasiswa"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
