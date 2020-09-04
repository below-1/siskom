<script>
  import { getContext } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import apolloClient from 'siskom/apollo-client.js';
  import JoAsyncContent from 'siskom/components/commons/JoAsyncContent.svelte';
  import JoSelect from 'siskom/components/commons/JoSelect.svelte';
  import JoButton from 'siskom/components/commons/JoButton.svelte';
  import JoLink from 'siskom/components/commons/JoLink.svelte';
  import JoInput from 'siskom/components/commons/JoInput.svelte';
  import InfoTranskrip from 'siskom/components/commons/mahasiswa/info-transkrip.svelte';
  import GQL_transkrip from 'siskom/graphql/transkrip.gql';
  import GQL_info_transkrip from 'siskom/graphql/info-transkrip.gql';
  import * as context_key from './context.js';
  import { periode } from 'siskom/stores/index.js';

  const mahasiswa = getContext(context_key.mahasiswa);
  const attendedPeriode = getContext(context_key.attendedPeriode);
  const ilkomBasePath = getContext(context_key.prefix);

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
  let infoNetworkStatus = 'loading';
  let take = 5;
  let keyword = '';

  $: {
    if ($periode && $periode.id && !idPeriode) {
      idPeriode = $periode.id;
    }
  };
  $: ({ tahun, semester } = selectedTahunSemester({ idPeriode, periodes: $attendedPeriode }));
  $: loadInfoTranskrip({ tahun, semester });
  $: reload({
    idMahasiswa,
    idPeriode,
    take,
    keyword,
    tahun,
    semester
  });

  function selectedTahunSemester ({ idPeriode, periodes }) {
    const selectedPeriode = periodes.find(it => it.id == idPeriode);
    if (!selectedPeriode) {
      return { tahun:null, semester: null };
      // throw new Error(`invalid periode: ${idPeriode}`);
    }
    const { tahun, semester } = selectedPeriode;
    return { tahun, semester };
  }

  async function loadInfoTranskrip ({ tahun, semester }) {
    if (!tahun) return;
    if (!semester) return;
    infoNetworkStatus = 'loading';
    try {
      const result = await apolloClient.query({
        query: GQL_info_transkrip,
        variables: {
          id: idMahasiswa,
          tahun,
          semester
        }
      });
      infoTranskrip = result.data.infoTranskripKumulatif;
      infoNetworkStatus = 'success';
    } catch (err) {
      console.log(err);
      infoNetworkStatus = 'error';
    }
  }

  async function fetchTranskrip ({ idMahasiswa, idPeriode, take, after, keyword, tahun, semester }) {
    const queryResult = await apolloClient.query({
      query: GQL_transkrip,
      fetchPolicy: 'network-only',
      variables: {
        id: idMahasiswa,
        tahun,
        semester,
        take,
        after,
        keyword: !keyword || keyword == '' ? null : keyword
      }
    })
    return queryResult.data.transkrip.edges;
  }

  async function reload ({ idMahasiswa, idPeriode, take, keyword, tahun, semester }) {
    if (!idMahasiswa) return;
    if (!idPeriode) return;
    if (!take) return;
    if (!tahun) return;
    if (!semester) return;
    networkStatus = 'loading';
    try {
      const result = await fetchTranskrip({ idMahasiswa, idPeriode, take, keyword, after: null, tahun, semester });
      console.log(result);
      items = result;
      networkStatus = 'success';
    } catch (err) {
      console.log(err);
      networkStatus = 'error';
    }
  }

  async function onLoadNext () {
    let params = {
      idMahasiswa,
      idPeriode,
      take,
      after: null,
      keyword,
      tahun,
      semester
    }
    if (items.length > 0) {
      params.after = items[items.length - 1].cursor;
    }
    const nextItems = await fetchTranskrip(params);
    items = [ ...items, ...nextItems ];
  }
</script>

<div class="bg-white py-4 px-4">
  <div class="text-lg font-bold">Transkrip Nilai</div>
  <JoSelect 
    options={optionsPeriode} 
    bind:value={idPeriode} 
    emptyLabel="Semua Semester" 
    label="periode"
  />
  <div class="my-2 flex items-center justify-start w-full">
    <input
      bind:value={keyword}
      type='text'
      placeholder='keyword'
      class="bg-white border-gray-400 border p-2 py-1 text-sm font-semibold rounded"
    />
    <JoButton label="info" cls="ml-2">
    </JoButton>
    <JoButton label="print" cls="ml-2">
    </JoButton>
  </div>
</div>

<JoAsyncContent networkStatus={infoNetworkStatus}>
  <div slot="success" class="p-6 text-gray-800 text-sm bg-white md:my-4">
    <div class="text-left font-bold text-gray-600 py-2">Rangkuman</div>
    <InfoTranskrip {...infoTranskrip} />
  </div>
</JoAsyncContent>

<JoAsyncContent {networkStatus}>
  <div slot="success" class="bg-white">
    <ul>
      {#each items as item (item.cursor)}
        <li 
          class="py-3 px-6 border-b border-gray-300 w-full font-bold text-gray-800 lowercase"
        >
          <div class="flex items-center">
            <div class="flex flex-col flex-grow">
              <div class="flex items-center flex-wrap">
                <a
                  href={`/#/app/ilkom/mks/${item.node.idMk}`}
                  class="underline font-black mr-2"
                >
                  {item.node.namaMk}
                </a>
                <a
                  href={`/#/app/ilkom/kelas/${item.node.idKelas}`}
                  class="underline font-black"
                >
                  kelas {item.node.label}
                </a>
              </div>
              <div class="text-gray-700 text-sm">
                {item.node.tahun}/{item.node.tahun + 1} semester {item.node.semester}
              </div>
            </div>
            <div 
              class="font-bold"
              class:text-red-800={item.node.lulus == 'tidak lulus'}
            >
              <span class="">
                A
              </span>
              <span>/ {item.node.nilai.toFixed(2)}</span>
            </div>
          </div>
        </li>
      {/each}
    </ul>
    <div class="w-full mx-4 py-4 w-full flex justify-center items-center">
      <button 
        on:click={onLoadNext}
        class="bg-gray-300 rounded p-2 text-center"
      >selanjutnya</button>
    </div>
  </div>
</JoAsyncContent>

