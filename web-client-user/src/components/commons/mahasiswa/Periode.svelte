<script>
	import { getContext } from 'svelte';
	import { gql } from '@apollo/client/core';
	import apolloClient from 'siskom-web-user/apolloClient.js';
	import {
		JoAsyncContent
	} from 'siskom-web-commons';
	import * as context_key from './context.js';

	const GQLPeriodeMahasiswa = gql`
		query PeriodeMahasiswa ($idMahasiswa: Int!) {
			attendedPeriode (_idMahasiswa: $idMahasiswa) {
				nodes {
					id
					tahun
					semester
					awal
					akhir
					ketua: dosenByIdKetua {
		        id
		        nama
		        nip
		      }
		      sekretaris: dosenByIdSekretaris {
		        id
		        nama
		        nip
		      }
				}
			}
		}
	`;

	const mahasiswa = getContext(context_key.mahasiswa);
	$: idMahasiswa = $mahasiswa.id;

	let networkStatus = 'loading';
	let errorMessage = null;
	let items = [];

	$: getPeriodeMahasiswa({ idMahasiswa });

	async function getPeriodeMahasiswa ({ idMahasiswa }) {
		if (!idMahasiswa) return;
		networkStatus = 'loading';
		try {
			const result = apolloClient.query({
				query: GQLPeriodeMahasiswa,
				variables: {
					idMahasiswa
				}
			});
			items = result.data.attendedPeriode.nodes;
			networkStatus = 'success';
		} catch (err) {
			console.log(err);
			errorMessage = 'gagal mengambil data periode';
			networkStatus = 'error';
		}
	}
</script>

<div class="text-3xl font-black">Daftar Kelas</div>
<JoAsyncContent {networkStatus}>
	<div slot="success">
		Ok...
	</div>
</JoAsyncContent>

