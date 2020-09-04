<script>
  import { getContext } from 'svelte';
  import apolloClient from 'siskom/apollo-client.js';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoLink from 'siskom/components/commons/JoLink.svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import avatar_url from 'siskom/commons/avatar.js';
  import formatScheduleDayTime from 'siskom/commons/formatScheduleDayTime.js'
  import * as context_key from './context';
  import { periode } from 'siskom/stores/index.js';
  import GQL_dosen_detail_summary from 'siskom/graphql/dosen-detail-summary.gql';

  const dosen = getContext(context_key.dosen);
  const prefix = getContext(context_key.prefix);

  // states
  let networkStatus = 'loading';
  let bimbinganPa = [];
  let schedule = [];
  let totalActivePa = 0;

  $: id = $dosen ? $dosen.id : null;
  $: idPeriode = $periode.id;
  $: avatar = $dosen ? avatar_url($dosen.nip, 64) : null;
  $: loadDetailSummary({ id, idPeriode });

  async function loadDetailSummary ({ id, idPeriode }) {
    if (!id) return;
    if (!idPeriode) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_dosen_detail_summary,
        variables: { id, idPeriode }
      });
      const data = result.data;
      bimbinganPa = data.bimbinganPa.nodes.map(it => {
        return {
          ...it,
          avatar: avatar_url(it.nim, 32)
        }
      });
      totalActivePa = data.totalActivePa;
      schedule = data.schedule.nodes.map(it => {
        const _schedule = formatScheduleDayTime({
          hari: it.hariKul,
          jam: it.waktuKul,
          totalMenit: it.totalMenit
        });
        return {
          ...it,
          _schedule
        }
      });
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
    }
  }
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <ul class="my-2 bg-white">
      <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
        <span>Nama:</span>
        <span>{$dosen.nama}</span>
      </li>
      <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
        <span>NIP:</span>
        <span>{$dosen.nip}</span>
      </li>
      <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
        <span>jenis kelamin:</span>
        <span>{$dosen.sex.toLowerCase()}</span>
      </li>
      <li class="py-2 px-4 border-b border-gray-300 flex items-center justify-between">
        <span>status:</span>
        <span>{$dosen.status.toLowerCase()}</span>
      </li>
    </ul>

    <div class="my-2 bg-white p-4">
      <div class="font-semibold">Daftar Kelas ({$periode.tahun}/{$periode.tahun + 1}, semester {$periode.semester})</div>
      <ul>
        {#each schedule as item (item.nodeId)}
          <li class="border-b border-gray-300 py-4 flex items-center text-sm">
            <div>
              <div class="font-semibold">{item.kelas.mk.nama}, {item.kelas.label}</div>
              <div class="text-xs">{item.kelas.mk.tipeMk.toLowerCase()} {item.kelas.mk.kode}</div>
              {#if item.kelas.mk.scheduled}
                <div class="text-xs">{item._schedule} {item.ruangan}</div>
              {/if}
            </div>
          </li>
        {/each}
      </ul>
      <JoLink cls="mt-2 text-xs" label="selengkapnya" to={`/#${prefix}/schedules`} />
    </div>

    <div class="my-2 bg-white p-4">
      <div class="font-semibold">Bimbingan Akademik ({$periode.tahun}/{$periode.tahun + 1}, semester {$periode.semester})</div>
      <ul>
        {#each bimbinganPa as mahasiswa (mahasiswa.nodeId)}
          <li class="border-b border-gray-300 py-2 flex items-center text-sm">
            <div style="max-width: 2.5rem; min-width: 2.5rem; width: 2.5rem;">
              <img src={mahasiswa.avatar} />
            </div>
            <div class="ml-2">
              <div class="font-semibold">{mahasiswa.nama}</div>
              <div class="text-xs">{mahasiswa.sex.toLowerCase()}, {mahasiswa.nim}</div>
            </div>
          </li>
        {/each}
      </ul>
      <JoLink cls="mt-2 text-xs" label="selengkapnya" to={`/#${prefix}/pas`} />
    </div>

  </div>
</JoAsyncContent>