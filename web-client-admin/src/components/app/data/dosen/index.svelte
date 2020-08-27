<script>
  import ContentWrapper from 'siskom-web-admin/components/commons/ContentWrapper.svelte';
  import List from './List.svelte';
  import TrainingSVG from 'siskom-web-admin/icons/training.svg';

  const prefix = '/admin/data/dosen';
  const routes = {
    '/': List
  }
</script>

<ContentWrapper
  image={TrainingSVG}
  label="Dosen"
  prefix={prefix}
  routes={routes}
>
</ContentWrapper>
