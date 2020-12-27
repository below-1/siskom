const bodyParser = require('body-parser')
const Pool = require('../storage/pg')
const send = require('@polka/send-type')

export async function registerIntoClass (request, response) {
	let status = 200;
	let result;
	const {
		idKelas,
		idMahasiswa
	} = request.body;
	const query = `
		insert into mahasiswa_kelas
		 (id_kelas, id_mahasiswa)
		 values ($1, $2)
	`;
	try {
		const pgResult = await Pool.query(query, [idKelas, idMahasiswa]);
	} catch (err) {
		console.log(err);
		status = 500;
		result = { message: 'error insert data' };
	}
}