const path = require('path');
const csvtojson = require('csvtojson');
const file_path = path.join(process.cwd(), "csv", "mk.csv");
const db = require('./db');

async function load_mk () {
	const data = await csvtojson().fromFile(file_path);
	const parsed_data = data.map(row => {
		return {
			...row,
			pref_schedule: row.pref_schedule ? parseInt(row.pref_schedule) : null,
			sks: row.sks ? parseInt(row.sks) : null,
			min_sks: row.min_sks ? parseInt(row.min_sks) : null
		}
	});
	console.log(parsed_data);
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
