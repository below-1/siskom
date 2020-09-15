<script>
  import { getContext } from 'svelte';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoAsyncContent,
    JoDialog,
    JoNumber,
    JoButton,
    formatNilai,
    user, 
    mahasiswa, 
    phase, 
    periode
  } from 'siskom-web-commons';
  import EditGrade from './EditGrade.svelte';
  import buildAvatar from 'siskom-web-user/commons/buildAvatar.js';
  import GQLKelasScheduleMembers from 'siskom-web-user/graphql/KelasScheduleMembers.js';
  import GQLKelasSchedule from 'siskom-web-user/graphql/KelasSchedule.js';
  import * as context_key from './context.js';

  export let params = {};
  const kelas = getContext(context_key.kelas);
  $: idKelas = $kelas && $kelas.id ? $kelas.id : null;

  let schedule = null;
  let members = [];
  let networkStatus = 'loading';

  let showEditGrade = false;
  let nama = '';
  let nilai = 0;
  let idMahasiswaKelas = 0;

  $: loadMembers({ idKelas });
  $: loadSchedule({ user: $user, idKelas });
  $: editTitle = 'Ubah Nilai ' + nama;
  $: canSeeGrade = userCanSeeGrade({ user: $user });
  $: canEditGrade = userCanEditGrade({ 
    user: $user, 
    schedule, 
    phase: $phase, 
    periode: $periode,
    kelas: $kelas
  });

  function userCanSeeGrade ({ user }) {
    if (!user) return false;
    if (user.tipeUser == 'DOSEN' || user.tipeUser == 'ADMIN') return true;
    return false;
  }

  function userCanEditGrade ({ user, kelas, schedule, phase, periode }) {
    if (!user) return false;
    if (!schedule) return false;
    if (!phase) return false;
    if (!kelas) return false;
    if (user.tipeUser == 'MAHASISWA') return false;
    if (periode.id != kelas.periode.id) return false;
    if (phase != 'GRADING' && phase != 'REVISE') return false;
    if (user.targetId == schedule.dosen.id) return true;
    return false;
  }

  function onEditGrade (idMember) {
    let member = members.find(it => it.id == idMember);
    if (!member) return;
    idMahasiswaKelas = idMember;
    nama = member.mahasiswa.nama;
    nilai = member.nilai;
    console.log(showEditGrade);
    showEditGrade = true;
  }

  function onDoneEdit () {
    showEditGrade = false;
    loadMembers({ idKelas });
  }

  async function loadMembers ({ idKelas }) {
    console.log('logging');
    console.log(idKelas);
    if (!idKelas) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLKelasScheduleMembers,
        variables: {
          idKelas
        }
      });
      members = result.data.members.nodes.map(it => {
        const { nilai } = it;
        const formattedNilai = nilai ? formatNilai(nilai) : null;
        return {
          ...it,
          avatar: buildAvatar(it.mahasiswa.id, 32),
          formattedNilai
        }
      });

      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  async function loadSchedule ({ user, idKelas }) {
    if (!user) return;
    if (!idKelas) return;
    if (user.tipeUser == 'MAHASISWA') return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLKelasSchedule,
        variables: {
          idKelas
        }
      });
      schedule = result.data.schedule;
      networkStatus = 'success';
    } catch (err) {
      networkStatus = 'error';
      console.log(err);
    }
  }
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <ul class="my-2 bg-white">
      {#each members as member (member.id)}
        <li class="py-2 border-b border-gray-300 flex items-center hover:bg-gray-100">
          <div class="w-20 px-2 py-1 flex items-center">
            <img src={member.avatar} />
          </div>
          <div class="flex-grow flex items-center">
            <div class="w-1/2 md:w-1/3">
              <a 
                class="font-black underline" 
                href={`/#/app/ilkom/mahasiswas/${member.mahasiswa.id}/info`}
                >{member.mahasiswa.nama}</a>
              <div class="text-sm text-gray-700 md:hidden">
                <span>{member.mahasiswa.sex.toLowerCase()}</span> 
                <span>, {member.mahasiswa.nim}</span>
              </div>
            </div>
            <div class="hidden md:block md:w-1/3 text-right">
              angkatan {member.mahasiswa.tahunMasuk}
            </div>
            {#if canSeeGrade || ($mahasiswa && $mahasiswa.id == member.mahasiswa.id) }
              <div class="w-1/2 md:w-1/3 flex items-center justify-end">
                <span class="text-right font-bold">
                  {member.formattedNilai.huruf} - {member.nilai.toFixed(2)}
                </span>
                {#if canEditGrade }
                  <JoButton 
                    label="edit" 
                    action={() => {
                      onEditGrade(member.id)
                    }}
                    cls="py-1 ml-2 text-xs font-bold"
                  />
                {/if}
              </div>
            {/if}
          </div>
        </li>
      {/each}
    </ul>

    <JoDialog bind:show={showEditGrade} title={editTitle}>
      <div>
        <EditGrade 
          id={idMahasiswaKelas}
          bind:nilai={nilai} 
          on:done={onDoneEdit}
        />
      </div>
    </JoDialog>
  </div>
</JoAsyncContent>
