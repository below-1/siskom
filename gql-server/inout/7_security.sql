drop role if exists mahasiswa;
create role mahasiswa;
drop role if exists dosen;
create role dosen;
drop role if exists admin;
create role admin;

create or replace function login (
  _username varchar, 
  _password varchar
) returns app_user_jwt as $$
  declare
    _user app_user;
  begin
    select au.* into _user
      from app_user au
      where au.username = _username;

    if _user.password = crypt(_password, _user.password) then
      return (
        _user.id,
        _user.username,
        _user.target_id,
        _user.tipe_user::varchar,
        extract(epoch from now() + interval '7 days')
      )::app_user_jwt;
    else
      return null;
    end if;
  end;
$$ language plpgsql strict security definer;

-- all can view app_user data
grant select on app_user to mahasiswa, dosen;
grant all privileges on app_user to admin;

-- dosen can view all mahasiswa data
grant select on mahasiswa to dosen, mahasiswa;
grant all privileges on mahasiswa to admin;

-- dosen can view all mahasiswa data
grant select on dosen to mahasiswa, dosen;
grant all privileges on dosen to admin;

-- all can view periode data
grant select on periode to mahasiswa, dosen;
grant all privileges on periode to admin;

-- dosen can view periode data
grant select on periode_mahasiswa to dosen, mahasiswa;
grant all privileges on periode_mahasiswa to admin;

-- all can view mk data
grant select on mata_kuliah to mahasiswa, dosen;
grant select on prasyarat_mk to mahasiswa, dosen;
grant all privileges on mata_kuliah to admin;
grant all privileges on prasyarat_mk to admin;

grant select on kelas to dosen, mahasiswa;
grant all privileges on kelas to admin;

grant select on scheduled_kelas to dosen, mahasiswa;
grant all privileges on scheduled_kelas to admin;

grant select, insert on mahasiswa_kelas to dosen, mahasiswa;
grant select, update on mahasiswa_kelas to dosen;
grant all privileges on mahasiswa_kelas to admin;

grant select on room to mahasiswa, dosen;
grant all privileges on room to admin;

grant select on app_settings to mahasiswa, dosen;
grant all privileges on app_settings to admin;

grant select on role_dosen_private_kelas to dosen, mahasiswa;
grant all privileges on role_dosen_private_kelas to admin;

-- grant usage, select on all sequences in schema public to admin;
-- grant usage, select on all sequences in schema public to dosen;
-- grant usage, select on all sequences in schema public to mahasiswa;

-- alter table mahasiswa enable row level security;
-- alter table mahasiswa_kelas enable row level security;
-- alter table periode_mahasiswa enable row level security;

-- create policy admin_all_mahasiswa on mahasiswa to admin using (true);
-- create policy admin_all_mahasiswa_kelas on mahasiswa_kelas to admin using (true);
-- create policy admin_all_periode_mahasiswa on periode_mahasiswa to admin using (true);

-- create policy dosen_all_mahasiswa on mahasiswa to dosen using (true);
-- create policy dosen_all_mahasiswa_kelas on mahasiswa_kelas to dosen using (true);
-- create policy dosen_all_periode_mahasiswa on periode_mahasiswa to dosen using (true);

-- -- mahasiswa can update username and password
-- create policy mahasiswa_user_policy
--   on app_user 
--   for update
--   to mahasiswa
--   using (
--     current_id_mahasiswa() = target_id
--     and tipe_user = 'mahasiswa'
--   );

-- -- mahasiswa can change all of its data
-- grant select on mahasiswa to mahasiswa;
-- grant update (nama, sex, biodata) on mahasiswa to mahasiswa;
-- create policy mahasiswa_self_policy
--   on mahasiswa
--   for all
--   to mahasiswa
--   using (
--     current_id_mahasiswa() = mahasiswa.id
--   );

-- grant select on kelas to mahasiswa;
-- grant select on scheduled_kelas to mahasiswa;

-- grant select on mahasiswa_kelas to mahasiswa;
-- grant insert on mahasiswa_kelas to mahasiswa;
-- create policy mahasiswa_kelas_mutation_policy
--   on mahasiswa_kelas 
--    for all
--   to mahasiswa
--   using (
--     current_id_mahasiswa() = mahasiswa_kelas.id_mhs
--   );

-- grant select on periode_mahasiswa to mahasiswa;
-- create policy periode_mahasiswa_self_policy
--   on periode_mahasiswa 
--   for select
--   to mahasiswa
--   using (
--     current_id_mahasiswa() = periode_mahasiswa.id_mahasiswa
--   );
