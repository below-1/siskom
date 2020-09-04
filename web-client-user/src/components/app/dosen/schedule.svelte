<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import formatPeriode from 'siskom/commons/formatPeriode.js';
  import formatDay from 'siskom/commons/formatDay.js';
  import formatScheduleDayTime from 'siskom/commons/formatScheduleDayTime.js';

  let items = [];
  let networkStatus = 'loading';
  let optionsPeriode = [];
  let idPeriode = null;

  const GQL_ScheduleRequired = gql`
    query ScheduleRequired {
      allPeriodes {
        nodes {
          id
          tahun
          semester
        }
      }
      currentSetting {
        currentPeriode {
          id
        }
      }
    }
  `;

  const GQL_Schedule = gql`
    query Schedule($idPeriode: Int) {
      schedule: scheduleOfDosen(_idPeriode: $idPeriode) {
        nodes {
          hariKul
          idDosen
          kapasitas
          nodeId
          ruangan
          totalMenit
          waktuKul
          kelas: kelaByIdKelas {
            label
            id
            mk: mataKuliahByIdMk {
              id
              kode
              minSks
              nama
              nodeId
              openIn
              prefSchedule
              scheduled
              sks
              tipeMk
            }
            nodeId
          }
        }
      }
    }
  `;

  function getRequired () {
    networkStatus = 'loading';
    apolloClient.query({
      query: GQL_ScheduleRequired
    })
      .then(result => {
        optionsPeriode = result.data.allPeriodes.nodes.map(it => {
          return {
            label: formatPeriode(it),
            value: it.id
          }
        })
        idPeriode = result.data.currentSetting.currentPeriode.id;
        networkStatus = 'success';
      })
      .catch(err => {
        networkStatus = 'error';
        console.log(err);
      })
  }

  function getSchedules ({ idPeriode }) {
    apolloClient.query({
      query: GQL_Schedule,
      variables: {
        idPeriode
      }
    })
      .then(result => {
        const raws = result.data.schedule.nodes.map(it => {
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
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  }

  onMount(getRequired);

  $: getSchedules({ idPeriode });
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="px-6 py-4 border-b border-gray-300 bg-gray-100">
      <div class="font-semibold text-lg text-center">Jadwal Perkuliahan</div>
      <JoSelect label="periode" bind:value={idPeriode} options={optionsPeriode} />
    </div>
    <ul class="my-3">
      {#each items as group (group.hari)}
        <li class="px-4 flex my-6">
          <div class="font-semibold w-16 ">{group.hari}</div>
          <ul class="ml-2 pl-2 border-l-2 border-teal-600">
            {#each group.items as item (item.nodeId)}
              <li class="pl-4 py-4 border-b border-gray-300 w-full" on:click={() => {
                pushRoute('/dosen/detail-kelas/' + item.kelas.id)
              }}>
                <div class="flex text-sm">
                  <div class="flex flex-col">
                    <span class="font-semibold text-sm">{item.kelas.mk.nama}</span>
                    <div>
                      kelas {item.kelas.label}
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
