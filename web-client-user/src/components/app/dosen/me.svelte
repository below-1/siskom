<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import getCurrentPeriode from 'siskom/services/currentPeriode.js';

  import SVGCalendar from 'siskom/icons/calendar.svg';
  import SVGWork from 'siskom/icons/work.svg';
  import SVGTraining from 'siskom/icons/training.svg';
  import SVGTeacher from 'siskom/icons/teacher.svg';
  import SVGStudent from 'siskom/icons/student.svg';  
  import SVGBook from 'siskom/icons/book.svg';  

  const menus = [
    { label: 'jadwal', description: 'jadwal kelas yang diampuh pada tiap periode', icon: SVGCalendar, path: '/#/dosen/schedule' },
    { label: 'kelas', description: 'kelas pada tiap periode', icon: SVGWork, path: '/#/dosen/kelas' },
    { label: 'bimbingan pa', description: 'mahasiswa yang termasuk dalam bimbingan pa anda', icon: SVGTraining, path: '/#/dosen/pa' },
    { label: 'dosen', description: 'daftar dosen', icon: SVGTeacher, path: '/#/dosen/dosens' },
    { label: 'mahasiswa', description: 'daftar mahasiswa', icon: SVGStudent, path: '/#/dosen/students' },
    { label: 'mata kuliah', description: 'mata kuliah', icon: SVGBook, path: '/#/dosen/mks' }
  ];

  let id = null;
  let currentPeriode = null;
  let dosen = null;
  let phase = null;
  let totalSchedule = 0;
  let networkStatus = 'loading';

  const avatarUrl = 'https://api.adorable.io/avatars';
  $: avatar = !dosen ? undefined : `${avatarUrl}/64/${dosen.nip}.png`;

  const DosenDataGQL = gql`
    query DosenData {
      currentDosen {
        nama
        nip
        sex
        status
        id
        nodeId
      }
      currentSetting {
        currentPeriode {
          id
          awal
          akhir
          tahun
          semester
        }
        phase
      }
      scheduleOfDosen {
        totalCount
      }
    }
  `;

  function loadDosenData () {
    networkStatus = 'loading';
    apolloClient.query({
      query: DosenDataGQL
    })
      .then(result => {
        const {
          currentDosen,
          currentSetting: { 
            phase: currentPhase,
            currentPeriode: periode
          },
          scheduleOfDosen: { 
            totalCount 
          }
        } = result.data;
        dosen = currentDosen;
        phase = currentPhase;
        currentPeriode = periode;
        totalSchedule = totalCount;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  }

  onMount(loadDosenData);
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="bg-blue-900 text-white text-sm py-3 text-center">
      semester {currentPeriode.semester}, 
      periode {currentPeriode.tahun}/{currentPeriode.tahun + 1},
      fase {phase}
    </div>

    <div class="p-4 text-center flex flex-col items-center justify-center border-b border-gray-400 bg-gray-100">
      <img src={avatar} class="my-3 rounded-full" />
      <div class="font-semibold text-2xl">{dosen.nama}</div>
      <div class="font-semibold text-gray-700 text-sm">
        <span>{dosen.nip} </span>
        <span>{dosen.sex.toLowerCase()}</span>
        {#if dosen.status == 'AKTIF'}
          <span class="bg-green-600 text-white font-bold p-1">aktif</span>
        {:else if dosen.status == 'INAKTIF'}
          <span class="bg-red-600 text-white font-bold p-1">drop out</span>
        {/if}
      </div>

      <ul class="m-6">
        {#each menus as menu (menu.label)}
          <li class="shadow">
            <a href={menu.path} class="flex items-center bg-gray-200 mb-4 p-2 w-full h-full">
              <div style="max-width: 4rem; min-width: 4rem; width: 4rem;">
                <img src={menu.icon} />
              </div>
              <div class="text-left ml-2 flex-grow">
                <div class="font-bold">{menu.label}</div>
                <div class="font-medium text-xs break-all">{menu.description}</div>
              </div>
            </a>
          </li>
        {/each}
      </ul>

    </div>
  </div>
</JoAsyncContent>
