CREATE EXTENSION pgcrypto;

CREATE DOMAIN TH_AJAR AS SMALLINT NOT NULL CHECK (value >= 2007);
CREATE DOMAIN SEMESTER AS SMALLINT NOT NULL CHECK (value = 1 OR value = 2);
CREATE DOMAIN HARI AS SMALLINT NOT NULL CHECK (value >= 1 AND value <= 7);
CREATE DOMAIN JAM_KUL AS SMALLINT NOT NULL CHECK (value >= 0 AND value <= 24);

CREATE TYPE mk_open_in_type AS enum('ganjil', 'genap', 'all');
CREATE TYPE user_type AS enum('mahasiswa', 'dosen', 'admin');
CREATE TYPE user_scope AS enum('mahasiswa', 'dosen', 'kaprodi', 'admin');
CREATE TYPE mk_type AS enum('wajib', 'pilihan', 'umum');
CREATE TYPE non_scheduled_type AS enum('kkn', 'kp', 'ta');
CREATE TYPE dosen_role_type AS enum('pembimbing 1', 'pembimbing 2', 'penguji 1', 'penguji 2');
CREATE TYPE dosen_status AS enum('aktif', 'inaktif');
CREATE TYPE sex_type as enum('laki-laki', 'perempuan');
CREATE TYPE phase_type as enum(
  'registration',
  'scheduling',
  'class_pick',
  'kmb',
  'grading',
  'revise'
);
CREATE TYPE mhs_status_type as enum('lulus', 'aktif', 'drop out', 'cuti');