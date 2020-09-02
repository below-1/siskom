<script>
  import { gql } from '@apollo/client/core';
  import {
    JoAsyncContent,
    JoDialog,
    JoAutoComplete,
    JoButton
  } from 'siskom-web-commons';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
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
    try {
      const result = await apolloClient.query({
        query: GQLMahasiswaByKeyword,
        variables: {
          keyword: `${keyword}%`,
          currentMemberIds
        }
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
      const result = await apolloClient.mutate({
        mutation: GQLAddMahasiswaToKelas,
        variables: {
          idKelas,
          idMahasiswa
        }
      })
      const id = result.data.addMahasiswaToKelas.id
      console.log('done insert. new id = ', id)
    } catch (err) {
      console.log(err);
    }
  }

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