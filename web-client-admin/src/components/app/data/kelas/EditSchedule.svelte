<script>
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import isEmpty from 'validator/es/lib/isEmpty'
  import trim from 'validator/es/lib/trim'
  import { 
    allIsNull,
    isEmptyRef,
    JoAutoComplete,
    JoLink,
    JoInput,
    JoNumber,
    JoSelect,
    JoButton
  } from 'siskom-web-commons';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { 
    pop as popRoute, 
    push as pushRoute 
  } from 'svelte-spa-router';
  import { notification } from 'siskom-web-admin/stores/index.js';
  import filterDosen from 'siskom-web-admin/services/filterDosen.js';
  import * as GQL from 'siskom-web-admin/graphql/KelasSchedule.js';
  import { ClashError, CLASHES } from './commons'

  export let params;

  let loading = false
  let nodeId = null
  let dosenId = null
  let ruangan = ''
  let hariKul = 1
  let waktuKul;
  let totalMenit = 120
  let kapasitas = 40
  let keywordDosen = ''
  let periodeId = null
  let clashes = []
  let allHariKuliahs = [
    { value: 1, label: 'senin' },
    { value: 2, label: 'selasa' },
    { value: 3, label: 'rabu' },
    { value: 4, label: 'kamis' },
    { value: 5, label: 'jumat' },
    { value: 6, label: 'sabtu' }
  ];
  let allDosens = []
  let allRooms = []

  $: id = params && params.id ? parseInt(params.id) : null;
  $: room = allRooms && allRooms.length > 0 
    ? allRooms.find(it => it.value == ruangan) 
    : null;
  $: errors = {
    dosenId: !dosenId ? 'Dosen tidak boleh kosong' : null,
    ruangan: isEmpty(ruangan) ? 'Ruangan tidak boleh kosong' : null,
    hariKul: !hariKul ? 'Hari tidak valid' : null,
    waktuKul: !waktuKul ? 'Waktu tidak valid' : null,
    totalMenit: !totalMenit ? 'Total menit tidak valid' : null
  };
  $: warnings = {
    kapasitas: checkKapasitas({ kapasitas, room })
  };
  $: invalid = !allIsNull(errors);
  $: selectedDosen = allDosens.find(dosen => dosen.id == dosenId);
  $: filtered_dosen = filterDosen({ keywordDosen, allDosens });

  $: {
    console.log(selectedDosen);
  };

  onMount(loadData);

  async function checkClashes () {
    const variables = {
      periodeId,
      dosenId,
      ruangan,
      waktuKul,
      hariKul,
      totalMenit
    }
    const result = await apolloClient.query({
      query: GQL.ClashCourse,
      variables
    })
    // remove current class from list clashed courses.
    const clashes = result.data.listClashCourses.nodes.filter(node => node.id != id);

    if (clashes.length > 0) {
      throw new ClashError(clashes)
    }
  }

  async function loadData () {
    let result = await apolloClient.query({
      query: GQL.RequiredData,
      fetchPolicy: 'network-only'
    })
    if (!result) throw new Error('empty data');
    allDosens = result.data.allDosens.nodes
    allRooms = result.data.allRooms.nodes.map(it => ({
      label: it.nama,
      value: it.nama
    }))

    result = await apolloClient.query({
      query: GQL.ScheduleById,
      variables: {
        id
      },
      fetchPolicy: 'network-only'
    })
    if (!result) throw new Error('data kosong');
    const node = result.data.scheduledKelaByIdKelas
    dosenId = node.idDosen
    hariKul = node.hariKul
    waktuKul = node.waktuKul
    kapasitas = node.kapasitas
    totalMenit = node.totalMenit
    ruangan = node.ruangan
    nodeId = node.nodeId
    periodeId = node.kelas.idPeriode
    keywordDosen = '';
  }

  async function onSave () {
    if (!nodeId) throw new Error('nodeId is undefined');
    if (!id) throw new Error('id is undefined');
    const payload = {
      _id: id,
      _dosenId: dosenId,
      _ruangan: ruangan,
      _waktuKul: waktuKul,
      _hariKul: hariKul,
      _kapasitas: kapasitas,
      _totalMenit: totalMenit
    }
    loading = true
    try {
      await checkClashes()
      await apolloClient.mutate({
        mutation: GQL.UpdateSchedule,
        variables: {
          payload
        }
      })
      notification.show({
        type: 'info',
        message: 'sukses mengubah data jadwal'
      })
      popRoute()
    } catch (err) {
      console.log(err.clashes)
      if (err.clashes) {
        localStorage.setItem(CLASHES, JSON.stringify(err.clashes));
        pushRoute('/admin/data/kelas/error-clashes');
        return
      } else {
        notification.show({
          type: 'danger',
          message: 'gagal mengubah data jadwal'
        })
      }
    } finally {
      loading = true
    }
  }

  function checkKapasitas ({ kapasitas, room }) {
    if (!room) return null
    if (room && kapasitas > room.kapasitas) 
      return `Jumlah peserta tidak boleh melebihi kapasitas ruangan. Maksimal ${room.kapasitas}`
    return null
  }
</script>

<div 
  class="h-12 text-xl font-bold flex justify-center items-center text-sm border-b border-gray-300">
  Edit Jadwal Kelas
</div>
<div class="w-1/3 mx-auto my-4 border border-gray-400 p-4">
  <form>
    <div class="mb-6 flex flex-col">
      <label class="text-sm">Dosen</label>
      <JoAutoComplete
        placeholder="Cari Dosen..."
        onSearch={async key => {
          keywordDosen = key;
        }}
        items={filtered_dosen}
        bind:value={dosenId}
        let:item={item}
      >
        <div slot="selected" id="my-ass">
          {selectedDosen.nama}
        </div>
        <div slot="item">
          <div class="text-sm font-medium">{item.nama}</div>
          <div class="text-xs">{item.nip}</div>
        </div>
      </JoAutoComplete>
      {#if errors.dosenId}
        <div class="text-red-600 text-sm font-semibold">{errors.dosenId}</div>
      {/if}
    </div>

    <div class="mb-6 flex flex-col">
      <label class="text-sm">Ruangan</label>
      <JoSelect bind:value={ruangan} options={allRooms} />
      {#if errors.ruangan}
        <div class="text-red-600 text-sm font-semibold">{errors.ruangan}</div>
      {/if}
    </div>

    <div class="mb-6 flex flex-col">
      <label class="text-sm">Hari</label>
      <JoSelect options={allHariKuliahs} bind:value={hariKul} />
      {#if errors.hariKul}
        <div class="text-red-600 text-sm font-semibold">{errors.hariKul}</div>
      {/if}
    </div>
    <div class="mb-6 flex flex-col">
      <label class="text-sm">Waktu</label>
      <input 
        bind:value={waktuKul}
        type="time"
        class="rounded bg-gray-200 p-2 text-sm focus:bg-white focus:outline-none focus:shadow-outline" 
        placeholder="Waktu" />
      {#if errors.waktuKul}
        <div class="text-red-600 text-sm font-semibold">{errors.waktuKul}</div>
      {/if}
    </div>
    <div class="mb-6 flex flex-col">
      <label class="text-sm">Total Menit</label>
      <JoNumber 
        bind:value={totalMenit}
        min={0}
        placeholder="Total Menit" 
      />
    </div>
    <div class="mb-6 flex flex-col">
      <label class="text-sm">Maximum Peserta Perkuliahan</label>
      <JoNumber
        bind:value={kapasitas}
        min="0"
        placeholder="Kapasitas" />
      {#if warnings.kapasitas}
        <div class="text-yellow-700 text-sm font-semibold">{warnings.kapasitas}</div>
      {/if}
    </div>

    <div>
      <JoButton
        dark={true}
        color="blue"
        action={onSave}
        disabled={invalid}
      >
        simpan
      </JoButton>
      <JoButton
        action={() => popRoute()}
      >
        kembali
      </JoButton>
    </div>
  </form>
</div>