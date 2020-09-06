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
          const hari = formatDay(item.hariKul);
          let group = items.find(gr => gr.hari == hari);
          if (!group) {
            group = {
              hari,
              items: []
            };
            items.push(group);
          }
          group.items.push(item);
        });
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

<div class="bg-white mb-2 py-4 px-4">
  <div class="text-lg font-bold">Jadwal Perkuliahan</div>
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
      {#each items as group (group.hari)}
        <li class="p-4 flex">
          <div class="font-semibold w-16 ">{group.hari}</div>
          <ul class="ml-2 pl-2 border-l-2 border-teal-600 flex-grow">
            {#each group.items as item (item.idKelas)}
              <li class="pl-4 py-4 border-b border-gray-300 w-full">
                <div class="flex">
                  <div class="flex flex-col">
                    <a href={`/#/app/ilkom/mks/${item.idMk}`} class="font-bold underline">{item.namaMk}</a>
                    <div>
                      <a class="font-semibold underline" href={`/#/app/ilkom/kelas/${item.idKelas}/schedule`}>kelas {item.label}</a>, 
                      <a class="font-semibold underline" href={`/#/app/ilkom/dosens/${item.idDosen}/info`}>
                        {item.namaDosen}
                      </a>
                    </div>
                    <div>{item._schedule}, {item.ruangan}</div>
                  </div>
                </div>
              </li>
            {/each}
          </ul>
        </li>
      {/each}
    </ul>
  </div>
</JoAsyncContent>

