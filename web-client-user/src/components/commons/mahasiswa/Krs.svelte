<script>
  import { onMount, getContext } from 'svelte';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoSelect,
    JoAsyncContent,
    JoButton,
    JoLink,
    JoNameAvatar,
    periode
  } from 'siskom-web-commons';
  import GQLKrs from 'siskom-web-user/graphql/KRS.js';
  import * as context_key from './context.js';

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
        query: GQLKrs,
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

<div class="text-3xl font-black my-6">Kartu Rencana Studi</div>

<div class="flex items-center flex-wrap my-4">
  <JoSelect 
    label="periode"
    options={optionsPeriode} 
    bind:value={idPeriode}
    emptyLabel="pilih periode"
  />
  <JoButton cls="py-1 my-2 md:my-0 text-lg font-black" label="print" dark color="green" />
</div>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="p-4 font-semibold mb-4 border-2 border-dashed border-gray-400 md:w-1/2">
      <div class="p-2 border-b border-gray-400">total mata kuliah: {total} mk</div>
      <div class="p-2 border-b border-gray-400">total sks: {totalSks} mk</div>
    </div>

    <ul class="mt-8">
      {#each items as item (item.id)}
        <li class="py-3 border-b border-gray-400 flex items-center">
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
