create or replace function huruf_nilai (nilai float)
returns char(2) as $$
  select case
    when nilai >= 80.00 then 'A'
    when nilai >= 77.5 then 'A-'
    when nilai >= 75.0 then 'AB'
    when nilai >= 72.5 then 'B+'
    when nilai >= 70.0 then 'B'
    when nilai >= 67.5 then 'B-'
    when nilai >= 65.0 then 'BC'
    when nilai >= 62.5 then 'C+'
    when nilai >= 60.0 then 'C'
    when nilai >= 57.5 then 'C-'
    when nilai >= 55.0 then 'CD'
    when nilai >= 52.5 then 'D+'
    when nilai >= 50.0 then 'D'
    else 'E'
  end
$$ language sql stable;



create or replace function angka_nilai (nilai float)
returns numeric as $$
  select case
    when nilai >= 80.00 then 4.0
    when nilai >= 77.5 then 3.75
    when nilai >= 75.0 then 3.5
    when nilai >= 72.5 then 3.25
    when nilai >= 70.0 then 3.0
    when nilai >= 67.5 then 2.75
    when nilai >= 65.0 then 2.5
    when nilai >= 62.5 then 2.25
    when nilai >= 60.0 then 2.0
    when nilai >= 57.5 then 1.75
    when nilai >= 55.0 then 1.5
    when nilai >= 52.5 then 1.25
    when nilai >= 50.0 then 1.0
    else 0
  end
$$ language sql stable;



create or replace function current_periode () 
returns periode as $$
  select p.* from periode p inner join
    (select setting_value->>'value' as vl
      from app_settings 
      where setting_key = 'id_active_periode') d 
      on d.vl::integer = p.id;
$$ language sql stable;



create or replace function current_periode_id ()
returns integer as $$
  select (setting_value->>'value')::integer
    from app_settings
    where setting_key = 'id_active_periode'
    limit 1
$$ language sql stable;



create or replace function current_user_id () returns integer as $$
  select nullif(current_setting('siskom.user_id'), '')::integer
$$ language sql stable;
comment on function current_user_id is E'@omit execute';



create or replace function current_id_mahasiswa () returns integer as $$
  select
    case
      when tipe_user = 'mahasiswa' then target_id
      else 0
    end
  from app_user where id = current_user_id()
$$ language sql stable;
comment on function current_id_mahasiswa is E'@omit execute';



create or replace function current_mahasiswa () returns mahasiswa as $$
  select * from mahasiswa where id = current_id_mahasiswa()
$$ language sql stable;



create or replace function current_id_dosen () returns integer as $$
  select
    case
      when tipe_user = 'dosen' then target_id
      else 0
    end
  from app_user where id = current_user_id()
$$ language sql stable;
comment on function current_id_dosen is E'@omit execute';



create or replace function current_dosen () returns dosen as $$
  select * from dosen where id = current_id_dosen()
$$ language sql stable;



create or replace function current_app_user () returns app_user as $$
  select * from app_user where id = current_user_id()
$$ language sql stable;



create or replace function find_mahasiswa(
    _keyword varchar, 
    _tahun_masuk TH_AJAR, 
    _take int
)
returns setof mahasiswa as $$
begin
    select * from _temp_mhs 
        where 
            tahun_masuk = _tahun_masuk 
            and nama ilike (_keyword || '%')
        limit _take;
end $$ language plpgsql stable;



create or replace function all_years() returns setof TH_AJAR as $$
    select distinct p.tahun from periode p order by p.tahun asc
$$ language sql stable;



create or replace function list_kelas(
  _id_periode periode.id%type
) returns setof kelas_summary as $$
  select 
    k.id, k.id_mk, k.id_periode, k.label,
    sk.ruangan, sk.hari_kul, sk.waktu_kul, sk.total_menit, sk.kapasitas,
    d.id as dosen_id, d.nama as dosen_nama, d.nip as dosen_nip,
    mk.kode as mk_kode, mk.nama as mk_nama, mk.tipe_mk
    from kelas k
    left join mata_kuliah mk on k.id_mk = mk.id
    left join scheduled_kelas sk on sk.id_kelas = k.id
    left join dosen d on sk.id_dosen = d.id
    where k.id_periode = _id_periode
$$ language sql stable;



create or replace function list_clash_courses (
  _id_periode integer,
  _id_dosen integer,
  _ruangan varchar,
  _hari_kul HARI,
  _waktu_kul time,
  _total_menit smallint
) returns setof kelas_summary as $$
  select 
    k.id,
    k.id_mk,
    k.id_periode,
    k.label,
    sk.ruangan,
    sk.hari_kul,
    sk.waktu_kul,
    sk.total_menit,
    sk.kapasitas,
    d.id as id_dosen,
    d.nama as dosen_nama,
    d.nip as dosen_nip,
    mk.kode as mk_kode,
    mk.nama as mk_nama,
    mk.tipe_mk
    from kelas k 
    join scheduled_kelas sk on sk.id_kelas = k.id
    join dosen d on sk.id_dosen = d.id
    join mata_kuliah mk on k.id_mk = mk.id
    where 
      k.id_periode = _id_periode and 
      sk.hari_kul = _hari_kul and
      -- time overlap
      (sk.waktu_kul, 
        sk.waktu_kul + (sk.total_menit * INTERVAL '1 minute')) 
      overlaps 
      (_waktu_kul, 
        _waktu_kul + (_total_menit * INTERVAL '1 minute')) and
      -- Either lecturer is same or room is same
      (
        sk.id_dosen = _id_dosen
        or
        sk.ruangan = _ruangan
      )
$$ language sql stable;



create or replace function next_label (
  _id_periode integer,
  _id_mk integer
) returns char as $$
  with d as (
    select count(k.id) as total from 
      kelas k
      join scheduled_kelas sk on sk.id_kelas = k.id
      where 
        k.id_periode = _id_periode and
        k.id_mk = _id_mk
  )
  select chr(ascii('A') + total::smallint) as label from d
$$ language sql stable;



create or replace function current_setting () returns setting as $$
  with 
    cp as (select * from current_periode()),
    pr as (select * from app_settings where setting_key = 'current_phase')
    select 
    (cp, (pr.setting_value->>'value')::phase_type)::setting
      from pr, cp
$$ language sql stable;



create or replace function scheduled_kelas_mahasiswa (
  _id_mahasiswa integer,
  _id_periode integer
) returns setof sc_mahasiswa_summary as $$
  select 
    k.id,
    k."label",
    sc_kel.ruangan,
    sc_kel.hari_kul,
    sc_kel.waktu_kul,
    sc_kel.total_menit,
    d.id,
    d.nama,
    d.nip,
    mk.id,
    mk.nama,
    mk.kode,
    mk.tipe_mk
    from mahasiswa m
    left join mahasiswa_kelas m_kel on m_kel.id_mhs = m.id
    left join kelas k on m_kel.id_kelas = k.id
    left join scheduled_kelas sc_kel on sc_kel.id_kelas  = k.id
    left join mata_kuliah mk on k.id_mk  = mk.id
    left join dosen d on sc_kel.id_dosen  = d.id
    where m.id = _id_mahasiswa and k.id_periode = _id_periode
    order by sc_kel.hari_kul, sc_kel.waktu_kul
$$ language sql stable;



create or replace function attended_periode (_id_mahasiswa integer) 
returns setof periode as $$
  select p
    from mahasiswa m 
    left join periode_mahasiswa pm on pm.id_mahasiswa  = m.id
    left join periode p on p.id = pm.id_periode 
    where m.id = _id_mahasiswa
    order by p.tahun desc, p.semester desc 
$$ language sql stable;



create or replace function transkrip (
  _id_mahasiswa integer, 
  _tahun integer,
  _semester integer,
  _keyword varchar
) returns setof mhs_transkrip as $$
  select 
    k.id,
    mk.id,
    mk.nama, 
    mk.kode,
    k.label,
    mk.tipe_mk, 
    mk.sks, 
    mh_k.nilai, 
    huruf_nilai(mh_k.nilai),
    angka_nilai(mh_k.nilai),
    (case 
      when mh_k.nilai >= 2.0 then 'lulus'
      when mh_k.nilai < 2.0 then 'tidak lulus'
    end) as lulus,
    p.tahun, 
    p.semester
    from mahasiswa m 
    join mahasiswa_kelas mh_k on mh_k.id_mhs  = m.id
    join kelas k on k.id = mh_k.id_kelas
    join mata_kuliah mk on mk.id = k.id_mk 
    join periode p on k.id_periode = p.id
    where 
      m.id = _id_mahasiswa 
      and p.tahun <= _tahun
      and (not (p.tahun::integer = _tahun) or p.semester <= _semester)
      and (
        _keyword is null 
        or (
          mk.nama ilike _keyword || '%'
          or mk.kode ilike _keyword || '%'
        )
      )
    order by p.tahun desc, p.semester desc
$$ language sql stable;



create or replace function kelas_in_periode (
  _id_mahasiswa integer, 
  _id_periode integer
) returns setof mahasiswa_kelas as $$
  select mh_k.*
    from mahasiswa m 
    join mahasiswa_kelas mh_k on mh_k.id_mhs  = m.id
    join kelas k on k.id = mh_k.id_kelas
    where m.id = _id_mahasiswa and k.id_periode = _id_periode
$$ language sql stable;



create or replace function info_transkrip_kumulatif (
  _id_mahasiswa integer, 
  _tahun integer,
  _semester integer
) returns info_transkrip as $$
  with d as (select
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
        m.id = _id_mahasiswa
        and p.tahun <= _tahun
        and (not (p.tahun::integer = _tahun) or p.semester <= _semester)
  ) select *, (sksn / sksd)::float as ipk from d
$$ language sql stable;



create or replace function info_transkrip_periode (
  _id_mahasiswa integer, 
  _id_periode integer
) returns info_transkrip as $$
  with d as (select
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
        m.id = _id_mahasiswa
        and p.id = _id_periode
  ) select *, (sksn / sksd)::float as ipk from d
$$ language sql stable;



create or replace function kelas_dosen (
  _id_dosen integer,
  _id_periode integer
) returns setof scheduled_kelas as $$
  select 
    sk.*
    from scheduled_kelas sk
    join kelas k on sk.id_kelas = k.id
    join periode p on p.id = k.id_periode
    join dosen d on sk.id_dosen = d.id
    where 
      d.id = _id_dosen
      and p.id = _id_periode
$$ language sql stable;



create or replace function kelas_of_mahasiswa (
  _id_mhs integer,
  _id_kelas integer
) returns mahasiswa_kelas as $$
  select *
    from mahasiswa_kelas
    where id_kelas = _id_kelas and id_mhs = _id_mhs
    limit 1
$$ language sql stable;



create or replace function schedule_of_dosen (
  _id_periode integer,
  _id_dosen integer
) returns setof scheduled_kelas as $$
  begin
    return query select sc.*
      from scheduled_kelas sc
      join kelas k on sc.id_kelas = k.id
      where sc.id_dosen = _id_dosen
        and k.id_periode = _id_periode;
  end;
$$ language plpgsql stable;



create or replace function filtered_kelas (
  _id_periode integer,
  _keyword varchar
) returns setof kelas as $$
  select k.*
    from kelas k
    join mata_kuliah mk on k.id_mk = mk.id
    join periode p on k.id_periode = p.id
    where 
      (mk.nama ilike _keyword || '%'
      or mk.kode ilike _keyword || '%')
      and p.id = _id_periode
$$ language sql stable;



create or replace function total_mahasiswa_active_pa_dosen (
  _id_dosen integer
) returns bigint as $$
  select count(*)
    from mahasiswa m 
    where m.id_pa = _id_dosen
$$ language sql stable;



create or replace function kelas_schedule_members (
  _id_kelas integer
) returns setof mahasiswa_kelas as $$
  select mh_k.*
    from kelas k
    join mahasiswa_kelas mh_k on mh_k.id_kelas = k.id
    where k.id = _id_kelas
$$ language sql stable;



create or replace function calc_mahasiswa_periode_info (
  _id_mahasiswa integer
)  returns setof mahasiswa_periode_info as $$
  select
      p.id,
      p.tahun,
      p.semester,
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
          m.id = _id_mahasiswa
      group by p.id
      order by p.tahun desc
$$ language sql stable;



-- create or replace function mata_kuliah_mahasiswa (
--   _id_mahasiswa integer
-- ) returns setof mata_kuliah as $$
--   select 
-- $$ language sql stable;
