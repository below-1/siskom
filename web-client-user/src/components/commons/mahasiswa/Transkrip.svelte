<script>
  import { getContext } from 'svelte';
  import { push as pushRoute } from 'svelte-spa-router';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import 'siskom-web-user/styles/jo-table.css';

  import {
    JoAsyncContent,
    JoNameAvatar,
    JoSelect,
    JoButton,
    JoLink,
    JoInput,
    periode,
    formatNilai
  } from 'siskom-web-commons';
  import InfoTranskrip from './InfoTranskrip.svelte';
  import GQLTranskrip from 'siskom-web-user/graphql/Transkrip.js';
  import GQLInfoTranskrip from 'siskom-web-user/graphql/InfoTranskrip.js';
  import * as context_key from './context.js';

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
        query: GQLInfoTranskrip,
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
      query: GQLTranskrip,
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
    const result = queryResult.data.transkrip.edges.map(e => {
      const nilai = formatNilai(e.node.nilai);
      return {
        ...e,
        nilai
      };
    });
    return result;
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

<div class="text-3xl font-black mb-8">Transkrip Nilai</div>
<JoSelect 
  options={optionsPeriode} 
  bind:value={idPeriode} 
  emptyLabel="Semua Semester" 
  label="periode"
  cls="w-64"
/>
<div class="my-2 flex items-center justify-start w-full">
  <input
    bind:value={keyword}
    type='text'
    placeholder='keyword'
    class="bg-white border-gray-400 border p-2 py-1 text-sm font-semibold rounded"
  />
</div>

<JoAsyncContent networkStatus={infoNetworkStatus}>
  <div slot="success">
    <div class="text-left font-bold text-2xl mb-2">Rangkuman</div>
    <div class="text-gray-800 text-sm bg-white md:my-4 border-2 border-dashed border-gray-400 p-4">
      <InfoTranskrip {...infoTranskrip} />
    </div>
  </div>
</JoAsyncContent>

<div class="text-left font-bold text-2xl mb-2">Daftar Mata Kuliah</div>
<JoAsyncContent {networkStatus}>
  <div slot="success" class="bg-white">
    <table class="jo-table text-base">
      <tbody>
        {#each items as item (item.cursor)}
          <tr>
            <td class="hidden md:table-cell">
              <JoNameAvatar name={item.node.namaMk} size='base' cls='mr-4 w-12' />
            </td>
            <td class="flex flex-col py-4 md:table-cell">
              <a
                href={`/#/app/ilkom/mks/${item.node.idMk}`}
                class="font-black mr-4"
              >
                {item.node.namaMk}
              </a>
              <a
                href={`/#/app/ilkom/kelas/${item.node.idKelas}`}
                class="font-black md:hidden"
              >
                kelas {item.node.label}
              </a>
              <div class="md:hidden">{item.node.tahun}/{item.node.tahun + 1} semester {item.node.semester}</div>
            </td>
            <td class="hidden md:table-cell">
              <a
                href={`/#/app/ilkom/kelas/${item.node.idKelas}`}
                class="font-black"
              >
                kelas {item.node.label}
              </a>
            </td>
            <td class="hidden md:table-cell">
              {item.node.tahun}/{item.node.tahun + 1} semester {item.node.semester}
            </td>
            <td>
              <div 
                class="font-bold text-sm md:text-base"
                class:text-red-800={item.node.lulus == 'tidak lulus'}
              >
                <span class="uppercase">
                  {item.nilai.huruf}
                </span>
                <span>/ {item.node.nilai.toFixed(2)}</span>
              </div>
            </td>
          </tr>
        {/each}
      </tbody>
    </table>

<!--
    <ul>
      {#each items as item (item.cursor)}
        <li 
          class="py-4 border-b-2 border-dashed border-gray-400 w-full font-bold lowercase"
        >
          <div class="flex items-center">
            <JoNameAvatar name={item.node.namaMk} size='base' cls='hidden md:block mr-4 w-12' />
            <div class="flex flex-col flex-grow">
              <div class="flex items-center flex-wrap text-xl">
                <a
                  href={`/#/app/ilkom/mks/${item.node.idMk}`}
                  class="underline font-black mr-4"
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
              <div class="text-gray-700">
                {item.node.tahun}/{item.node.tahun + 1} semester {item.node.semester}
              </div>
            </div>
            <div 
              class="font-bold text-lg"
              class:text-red-800={item.node.lulus == 'tidak lulus'}
            >
              <span class="uppercase">
                {item.nilai.huruf}
              </span>
              <span>/ {item.node.nilai.toFixed(2)}</span>
            </div>
          </div>
        </li>
      {/each}
    </ul>
-->

    <div class="w-full mx-4 py-4 w-full flex justify-center items-center">
      <button 
        on:click={onLoadNext}
        class="bg-gray-300 rounded p-2 text-center"
      >selanjutnya</button>
    </div>
  </div>
</JoAsyncContent>

