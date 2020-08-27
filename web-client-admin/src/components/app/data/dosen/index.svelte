<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import List from './List.svelte';
  import Create from './Create.svelte';
  import Edit from './Edit.svelte';
  import TrainingSVG from 'siskom-web-admin/icons/training.svg';

  const prefix = '/admin/data/dosen';
  const routes = {
    '/': List,
    '/create': Create,
    '/edit/:id': Edit
  }
</script>

<ContentWrapper
  image={TrainingSVG}
  label="Dosen"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
