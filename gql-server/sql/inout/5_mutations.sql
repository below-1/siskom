CREATE OR REPLACE PROCEDURE new_user(
	_username VARCHAR,
	_password VARCHAR,
	_scopes user_scope[],
	_tipe_user user_type,
	_target_id INTEGER
) LANGUAGE plpgsql AS
$$ BEGIN
	INSERT INTO app_user (username, password, scopes, tipe_user, target_id) 
    VALUES (
        _username,
        crypt(_username, gen_salt('bf')), 
        _scopes,
	     _tipe_user,
        _target_id
    );
END $$;


create or replace function new_dosen(
	_nama varchar, 
	_nip char(20),
	_sex sex_type,
	_in_active_periode boolean
) returns dosen language plpgsql as $$
declare
	_dosen dosen;
	_id_dosen dosen.id%type;
	_id_active_periode periode.id%type;
begin
	insert into dosen (nama, nip, sex) values (_nama, _nip, _sex) RETURNING * into STRICT _dosen;
	select setting_value->>'value' into STRICT _id_active_periode from app_settings where setting_key = 'id_active_periode';
	call new_user(
		_username => _nip, 
		_password => _nip, 
		_scopes => '{dosen}', 
		_tipe_user => 'dosen', 
		_target_id => _dosen.id);
	return _dosen;
end $$;


create or replace function new_mahasiswa(
	_nama varchar,
	_nim char(10),
	_th_masuk TH_AJAR,
  _sex sex_type
)
returns mahasiswa.id%type LANGUAGE plpgsql as $$
declare 
	_id_pa mahasiswa.id_pa%type;
	_id_mahasiswa mahasiswa.id%type;
begin
	select id_pa into strict _id_pa from (
		select d.id as id_pa, count(m.nim) as total
	  	from dosen d
    	left join mahasiswa m on m.id_pa = d.id
    	where d.status = 'aktif'
    	group by d.id
    	order by total asc
			limit 1
	) as t;
	insert into mahasiswa (nama, nim, tahun_masuk, id_pa, sex) 
    values (_nama, _nim, _th_masuk, _id_pa, _sex)
    returning id into strict _id_mahasiswa;
	call new_user(_nim, _nim, '{mahasiswa}', 'mahasiswa', _id_mahasiswa);
	return _id_mahasiswa;
end $$;

create or replace function new_dosen_in_all_periode(
    _nama varchar, 
	_nip char(20),
	_sex sex_type
) 
returns dosen language plpgsql as $$
declare
	_dosen dosen;
	_id_dosen dosen.id%type;
	_id_active_periode periode.id%type;
begin
	insert into dosen (nama, nip, sex) values (_nama, _nip, _sex) RETURNING * into STRICT _dosen;

	select setting_value->>'value' into STRICT _id_active_periode from app_settings where setting_key = 'id_active_periode';
	call new_user(
		_username => _nip, 
		_password => _nip, 
		_scopes => '{dosen}', 
		_tipe_user => 'dosen', 
		_target_id => _dosen.id);
	return _dosen;
end $$;

create or replace function remove_prasyarat (
  _id_parent int,
  _id_child int
) returns bigint as $$
    with d as (
      delete from prasyarat_mk where (id_parent = _id_parent and id_child = _id_child) returning *
    )
    select count(*) from d
$$ language sql;


create or replace function new_scheduled_class (
  _mk_id int,
  _periode_id int,
  _label varchar,
  _dosen_id int,
  _ruangan varchar,
  _hari_kul HARI,
  _waktu_kul time,
  _total_menit smallint,
  _kapasitas smallint  
) returns int as $$
declare
  _id_kelas kelas.id%type;
  n_overlap int;
begin
  select count(id) into strict n_overlap 
    from list_clash_courses(_periode_id, _dosen_id, _ruangan, _hari_kul, _waktu_kul, _total_menit);
  if n_overlap > 0 then
    RAISE EXCEPTION 'CLASH';
  end if;
  insert into kelas (id_periode, id_mk, label) values (_periode_id, _mk_id, _label) returning id into strict _id_kelas;
  insert into scheduled_kelas 
    (id_kelas, id_dosen, ruangan, hari_kul, waktu_kul, total_menit, kapasitas)
    values (_id_kelas, _dosen_id, _ruangan, _hari_kul, _waktu_kul, _total_menit, _kapasitas);
  return _id_kelas;
end $$ language plpgsql strict;

create or replace function update_scheduled_class (
  _id int,
  _dosen_id int,
  _ruangan varchar,
  _hari_kul HARI,
  _waktu_kul time,
  _total_menit smallint,
  _kapasitas smallint
) returns int as $$
declare
  id_periode int;
  n_overlap int;
begin
  select k.id_periode into strict id_periode from kelas k where id = _id;
  select count(id) into strict n_overlap 
    from list_clash_courses(id_periode, _dosen_id, _ruangan, _hari_kul, _waktu_kul, _total_menit);
  if n_overlap > 0 then
    RAISE EXCEPTION 'CLASH';
  end if;
  update scheduled_kelas 
    set 
      id_dosen = _dosen_id,
      ruangan = _ruangan,
      total_menit = _total_menit,
      kapasitas = _kapasitas,
      hari_kul = _hari_kul,
      waktu_kul = _waktu_kul
    where id_kelas = _id;
  return _id;
end $$ language plpgsql strict;

create or replace function change_current_phase (
  phase phase_type
) returns phase_type as $$
  insert into app_settings (setting_key, setting_value)
    values ('current_phase', json_build_object('value', phase))
    on conflict (setting_key)
      do update set setting_value = json_build_object('value', phase)
      returning phase;
$$ language sql strict;

create or replace function change_current_periode (
  id_periode int
) returns int as $$
begin
  if (id_periode not in (select id from periode)) then
    RAISE EXCEPTION 'unknown_id_periode';
  end if;
  insert into app_settings (setting_key, setting_value)
    values ('id_active_periode', json_build_object('value', id_periode))
    on conflict (setting_key)
      do update set setting_value = json_build_object('value', id_periode);
  return id_periode;
end $$ language plpgsql strict;

create or replace function change_nilai (
  _id_mahasiswa int,
  _id_kelas int,
  _nilai float
) returns int as $$
  update mahasiswa_kelas
    set nilai = _nilai
    where 
      id_mhs = _id_mahasiswa
      and id_kelas = _id_kelas
    returning 1
$$ language sql strict;

create or replace function remove_mahasiswa_from_kelas (
  _id_mahasiswa int,
  _id_kelas int
) returns int as $$
  delete from mahasiswa_kelas
    where 
      id_mhs = _id_mahasiswa
      and id_kelas = _id_kelas
      returning 1
$$ language sql strict;

create or replace function add_mahasiswa_to_kelas (
  _id_mahasiswa int,
  _id_kelas int
) returns int as $$
declare
  _mk mata_kuliah;
  _id_result int;
  _sksd int;
  _periode periode;
begin
  -- Check requirement of this mata_kuliah
  -- select mk into strict _mk 
  --   from kelas
  --   join mata_kuliah mk on kelas.id_mk = mk.id;
  -- select * from mata_kuliah mk
  --   join prasyarat_mk pmk on pmk.id_parent = mk.id
  --   where mk.id = _mk.id;
  insert into mahasiswa_kelas (id_kelas, id_mhs, nilai)
    values (_id_kelas, _id_mahasiswa, null)
    returning id into _id_result;
  return _id_result;
end $$ language plpgsql strict;
