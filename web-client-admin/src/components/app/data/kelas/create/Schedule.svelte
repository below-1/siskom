<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { pop as pop_route, push as pushRoute } from 'svelte-spa-router';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';
  import MdWarning from 'svelte-icons/md/MdWarning.svelte'
  import {
    allIsNull,
    isEmptyRef,
    JoAutoComplete,
    JoInput,
    JoNumber,
    JoSelect,
    JoButton
  } from 'siskom-web-commons';
  import { notification } from 'siskom-web-admin/stores/index.js';
  import filterDosen from 'siskom-web-admin/services/filterDosen.js';
  import * as GQL from 'siskom-web-admin/graphql/KelasSchedule.js';
  import { ClashError, CLASHES, FORM } from '../commons.js';

  let dosenId = null;
  let ruangan = '';
  let hariKul = 1;
  let waktuKul;
  let totalMenit;
  let kapasitas = 40;
  let keywordDosen = '';
  let clashes = [];
  let allHariKuliahs = [
    { value: 1, label: 'senin' },
    { value: 2, label: 'selasa' },
    { value: 3, label: 'rabu' },
    { value: 4, label: 'kamis' },
    { value: 5, label: 'jumat' },
    { value: 6, label: 'sabtu' }
  ];
  let allDosens = [];
  let allRooms = [];

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
  $: filteredDosen = filterDosen({ keywordDosen, allDosens });

  function checkKapasitas ({ kapasitas, room }) {
    if (!room) return null
    if (room && kapasitas > room.kapasitas) 
      return `Jumlah peserta tidak boleh melebihi kapasitas ruangan. Maksimal ${room.kapasitas}`
    return null
  }

  async function loadData () {
    try {
      const result = await apolloClient.query({ query: GQL.RequiredData })
      allDosens = result.data.allDosens.nodes
      allRooms = result.data.allRooms.nodes.map(it => ({
        label: it.nama,
        value: it.nama
      }))

      const rawPrevData = localStorage.getItem(FORM);
      if (!rawPrevData) return;
      const prev_data = JSON.parse(rawPrevData);
      // remember exoteric naming
      if (prev_data._dosenId) dosenId = prev_data._dosenId;
      if (prev_data._ruangan) ruangan = prev_data._ruangan;
      if (prev_data._hariKul) hariKul = prev_data._hariKul;
      if (prev_data._waktuKul) waktuKul = prev_data._waktuKul;
      if (prev_data._kapasitas) kapasitas = prev_data._kapasitas;
      if (prev_data._totalMenit) totalMenit = prev_data._totalMenit;
    } catch (err) {
      console.log(err)
    }
  }

  async function onSave () {
    const rawPrevData = localStorage.getItem(FORM)
    if (!rawPrevData) {
      alert('Data belum diisi');
      return;
    };
    const prev_data = JSON.parse(rawPrevData);
    // // Mapping to esoteric naming
    const payload = {
      _mkId: prev_data.mkId,
      _periodeId: prev_data.periodeId,
      _label: prev_data.label,
      _dosenId: dosenId,
      _ruangan: ruangan,
      _hariKul: hariKul,
      _waktuKul: waktuKul,
      _totalMenit: totalMenit,
      _kapasitas: kapasitas
    }
    // Save form data for later use
    localStorage.setItem(FORM, JSON.stringify({
      ...prev_data,
      ...payload
    }))
    try {
      const clashesResult = await apolloClient.query({
        query: GQL.ClashCourse,
        variables: {
          periodeId: prev_data.periodeId,
          dosenId,
          ruangan,
          waktuKul,
          hariKul,
          totalMenit
        }
      })
      if (!clashesResult) throw new Error('fail to check clash');
      let clashes = clashesResult.data.listClashCourses.nodes;
      if (clashes.length > 0) {
        throw new ClashError(clashes)
      }
      await apolloClient.mutate({
        mutation: GQL.CreateSchedule,
        variables: {
          payload
        }
      })
      notification.show({ type: 'info', message: 'sukses menambah data kelas' })
      pushRoute('/admin/data/kelas')
    } catch (err) {
      console.log(err)
      if (err.name == 'ClashError') {
        localStorage.setItem(CLASHES, JSON.stringify(err.clashes));
        notification.show({ type: 'danger', message: 'kelas bertabrakan' });
        pushRoute('/admin/data/kelas/error-clashes');
      } else {
        notification.show({ type: 'danger', message: 'gagal menambah data kelas' });
      }
    }
  }

  onMount(loadData);
</script>

<div class="w-1/2 mx-auto border border-gray-400 p-4">
  <form>

    <div class="mb-6 flex flex-col">
      <label class="text-sm">Dosen</label>
      <JoAutoComplete
        placeholder="Cari Dosen..."
        onSearch={async key => {
          keywordDosen = key;
        }}
        items={filteredDosen}
        bind:value={dosenId}
        let:item={item}
        let:selected={selected}
      >
        <div slot="selected">
          {selected.nama} - {selected.nip}
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
      <JoSelect label="Ruangan" bind:value={ruangan} options={allRooms} />
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
        action={() => { pop_route(); }}
      >
        kembali
      </JoButton>
    </div>

  </form>
</div>