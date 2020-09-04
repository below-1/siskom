<script>
  import Router from 'svelte-spa-router';
  import Pa from './pa.svelte';
  import Schedule from './schedule.svelte';

  const routes = {
    '/pas': Pa,
    '/schedules': Schedule
  };
</script>

<slot name="info"></slot>
<Router {routes} prefix="/app/me_dosen" />
