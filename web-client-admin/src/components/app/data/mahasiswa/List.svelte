<script>
  import { onMount } from 'svelte';
  import apolloClient from 'siskom-web-admin/apolloClient.js';
  import MdDelete from 'svelte-icons/md/MdDelete.svelte';
  import MdCreate from 'svelte-icons/md/MdCreate.svelte';
  import GQLListMahasiswa from 'siskom-web-admin/graphql/ListMahasiswa.js';
  import GQLAllYears from 'siskom-web-admin/graphql/AllYears.js';
  import GQLDeleteMahasiswa from 'siskom-web-admin/graphql/DeleteMahasiswa.js';
  import {
    JoAsyncContent,
    JoInput,
    JoLink,
    JoSelect,
    JoButton
  }from 'siskom-web-commons';
  import { warning } from 'siskom-web-admin/stores/index.js';
  import 'siskom-web-admin/styles/jo-table.css';

  const perPage = 2;
  let tahunAjaranOptions = [];
  let keyword = '';
  let tahunMasuk = 2007;
  let take = 10;
  let items = [];
  let hasMore = false;
  let networkStatus = 'loading';

  $: canLessen = items.length > perPage;
  $: loadMahasiswa({
    keyword: '%' + keyword + '%',
    tahunMasuk,
    take
  });

  onMount(() => {
    networkStatus = 'loading';
    return loadTahunAjaran().then(reloadMahasiswa);
  });

  function onError (err) {
    console.log(err);
    networkStatus = 'error';
  }

  function loadTahunAjaran () {
    const queryResult = apolloClient.query({
      query: GQLAllYears
    });
    return queryResult
      .then(onSuccessLoadTahunAjaran)
      .catch(onError);
  }

  function onSuccessLoadTahunAjaran (result) {
    if (result.networkStatus != 7) {
      return;
    }
    const nodes = result.data.allYears.nodes;
    tahunAjaranOptions = nodes.map(year => ({
      value: year,
      label: `Tahun Ajaran ${year}/${year+1}`
    }));
  }

  function onSuccessLoadMahasiswa (result) {
    if (result.networkStatus != 7) {
      return;
    }
    const nodes = result.data.allMahasiswas.nodes;
    const pageInfo = result.data.allMahasiswas.pageInfo;
    items = nodes;
    hasMore = pageInfo.hasNextPage;
    networkStatus = 'success';
  }

  function loadMahasiswa ({ tahunMasuk, keyword, take }) {
    networkStatus = 'loading';
    const variables = {
      keyword: keyword + '%',
      tahunMasuk,
      take
    };
    const queryResult = apolloClient.query({
      query: GQLListMahasiswa,
      variables,
      fetchPolicy: 'network-only'
    });
    return queryResult
      .then(onSuccessLoadMahasiswa)
      .catch(onError);
  }

  function reloadMahasiswa () {
    return loadMahasiswa({
      keyword: '%' + keyword + '%',
      tahunMasuk,
      take
    })
  }

  function onDelete (item) {
    warning.show({
      message: `anda akan menghapus mahasiswa #${item.nim}, ${item.nama}`,
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

  function commitDelete (id) {
    const mutationResult = apolloClient.mutate({
      mutation: GQLDeleteMahasiswa,
      variables: {
        id
      }
    });
    const onSuccess = result => {
      networkStatus = 'success';
      return reloadMahasiswa();
    };

    return mutationResult
      .then(onSuccess)
      .catch(onError);
  }

  function onNext () {
    take += perPage;
  }

  function onPrevious () {
    take -= perPage;
  }
</script>

<div class="py-4 text-gray-800 text-sm flex items-stretch">
  <JoSelect bind:value={tahunMasuk} options={tahunAjaranOptions} />
  <JoInput bind:value={keyword} placeholder='keyword...' cls="mx-2" />
  <JoLink to={"/#/admin/data/mahasiswa/create"} label="tambah" />
</div>

<table class="jo-table">
  <thead>
    <tr>
      <th>NIM</th>
      <th>Nama</th>
      <th>Tahun Masuk</th>
      <th>Dosen PA</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    {#each items as student (student.id)}
      <tr>
        <td class="font-semibold">{student.nim}</td>
        <td class="font-semibold">{student.nama}</td>
        <td>{student.tahunMasuk}</td>
        <td>{student.pa.nama}</td>
        <td class="text-xs flex items-center justify-end">
          <JoLink to={`/#/admin/data/mahasiswa/edit/${student.id}`} cls="mr-2">
            <div class="h-4 w-4 text-blue-700">
              <MdCreate />
            </div>
          </JoLink>
          <JoButton action={() => onDelete(student)}>
            <div class="h-4 w-4 text-red-700">
              <MdDelete />
            </div>
          </JoButton>
        </td>
      </tr>
    {/each}
  </tbody>
</table>

<div class="mt-2 text-xs py-2">
  <JoButton
    label="lebih banyak"
    disabled={!hasMore}
    action={onNext}
  />
  <JoButton
    label="kurangi"
    disabled={!canLessen}
    action={onPrevious}
  />
</div>