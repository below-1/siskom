<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import MdDelete from 'svelte-icons/md/MdDelete.svelte'
  import {
    JoAsyncContent,
    JoSpinner,
    JoLink,
    JoInput,
    JoSelect,
    JoButton,
    formatNilai
  } from 'siskom-web-commons';
  import GQLKelasMembers from 'siskom-web-admin/graphql/KelasMembers.js';
  import GQLDeleteMember from 'siskom-web-admin/graphql/DeleteMember.js';
  import { notification, phase } from 'siskom-web-admin/stores/index.js';
  import MemberGradeDialog from './MemberGrade.svelte';
  import * as GQL from 'siskom-web-admin/graphql/KelasSchedule.js';

  const perPage = 10
  export let params = {};
  $: idKelas = params.id ? parseInt(params.id) : null;
  let networkStatus = 'loading';
  let keyword = '';
  let items = [];
  let take = perPage;
  let kelas = {};
  $: selectedId = items
    .filter(it => it.selected)
    .map(it => it.id);
  let addMemberDialog = false;
  let gradeDialogData = {
    idMahasiswa: null,
    idKelas: null,
    currentGrade: 0,
    show: false
  };
  $: filtered = items.filter(filterMahasiswa(keyword));
  $: sliced = filtered.slice(0, take);
  $: canMore = filtered.length > take;
  $: canLess = filtered.length > perPage;

  function filterMahasiswa (keyword) {
    const _keyword = keyword.toLowerCase();
    return (it) => {
      const nama = it.mahasiswa.nama.toLowerCase();
      if (nama.includes(_keyword)) return true;
      const nim = it.mahasiswa.nim.toLowerCase();
      if (nim.includes(_keyword)) return true;
      return false;
    }
  }

  function onMore () {
    take += perPage;
  }

  function onLess () {
    take -= perPage;
  }

  async function loadData () {
    if (!idKelas) return;
    try {
      const result = await apolloClient.query({
        query: GQLKelasMembers,
        variables: {
          idKelas
        },
        fetchPolicy: 'network-only'
      })
      items = result.data.allMahasiswaKelas.nodes.map(it => ({
        ...it,
        selected: false,
        formattedNilai: formatNilai(it.nilai)
      }));

      // Load kelas
      const kelas_result = await apolloClient.query({
        query: GQL.ScheduleById,
        variables: {
          id: idKelas
        },
        fetchPolicy: 'network-only'
      })
      kelas = kelas_result.data.scheduledKelaByIdKelas;
      console.log('kelas');
      console.log(kelas);
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  async function removeMember(idMahasiswaKelas) {
    try {
      await apolloClient.mutate({
        mutation: GQLDeleteMember,
        variables: {
          idMahasiswaKelas
        }
      })
      notification.show({
        type: 'success',
        message: 'sukses menghapus data anggota kelas'
      })
    } catch (err) {
      console.log(err)
      notification.show({
        type: 'error',
        message: 'gagal menghapus data anggota kelas'
      })
    } finally {
      await loadData();
    }
  }

  onMount(loadData);
</script>

<div class="flex items-center justify-between">
  <div class="font-semibold text-lg">Data Anggota Kelas</div>
  <div class="text-sm my-4 flex items-stretch">
    <JoInput bind:value={keyword} placeholder="cari.." />
    {#if items.length < kelas.kapasitas}
      <JoLink
        to={`/#/admin/data/kelas/${idKelas}/add-member`}
        cls="ml-2"
        label="tambah"
      />
    {/if}
  </div>
</div>

<JoAsyncContent {networkStatus}>
  <div slot="success">
    <table class="jo-table">
      <thead>
        <tr>
          <th>NIM</th>
          <th>Nama</th>
          <th>Angkatan</th>
          <th>Nilai</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {#each sliced as it (it.mahasiswa.id)}
          <tr>
            <td>{it.mahasiswa.nim}</td>
            <td class="font-semibold">{it.mahasiswa.nama}</td>
            <td>{it.mahasiswa.tahunMasuk}</td>
            <td class="font-semibold">
              {#if it.nilai || it.nilai == 0}
                {it.nilai.toFixed(3)}
                / {it.formattedNilai.angka}
                / {it.formattedNilai.huruf}
              {:else}
                -
              {/if}
            </td>
            <td class="text-right flex items-center justify-end">
              <JoButton 
                cls="mr-1" 
                action={() => {
                  removeMember(it.id);
                }}
              >
                <div class="h-4 w-4 text-red-700">
                  <MdDelete />
                </div>
              </JoButton>
              {#if (($phase === 'GRADING') || ($phase == 'REVISE'))}
                <JoButton
                  label="nilai"
                  action={() => {
                    gradeDialogData = {
                      id: it.id,
                      idMahasiswa: it.mahasiswa.id,
                      idKelas,
                      currentGrade: it.nilai,
                      show: true
                    }
                  }}
                >
                </JoButton>
              {/if}
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
    <div class="flex items-center mt-4 text-sm">
      <JoButton disabled={!canMore} action={onMore}>more</JoButton>
      <JoButton disabled={!canLess} action={onLess} cls="ml-2">less</JoButton>
    </div>
  </div>
</JoAsyncContent>

<MemberGradeDialog 
  {...gradeDialogData} 
  on:done={() => {
    console.log('ok');
    loadData();
    gradeDialogData = {
      ...gradeDialogData,
      show: false
    }
  }}
/>
