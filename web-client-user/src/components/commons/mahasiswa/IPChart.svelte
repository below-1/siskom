<script>
  import { onMount, getContext } from 'svelte';
  import ApexCharts from 'apexcharts';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import CalcMahasiswaPeriodeInfo from 'siskom-web-user/graphql/CalcMahasiswaPeriodeInfo.js';
  import * as context_key from './context.js';

  const mahasiswa = getContext(context_key.mahasiswa);
  $: idMahasiswa = $mahasiswa.id;
  let networkStatus = 'loading';

  $: onIdChange({ idMahasiswa });

  async function onIdChange ({ idMahasiswa }) {
    try {
      const data = await getMahasiswaPeriodeInfo({ idMahasiswa });
      buildChart(data);
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  async function buildChart ({ tahun, sksn, sksd, ip, ipk }) {
    const optionsSks = {
      chart: {
        type: 'line'
      },
      series: [
        {
          name: 'sksd',
          data: sksd
        },
        {
          name: 'sksn',
          data: sksn
        }
        // {
        //   name: 'ipk',
        //   data: ipk
        // }
      ],
      xaxis: {
        categories: tahun
      }
    };
    const optionsIp = {
      stroke: {
        curve: 'smooth'
      },
      chart: {
        type: 'line'
      },
      series: [
        {
          name: 'ip',
          data: ip
        }
        // {
        //   name: 'ipk',
        //   data: ipk
        // }
      ],
      xaxis: {
        categories: tahun
      },
      yaxis: {
        min: 0,
        max: 4,
        tickAmount: 5,
        floating: false
      }
    };
    const chartSks = new ApexCharts(document.querySelector("#sks"), optionsSks);
    const chartIp = new ApexCharts(document.querySelector("#ip"), optionsIp);
    chartSks.render();
    chartIp.render();
  }

  async function getMahasiswaPeriodeInfo ({ idMahasiswa }) {
    try {
      const result = await apolloClient.query({
        query: CalcMahasiswaPeriodeInfo,
        variables: {
          idMahasiswa
        }
      });
      let data = result.data.calcMahasiswaPeriodeInfo.nodes;
      let ip = [];
      let ipk = [];
      let sksd = [];
      let sksn = [];
      let tahun = [];
      data.forEach((d, index) => {
        sksd.push(d.sksd);
        sksn.push(d.sksn);
        ip.push(d.sksn / d.sksd);
        tahun.push(d.tahun);

        const prevTotalSksd = sksd.reduce((a, b) => a + b, 0);
        const prevTotalSksn = sksn.reduce((a, b) => a + b, 0);
        ipk.push(prevTotalSksn / prevTotalSksd);
      });
      const dataResult = {
        ip,
        sksd,
        sksn,
        tahun
        // ipk
      };
      console.log(dataResult);
      return dataResult;
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }
</script>

<div style="height: 600px; width: 100%;">
  <div id="sks">
  </div>
</div>

<div style="height: 600px; width: 100%;">
  <div id="ip">
  </div>
</div>
