const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const redis = require('../../../storage/redis');

const GQL = gql`
	extend type Mutation {
		registerIntoClass (_idKelas: Int!, _idMahasiswa: Int!): Int!
	}
`;

async function registerIntoClass (parent, args, context, info) {
	const { pgClient } = context;
	const { idMahasiswa } = args;
	try {
		const periode = await redis.get('siskom.active_periode');
		const { tahun, semester } = periode;
		await pgClient.query('BEGIN');
		const infoTranskripKumResult = await pgClient.query(
			`SELECT * from info_transkrip_kumulatif($1, $2, $3)`,
			idMahasiswa, tahun, semester
		);
		if (infoTranskripKumResult.rows.length == 0) {
			throw new Error('error getting total sksd');
		}
		const infoTransKum = infoTranskripKumResult.rows[0];
		const { sksd } = infoTransKum;
		pgClient.query(
			`select `
		);
		pgClient.query(`
			insert into mahasiswa_kelas
			(id_kelas, id_mahasiswa)
			values ($1, $2)
		`);
		pgClient.query('COMMIT');
	} catch (err) {
		pgClient.query('ROLLBACK');
		console.log(err);
	}
}