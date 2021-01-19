const path = require('path');
const csvtojson = require('csvtojson');
const { findIndex } = require('lodash');
const file_path = path.join(process.cwd(), "csv", "mahasiswa.csv");
const db = require('./db');

async function load_mahasiswa (data_periode) {
	const data = await csvtojson().fromFile(file_path);
	let list_periode_mahasiswa = [];
	const parsed_data = data.map((row, i) => {
		const id = i + 1;
		const tahun_masuk = parseInt('20' + row.nim.substr(0, 2));
		const start_per_index = findIndex(data_periode, p => p.tahun == tahun_masuk);
		data_periode.slice(start_per_index).forEach(p => {
			const per_mah = {
				id_periode: p.id,
				id_mahasiswa: id,
				registrasi: 1
			};
			list_periode_mahasiswa.push(per_mah);
		});
		return {
			...row,
			id: i + 1,
			id_pa: parseInt(row.id_pa),
			tahun_masuk,
			sex: Math.random() > 0.5 ? 'laki-laki' : 'perempuan'
		}
	});
	console.log(parsed_data);
	const result = await db.transaction(async (tx) => {
		await tx('mahasiswa').delete();
		await tx('mahasiswa').insert(parsed_data);
		await tx('periode_mahasiswa').delete();
		await tx('periode_mahasiswa').insert(list_periode_mahasiswa);

		const app_users = parsed_data.map(m => {
			return {
				username: m.nim,
				password: tx.raw(`crypt('${m.nim}', gen_salt('bf'))`),
				scopes: `{mahasiswa}`,
				tipe_user: 'mahasiswa',
				target_id: m.id
			}
		});

		await tx('app_user').insert(app_users);
	});
}

module.exports = load_mahasiswa;

// load_mahasiswa()
// 	.catch(err => {
// 		console.log(err);
// 		process.exit(1);
// 	})
// 	.then(() => {
// 		console.log("exiting whatsoever...");
// 		process.exit(0);
// 	})
