<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { periode } from 'siskom-web-admin/stores/index.js';
  import { parse, format, addMinutes } from 'date-fns';
  import { push as pushRoute } from 'svelte-spa-router';
  import MdDateRange from 'svelte-icons/md/MdDateRange.svelte'
  import MdDelete from 'svelte-icons/md/MdDelete.svelte'
  import MdSupervisorAccount from 'svelte-icons/md/MdSupervisorAccount.svelte';
  import {
    formatDay,
    filterKelas,
    allIsNull,
    JoSpinner,
    JoAsyncContent,
    JoLink,
    JoSelect,
    JoInput,
    JoButton
  } from 'siskom-web-commons';
  import { warning, notification } from 'siskom-web-admin/stores/index.js';
  import GQLListKelas from 'siskom-web-admin/graphql/ListKelas.js';
  import GQLDeleteKelas from 'siskom-web-admin/graphql/DeleteKelas.js';
  import 'siskom-web-admin/styles/jo-table.css';

  // state
  let idPeriode = null;
  let keyword = ''
  let optionsPeriode = []
  let error = null
  let items = []
  let loading = true
  let classes = []
  let filteredClasses = []
  let networkStatus = 'loading';

  $: selectedPeriode = idPeriode ? idPeriode : ($periode ? $periode.id : null);
  $: getListKelas({ selectedPeriode });
  $: onKeywordChange({ keyword, classes });

  async function getListKelas ({ selectedPeriode }) {
    let result;
    networkStatus = 'loading';

    try {
      result = await apolloClient.query({ 
        query: GQLListKelas, 
        variables: { idPeriode: selectedPeriode }
      });

      optionsPeriode = result.data.allPeriodes.nodes.map(it => ({
        label: `${it.tahun}/${it.tahun + 1}, semester ${it.semester}`,
        value: it.id
      }));

      classes = result.data.allKelas.nodes.map(kelas => {
        if (kelas.schedule) {
          const sch = kelas.schedule;
          const t0 = parse(sch.waktuKul, 'HH:mm:ss', new Date());
          const t1 = addMinutes(t0, 120);
          const fday = formatDay(sch.hariKul);
          return {
            ...kelas,
            schedule: {
              ...kelas.schedule,
              formatDayTime: `${fday}, ${format(t0, 'HH:mm')} - ${format(t1, 'HH:mm')}`
            }
          }
        }
        return kelas;
      })
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }    
  }

  function onKeywordChange({ keyword, classes }) {
    if (!keyword) {
      filteredClasses = [ ...classes ]
      return
    }
    loading = true;
    const lowerKeyword = keyword.toLowerCase()
    filteredClasses = classes.filter(filterKelas(lowerKeyword))
    loading = false;
  }

  async function on_delete_commit (id) {
    try {
      await apolloClient.mutate({
        mutation: GQLDeleteKelas,
        variables: {
          id
        }
      })
      notification.show({ 
        type: 'info', 
        message: 'sukses menghapus data' 
      })
    } catch (err) {
      notification.show({ 
        type: 'danger', 
        message: 'gagal menghapus data' 
      })
    }
  }

  function on_delete (item) {
    warning.show({
      message: `anda akan menghapus data kelas #${item.label}, ${item.mataKuliah.nama}`,
      on_next: async () => {
        await on_delete_commit(item.id)
        onFilterChange ({ idPeriode, keyword })
      }
    })
  }

  onMount(async () => {
  })
</script>

<div class="text-sm my-6 flex items-stretch">
  <JoSelect label="periode" options={optionsPeriode} bind:value={idPeriode} />
  <JoInput bind:value={keyword} placeholder="nama mk.." cls="ml-2" />
  <JoLink cls="ml-2" to="/#/admin/data/kelas/create" label="tambah" />
</div>
<JoAsyncContent
  {networkStatus}
>
  <table slot="success" class="jo-table">
    <thead>
      <tr>
        <th>Mata Kuliah</th>
        <th>Label</th>
        <th>Dosen</th>
        <th>Waktu</th>
        <th>Ruangan</th>
        <th>Peserta</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      {#each filteredClasses as item (item.nodeId)}
        <tr>
          <td>
            <div class="font-semibold">{item.mataKuliah.nama}</div>
            <div class="font-medium text-gray-900 text-xs">
              {item.mataKuliah.tipeMk}, {item.mataKuliah.kode}
            </div>
          </td>
          <td>{item.label}</td>
          {#if item.schedule}
            <td>{item.schedule.dosen.nama}</td>
            <td>{item.schedule.formatDayTime}</td>
            <td>{item.schedule.ruangan}</td>
            <td>{item.schedule.kapasitas}</td>
          {:else}
            <td colspan=4></td>
          {/if}
          <td class="flex items-stretch justify-end">
            {#if item.schedule}
            <JoButton
              action={() => {
                pushRoute(`/admin/data/kelas/members/${item.id}`)
              }}
            >
              <div class="flex items-center">
                <div class="h-4 w-4">
                  <MdSupervisorAccount />
                </div>
              </div>
            </JoButton>
            <JoButton
              action={() => {
                pushRoute(`/admin/data/kelas/schedule/${item.id}`)
              }}
              cls="ml-1"
            >
              <div class="flex items-center">
                <div class="h-4 w-4">
                  <MdDateRange />
                </div>
              </div>
            </JoButton>
            {/if}
            <JoButton
              action={() => on_delete(item)}
              cls="ml-1"
            >
              <div class="h-4 w-4 text-red-700">
                <MdDelete />
              </div>
            </JoButton>
          </td>
        </tr>
      {/each}
    </tbody>
  </table>
</JoAsyncContent>
