<script>
  import { onMount, getContext } from 'svelte';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoAsyncContent,
    JoSelect,
    formatDay,
    formatScheduleDayTime,
    periode
  } from 'siskom-web-commons';
  import GQLScheduledKelasMahasiswa from 'siskom-web-user/graphql/ScheduledKelasMahasiswa.js';
  import * as context_key from './context.js';

  const mahasiswa = getContext(context_key.mahasiswa);
  const attendedPeriode = getContext(context_key.attendedPeriode);

  $: idMahasiswa = $mahasiswa.id;
  $: optionsPeriode = $attendedPeriode.map((it, index) => {
    return {
      value: it.id,
      label: `semester ${index + 1}, ${it.tahun}/${it.tahun + 1}`
    }
  });
  let idPeriode = null;
  let items = [];
  let optionsPeriode = [];
  let networkStatus = 'loading';

  function loadSchedule ({ idMahasiswa, idPeriode }) {
    if (!idPeriode || !idMahasiswa) {
      return
    }
    networkStatus = 'loading';
    apolloClient.query({
      query: GQLScheduledKelasMahasiswa,
      variables: {
        idMahasiswa,
        idPeriode
      }
    })
      .then(result => {
        const raws = result.data.scheduledKelasMahasiswa.nodes.map(it => {
          const _schedule = formatScheduleDayTime({
            hari: it.hariKul,
            jam: it.waktuKul,
            totalMenit: it.totalMenit
          });
          const [ day, ..._withoutDay ] = _schedule.split(',')
          return {
            _schedule: _withoutDay.join(','),
            ...it
          }
        });
        items = [];
        raws.forEach(item => {
          if (items.length == 0) {
            // if empty list, push day of this item
            const itemDay = formatDay(item.hariKul);
            items.push({
              separator: true,
              text: itemDay,
              idKelas: itemDay // fake id for iteration key
            })
            items.push(item);
            return;
          }
          // if day of last item is different from current item,
          // add separator
          const n = items.length;
          const prevItem = items[n - 1];
          const prevItemDay = formatDay(prevItem.hariKul);
          const currentItemDay = formatDay(item.hariKul);
          if (prevItemDay != currentItemDay) {
            items.push({
              separator: true,
              text: currentItemDay,
              idKelas: currentItemDay // fake id for iteration key
            })
          }
          items.push(item);
        })
        console.log(items);
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      });
  }

  $: {
    if ($periode && $periode.id && !idPeriode) {
      idPeriode = $periode.id;
    }
  };

  $: loadSchedule({ idMahasiswa, idPeriode });
</script>

<div class="text-3xl font-black my-6">Jadwal Perkuliahan</div>
<div class="w-64 mb-6">
  <JoSelect
    options={optionsPeriode}
    emptyLabel='Pilih Periode'
    label="periode"
    bind:value={idPeriode}
  />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success" class="bg-white">
    <ul>
      {#each items as item (item.idKelas)}
        {#if item.separator}
          <li class="font-bold mt-8 text-2xl">{item.text}</li>
        {:else}
          <li class="p-4 border-b-2 border-dashed border-gray-400 w-full">
            <div class="flex">
              <div class="flex flex-col">
                <div class="text-lg">
                  <a href={`/#/app/ilkom/mks/${item.idMk}`} class="font-bold underline mr-4">{item.namaMk}</a>
                  <a class="mr-4 font-semibold underline" href={`/#/app/ilkom/kelas/${item.idKelas}/schedule`}>kelas {item.label}</a>, 
                  <a class="mr-4 font-semibold underline" href={`/#/app/ilkom/dosens/${item.idDosen}/info`}>
                    {item.namaDosen}
                  </a>
                </div>
                <div>{item._schedule}, {item.ruangan}</div>
              </div>
            </div>
          </li>
        {/if}
      {/each}
    </ul>
  </div>
</JoAsyncContent>

