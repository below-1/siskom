SELECT nextval('mata_kuliah_id_seq');
SELECT setval('mata_kuliah_id_seq', (SELECT MAX(id) FROM mata_kuliah)+1);

SELECT nextval('app_user_id_seq');
SELECT setval('app_user_id_seq', (SELECT MAX(id) FROM app_user)+1);

SELECT nextval('dosen_id_seq');
SELECT setval('dosen_id_seq', (SELECT MAX(id) FROM dosen)+1);

SELECT nextval('kelas_id_seq');
SELECT setval('kelas_id_seq', (SELECT MAX(id) FROM kelas)+1);

SELECT nextval('mahasiswa_id_seq');
SELECT setval('mahasiswa_id_seq', (SELECT MAX(id) FROM mahasiswa)+1);

SELECT nextval('mahasiswa_kelas_id_seq');
SELECT setval('mahasiswa_kelas_id_seq', (SELECT MAX(id) FROM mahasiswa_kelas)+1);

SELECT nextval('periode_id_seq');
SELECT setval('periode_id_seq', (SELECT MAX(id) FROM periode)+1);

SELECT nextval('role_dosen_private_kelas_id_seq');
SELECT setval('role_dosen_private_kelas_id_seq', (SELECT MAX(id) FROM role_dosen_private_kelas)+1);
