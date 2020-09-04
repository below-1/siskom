<script>
  import { onMount, getContext } from 'svelte';
  import apolloClient from 'siskom/apollo-client.js';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoLink from 'siskom/components/commons/JoLink.svelte';
  import JoNameAvatar from 'siskom/components/commons/JoNameAvatar.svelte';
  import GQL_krs from 'siskom/graphql/krs.gql';
  import * as context_key from './context.js';
  import { periode } from 'siskom/stores/index.js';

  const mahasiswa = getContext(context_key.mahasiswa);
  const attendedPeriode = getContext(context_key.attendedPeriode);

  $: idMahasiswa = $mahasiswa.id;
  $: optionsPeriode = $attendedPeriode.map((it, index) => {
    return {
      value: it.id,
      label: `semester ${index + 1}, ${it.tahun}/${it.tahun + 1}`
    }
  });
  let idPeriode = null;
  let items = [];
  let total = 0;
  let networkStatus = 'loading';
  $: totalSks = items.map(it => it.kelas.mk.sks).reduce((a, b) => a + b, 0);

  // initialize idPeriode;
  $: {
    if ($periode && $periode.id && !idPeriode) {
      idPeriode = $periode.id;
    }
  };

  $: loadKrs({ idMahasiswa, idPeriode });

  async function loadKrs ({ idMahasiswa, idPeriode }) {
    if (!idMahasiswa) return;
    if (!idPeriode) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_krs,
        variables: {
          idMahasiswa,
          idPeriode
        }
      });
      items = result.data.kelasInPeriode.nodes;
      total = result.data.kelasInPeriode.totalCount;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }
</script>

<div class="bg-white py-4 px-4 mb-2">
  <div class="text-left text-xl font-black">Kartu Rencana Studi</div>
  <JoSelect 
    options={optionsPeriode} 
    bind:value={idPeriode}
    emptyLabel="pilih periode"
  />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="bg-white font-bold flex justify-between items-center px-4 py-3 mb-2">
      <div>
        <div>total mata kuliah: {total} mk</div>
        <div>total sks: {totalSks} mk</div>
      </div>
      <JoButton cls="py-1" label="print" dark color="green" />
    </div>
    <ul class="bg-white">
      {#each items as item (item.id)}
        <li class="py-3 px-4 border-b border-gray-300 w-full flex items-center">
          <JoNameAvatar name={item.kelas.mk.nama} size='base' cls='mr-4 w-12' />
          <div class="flex flex-col flex-grow">
            <div class="font-semibold">
              <a class="font-bold underline" href={`/#/app/ilkom/mks/${item.kelas.id}`}>{item.kelas.mk.nama}</a>
              <a class="font-bold underline ml-2" href={`/#/app/ilkom/kelas/${item.kelas.mk.id}`}>kelas {item.kelas.label}</a>
            </div>
            <div class="font-semibold text-sm text-gray-800">
              {item.kelas.mk.kode}, {item.kelas.mk.sks} sks, {item.kelas.mk.tipeMk.toLowerCase()}
            </div>
          </div>
        </li>
      {/each}
    </ul>
  </div>
</JoAsyncContent>
