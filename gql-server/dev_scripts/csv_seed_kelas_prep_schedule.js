const path = require('path');
const csvtojson = require('csvtojson');
const file_path = path.join(process.cwd(), "csv", "kelas.csv");
const db = require('./db');

async function load_kelas ({ dosen_list, mk_list }) {

	function decode_semester (s) {
		if (s == "I") return 1;
		if (s == "II") return 2;
		if (s == "III") return 3;
		if (s == "IV") return 4;
		if (s == "V") return 5;
		if (s == "VI") return 6;
		if (s == "VII") return 7;
		if (s == "VIII") return 8;
		if (s == "IX") return 9;
		if (s == "X") return 10;
	}

	function find_mk (kode) {
		return mk_list.find(mk => mk.kode == kode);
	}

	function find_dosen (nip) {
		return dosen_list.find(dosen => dosen.nip == nip);
	}

	let kelas_list = [];
	let scheduled_kelas_list = [];

	const data = await csvtojson().fromFile(file_path);
	let xs = [];
	data.forEach((row, i) => {
		const { nip, kode, label, sks: _sks, semester: _semester } = row;
		const mk = find_mk(kode);
		const dosen = find_dosen(nip);
		const semester = decode_semester(_semester);
		if (!dosen) {
			console.log(nip);
			console.log(dosen_list);
		}
		if (mk.open_in == 'ganjil') return;
		const id_periode = 26;
		const x = {
			id: i + 1,
			id_mk: mk.id,
			label,
			id_dosen: dosen.id,
			semester,
			sks: parseInt(_sks)
		}
		xs.push(x);
	});
	console.log(xs);

	await db.transaction(async (tx) => {
		await tx('schedule_params').delete();
		await tx('schedule_params').insert(xs);
	});
}

module.exports = load_kelas;