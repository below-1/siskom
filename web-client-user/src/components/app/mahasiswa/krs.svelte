<script>
  import { onMount } from 'svelte';
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

  const KrsGQL = gql`
    query KRS($idMahasiswa: Int!, $idPeriode: Int!) {
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
    }
  `

  async function getKrs ({ idMahasiswa, idPeriode }) {
    if (!idPeriode) return;
    if (!idMahasiswa) return;
    networkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: KrsGQL,
        variables: {
          idMahasiswa,
          idPeriode
        }
      });
      items = result.data.kelasInPeriode.nodes;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  $: getKrs({ idMahasiswa, idPeriode });

  onMount(async () => {
    const user = loadStorage('siskom.user');
    idMahasiswa = user.targetId;
    const { periodes, currentPeriode } = await mahasiswaPeriodeData(idMahasiswa);
    optionsPeriode = periodes;
    await getKrs({ idMahasiswa, idPeriode: currentPeriode.id });
  });
</script>

<div class="bg-gray-200 py-4 px-4 border-gray-300">
  <div class="text-center text-lg font-bold">Kartu Rencana Studi</div>
  <JoSelect 
    options={optionsPeriode} 
    bind:value={idPeriode}
    emptyLabel="Pilih Semester"
  />
</div>
<JoAsyncContent {networkStatus}>
  <div slot="success">
    <ul>
      {#each items as item (item.idKelas)}
        <li class="py-3 px-4 border-b border-gray-300 w-full">
          <div class="flex items-center text-sm">
            <div class="flex flex-col flex-grow">
              <span class="font-semibold">{item.namaMk}</span>
              <div>
                {item.sks} sks, {item.tipeMk.toLowerCase()}, kelas {item.label}
              </div>
            </div>
          </div>
        </li>
      {/each}
    </ul>
  </div>
</JoAsyncContent>
