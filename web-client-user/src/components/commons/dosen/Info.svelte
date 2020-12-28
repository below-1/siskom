<script>
  import { getContext } from 'svelte';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoButton,
    JoLink,
    JoAsyncContent,
    formatScheduleDayTime,
    periode
  } from 'siskom-web-commons';
  import buildAvatar from 'siskom-web-user/commons/buildAvatar.js';
  import * as context_key from './context';
  import GQLDetailSummary from 'siskom-web-user/graphql/DosenDetailSummary.js';

  const dosen = getContext(context_key.dosen);
  const prefix = getContext(context_key.prefix);

  // states
  let networkStatus = 'loading';
  let bimbinganPa = [];
  let schedule = [];
  let totalActivePa = 0;

  $: id = $dosen ? $dosen.id : null;
  $: idPeriode = $periode.id;
  $: avatar = $dosen ? buildAvatar($dosen.nip, 64) : null;
  $: loadDetailSummary({ id, idPeriode });

  async function loadDetailSummary ({ id, idPeriode }) {
    if (!id) return;
    if (!idPeriode) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLDetailSummary,
        variables: { id, idPeriode }
      });
      const data = result.data;
      bimbinganPa = data.bimbinganPa.nodes.map(it => {
        return {
          ...it,
          avatar: buildAvatar(it.nim, 32)
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

<div class="border-b border-gray-300 my-2"></div>
<JoAsyncContent {networkStatus}>
  <div slot="success">

    <ul class="my-2 border-2 border-dashed border-gray-400 p-4 md:w-1/2">
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

    <div class="font-black text-2xl mt-8">Daftar Kelas ({$periode.tahun}/{$periode.tahun + 1}, semester {$periode.semester})</div>
    <ul>
      {#each schedule as item (item.nodeId)}
        <li class="border-b border-gray-300 py-4 flex items-center">
          <div>
            <div class="font-bold text-lg">{item.kelas.mk.nama}, {item.kelas.label}</div>
            <div class="text-sm">{item.kelas.mk.tipeMk.toLowerCase()} {item.kelas.mk.kode}</div>
            {#if item.kelas.mk.scheduled}
              <div class="text-xs">{item._schedule} {item.ruangan}</div>
            {/if}
          </div>
        </li>
      {/each}
    </ul>
    <JoLink cls="mt-2 text-xs" label="selengkapnya" to={`/#${prefix}/schedules`} />

    <div class="text-2xl font-black mt-8">Bimbingan Akademik ({$periode.tahun}/{$periode.tahun + 1}, semester {$periode.semester})</div>
    <ul>
      {#each bimbinganPa as mahasiswa (mahasiswa.nodeId)}
        <li class="border-b border-gray-300 py-4 flex items-center">
          <div style="max-width: 2.5rem; min-width: 2.5rem; width: 2.5rem;">
            <img class="rounded-full" src={mahasiswa.avatar} />
          </div>
          <div class="ml-2">
            <div class="font-bold text-lg">{mahasiswa.nama}</div>
            <div class="text-sm">{mahasiswa.sex.toLowerCase()}, {mahasiswa.nim}</div>
          </div>
        </li>
      {/each}
    </ul>
    <JoLink cls="mt-2 text-xs" label="selengkapnya" to={`/#${prefix}/pas`} />

  </div>
</JoAsyncContent>