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
	console.log(parsed_data);
	await db.transaction(async (tx) => {
		await tx('dosen').delete();
		try {
			const result = await tx('dosen').insert(parsed_data);
			console.log(result);
		} catch (err) {
			console.log(err);
			throw err;
		}
	});

	// console.log(atomic_data);
}

load_mk()
	.catch(err => {
		console.log(err);
		process.exit(1);
	})
	.then(() => {
		console.log("exiting whatsoever...");
		process.exit(0);
	})
