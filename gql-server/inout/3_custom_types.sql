CREATE TYPE setting AS (
  current_periode periode,
  phase phase_type
);

CREATE TYPE info_transkrip AS (
  sks INTEGER,
  sksd INTEGER,
  sksn FLOAT,
  ip FLOAT
);

CREATE TYPE mhs_semester AS (
  id_periode INTEGER,
  label VARCHAR,
  tahun INTEGER,
  semester INTEGER
);

CREATE TYPE mhs_transkrip AS (
  id_kelas INTEGER,
  id_mk INTEGER,
  nama_mk VARCHAR,
  kode_mk VARCHAR,
  label VARCHAR,
  tipe_mk mk_type,
  sks SMALLINT,
  nilai FLOAT,
  huruf_nilai CHAR(2),
  angka_nilai numeric,
  lulus VARCHAR,
  tahun TH_AJAR,
  semester SEMESTER
);

CREATE TYPE sc_mahasiswa_summary AS (
  id_kelas INTEGER,
  label VARCHAR,
  ruangan VARCHAR,
  hari_kul SMALLINT,
  waktu_kul TIME,
  total_menit SMALLINT,
  id_dosen INTEGER,
  nama_dosen VARCHAR,
  nip_dosen CHAR(20),
  id_mk INTEGER,
  nama_mk VARCHAR,
  kode_mk VARCHAR,
  tipe_mk mk_type
);

CREATE TYPE kelas_summary AS (
  id INTEGER,
  id_mk INTEGER,
  id_periode INTEGER,
  label VARCHAR,
  ruangan VARCHAR,
  hari_kul SMALLINT,
  waktu_kul TIME,
  total_menit SMALLINT,
  kapasitas SMALLINT,
  dosen_id INTEGER,
  dosen_nama VARCHAR,
  dosen_nip CHAR(20),
  mk_kode VARCHAR,
  mk_nama VARCHAR,
  tipe_mk mk_type
);

create type app_user_jwt AS (
  id INTEGER,
  username VARCHAR,
  target_id INTEGER,
  role VARCHAR,
  exp INTEGER
);

create type app_user_comp as (
  _mahasiswa mahasiswa,
  _dosen dosen
);

CREATE TYPE mahasiswa_ip as (
  tahun integer,
  semester SEMESTER,
  nilai float
);
