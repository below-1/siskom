<script>
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import {
    JoAsyncContent,
    JoDialog,
    JoAutoComplete,
    JoButton
  } from 'siskom-web-commons';
  import { pop as popRoute } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { notification } from 'siskom-web-admin/stores/index.js';
  import GQLAddMahasiswaToKelas from 'siskom-web-admin/graphql/AddMahasiswaToKelas.js'

  const GQLCurrentMemberIds = gql`
    query CurrentMemberIds($idKelas: Int!) {
      all: allMahasiswaKelas(condition: {idKelas: $idKelas}) {
        nodes {
          mahasiswa: mahasiswaByIdMhs {
            id
          }
        }
      }
    }
  `;

  const GQLMahasiswaByKeyword = gql`
    query MahasiswaByKeyword($keyword: String!, $currentMemberIds: [Int!]!) {
      allMahasiswas(
        filter: {
          or: [
            { nim: { likeInsensitive: $keyword } }
            { nama: { likeInsensitive: $keyword }}
          ],
          id: {notIn: $currentMemberIds}
        }
      ) {
        nodes {
          id
          nama
          nim
          tahunMasuk
        }
      }
    }
  `;

  const GQLMahasiswaPassedMk = gql`
    query MahasiswaPassedMk($idMahasiswa: Int!) {
      transkrip(_idMahasiswa: $idMahasiswa, _tahun: 2020, _semester: 1, _keyword: "") {
        nodes {
          idMk
        }
      }
    }
  `;

  const GQLPrasyaratIds = gql`
    query PrasyaratIds($idKelas: Int!) {
      kelaById(id: $idKelas) {
        idMk
        mk: mataKuliahByIdMk {
          prasyaratMksByIdParent {
            nodes {
              idChild
            }
          }
        }
      }
    }

  `;

  export let params = {}
  $: idKelas = params.id ? parseInt(params.id) : null;
  let networkStatus = 'loading';
  let errorMessage = '';
  let currentMemberIds = []
  let keyword = '';
  let items = []
  let idMahasiswa = null;

  $: onSearch({ keyword });

  async function loadData () {
    networkStatus = 'loading';
    if (!idKelas) {
      networkStatus = 'error';
      return;
    }
    try {
      const currentMemberIdsResult = await apolloClient.query({
        query: GQLCurrentMemberIds,
        variables: {
          idKelas
        }
      })
      currentMemberIds = currentMemberIdsResult.data.all.nodes.map(it => it.mahasiswa.id)
      networkStatus = 'success'
    } catch (err) {
      console.log(err)
      networkStatus = 'error'
    }
  }

  async function onSearch({ keyword }) {
    console.log('currentMemberIds');
    console.log(currentMemberIds);
    try {
      const result = await apolloClient.query({
        query: GQLMahasiswaByKeyword,
        variables: {
          keyword: `${keyword}%`,
          currentMemberIds
        },
        fetchPolicy: 'network-only'
      })
      const { allMahasiswas } = result.data
      items = allMahasiswas.nodes
    } catch (err) {
      console.log(err);
    }
  }

  async function addMember () {
    if (!idKelas) return;
    if (!idMahasiswa) return;
    try {
      // check prasyarat
      const check_passed_result = await apolloClient.query({
        query: GQLMahasiswaPassedMk,
        variables: {
          idMahasiswa
        },
        fetchPolicy: 'network-only'
      });
      const mks = check_passed_result.data.transkrip.nodes.map(n => n.idMk);

      const curent_prasyarat_ids_result = await apolloClient.query({
        query: GQLPrasyaratIds,
        variables: {
          idKelas
        },
        fetchPolicy: 'network-only'
      });

      const current_prasyarat_ids_result = await apolloClient.query({
        query: GQLPrasyaratIds,
        variables: {
          idKelas
        },
        fetchPolicy: 'network-only'
      });

      let current_prasyarat_ids = [];
      console.log('current_prasyarat_ids_result');
      console.log(current_prasyarat_ids_result.data);
      current_prasyarat_ids_result
        .data.kelaById
        .mk.prasyaratMksByIdParent.nodes.forEach(n2 => {
          current_prasyarat_ids.push(n2.idChild);
        });
      console.log('====');
      console.log('mks');
      console.log(mks);
      // console.log('current_mk_id_result');
      // console.log(current_mk_id_result.data);
      for (let cpid of current_prasyarat_ids) {
        if (!mks.includes(cpid)) {
          notification.show({ type: 'error', message: 'mata kuliah prasyarat tidak terpenuhi' });
          return;
        }
      }

      const result = await apolloClient.mutate({
        mutation: GQLAddMahasiswaToKelas,
        variables: {
          idKelas,
          idMahasiswa
        }
      })
      const id = result.data.addMahasiswaToKelas.id
      console.log('done insert. new id = ', id);
      notification.show({ type: 'info', message: 'sukses menambah anggota kelas' });
      popRoute();
    } catch (err) {
      console.log(err);
    }
  }

  async function loadMembers () {
    try {
      const result = await apolloClient.query({
        query: GQLCurrentMemberIds,
        variables: {
          idKelas
        },
        fetchPolicy: 'network-only'
      });
      console.log('in loadMembers');
      console.log(result);
      currentMemberIds = result.data.all.nodes.map(n => n.mahasiswa.id);
    } catch (err) {
      console.log(err);
      alert('gagal mengambil data anggota kelas');
    }
  }

  onMount(loadMembers);

</script>

<div>
  <JoAutoComplete
    strategy='absolute'
    placeholder="Cari Mahasiswa..."
    onSearch={async (key) => {
      keyword = key;
    }}
    items={items}
    bind:value={idMahasiswa}
    let:item={item}
    let:selected={selected}
  >
    <div slot="selected">
      {selected.nama} - {selected.nim}
    </div>
    <div slot="item">
      <div class="text-sm font-medium">{item.nama}</div>
      <div class="text-xs">{item.nim}</div>
    </div>
  </JoAutoComplete>
  <JoButton 
    label="Simpan" dark={true} color="blue" cls="mt-2" 
    action={addMember}
  />
</div>