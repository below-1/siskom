require('dotenv').config()
const pgPool = require('./storage/pg');
const redis = require('./storage/redis');

async function storeCurrentPeriode ({ pgPool }) {
	const currentPeriodeResult = await pgPool.query('select * from current_periode()');
	const currentPeriode = currentPeriodeResult.rows[0];
	await redis.set("siskom.current_periode", JSON.stringify(currentPeriode));
	return currentPeriode;
}

async function storeMahasiswaData ({ pgPool, tahun, semester }) {
	let data = [];
	try {
		const mahasiswaResult = await pgPool.query(`
			with records as (select
				m.id,
			    sum(mk.sks)::integer as sks,
			    sum(
			      case 
			        when mh_k.nilai >= 60.0 then mk.sks
			        else 0
			      end
			    )::integer as sksd,
			    sum(mk.sks * angka_nilai(mh_k.nilai))::float as sksn
			    from mahasiswa m 
			    join mahasiswa_kelas mh_k on mh_k.id_mhs = m.id
			    join kelas k on k.id = mh_k.id_kelas
			    join mata_kuliah mk on mk.id = k.id_mk
			    join periode p on p.id = k.id_periode
			    where 
			        mh_k.validated = true
			        and p.tahun <= $1
			        and (not (p.tahun::integer = $1) or p.semester <= $2)
			    group by m.id
					order by m.id
			)
			select *, (sksn / sksd)::float as ipk from records
		`, [tahun, semester]);
		data = mahasiswaResult.rows;
	} catch (err) {
		console.log('here');
		throw err;
	}

	try {
		const mahasiswaMks = await pgPool.query(`
		select 
			m.id,
			array_agg(
				mk.id
			) filter(where mhs_kel.nilai < 60) as failed_mks,
			array_agg(
				mk.id
			) filter(where mhs_kel.nilai >= 60) as passed_mks
			from mahasiswa m 
			left join mahasiswa_kelas mhs_kel on mhs_kel.id_mhs = m.id
			left join kelas k on mhs_kel.id_kelas = k.id
			left join mata_kuliah mk on mk.id = k.id_mk 
			where 
				mhs_kel.validated = true
			group by m.id
			order by m.id
	`);
		data = data.map((mahasiswa, index) => {
			const mks_data = mahasiswaMks.rows[index];

			return {
				...mahasiswa,
				failed_mks: mks_data.failed_mks,
				passed_mks: mks_data.passed_mks
			}
		})
	} catch (err) {
		console.log(err);
		throw err;
	}

	console.log(data);
}

async function main() {
	const { tahun, semester } = await storeCurrentPeriode({ pgPool });
	await storeMahasiswaData({ pgPool, tahun, semester });
	console.log('done');
}

main();