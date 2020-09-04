<script>
  import { onMount, onDestroy } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import { load as getStorage } from 'siskom/commons/storage.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import formatDay from 'siskom/commons/formatDay.js';
  import formatScheduleDayTime from 'siskom/commons/formatScheduleDayTime.js';

  const ScKelasMahasiswaGQL = gql`
    query ScKelasMahasiswa($idMahasiswa: Int!, $idPeriode: Int!) {
      scheduledKelasMahasiswa(_idMahasiswa: $idMahasiswa, _idPeriode: $idPeriode) {
        nodes {
          idKelas,
          idMk,
          kodeMk,
          namaMk,
          idDosen,
          namaDosen,
          nipDosen,
          label,
          hariKul,
          waktuKul,
          totalMenit,
          ruangan
        }
      }
    }
  `;

  const RequiredDataGQL = gql`
    query RequiredData($idMahasiswa: Int!) {
      currentPeriode {
        akhir
        awal
        id
        semester
        tahun
      }

      attendedPeriode (_idMahasiswa: $idMahasiswa) {
        nodes {
          id
          tahun
          semester
        }
      }
    }
  `

  let idPeriode = null;
  let idMahasiswa = null;
  let items = [];
  let networkStatus = 'loading';
  let optionsPeriode = [];

  function loadSchedule ({ idMahasiswa, idPeriode }) {
    if (!idPeriode || !idMahasiswa) {
      return
    }
    networkStatus = 'loading';
    apolloClient.query({
      query: ScKelasMahasiswaGQL,
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

  $: loadSchedule({ idMahasiswa, idPeriode });

  onMount(() => {
    networkStatus = 'loading';
    let user = getStorage('siskom.user');
    idMahasiswa = user.targetId;
    apolloClient.query({
      query: RequiredDataGQL,
      variables: {
        idMahasiswa
      }
    })
      .then(result => {
        const { attendedPeriode, currentPeriode } = result.data;
        optionsPeriode = attendedPeriode.nodes.map((periode, index) => {
          return {
            value: periode.id,
            label: `semester ${index + 1}, ${periode.tahun}/${periode.tahun + 1}`
          }
        })
        idPeriode = currentPeriode.id;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  });
</script>

<div class="bg-gray-200 py-4 px-4 border-gray-300">
  <div class="text-lg font-bold">Jadwal Perkuliahan</div>
  <JoSelect
    options={optionsPeriode}
    emptyLabel='Pilih Periode'
    bind:value={idPeriode}
  />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">
    <ul>
      {#each items as group (group.hari)}
        <li class="px-4 flex my-6">
          <div class="font-semibold w-16 ">{group.hari}</div>
          <ul class="ml-2 pl-2 border-l-2 border-teal-600">
            {#each group.items as item (item.idKelas)}
              <li class="pl-4 py-4 border-b border-gray-300 w-full">
                <div class="flex text-sm">
                  <div class="flex flex-col">
                    <span class="font-semibold text-sm">{item.namaMk}</span>
                    <div>
                      kelas {item.label}, {item.namaDosen}
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

