<script>
  import { onMount } from 'svelte'
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import MdDelete from 'svelte-icons/md/MdDelete.svelte'
  import {
    JoLink,
    JoAsyncContent,
    JoInput,
    JoSelect,
    JoButton
  } from 'siskom-web-commons';
  import 'siskom-web-admin/styles/jo-table.css';
  import GQLListPeriode from 'siskom-web-admin/graphql/ListPeriode.js';
  import GQLDeletePeriode from 'siskom-web-admin/graphql/DeletePeriode.js';

  let items = [];
  let networkStatus = 'loading';

  function loadAllPeriode () {
    networkStatus = 'loading';
    return apolloClient.query({
      query: GQLListPeriode
    })
      .then(result => {
        items = result.data.allPeriodes.nodes;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
      })
  }

  function onDelete (id) {
    return apolloClient.mutate({
      mutation: GQLDeletePeriode,
      variables: { id }
    })
      .catch(err => {
        console.log(err);
        alert('Gagal menghapus data periode');
      })
      .then(() => queryResult.refetch());
  }

  onMount(loadAllPeriode);
</script>

<div class="text-sm text-gray-800 py-4">
  <JoLink
    to="/#/admin/data/periode/create"
  >
    tambah
  </JoLink>
</div>
<JoAsyncContent {networkStatus}>
  <table slot="success" class="jo-table">
    <thead>
      <tr>
        <th>Tahun</th>
        <th>Semester</th>
        <th>Awal</th>
        <th>Akhir</th>
        <th>Ketua</th>
        <th>Sekretaris</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      {#each items as item (item.id)}
        <tr>
          <td>{item.tahun}</td>
          <td>{item.semester}</td>
          <td>{item.awal}</td>
          <td>{item.akhir}</td>
          <td>
            {#if item.ketua}
              <a 
                href={`/#/admin/data/dosen/edit/${item.ketua.id}`} 
                class="underline"
              >
                {item.ketua.nama}
              </a>
            {:else}
              -
            {/if}
          </td>
          <td>
            {#if item.sekretaris}
              <a 
              href={`/#/admin/data/dosen/edit/${item.sekretaris.id}`} 
              class="underline"
            >
              {item.sekretaris.nama}
            </a>
            {:else}
              -
            {/if}
          </td>
          <td class="text-right">
            <JoButton
              action={() => onDelete(item.id)}
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
