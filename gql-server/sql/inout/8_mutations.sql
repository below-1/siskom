-- Mutations that depends on queries

-- create or replace function register_into_class (
-- 	_id_mahasiswa int,
-- 	_id_kelas int
-- ) returns int as $$
-- 	declare
-- 	_min_sks int;
-- 	_mk mata_kuliah;
-- 	_id_result int;
-- 	_sksd int;
-- 	_periode periode;
-- 	_child_mk_ids setof int;
-- begin
--   	-- Check requirement of this mata_kuliah
--   	select * into _periode from current_periode();
--   	select sksd into _sksd from info_transkrip_kumulatif(_id_mahasiswa, _periode.tahun, _periode.semester);
--   	select mk.* into _mk from kelas k
--   		left join mata_kuliah mk on k.id_mk = mk.id
--   		where k.id = _id_kelas;

--   	if sksd < _mk.min_sks then
--   		raise 'INSUFFICIENT_SKSD';
--   	end if;

-- 	select mk_child.id into _child_mk_ids from mata_kuliah mk
-- 	  	join prasyarat_mk pmk on pmk.id_parent = mk.id
-- 	  	join mata_kuliah mk_child on pmk.id_child = mk_child.id
-- 	  	where mk.id = _mk.id;

--   	insert into mahasiswa_kelas (id_kelas, id_mhs, nilai)
--   		values (_id_kelas, _id_mahasiswa, null)
--   		returning id into _id_result;
--   	return _id_result;

-- end $$ language plpgsql strict;
