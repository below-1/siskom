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
  import { notification } from 'siskom-web-admin/stores/index.js';

  const perPage = 10
  export let params = {};
  $: idKelas = params.id ? parseInt(params.id) : null;
  let networkStatus = 'loading';
  let keyword = '';
  let items = [];
  let take = perPage;
  $: selectedId = items
    .filter(it => it.selected)
    .map(it => it.id);
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
        }
      })
      items = result.data.allMahasiswaKelas.nodes.map(it => ({
        ...it,
        selected: false,
        formattedNilai: formatNilai(it.nilai)
      }));
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  onMount(loadData);
</script>

<div class="flex items-center justify-between">
  <div class="font-semibold text-lg">Data Anggota Kelas</div>
  <div class="text-sm my-4 flex items-stretch">
    <JoInput bind:value={keyword} placeholder="cari.." />
    <JoLink cls="ml-2" to={`/#/admin/kelas/${idKelas}/members/add`} label="tambah" />
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
              {it.nilai.toFixed(3)}
              / {it.formattedNilai.angka}
              / {it.formattedNilai.huruf}
            </td>
            <td class="text-right flex items-center justify-end">
              <JoButton 
                cls="mr-1" 
                action={() => {
                  removeMember(it.mahasiswa.id)
                }}
              >
                <div class="h-4 w-4 text-red-700">
                  <MdDelete />
                </div>
              </JoButton>
              <JoButton
                label="nilai"
                action={() => {
                  gradeDialogData = {
                    idMahasiswa: it.mahasiswa.id,
                    idKelas,
                    currentGrade: it.nilai,
                    show: true
                  }
                }}
              >
              </JoButton>
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