<script>
  import { onMount, getContext } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import mahasiswaPeriodeData from 'siskom/services/mahasiswa-periode-data.js';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoLink from 'siskom/components/commons/JoLink.svelte';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoNameAvatar from 'siskom/components/commons/JoNameAvatar.svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import InfoTranskrip from 'siskom/components/commons/mahasiswa/info-transkrip.svelte';
  import GQL_khs from 'siskom/graphql/khs.gql';
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
        query: GQL_khs,
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

<div class="bg-white py-4 px-4 mb-2">
  <div class="text-left text-xl font-bold">Kartu Hasil Studi</div>
  <div class="flex items-center">
    <JoSelect 
      options={optionsPeriode} 
      bind:value={idPeriode}
      label="semester"
      emptyLabel="Pilih Semester"
    />
    <JoButton cls="py-1 my-2 mx-4" label="print" dark color="green" />
  </div>
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="bg-white p-4 text-sm font-bold mb-2">
      <div class="text-left font-bold text-gray-600 py-2">Rangkuman</div>
      <InfoTranskrip {...infoTranskrip} />
    </div>

    <ul class="bg-white">
      {#each items as item (item.id)}
        <li 
          class="py-3 px-4 border-b border-gray-300 w-full"
        >
          <div class="flex items-center justify-between">
            <JoNameAvatar name={item.kelas.mk.nama} size='base' cls='hidden md:block mr-4 w-12' />
            <div class="flex flex-col flex-grow md:w-1/3">
              <div class="flex items-center">
                <a class="font-bold mr-2 underline" href={`/#/app/ilkom/mks/${item.kelas.mk.id}`}>{item.kelas.mk.nama}</a>
                <a class="font-bold underline" href={`/#/app/ilkom/kelas/${item.kelas.mk.id}`}>kelas {item.kelas.label}</a>
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
