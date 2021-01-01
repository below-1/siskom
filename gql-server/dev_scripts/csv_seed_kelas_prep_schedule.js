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
			id_periode,
			label,
			id_dosen: dosen.id,
			semester,
			sks: parseInt(_sks)
		}
		xs.push(x);
	});

	await db.transaction(async (tx) => {
		await tx("app_settings").where("setting_key", "=", "schedule_params").delete();
		await tx("app_settings").insert({
			setting_key: "schedule_params",
			setting_value: {
				id_periode: 25,
				xs
			}
		});
		await tx("scheduled_kelas").delete();
		await tx("kelas").insert(kelas_list);
		await tx("scheduled_kelas").insert(scheduled_kelas_list);
	});
}

module.exports = load_kelas;