<script>
	import { onMount } from 'svelte';
	import { gql } from '@apollo/client/core';
	import apolloClient from 'siskom-web-admin/apolloClient.js';
	import Logo from 'siskom-web-admin/icons/settings.svg';
	import 'siskom/styles/jo-table.css';
	import {
    JoLink,
    JoInput,
    JoSelect,
    JoButton,
    JoAsyncContent,
    formatMk
  } from 'siskom-web-commons';

  const GQLLoadSchParams = gql`
  	query MyQuery {
		  allScheduleParams {
		    nodes {
		      id
		      label
		      semester
		      sks
		      mk: mataKuliahByIdMk {
		        id
		        kode
		        minSks
		        nama
		        openIn
		        sks
		        tipeMk
		      }
		      dosen: dosenByIdDosen {
		        nama
		        nip
		        id
		      }
		    }
		  }
		}
  `;

  let items = [];

  async function loadParams () {
  	networkStatus = 'loading';
  	try {
  		const result = await apolloClient.query({
  			query: GQLLoadSchParams,
  			fetchPolicy: 'networkStatus'
  		});
  		items = result.data.allScheduleParams.nodes;
  		networkStatus = 'success';
  	} catch (err) {
  		console.log(err);
  		alert('gagal mengambil data');
  		networkStatus = 'error';
  	}
  }

	let networkStatus = 'loading';


	onMount(async () => {
		await loadParams();
	});
</script>

<div class="h-full">

  <div class="border-b border-gray-300 bg-white h-16 fixed top-0 right-0" style="left: 14rem;">
    <div class="flex items-center px-12 h-full">
      <img src={Logo} height={24} width={24} class="mr-4" />
      <span class="font-bold text-lg">Penjadwalan</span>
    </div>
  </div>

  <JoAsyncContent {networkStatus}>
	  <div slot="success" class="px-12">
	  	<div>
	  		<button class="">Jalankan</button>
	  	</div>
	    <table class="jo-table mt-20">
	      <thead>
	        <tr>
	          <th>Dosen</th>
	          <th>Mk</th>
	          <th>Label</th>
	          <th>Kode</th>
	          <th>Tipe</th>
	          <th>Ganjil/Genap</th>
	          <th>SKS</th>
	          <th>Semester</th>
	          <th></th>
	        </tr>
	      </thead>
	      <tbody>
	      	{#each items as item, index (index)}
	      		<tr>
	      			<td>{item.dosen.nama}</td>
	      			<td>{item.mk.nama}</td>
	      			<td>{item.label}</td>
	      			<td>{item.mk.kode}</td>
	      			<td>{item.mk.tipe_mk}</td>
	      			<td>{item.mk.open_in}</td>
	      			<td>{item.mk.sks}</td>
	      			<td>{item.mk.pref_scheduled}</td>
	      		</tr>
	      	{/each}
	      </tbody>
	    </table>
	  </div>
	</JoAsyncContent>

</div>