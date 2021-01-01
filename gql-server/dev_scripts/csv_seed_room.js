const path = require('path');
const csvtojson = require('csvtojson');
const file_path = path.join(process.cwd(), "csv", "room.csv");
const db = require('./db');

async function load_room () {
	const data = await csvtojson().fromFile(file_path);
	await db.transaction(async (tx) => {
		await tx('room').delete();
		const result = await tx('room').insert(data);
	});

	// console.log(atomic_data);
	return data;
}

module.exports = load_room;

// load_mk()
// 	.catch(err => {
// 		console.log(err);
// 		process.exit(1);
// 	})
// 	.then(() => {
// 		console.log("exiting whatsoever...");
// 		process.exit(0);
// 	})
