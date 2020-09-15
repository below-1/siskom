<script>
  import { onMount, getContext } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import {
    JoButton,
    JoLink,
    JoSelect,
    JoNameAvatar,
    JoAsyncContent,
    periode
  } from 'siskom-web-commons';
  import InfoTranskrip from './InfoTranskrip.svelte';
  import GQLKhs from 'siskom-web-user/graphql/KHS.js';
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
  let infoTranskrip = null;
  let networkStatus = 'loading';

  $: getKhs({ idMahasiswa, idPeriode });
  // initialize idPeriode;
  $: {
    if ($periode && $periode.id && !idPeriode) {
      idPeriode = $periode.id;
    }
  };

  async function getKhs ({ idMahasiswa, idPeriode }) {
    if (!idPeriode) return;
    if (!idMahasiswa) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQLKhs,
        variables: {
          idMahasiswa,
          idPeriode
        }
      });
      items = result.data.kelasInPeriode.nodes;
      infoTranskrip = result.data.infoTranskripPeriode;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }
</script>

<div class="text-left text-3xl font-black my-6">Kartu Hasil Studi</div>
<div class="flex items-center flex-wrap my-4">
  <JoSelect 
    options={optionsPeriode} 
    bind:value={idPeriode}
    label="semester"
    emptyLabel="Pilih Semester"
    cls="mr-4"
  />
  <JoButton cls="py-1 my-2 font-bold" label="print" dark color="green" />
</div>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="border-2 border-dashed border-gray-400 p-4 font-bold md:w-1/2">
      <div class="text-left font-bold text-gray-600 py-2">Rangkuman</div>
      <InfoTranskrip {...infoTranskrip} />
    </div>

    <ul class="my-4">
      {#each items as item (item.id)}
        <li 
          class="py-4 border-b-2 border-dashed border-gray-400"
        >
          <div class="flex items-center justify-between pr-6 md:pr-0">
            <JoNameAvatar name={item.kelas.mk.nama} size='base' cls='hidden md:block mr-4 w-12' />
            <div class="flex flex-col flex-grow md:w-1/3">
              <div class="flex items-center flex-wrap text-lg">
                <a class="font-black mr-4 underline" href={`/#/app/ilkom/mks/${item.kelas.mk.id}`}>{item.kelas.mk.nama}</a>
                <a class="font-black underline" href={`/#/app/ilkom/kelas/${item.kelas.mk.id}`}>kelas {item.kelas.label}</a>
              </div>
              <div class="text-sm font-semibold">
                {item.kelas.mk.sks} sks, {item.kelas.mk.tipeMk.toLowerCase()}
              </div>
            </div>

            <div 
              class="font-medium text-right md:text-sm"
              class:text-red-800={item.lulus == 'tidak lulus'}
            >
              <span class="">
                A
              </span>
              <span>/ {item.nilai.toFixed(2)}</span>
            </div>
          </div>
        </li>
      {/each}
    </ul>
  </div>
</JoAsyncContent>
