const path = require('path');
const csvtojson = require('csvtojson');
const file_path = path.join(process.cwd(), "csv", "dosen.csv");
const db = require('./db');

async function load_mk () {
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
		console.log(result);
	});

	// console.log(atomic_data);
}

module.exports = load_mk;

// load_mk()
// 	.catch(err => {
// 		console.log(err);
// 		process.exit(1);
// 	})
// 	.then(() => {
// 		console.log("exiting whatsoever...");
// 		process.exit(0);
// 	})
