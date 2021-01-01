<script>
  import { onMount } from 'svelte'
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { push as pushRoute } from 'svelte-spa-router'
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';
  import { 
    isEmptyRef,
    allIsNull,
    JoAutoComplete,
    JoLink,
    JoInput,
    JoSelect,
    JoButton,
    formatPeriode
  } from 'siskom-web-commons';
  import { get_input_payload, set_input_payload } from '../commons';
  import { notification } from 'siskom-web-admin/stores/index.js';

  const GQLRequired = gql`
    query CreateKelasBaseRequired {
      allPeriodes {
        nodes {
          id
          tahun
          semester
        }
      }

      allMataKuliahs {
        nodes {
          id
          kode
          nama
          tipeMk
          scheduled
          openIn
        }
      }
    }
  `;

  const GQLCreateNonScheduled = gql`
    mutation CreateNonScheduled($payload: KelaInput!) {
      createKela(input: {
        kela: $payload
      }) {
        kela {
          id
        }
      }
    }
  `;

  const take = 5;

  let mkId = null;
  let periodeId = null;
  let label = '';
  let periodes = [];
  let mks = [];
  let keyword = '';

  $: selected_mk = !mkId || mks.length == 0 ? null : mks.find(it => it.id == mkId);
  $: scheduled = selected_mk && selected_mk.scheduled
  $: filtered_periode = filter_periode({ mk: selected_mk, periodes });
  $: options_periode = filtered_periode 
    ? filtered_periode.map(it => ({
        value: it.id,
        label: it.formatted
      }))
    : [];
  $: filtered_mata_kuliah = filter_mata_kuliah({ mks, keyword });
  $: errors = {
    mkId: !mkId ? 'Mata Kuliah tidak boleh kosong' : null,
    label: isEmpty(label) ? 'Label tidak boleh kosong' : null,
    periodeId: !periodeId ? 'Periode tidak boleh kosong' : null
  };
  $: invalid = !allIsNull(errors);

  function filter_mata_kuliah ({ mks, keyword }) {
    if (!mks || mks.length == 0) return [];
    const keywordUpper = keyword.toUpperCase();
    const items = mks.filter(mk => {
      const nama = mk.nama.toUpperCase();
      if (nama.includes(keywordUpper)) return true;
      const kode = mk.kode.toUpperCase();
      if (kode.includes(keywordUpper)) return true;
      return false;
    }).slice(0, 5);
    return items;
  }

  function filter_periode ({ mk, periodes }) {
    if (!mk) return periodes;
    if (mk.openIn == 'ALL') return periodes;
    if (mk.openIn == 'GANJIL') return periodes.filter(it => it.semester == 1);
    if (mk.openIn == 'GENAP') return periodes.filter(it => it.semester == 2);
    else 
      throw new Error(`invalid openIn: ${mk.openIn}`);
  }

  async function save_non_scheduled () {
    const payload = {
      idPeriode: periodeId,
      idMk: mkId,
      label
    }
    try {
      const result = await client.mutate({
        mutation: GQLCreateNonScheduled,
        variables: {
          payload
        }
      })
      notification.show({ 
        type: 'info',
        message: 'sukses menambah data kelas'
      })
      pushRoute('/admin/kelas')
    } catch (err) {
      notification.show({ 
        type: 'danger',
        message: 'gagal menambah data kelas'
      })
    }
  }

  function onSave() {
    let nextPath;
    if (!scheduled) {
      save_non_scheduled()
      nextPath = '/admin/kelas'
    } else {
      set_input_payload({
        periodeId,
        label,
        mkId
      })
      nextPath = '/admin/data/kelas/create/schedule'
    }
    pushRoute(nextPath)
  }

  onMount(async () => {
    const result = await apolloClient.query({ query: GQLRequired });
    periodes = result.data.allPeriodes.nodes.map(it => ({
      ...it,
      formatted: formatPeriode(it)
    }));
    mks = result.data.allMataKuliahs.nodes;

    // const inputPayload = get_input_payload();
    // if (!inputPayload) return;
    // if (inputPayload.mkId) mkId = inputPayload.mkId;
    // if (inputPayload.periodeId) periodeId = inputPayload.periodeId;
    // if (inputPayload.label) label = inputPayload.label;
  });
</script>

<div class="w-1/3 mx-auto border border-gray-400 p-4">
  <form>
    <div class="mb-6 flex flex-col">
      <label class="text-sm">Mata Kuliah</label>
      <JoAutoComplete
        placeholder="Cari Mata Kuliah..."
        onSearch={async key => {
          keyword = key;
        }}
        items={filtered_mata_kuliah}
        bind:value={mkId}
        let:item={item}
        let:selected={selected}
      >
        <div slot="selected">
          {selected.nama} - {selected.kode}
        </div>
        <div slot="item">
          <div class="text-sm font-medium">{item.nama}</div>
          <div class="text-xs">{item.kode}</div>
        </div>
      </JoAutoComplete>
      {#if errors.mkId}
        <div class="text-red-600 text-sm font-semibold">{errors.mkId}</div>
      {/if}
    </div>
    <div class="mb-6 flex flex-col">
      <label class="text-sm">Periode</label>
      <JoSelect options={options_periode} bind:value={periodeId} />
      {#if errors.periodeId}
        <div class="text-red-600 text-sm font-semibold">{errors.periodeId}</div>
      {/if}
    </div>
    <div class="mb-6 flex flex-col">
      <label class="text-sm">Label</label>
      <input 
        bind:value={label}
        class="rounded bg-gray-200 p-2 text-sm focus:bg-white focus:outline-none focus:shadow-outline" 
        placeholder="Label Kelas" />
      {#if errors.label}
        <div class="text-red-600 text-sm font-semibold">{errors.label}</div>
      {/if}
    </div>
    <div>
      <button 
        type="button"
        on:click={onSave}
        disabled={invalid}
        class="px-4 py-1 font-semibold bg-blue-700 rounded disabled:opacity-50 text-white"
      >
        {scheduled ? 'Selanjutnya' : 'Simpan'}
    </button>
    </div>
  </form>
</div>
