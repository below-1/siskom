<script>
  import { onMount } from 'svelte';
  import ApexCharts from 'apexcharts';

  const options = {
    chart: {
      type: 'line'
    },
    series: [{
      name: 'sales',
      data: [30,40,35,50,49,60,70,91,125]
    }],
    xaxis: {
      categories: [1991,1992,1993,1994,1995,1996,1997, 1998,1999]
    }
  };

  onMount(() => {
    var chart = new ApexCharts(document.querySelector("#foobar"), options);
    chart.render();
  });
</script>

<div style="height: 500px; width: 100%;">
  <div id="foobar">
  </div>
</div>
