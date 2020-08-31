<script>
  import { onMount } from 'svelte';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import { push as pushRoute } from 'svelte-spa-router';
  import {
    JoLink,
    JoInput,
    JoSelect,
    JoButton,
    JoDialog,
    JoAsyncContent
  } from 'siskom-web-commons';
  import CreatePrasyarat from './CreatePrasyarat.svelte';
  import 'siskom-web-admin/styles/jo-table.css';

  const GQLById = gql`
    query ByIdWithPrasyarat($id: Int!) {
      mataKuliahById(id: $id) {
        id
        nama
        kode
        minSks
        openIn
        sks
        prefSchedule
        tipeMk
      }
      deps: allPrasyaratMks (condition: {idParent: $id}) {
        edges {
          cursor
          node {
            child: mataKuliahByIdChild {
              id
              kode
              nama
              tipeMk
              sks
            }
          }
        }
      }
    }
  `;

  const GQLRemove = gql`
    mutation RemovePrasyarat ($idChild: Int!, $idParent: Int!)  {
      removePrasyarat(input: {
        _idParent: $idParent,
        _idChild: $idChild
      }) {
        bigInt
      }
    }
  `;

  export let params = {};
  $: id = params.id ? parseInt(params.id) : null;
  let mataKuliah = {
    nama: '-'
  };
  let deps = [];
  let showAddForm = false;
  let networkStatus = 'loading';
  $: loadData({ id });

  function loadData ({ id }) {
    if (!id) return;
    networkStatus = 'loading';
    return apolloClient.query({
      query: GQLById,
      variables: {
        id
      },
      fetchPolicy: 'network-only'
    })
      .then(result => {
        mataKuliah = result.data.mataKuliahById;
        deps = result.data.deps.edges;
        networkStatus = 'success';
      })
      .catch(err => {
        console.log(err);
        networkStatus = 'error';
        pushRoute('/admin/mk');
      });
  }

  function handleRemove ({ idChild }) {
    apolloClient.mutate({
      mutation: GQLRemove,
      variables: {
        idParent: id,
        idChild
      }
    })
      .then(result => {
        console.log(result);
      })
      .catch(err => {
        console.log(err);
        alert("gagal menghapus data");
      })
      // Refetch data
      .then(() => loadData({ id }));
  }
</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="flex justify-between items-center font-bold text-left py-4 border-b border-gray-300 ">
      <div>Prasyarat Mata Kuliah {mataKuliah.nama}</div>
      <div>
        <JoButton 
          dark={true}
          color="blue"
          action={() => {
            showAddForm = !showAddForm;
          }}
          label="tambah"
        />
      </div>
    </div>

    <div class="mt-6 mx-auto">
      <table class="jo-table">
        <thead>
          <tr>
            <th>Kode</th>
            <th>Nama</th>
            <th>Tipe</th>
            <th>SKS</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {#each deps as edge (edge.cursor) }
            <tr>
              <td>{edge.node.child.kode}</td>
              <td>{edge.node.child.nama}</td>
              <td>{edge.node.child.tipeMk}</td>
              <td>{edge.node.child.sks}</td>
              <td>
                <button 
                  on:click={handleRemove({ idChild: edge.node.child.id })}
                  class="appearance-none px-3 py-1 bg-gray-300 font-semibold text-xs"
                >hapus</button>
              </td>
            </tr>
          {/each }
        </tbody>
      </table>
    </div>
  </div>
</JoAsyncContent>

<JoDialog 
  bind:show={showAddForm}
  title="Tambah Prasyarat Mata Kuliah"
>
  <CreatePrasyarat 
    idParent={id} 
    on:done={() => {
      showAddForm = !showAddForm
      loadData({ id })
    }}
  />
</JoDialog>