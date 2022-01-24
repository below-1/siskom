<script>
	import { onMount } from 'svelte';
	import apolloClient from 'siskom-web-admin/apolloClient.js';
	import { gql } from '@apollo/client/core';
	import { notification } from 'siskom-web-admin/stores/index.js';
	import Logo from 'siskom-web-admin/icons/settings.svg';
	import { 
		JoButton,
    JoSelect
  } from 'siskom-web-commons';
  import updateSession from 'siskom-web-admin/services/updateSession.js';

  import { 
		periode as storePeriode,
		phase as storePhase 
	} from 'siskom-web-admin/stores/index.js';

	const GQLRequiredData = gql`
		query Settings {
			allPeriodes {
        nodes {
          id
          tahun
          semester
        }
      }
		}
	`;

	const GQLUpdateCurrentPeriode = gql`
		mutation UpdateCurrentPeriode($idPeriode: Int!) {
		  changeCurrentPeriode(input: {idPeriode: $idPeriode}) {
		    clientMutationId
		    integer
		  }
	}`;

	const GQLUpdateCurrentPhase = gql`
		mutation UpdateCurrentPhase($phase: PhaseType!) {
		  changeCurrentPhase(input: {phase: $phase}) {
		    phaseType
		  }
		}
	`;

	const GQLSave = gql`
		mutation SaveSetting($phase: PhaseType!, $idPeriode: Int!) {
		  changeCurrentPhase(input: {phase: $phase}) {
		    phaseType
		  }
		  changeCurrentPeriode(input: {idPeriode: $idPeriode}) {
		    integer
		  }
		}

	`;


	let idPeriode = null;
	let phase = null;
	// When mounted, set idPeriode to current periode.
	$: {
		if ($storePeriode && idPeriode == null) {
			idPeriode = $storePeriode.id;
		}
	};
	$: {
		if (storePhase && null == null) {
			phase = $storePhase;
		}
	};

	let periodes = [];
	let phases = [
		{ value: 'REGISTRATION', label: 'Registrasi' }, 
		{ value: 'SCHEDULING', label: 'Penjadwalan' }, 
		{ value: 'CLASS_PICK', label: 'Entry Kelas' }, 
		{ value: 'KMB', label: 'Kegiatan Belajar Mengajar' }, 
		{ value: 'GRADING', label: 'Penilaian' },
		{ value: 'REVISE', label: 'Revisi Nilai' }
	];

	async function loadData () {
		try {
			let result = await apolloClient.query({
	      query: GQLRequiredData,
	      fetchPolicy: 'network-only'
	    });
	    periodes = result.data.allPeriodes.nodes.map(it => ({
	    	value: it.id,
	    	label: `${it.tahun}/${it.tahun + 1} semester ${it.semester}`
	    }));
		} catch (err) {
			console.log(err);
			alert('gagal memuat data periode');
		}
	}

	async function save () {
		try {
			const result = await apolloClient.mutate({
				mutation: GQLSave,
				variables: {
					idPeriode,
					phase
				}
			});
			console.log('setting save result');
			console.log(result.data);
			notification.show({
				type: 'info',
				message: 'sukses mengubah pengaturan'
			});
			// After successful save, we change current session
			await updateSession();
		} catch (err) {
			console.log(err);
			alert('gagal mengubah data');
		}
	}

	onMount(async () => {
		await loadData();
		console.log('storePeriode');
		console.log($storePeriode);
		console.log('periode');
		console.log(periodes);
	})
</script>

<div class="w-1/3 p-4 bg-white rounded shadow-lg mx-auto mt-20">

  <span class="font-black text-lg mb-12">Pengaturan</span>

	<div class="mb-6 flex flex-col">
    <label>Periode Aktif</label>
    <JoSelect label="Pilih Periode" options={periodes} bind:value={idPeriode} />
  </div>

  <div class="mb-6 flex flex-col">
    <label>Fase</label>
    <JoSelect label="Pilih Fase" options={phases} bind:value={phase} />
  </div>

  <JoButton 
  	action={save}
  	cls="bg-blue-600 text-white rounded">Simpan</JoButton>

</div>
