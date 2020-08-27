<script>
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import MdDelete from 'svelte-icons/md/MdDelete.svelte';
  import MdCreate from 'svelte-icons/md/MdCreate.svelte';
  import GQLListDosen from 'siskom-web-admin/graphql/ListDosen.js';
  import GQLDeleteDosen from 'siskom-web-admin/graphql/DeleteDosen.js';
  import {
    JoLink,
    JoInput,
    JoSelect,
    JoButton,
    JoAsyncContent,
    formatJk
  } from 'siskom-web-commons';
  import { warning } from 'siskom-web-admin/stores/index.js';
  import 'siskom-web-admin/styles/jo-table.css';

  let networkStatus = 'loading';
  let keyword = '';
  let items = [];

  function fetchData ({ keyword }) {
    networkStatus = 'loading';
    const queryResult = apolloClient.query({
      query: GQLListDosen,
      variables: {
        keyword: keyword + '%'
      },
      fetchPolicy: "network-only"
    });
    return queryResult
      .then(result => {
        const root = result.data.allDosens;
        items = root.nodes;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      });
  }

  function onNext () {
    take += 10;
  }

  function onPrevious () {
    take -= 10;
  }

  function onDelete (item) {
    warning.show({
      message: `anda akan menghapus dosen #${item.nip}, ${item.nama}`,
      on_next: async () => {
        await remove(item.id)
      }
    })
  }

  function remove(id) {
    return apolloClient.mutate({
      mutation: GQLDeleteDosen,
      variables: {
        id
      }
    })
      .then(() => fetchData({ keyword }))
      .catch(err => {
        console.log(err);
        alert('gagal menghapus data');
      });
  }

  $: {
    fetchData({
      keyword
    });
  };
</script>

<div class="my-8 mx-auto">
  <div class="text-sm text-gray-800 my-4 flex items-stretch">
    <JoInput bind:value={keyword} placeholder="cari..." />
    <JoLink
      to="/#/admin/data/dosen/create" 
      cls="ml-2"
      label="tambah"
    />
  </div>
  <JoAsyncContent {networkStatus}>
    <table slot="success" class="jo-table">
      <thead>
        <tr>
          <th>ID</th>
          <th>NIP</th>
          <th>Nama</th>
          <th>Jenis Kelamin</th>
          <th>Status</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {#each items as dosen (dosen.id)}
          <tr>
            <td>{dosen.id}</td>
            <td>{dosen.nip}</td>
            <td>{dosen.nama}</td>
            <td>{formatJk(dosen.sex)}</td>
            <td>{dosen.status.toLowerCase()}</td>
            <td class="flex items-center justify-end">
              <JoLink to={`/#/admin/data/dosen/edit/${dosen.id}`} cls="mr-2">
                <div class="h-4 w-4 text-blue-700">
                  <MdCreate />
                </div>
              </JoLink>
              <JoButton
                action={() => onDelete(dosen)}
              >
                <div class="h-4 w-4 text-red-700">
                  <MdDelete />
                </div>
              </JoButton>
            </td>
          </tr>
        {/each}
      </tbody>
    </table>
  </JoAsyncContent>
</div>