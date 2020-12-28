const { range } = require('lodash');
const db = require('./db');
const load_dosen = require('./csv_seed_dosen');
const load_mk = require('./csv_seed_mk');
const load_mahasiswa = require('./csv_seed_mahasiswa');

function generate_periode () {
	let data = [];
	range(2007, 2021).forEach(tahun => {
		const sem_1 = { tahun, semester: 1 };
		const sem_2 = { tahun, semester: 2 };
		data.push(sem_1);
		data.push(sem_2);
	});
	data = data.map((d, i) => {
		return {
			id: i + 1,
			...d
		}
	});
	return data;
}

async function load_periode (data) {	
	await db.transaction(async (tx) => {
		await tx('periode').delete();
		await tx('periode').insert(data);
	});
}

async function main () {
	const data_periode = generate_periode();
	await load_periode(data_periode);
	await load_dosen();
	await load_mk();
	await load_mahasiswa(data_periode);

	await db.raw(`
		call new_user(
		  _username => 'adminzero',
		  _password => 'adminzero',
		  _tipe_user => 'admin',
		  _scopes => '{admin}'::user_scope[],
		  _target_id => null
		)
	`);

	await db.raw(`
		insert into app_settings (setting_key, setting_value)
      values 
        ('id_active_periode', '{"value": 27}'),
        ('current_phase', '{"value": "registration"}')
	`);
}

main()
	.then(() => {
		console.log('success inserting data');
		process.exit(1);
	})
	.catch(err => {
		console.log(err);
		process.exit(1);
	})
