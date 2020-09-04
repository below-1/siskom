<script>
  import { onMount } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import { gql } from '@apollo/client/core';
  import apolloClient from 'siskom/apollo-client.js';
  import mahasiswaPeriodeData from 'siskom/services/mahasiswa-periode-data.js';
  import { load as loadStorage } from 'siskom/commons/storage.js';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';

  let idPeriode = null;
  let optionsPeriode = [];
  let idMahasiswa = null;
  let items = [];
  let networkStatus = 'loading';
  let infoTranskrip = null;

  const KhsGQL = gql`
    query KHS($idMahasiswa: Int!, $idPeriode: Int!) {
      kelasInPeriode(
        _idMahasiswa: $idMahasiswa, 
        _idPeriode: $idPeriode
      ) {
        nodes {
          idMk
          idKelas
          kodeMk
          label
          lulus
          namaMk
          nilai
          semester
          sks
          tahun
          tipeMk
        }
      }

      infoTranskripPeriode (
        _idMahasiswa: $idMahasiswa
        _idPeriode: $idPeriode
      ) {
        sks
        sksd
        sksn
        ip
      }
    }
  `

  async function getKhs ({ idMahasiswa, idPeriode }) {
    if (!idPeriode) return;
    if (!idMahasiswa) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: KhsGQL,
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

  $: getKhs({ idMahasiswa, idPeriode });

  onMount(async () => {
    const user = loadStorage('siskom.user');
    idMahasiswa = user.targetId;
    const { periodes, currentPeriode } = await mahasiswaPeriodeData(idMahasiswa);
    optionsPeriode = periodes;
    await getKhs({ idMahasiswa, idPeriode: currentPeriode.id });
  });
</script>

<div class="bg-gray-200 py-4 px-4 border-gray-300">
  <div class="text-center text-lg font-bold">Kartu Hasil Studi</div>
  <JoSelect 
    options={optionsPeriode} 
    bind:value={idPeriode}
    emptyLabel="Pilih Semester"
  />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">
    <div class="border-b border-gray-300 p-4 text-gray-800 text-sm">
      <div class="text-left font-bold text-gray-600 py-2">Rangkuman</div>
      <div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
        <div>Total SKS</div>
        <div>{infoTranskrip.sks}</div>
      </div>
      <div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
        <div>SKSD</div>
        <div>{infoTranskrip.sksd}</div>
      </div>
      <div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
        <div>SKSN</div>
        <div>{infoTranskrip.sksn.toFixed(3)}</div>
      </div>
      <div class="flex items-center justify-between font-semibold py-2 border-b border-gray-300">
        <div>IP</div>
        <div>{infoTranskrip.ip.toFixed(3)}</div>
      </div>
    </div>
    <ul>
      {#each items as item (item.idKelas)}
        <li 
          class="py-3 px-4 border-b border-gray-300 w-full"
          on:click={() => {
            pushRoute('/mahasiswa/kelas/' + item.idKelas)
          }}
        >
          <div class="flex items-center text-sm">
            <div class="flex flex-col flex-grow">
              <span class="font-semibold">{item.namaMk}</span>
              <div>
                {item.sks} sks, {item.tipeMk.toLowerCase()}, kelas {item.label}
              </div>
            </div>
            <div 
              class="font-bold"
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
