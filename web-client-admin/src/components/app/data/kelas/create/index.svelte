<script type="text/javascript">
  import { onMount } from 'svelte';
  import Router from 'svelte-spa-router';

  import BaseEditor from './Base.svelte';
  import ScheduleEditor from './Schedule.svelte';

  const prefix = '/admin/data/kelas/create';
  const routes = {
    '/': BaseEditor,
    '/base': BaseEditor,
    '/schedule': ScheduleEditor
  };
</script>

<div>
  <div 
    class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
    Input Data Kelas
  </div>
  <div class="my-12">
    <Router {prefix} {routes}></Router>
  </div>
</div>
