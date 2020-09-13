alter table kelas 
  add constraint unique_kelas_periode unique (id_periode, id_mk, label);

alter table periode
  add constraint periode_ketua_fk foreign key (id_ketua) references dosen (id),
  add constraint periode_sekretaris_fk foreign key (id_sekretaris) references dosen (id);

alter table mahasiswa
  add constraint pa_fk foreign key (id_pa) references dosen (id) on delete restrict;

alter table prasyarat_mk
  add constraint mk_parent_fk foreign key (id_parent) references mata_kuliah (id) on delete cascade,
  add constraint mk_child_fk foreign key (id_child) references mata_kuliah (id) on delete cascade;

alter table kelas
  add constraint kelas_periode_fk foreign key (id_periode) references periode (id) on delete restrict,
  add constraint kelas_mk_fk foreign key (id_mk) references mata_kuliah (id) on delete restrict;

alter table scheduled_kelas
  add constraint schedule_kelas_fk foreign key (id_kelas) references kelas (id) on delete restrict,
  add constraint schedule_dosen_fk foreign key (id_dosen) references dosen (id) on delete restrict,
  add constraint schedule_ruangan_fk foreign key (ruangan) references room (nama) on delete restrict;

alter table mahasiswa_kelas
  add constraint anggota_kelas_fk foreign key (id_kelas) references kelas (id) on delete restrict,
  add constraint anggota_mahasiswa_fk foreign key (id_mhs) references mahasiswa (id) on delete restrict;
alter table mahasiswa_kelas 
  add constraint unique_mahasiswa_kelas unique (id_kelas, id_mhs);
create index "id_kelas__mahasiswa_kelas" on mahasiswa_kelas using btree (id_kelas);
create index "id_mhs__mahasiswa_kelas" on mahasiswa_kelas using btree (id_mhs);

alter table periode_mahasiswa
  add constraint available_periode_fk foreign key (id_periode) references periode (id) on delete restrict,
  add constraint available_mahasiswa_fk foreign key (id_mahasiswa) references mahasiswa (id) on delete cascade;

alter table role_dosen_private_kelas
  add constraint kelas_mahasiswa_role_dosen foreign key (id_kelas_mahasiswa) references mahasiswa_kelas (id) on delete restrict,
  add constraint dosen_role_private_kelas foreign key (id_dosen) references dosen (id) on delete restrict;
