const exec = require('child_process').execSync;
const spawn = require('child_process').spawn;
const { createWriteStream } = require('fs');
const _ = require('lodash');
const Chance = require('chance');
const chance = new Chance();

const padToTwo = number => number <= 9999 ? `000${number}`.slice(-2) : number;

function random_time () {
  const starting_hour = chance.natural({ min: 7, max: 15 });
  return `${padToTwo(starting_hour)}:00`;
}

function serial() {
  let id = 1;
  return {
    random: () => {
      return chance.natural({ min: 1, max: id - 1 })
    },
    next: () => {
      return id++;
    }
  }
}

const nDosen = 15;
const nStudents = 40;
const dosenSerial = serial();
const mkSerial = serial();
const kelasSerial = serial();

let periodes = [
  { id: 1, tahun: 2007, semester: 1, awal: '2007-01-04', akhir: '2007-06-04' },
  { id: 2, tahun: 2007, semester: 2, awal: '2007-07-04', akhir: '2007-12-04' },
  { id: 3, tahun: 2008, semester: 1, awal: '2008-01-04', akhir: '2008-06-04' },
  { id: 4, tahun: 2008, semester: 2, awal: '2008-07-04', akhir: '2008-12-04' },
  { id: 5, tahun: 2009, semester: 1, awal: '2009-01-04', akhir: '2009-06-04' },
  { id: 6, tahun: 2009, semester: 2, awal: '2009-07-04', akhir: '2009-12-04' }
];
periodes = periodes.map(p => ({
  ...p,
  id_ketua: 1,
  id_sekretaris: 2
}))

const rooms = [
  { nama: 'k1', kapasitas: 40 },
  { nama: 'k2', kapasitas: 40 },
  { nama: 'k3', kapasitas: 40 },
  { nama: 'k4', kapasitas: 40 },
  { nama: 'k5', kapasitas: 40 },
  { nama: 'laboratorium komputer', kapasitas: 30 }
];
const room_names = rooms.map(room => room.nama);

const sexes = ['laki-laki', 'perempuan'];

function randomDosen (n) {
  return _.range(1, n + 1)
    .map(i => ({
      id: dosenSerial.next(),
      nip: chance.string({ length: 20, numeric: true }),
      nama: chance.name(),
      sex: chance.pickone(sexes),
      status: 'aktif'
    }))
}

function randomStudents (n, nDosen) {
  return _.range(1, n + 1)
    .map(i => ({
      id: i,
      nim: chance.string({ length: 10, numeric: true }),
      nama: chance.name(),
      sex: chance.pickone(sexes),
      tahun_masuk: 2007,
      id_pa: chance.natural({ min: 1, max: nDosen })
    }))
}

function randomMks (n, pref_schedule) {
  const open_in = pref_schedule % 2 == 0 ? 'genap' : 'ganjil';
  return _.range(1, n + 1)
    .map(i => ({
      id: mkSerial.next(),
      nama: chance.company(),
      kode: chance.string({ length: 5, numeric: true }),
      open_in,
      min_sks: 0,
      sks: chance.pickone([ 3, 2 ]),
      tipe_mk: chance.weighted(
        ['wajib', 'pilihan', 'umum'],
        [100, 40, 10]
      ),
      pref_schedule,
      scheduled: true
    }))
}

function kelasForPeriode (students, dosens, lastId) {
  let kelases = [];
  let scheduled = [];
  let mahasiswa_kelas = [];
  let mata_kuliahs = [];

  periodes.forEach(periode => {
    const mks = randomMks(12, periode.id);
    mata_kuliahs = [ ...mata_kuliahs, ...mks ];

    let _kelases = mks.map(mk => {
      return {
        id: kelasSerial.next(),
        id_periode: periode.id,
        id_mk: mk.id,
        label: 'A',
        mk
      }
    });

    const _scheduled = _kelases.map(kelas => {
      let room_name = chance.pickone(room_names);
      return {
        id_kelas: kelas.id,
        id_dosen: dosenSerial.random(),
        ruangan: room_name,
        hari_kul: chance.natural({ min: 1, max: 6 }),
        total_menit: kelas.mk.sks * 45,
        waktu_kul: random_time(),
        kapasitas: rooms.find(r => r.nama == room_name).kapasitas
      };
    });

    students.forEach(student => {
      const nKelas = chance.weighted(
        [4, 5, 6, 7],
        [7, 10, 10, 5]
      )
      const scs = chance.pickset(_scheduled, nKelas);
      scs.forEach(sc => {
        mahasiswa_kelas.push({
          id_kelas: sc.id_kelas,
          id_mhs: student.id,
          nilai: chance.floating({ min: 0, max: 100.0 })
        })
      })
    });

    _kelases = _kelases.map(k => {
      const { mk, ...rest } = k;
      return rest;
    });
    kelases = [...kelases, ..._kelases];
    scheduled = [...scheduled, ..._scheduled];
  });

  return {
    kelases,
    scheduled,
    mahasiswa_kelas,
    mata_kuliahs
  }
}

const dosens = randomDosen(nDosen);
const students = randomStudents(nStudents, nDosen);
let periodeStudents = [];
students.forEach(st => {
  periodes.forEach(p => {
    const x = {
      id_periode: p.id,
      id_mahasiswa: st.id
    };
    periodeStudents.push(x);
  })
})
const data = kelasForPeriode(students, dosens, 0);

function runSeed () {
  const knex = require('knex')({
    client: 'pg',
    connection: 'postgres://postgres@localhost/postgres'
  });

  let stream = createWriteStream('data.sql');
  stream.on('finish', () => {
    console.log('done write data');
  });

  const studentUserStrings = students.map(student => `
call new_user(
  _username => '${student.nim}',
  _password => '${student.nim}',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => ${student.id}
);`);

  const dosenUserStrings = dosens.map(dosen => `
call new_user(
  _username => '${dosen.nip}',
  _password => '${dosen.nip}',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => ${dosen.id}
);`);

  const {
    kelases,
    scheduled,
    mahasiswa_kelas,
    mata_kuliahs
  } = data;

  const xs = [
    [dosens, 'dosen'],
    [periodes, 'periode'],
    [rooms, 'room'],
    [students, 'mahasiswa'],
    [periodeStudents, 'periode_mahasiswa'],
    [mata_kuliahs, 'mata_kuliah'],
    [kelases, 'kelas'],
    [scheduled, 'scheduled_kelas'],
    [mahasiswa_kelas, 'mahasiswa_kelas']
  ];

  let lines = xs
    .map(([ data, tb_name ]) => {
      return knex.insert(data).into(tb_name).toString()
    });

  lines.splice(5, 0, studentUserStrings.join('\n'));
  lines.splice(6, 0, dosenUserStrings.join('\n'));

  lines.push(`
    insert into app_settings (setting_key, setting_value)
      values 
        ('id_active_periode', '{"value": 6}'),
        ('current_phase', '{"value": "registration"}');
  `);
  lines.push(`
call new_user(
  _username => 'adminzero',
  _password => 'adminzero',
  _tipe_user => 'admin',
  _scopes => '{admin}'::user_scope[],
  _target_id => null
);`);

  lines.forEach(s => {
    stream.write(s);
    stream.write(';\n\n');
  });

  stream.end();

  // console.log(s);
  // const result = knex.transaction(function (trx) {
  //   const dosenRes = trx.insert(dosens).into('dosen');
  //   const periodeRes = trx.insert(periodes).into('periode');
  //   const roomRes = trx.insert(rooms).into('room');
  //   const studentRes = trx.insert(students).into('mahasiswa');
  //   const periodeStudentRes = trx.insert(periodeStudents).into('periode_mahasiswa');
  //   const studentUserRes = Promise.all(
  //     students.map(student => 
  //       trx.raw(`call new_user(
  //         _username => '${student.nim}',
  //         _password => '${student.nim}',
  //         _tipe_user => 'mahasiswa',
  //         _scopes => '{mahasiswa}'::user_scope[],
  //         _target_id => ${student.id}
  //       )`)
  //   ));
  //   const dosenUserRes = Promise.all(
  //     dosens.map(dosen =>
  //       trx.raw(`call new_user(
  //         _username => '${dosen.nip}',
  //         _password => '${dosen.nip}',
  //         _tipe_user => 'dosen',
  //         _scopes => '{dosen}'::user_scope[],
  //         _target_id => ${dosen.id}
  //       )`)
  //   ));

  //   const {
  //     kelases,
  //     scheduled,
  //     mahasiswa_kelas,
  //     mata_kuliahs
  //   } = data;

  //   const mkRes = trx.insert(mata_kuliahs).into('mata_kuliah');
  //   const kelasRes = trx.insert(kelases).into('kelas');
  //   const scRes = trx.insert(scheduled).into('scheduled_kelas');
  //   const mahasiswaKelasRes = trx.insert(mahasiswa_kelas).into('mahasiswa_kelas');
  //   const settingRes = trx.insert([
  //     {
  //       setting_key: 'id_active_periode',
  //       setting_value: { value: 1 }
  //     },
  //     {
  //       setting_key: 'current_phase',
  //       setting_value: { value: 'registration' }
  //     }
  //   ]).into('app_settings');

  //   return Promise.all([
  //     periodeRes, 
  //     roomRes, 
  //     dosenRes, 
  //     dosenUserRes, 
  //     studentRes,
  //     studentUserRes,
  //     periodeStudentRes,
  //     mkRes, 
  //     kelasRes,
  //     scRes, 
  //     mahasiswaKelasRes,
  //     settingRes
  //   ]);
  // });

  // return result
  //   .then(ok => {
  //     console.log('done inserting data');
  //   })
  //   .catch(err => {
  //     console.log(err);
  //   });
}

// console.log(data.kelases);
runSeed();
