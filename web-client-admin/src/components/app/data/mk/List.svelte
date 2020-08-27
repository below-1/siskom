<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import GQLList from 'siskom-web-admin/graphql/ListMk.js';
  import GQLDosen from 'siskom-web-admin/graphql/DeleteMk.js';
  import MdDelete from 'svelte-icons/md/MdDelete.svelte'
  import MdCreate from 'svelte-icons/md/MdCreate.svelte'
  import {
    JoLink,
    JoInput,
    JoSelect,
    JoButton,
    JoAsyncContent,
    formatMk
  } from 'siskom-web-commons';
  import { warning, notification } from 'siskom-web-admin/stores/index.js';
  import 'siskom/styles/jo-table.css';

  const perPage = 10;
  let networkStatus = 'success';
  let keyword = '';
  let tipeMk = null;
  let openIn = null;
  let take = perPage;
  let openInOptions = [
    {value: 'GANJIL', label: 'ganjil'},
    {value: 'GENAP', label: 'genap'}
  ];
  let tipeMkOptions = [
    {value: 'WAJIB', label: 'wajib'}, 
    {value: 'PILIHAN', label: 'pilihan'}, 
    {value: 'UMUM', label: 'umum'}
  ];
  let items = [];
  let hasNext = false;
  let hasPrev = false;

  function loadDosen (options) {
    let variables = {
      ...options,
      keyword: `${options.keyword}%`
    };
    const queryResult = apolloClient.query({
      query: GQLList,
      variables
    })
    networkStatus = 'loading';
    return queryResult
      .then(result => {
        console.log(result);
        items = result.data.allMataKuliahs.nodes.map(formatMk);
        hasNext = result.data.allMataKuliahs.pageInfo.hasNextPage;
        networkStatus = 'success';
      })
      .catch(err => {
        networkStatus = 'error';
      })
  }

  $: loadDosen({
    tipeMk,
    openIn,
    keyword,
    take
  });

  $: canLessen = items.length > perPage;

  function onMore() {
    take += perPage;
  }

  function onLess() {
    take -= perPage;
  }

  async function commitDelete (id) {
    try {
      await apolloClient.mutate({
        mutation: DeleteGQL,
        variables: {
          id
        }
      })
      notification.show({ 
        type: 'info', 
        message: 'sukses menghapus data' 
      })
    } catch (err) {
      notification.show({ 
        type: 'danger', 
        message: 'gagal menghapus data' 
      })
    }
  }

  function onDelete (item) {
    warning.show({
      message: `anda akan menghapus data mata kuliah #${item.kode}, ${item.nama}`,
      on_next: async () => {
        await commitDelete(item.id)
        onRefetch({
          tipeMk,
          openIn,
          keyword: `${keyword}`,
          take
        })
      }
    })
  }
  
  onMount(() => {
    const params = {
      keyword,
      tipeMk,
      openIn,
      take
    }
    loadDosen(params);
  });
</script>

<div class="text-sm text-gray-800 my-4 flex items-center">
  <JoSelect 
    label="dibuka pada" 
    cls="w-64 mr-2" 
    emptyLabel='semua semester' 
    options={openInOptions} 
    bind:value={openIn} 
  />
  <JoSelect 
    label="tipe"
    cls="w-64 mr-2" 
    emptyLabel='semua tipe' 
    options={tipeMkOptions} 
    bind:value={tipeMk} 
  />
  <JoInput bind:value={keyword} placeholder="keyword..." />
  <JoLink to="/#/admin/data/mk/create" label="tambah" cls="ml-2" />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">
    <table class="jo-table">
      <thead>
        <tr>
          <th></th>
          <th>Kode</th>
          <th>Tipe</th>
          <th>Ganjil/Genap</th>
          <th>SKS</th>
          <th>Min SKS</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {#each items as mk (mk.id)}
          <tr>
            <td class="font-semibold">
              <div>{mk.nama}</div>
            </td>
            <td class="monospace">{mk.kode}</td>
            <td>{mk.tipeMk}</td>
            <td>{mk.openIn}</td>
            <td>{mk.sks}</td>
            <td>{mk.minSks}</td>
            <td class="flex items-center justify-end text-xs">
              <JoLink 
                cls="mr-2" 
                to={`/#/admin/data/mk/${mk.id}/prasyarat`}
                label="prasyarat"
              />
              <JoLink 
                cls="mr-2" 
                to={`/#/admin/data/mk/${mk.id}/update`}
              >
                <div class="h-4 w-4 text-blue-700">
                  <MdCreate />
                </div>
              </JoLink>
              <JoButton
                action={() => onDelete(mk)}
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

    <div class="mt-4 text-sm">
      <JoButton
        disabled={!hasNext}
        action={onMore}
        label="lebih banyak"
      />
      <JoButton
        disabled={!canLessen}
        action={onLess}
        label="kurangi"
      />
    </div>
  </div>
</JoAsyncContent>
