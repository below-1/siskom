const path = require('path');
const csvtojson = require('csvtojson');
const file_path = path.join(process.cwd(), "csv", "dosen.csv");
const db = require('./db');

async function load_dosen () {
	const data = await csvtojson().fromFile(file_path);
	const parsed_data = data.map((row, i) => {
		return {
			id: i + 1,
			...row
		}
	});
	await db.transaction(async (tx) => {
		await tx('dosen').delete();
		const result = await tx('dosen').insert(parsed_data);
		const app_users = parsed_data.map(m => {
			return {
				username: m.nip,
				password: tx.raw(`crypt('${m.nip}', gen_salt('bf'))`),
				scopes: `{dosen}`,
				tipe_user: 'dosen',
				target_id: m.id
			}
		});
		await tx('app_user').insert(app_users);
		console.log(result);
	});

	// console.log(atomic_data);
	return parsed_data;
}

module.exports = load_dosen;

// load_mk()
// 	.catch(err => {
// 		console.log(err);
// 		process.exit(1);
// 	})
// 	.then(() => {
// 		console.log("exiting whatsoever...");
// 		process.exit(0);
// 	})
