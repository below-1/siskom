<script>
  import { onMount } from 'svelte'
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import MdDelete from 'svelte-icons/md/MdDelete.svelte'
  import FaPencilAlt from 'svelte-icons/fa/FaPencilAlt.svelte'
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

  const GQLAllRooms = gql`
    query AllRooms {
      allRooms {
        nodes {
          nama
          kapasitas
        }
      }
    }
  `;

  // const GQLDeleteRoom = gql``

  let items = [];
  let networkStatus = 'loading';

  async function loadRooms () {
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLAllRooms,
        fetchPolicy: 'network-only'
      });
      items = result.data.allRooms.nodes;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
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

  onMount(loadRooms);
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
        <th>Nama</th>
        <th>Kapasitas</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      {#each items as item (item.nama)}
        <tr>
          <td>{item.nama}</td>
          <td>{item.kapasitas}</td>
          <td class="text-right">
            <JoButton
              action={() => {}}
            >
              <div class="h-4 w-4 text-red-700">
                <FaPencilAlt />
              </div>
            </JoButton>
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
