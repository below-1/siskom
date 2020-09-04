<script>
  import { getContext } from 'svelte';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import formatScheduleDayTime from 'siskom/commons/formatScheduleDayTime.js';
  import avatar_url from 'siskom/commons/avatar.js';
  import GQL_kelas_schedule from 'siskom/graphql/kelas-schedule.gql';
  import * as context_key from './context.js';

  const idKelas = getContext(context_key.id);

  let schedule = null;
  let networkStatus = 'loading';

  $: loadSchedule({ idKelas });

  async function loadSchedule ({ idKelas }) {
    if (!idKelas) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_kelas_schedule,
        variables: {
          idKelas
        }
      });
      schedule = result.data.schedule;
      const _formatTime = formatScheduleDayTime({
        hari: schedule.hariKul,
        jam: schedule.waktuKul,
        totalMenit: schedule.totalMenit
      });
      schedule = {
        ...schedule,
        _formatTime
      };
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <ul class="my-2 bg-white md:w-2/3">
      <li class="px-4 py-3 border-b border-gray-300 flex items-center justify-between text-lg">
        <div>Waktu</div>
        <div>{schedule._formatTime}</div>
      </li>
      <li class="px-4 py-3 border-b border-gray-300 flex items-center justify-between text-lg">
        <div>Ruangan</div>
        <div>{schedule.ruangan}</div>
      </li>
      {#if schedule.dosen}
        <li class="px-4 py-3 border-b border-gray-300 flex items-center justify-between text-lg">
          <div>Dosen</div>
          <a
            href={`/#/app/ilkom/dosens/${schedule.dosen.id}/info`}
            class="underline font-semibold"
          >{schedule.dosen.nama}</a>
        </li>
      {/if}
    </ul>
  </div>
</JoAsyncContent>