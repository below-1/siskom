insert into "dosen" ("id", "nama", "nip", "sex", "status") values (1, 'Lettie Swanson', '19179874038771519995', 'laki-laki', 'aktif'), (2, 'Andrew McKenzie', '97364175621048682196', 'laki-laki', 'aktif'), (3, 'Gregory Goodwin', '89081371668020295087', 'laki-laki', 'aktif'), (4, 'Eugene Kelley', '42758892358129180182', 'laki-laki', 'aktif'), (5, 'Florence Salazar', '75584946507521394327', 'laki-laki', 'aktif'), (6, 'Melvin Warren', '53393850083010723799', 'laki-laki', 'aktif'), (7, 'Dora Houston', '51557702630200268356', 'laki-laki', 'aktif'), (8, 'Addie Ward', '62133775461105817668', 'perempuan', 'aktif'), (9, 'Brett Hunt', '53240546626866694732', 'perempuan', 'aktif'), (10, 'Jordan Cruz', '13608981369930831823', 'perempuan', 'aktif'), (11, 'Juan Marsh', '99952461680315865148', 'perempuan', 'aktif'), (12, 'Benjamin Kelly', '22516189773993837115', 'laki-laki', 'aktif'), (13, 'Millie Maxwell', '42618076253939863029', 'perempuan', 'aktif'), (14, 'Amelia Fuller', '80339739711262903473', 'perempuan', 'aktif'), (15, 'Carlos Massey', '42723514718513693712', 'laki-laki', 'aktif');

insert into "periode" ("akhir", "awal", "id", "id_ketua", "id_sekretaris", "semester", "tahun") values ('2007-06-04', '2007-01-04', 1, 1, 2, 1, 2007), ('2007-12-04', '2007-07-04', 2, 1, 2, 2, 2007), ('2008-06-04', '2008-01-04', 3, 1, 2, 1, 2008), ('2008-12-04', '2008-07-04', 4, 1, 2, 2, 2008), ('2009-06-04', '2009-01-04', 5, 1, 2, 1, 2009), ('2009-12-04', '2009-07-04', 6, 1, 2, 2, 2009);

insert into "room" ("kapasitas", "nama") values (40, 'k1'), (40, 'k2'), (40, 'k3'), (40, 'k4'), (40, 'k5'), (30, 'laboratorium komputer');

insert into "mahasiswa" ("id", "id_pa", "nama", "nim", "sex", "tahun_masuk") values (1, 6, 'Clifford Collins', '3677018170', 'perempuan', 2007), (2, 3, 'Allen Reed', '6481081077', 'laki-laki', 2007), (3, 5, 'Adelaide Mitchell', '5622606015', 'laki-laki', 2007), (4, 9, 'Nelle Christensen', '3352936571', 'perempuan', 2007), (5, 5, 'Jay Blair', '4736256331', 'laki-laki', 2007), (6, 5, 'Clarence Cross', '2461925502', 'perempuan', 2007), (7, 13, 'Brian Morrison', '1435175390', 'perempuan', 2007), (8, 10, 'Cecelia Cross', '5913279687', 'perempuan', 2007), (9, 14, 'Josie Alvarado', '0266390828', 'laki-laki', 2007), (10, 5, 'Erik Phelps', '4333941204', 'laki-laki', 2007), (11, 13, 'Frances Matthews', '3115072247', 'perempuan', 2007), (12, 4, 'Daisy Hale', '8760369514', 'laki-laki', 2007), (13, 3, 'Leila Haynes', '1553919374', 'perempuan', 2007), (14, 5, 'Kevin Burke', '9139170726', 'laki-laki', 2007), (15, 7, 'Lizzie Hodges', '8647392959', 'laki-laki', 2007), (16, 6, 'Viola Osborne', '0043007228', 'perempuan', 2007), (17, 11, 'Georgia Hanson', '7935967054', 'laki-laki', 2007), (18, 6, 'Virginia Roy', '1204371901', 'perempuan', 2007), (19, 8, 'Jeremy Wilkins', '8270974028', 'perempuan', 2007), (20, 6, 'Miguel Fowler', '2186477334', 'laki-laki', 2007), (21, 14, 'Derek Butler', '8215831252', 'perempuan', 2007), (22, 14, 'Jorge Hicks', '0312456389', 'perempuan', 2007), (23, 12, 'Carlos Christensen', '2221021556', 'perempuan', 2007), (24, 3, 'Estelle Anderson', '0926259690', 'perempuan', 2007), (25, 12, 'Joe Bennett', '1970607457', 'perempuan', 2007), (26, 8, 'Jose Mathis', '7652966288', 'perempuan', 2007), (27, 12, 'Melvin Page', '0417592458', 'laki-laki', 2007), (28, 8, 'Leo Grant', '9418219421', 'perempuan', 2007), (29, 11, 'Leila Saunders', '8428198337', 'perempuan', 2007), (30, 9, 'Jesse Turner', '9636314722', 'laki-laki', 2007), (31, 4, 'Hannah Jackson', '6056915161', 'laki-laki', 2007), (32, 5, 'Brian Barber', '2936713615', 'laki-laki', 2007), (33, 10, 'Timothy Harrington', '3800250456', 'perempuan', 2007), (34, 13, 'Eliza Tate', '0541736342', 'perempuan', 2007), (35, 12, 'Madge Mathis', '7351131828', 'laki-laki', 2007), (36, 8, 'Theodore Allen', '7376672110', 'laki-laki', 2007), (37, 13, 'Georgia Rodgers', '5690112270', 'laki-laki', 2007), (38, 3, 'Genevieve Hardy', '9469869808', 'laki-laki', 2007), (39, 3, 'Luis Lowe', '0942448221', 'perempuan', 2007), (40, 1, 'Leo Tyler', '0353495422', 'perempuan', 2007);

insert into "periode_mahasiswa" ("id_mahasiswa", "id_periode") values (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (8, 1), (8, 2), (8, 3), (8, 4), (8, 5), (8, 6), (9, 1), (9, 2), (9, 3), (9, 4), (9, 5), (9, 6), (10, 1), (10, 2), (10, 3), (10, 4), (10, 5), (10, 6), (11, 1), (11, 2), (11, 3), (11, 4), (11, 5), (11, 6), (12, 1), (12, 2), (12, 3), (12, 4), (12, 5), (12, 6), (13, 1), (13, 2), (13, 3), (13, 4), (13, 5), (13, 6), (14, 1), (14, 2), (14, 3), (14, 4), (14, 5), (14, 6), (15, 1), (15, 2), (15, 3), (15, 4), (15, 5), (15, 6), (16, 1), (16, 2), (16, 3), (16, 4), (16, 5), (16, 6), (17, 1), (17, 2), (17, 3), (17, 4), (17, 5), (17, 6), (18, 1), (18, 2), (18, 3), (18, 4), (18, 5), (18, 6), (19, 1), (19, 2), (19, 3), (19, 4), (19, 5), (19, 6), (20, 1), (20, 2), (20, 3), (20, 4), (20, 5), (20, 6), (21, 1), (21, 2), (21, 3), (21, 4), (21, 5), (21, 6), (22, 1), (22, 2), (22, 3), (22, 4), (22, 5), (22, 6), (23, 1), (23, 2), (23, 3), (23, 4), (23, 5), (23, 6), (24, 1), (24, 2), (24, 3), (24, 4), (24, 5), (24, 6), (25, 1), (25, 2), (25, 3), (25, 4), (25, 5), (25, 6), (26, 1), (26, 2), (26, 3), (26, 4), (26, 5), (26, 6), (27, 1), (27, 2), (27, 3), (27, 4), (27, 5), (27, 6), (28, 1), (28, 2), (28, 3), (28, 4), (28, 5), (28, 6), (29, 1), (29, 2), (29, 3), (29, 4), (29, 5), (29, 6), (30, 1), (30, 2), (30, 3), (30, 4), (30, 5), (30, 6), (31, 1), (31, 2), (31, 3), (31, 4), (31, 5), (31, 6), (32, 1), (32, 2), (32, 3), (32, 4), (32, 5), (32, 6), (33, 1), (33, 2), (33, 3), (33, 4), (33, 5), (33, 6), (34, 1), (34, 2), (34, 3), (34, 4), (34, 5), (34, 6), (35, 1), (35, 2), (35, 3), (35, 4), (35, 5), (35, 6), (36, 1), (36, 2), (36, 3), (36, 4), (36, 5), (36, 6), (37, 1), (37, 2), (37, 3), (37, 4), (37, 5), (37, 6), (38, 1), (38, 2), (38, 3), (38, 4), (38, 5), (38, 6), (39, 1), (39, 2), (39, 3), (39, 4), (39, 5), (39, 6), (40, 1), (40, 2), (40, 3), (40, 4), (40, 5), (40, 6);


call new_user(
  _username => '3677018170',
  _password => '3677018170',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 1
);

call new_user(
  _username => '6481081077',
  _password => '6481081077',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 2
);

call new_user(
  _username => '5622606015',
  _password => '5622606015',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 3
);

call new_user(
  _username => '3352936571',
  _password => '3352936571',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 4
);

call new_user(
  _username => '4736256331',
  _password => '4736256331',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 5
);

call new_user(
  _username => '2461925502',
  _password => '2461925502',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 6
);

call new_user(
  _username => '1435175390',
  _password => '1435175390',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 7
);

call new_user(
  _username => '5913279687',
  _password => '5913279687',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 8
);

call new_user(
  _username => '0266390828',
  _password => '0266390828',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 9
);

call new_user(
  _username => '4333941204',
  _password => '4333941204',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 10
);

call new_user(
  _username => '3115072247',
  _password => '3115072247',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 11
);

call new_user(
  _username => '8760369514',
  _password => '8760369514',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 12
);

call new_user(
  _username => '1553919374',
  _password => '1553919374',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 13
);

call new_user(
  _username => '9139170726',
  _password => '9139170726',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 14
);

call new_user(
  _username => '8647392959',
  _password => '8647392959',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 15
);

call new_user(
  _username => '0043007228',
  _password => '0043007228',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 16
);

call new_user(
  _username => '7935967054',
  _password => '7935967054',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 17
);

call new_user(
  _username => '1204371901',
  _password => '1204371901',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 18
);

call new_user(
  _username => '8270974028',
  _password => '8270974028',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 19
);

call new_user(
  _username => '2186477334',
  _password => '2186477334',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 20
);

call new_user(
  _username => '8215831252',
  _password => '8215831252',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 21
);

call new_user(
  _username => '0312456389',
  _password => '0312456389',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 22
);

call new_user(
  _username => '2221021556',
  _password => '2221021556',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 23
);

call new_user(
  _username => '0926259690',
  _password => '0926259690',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 24
);

call new_user(
  _username => '1970607457',
  _password => '1970607457',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 25
);

call new_user(
  _username => '7652966288',
  _password => '7652966288',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 26
);

call new_user(
  _username => '0417592458',
  _password => '0417592458',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 27
);

call new_user(
  _username => '9418219421',
  _password => '9418219421',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 28
);

call new_user(
  _username => '8428198337',
  _password => '8428198337',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 29
);

call new_user(
  _username => '9636314722',
  _password => '9636314722',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 30
);

call new_user(
  _username => '6056915161',
  _password => '6056915161',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 31
);

call new_user(
  _username => '2936713615',
  _password => '2936713615',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 32
);

call new_user(
  _username => '3800250456',
  _password => '3800250456',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 33
);

call new_user(
  _username => '0541736342',
  _password => '0541736342',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 34
);

call new_user(
  _username => '7351131828',
  _password => '7351131828',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 35
);

call new_user(
  _username => '7376672110',
  _password => '7376672110',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 36
);

call new_user(
  _username => '5690112270',
  _password => '5690112270',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 37
);

call new_user(
  _username => '9469869808',
  _password => '9469869808',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 38
);

call new_user(
  _username => '0942448221',
  _password => '0942448221',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 39
);

call new_user(
  _username => '0353495422',
  _password => '0353495422',
  _tipe_user => 'mahasiswa',
  _scopes => '{mahasiswa}'::user_scope[],
  _target_id => 40
);;


call new_user(
  _username => '19179874038771519995',
  _password => '19179874038771519995',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 1
);

call new_user(
  _username => '97364175621048682196',
  _password => '97364175621048682196',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 2
);

call new_user(
  _username => '89081371668020295087',
  _password => '89081371668020295087',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 3
);

call new_user(
  _username => '42758892358129180182',
  _password => '42758892358129180182',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 4
);

call new_user(
  _username => '75584946507521394327',
  _password => '75584946507521394327',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 5
);

call new_user(
  _username => '53393850083010723799',
  _password => '53393850083010723799',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 6
);

call new_user(
  _username => '51557702630200268356',
  _password => '51557702630200268356',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 7
);

call new_user(
  _username => '62133775461105817668',
  _password => '62133775461105817668',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 8
);

call new_user(
  _username => '53240546626866694732',
  _password => '53240546626866694732',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 9
);

call new_user(
  _username => '13608981369930831823',
  _password => '13608981369930831823',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 10
);

call new_user(
  _username => '99952461680315865148',
  _password => '99952461680315865148',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 11
);

call new_user(
  _username => '22516189773993837115',
  _password => '22516189773993837115',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 12
);

call new_user(
  _username => '42618076253939863029',
  _password => '42618076253939863029',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 13
);

call new_user(
  _username => '80339739711262903473',
  _password => '80339739711262903473',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 14
);

call new_user(
  _username => '42723514718513693712',
  _password => '42723514718513693712',
  _tipe_user => 'dosen',
  _scopes => '{dosen}'::user_scope[],
  _target_id => 15
);;

insert into "mata_kuliah" ("id", "kode", "min_sks", "nama", "open_in", "pref_schedule", "scheduled", "sks", "tipe_mk") values (1, '48019', 0, 'Metals USA Inc.', 'ganjil', 1, true, 2, 'wajib'), (2, '68732', 0, 'Analog Devices, Inc.', 'ganjil', 1, true, 3, 'pilihan'), (3, '30728', 0, 'Mandalay Resort Group', 'ganjil', 1, true, 3, 'pilihan'), (4, '36112', 0, 'Northern Trust Corporation', 'ganjil', 1, true, 3, 'wajib'), (5, '80325', 0, 'Fleetwood Enterprises Inc.', 'ganjil', 1, true, 2, 'wajib'), (6, '05009', 0, 'BorgWarner Inc.', 'ganjil', 1, true, 2, 'pilihan'), (7, '08258', 0, 'Benchmark Electronics, Inc.', 'ganjil', 1, true, 3, 'pilihan'), (8, '03925', 0, 'Pathmark Stores Inc.', 'ganjil', 1, true, 3, 'pilihan'), (9, '23839', 0, 'Lehman Brothers Holdings Inc.', 'ganjil', 1, true, 3, 'pilihan'), (10, '40448', 0, 'XO Communications Inc', 'ganjil', 1, true, 2, 'wajib'), (11, '88438', 0, 'Textron Inc', 'ganjil', 1, true, 2, 'pilihan'), (12, '04536', 0, 'Coca-Cola Enterprises Inc.', 'ganjil', 1, true, 3, 'pilihan'), (13, '69294', 0, 'BMC Software, Inc.', 'genap', 2, true, 3, 'wajib'), (14, '39553', 0, 'Toys ''R'' Us Inc', 'genap', 2, true, 3, 'wajib'), (15, '64522', 0, 'CBRL Group Inc.', 'genap', 2, true, 3, 'pilihan'), (16, '54890', 0, 'Target Corp.', 'genap', 2, true, 2, 'wajib'), (17, '98968', 0, 'Quanta Services Inc.', 'genap', 2, true, 2, 'wajib'), (18, '67102', 0, 'MPS Group Inc.', 'genap', 2, true, 2, 'wajib'), (19, '15032', 0, 'Interstate Bakeries Corporation', 'genap', 2, true, 2, 'wajib'), (20, '42658', 0, 'Capital One Financial Corp.', 'genap', 2, true, 3, 'wajib'), (21, '91442', 0, 'National Oilwell Inc', 'genap', 2, true, 2, 'pilihan'), (22, '89231', 0, 'Greif Bros. Corporation', 'genap', 2, true, 2, 'pilihan'), (23, '57920', 0, 'Weyerhauser Company', 'genap', 2, true, 2, 'wajib'), (24, '78966', 0, 'Dun & Bradstreet Inc.', 'genap', 2, true, 3, 'pilihan'), (25, '59492', 0, 'Guidant Corporation', 'ganjil', 3, true, 2, 'wajib'), (26, '72192', 0, 'GreenPoint Financial Corp.', 'ganjil', 3, true, 3, 'wajib'), (27, '09870', 0, 'Peter Kiewit Sons'', Inc.', 'ganjil', 3, true, 2, 'pilihan'), (28, '98358', 0, 'Sempra Energy', 'ganjil', 3, true, 3, 'wajib'), (29, '37805', 0, 'Constellation Brands Inc.', 'ganjil', 3, true, 3, 'wajib'), (30, '54243', 0, 'Wyndham International Inc', 'ganjil', 3, true, 3, 'wajib'), (31, '12653', 0, 'Safeway Inc', 'ganjil', 3, true, 3, 'pilihan'), (32, '43008', 0, 'Washington Post Co.', 'ganjil', 3, true, 2, 'wajib'), (33, '30845', 0, 'Anheuser-Busch Companies, Inc.', 'ganjil', 3, true, 2, 'wajib'), (34, '95115', 0, 'Goldman Sachs Group Inc.', 'ganjil', 3, true, 2, 'wajib'), (35, '27269', 0, 'Mercury General Corporation', 'ganjil', 3, true, 3, 'pilihan'), (36, '74936', 0, 'DST Systems, Inc.', 'ganjil', 3, true, 2, 'wajib'), (37, '84674', 0, 'Computer Sciences Corp.', 'genap', 4, true, 3, 'pilihan'), (38, '17542', 0, 'Corn Products International Inc.', 'genap', 4, true, 2, 'wajib'), (39, '07068', 0, 'Viasystems Group Inc', 'genap', 4, true, 2, 'wajib'), (40, '70818', 0, 'Advanced Micro Devices, Inc.', 'genap', 4, true, 3, 'wajib'), (41, '61728', 0, 'AFLAC Incorporated', 'genap', 4, true, 2, 'wajib'), (42, '19205', 0, 'Texas Industries Inc.', 'genap', 4, true, 3, 'pilihan'), (43, '65015', 0, 'General Cable Corporation', 'genap', 4, true, 3, 'pilihan'), (44, '78088', 0, 'Integrated Electrical Services Inc.', 'genap', 4, true, 3, 'wajib'), (45, '73911', 0, 'C. H. Robinson Worldwide Inc.', 'genap', 4, true, 3, 'umum'), (46, '31514', 0, 'Tenet Healthcare Corporation', 'genap', 4, true, 3, 'wajib'), (47, '67300', 0, 'AMR Corporation', 'genap', 4, true, 2, 'wajib'), (48, '72873', 0, 'Microsoft Corporation', 'genap', 4, true, 3, 'wajib'), (49, '98534', 0, 'Starwood Hotels & Resorts Worldwide Inc', 'ganjil', 5, true, 2, 'wajib'), (50, '45959', 0, 'Exelon Corporation', 'ganjil', 5, true, 2, 'wajib'), (51, '38127', 0, 'Paccar Inc', 'ganjil', 5, true, 3, 'wajib'), (52, '13802', 0, 'Peter Kiewit Sons'', Inc.', 'ganjil', 5, true, 2, 'wajib'), (53, '50070', 0, 'Acterna Corp.', 'ganjil', 5, true, 2, 'wajib'), (54, '41067', 0, 'Energy East Corporation', 'ganjil', 5, true, 2, 'wajib'), (55, '82215', 0, 'Boise Cascade Corporation', 'ganjil', 5, true, 3, 'wajib'), (56, '02680', 0, 'Cooper Tire & Rubber Co.', 'ganjil', 5, true, 3, 'wajib'), (57, '12855', 0, 'Intuit Inc.', 'ganjil', 5, true, 2, 'wajib'), (58, '15081', 0, 'Perot Systems Corp', 'ganjil', 5, true, 2, 'wajib'), (59, '22252', 0, 'Conseco Inc.', 'ganjil', 5, true, 2, 'wajib'), (60, '34941', 0, 'Sysco Corp', 'ganjil', 5, true, 2, 'pilihan'), (61, '72765', 0, 'M & T Bank Corporation', 'genap', 6, true, 2, 'wajib'), (62, '49950', 0, 'Sprint Corp.', 'genap', 6, true, 2, 'pilihan'), (63, '94084', 0, 'Kroger Co.', 'genap', 6, true, 3, 'wajib'), (64, '71396', 0, 'W.W. Grainger Inc', 'genap', 6, true, 3, 'wajib'), (65, '73463', 0, 'Apache Corporation', 'genap', 6, true, 3, 'wajib'), (66, '75522', 0, 'Primedia Inc', 'genap', 6, true, 2, 'wajib'), (67, '59370', 0, 'Becton, Dickinson and Company', 'genap', 6, true, 3, 'wajib'), (68, '28155', 0, 'Radio Shack Corporation', 'genap', 6, true, 3, 'wajib'), (69, '41039', 0, 'BellSouth Corporation', 'genap', 6, true, 3, 'pilihan'), (70, '57394', 0, 'Laboratory Corporation of America Holdings', 'genap', 6, true, 2, 'wajib'), (71, '22615', 0, 'Raymond James Financial Inc.', 'genap', 6, true, 2, 'wajib'), (72, '99257', 0, 'ArvinMeritor, Inc.', 'genap', 6, true, 3, 'wajib');

insert into "kelas" ("id", "id_mk", "id_periode", "label") values (1, 1, 1, 'A'), (2, 1, 1, 'B'), (3, 2, 1, 'A'), (4, 2, 1, 'B'), (5, 3, 1, 'A'), (6, 3, 1, 'B'), (7, 3, 1, 'C'), (8, 3, 1, 'D'), (9, 3, 1, 'E'), (10, 4, 1, 'A'), (11, 4, 1, 'B'), (12, 5, 1, 'A'), (13, 5, 1, 'B'), (14, 5, 1, 'C'), (15, 5, 1, 'D'), (16, 6, 1, 'A'), (17, 6, 1, 'B'), (18, 7, 1, 'A'), (19, 7, 1, 'B'), (20, 7, 1, 'C'), (21, 7, 1, 'D'), (22, 8, 1, 'A'), (23, 8, 1, 'B'), (24, 8, 1, 'C'), (25, 8, 1, 'D'), (26, 8, 1, 'E'), (27, 9, 1, 'A'), (28, 9, 1, 'B'), (29, 9, 1, 'C'), (30, 10, 1, 'A'), (31, 10, 1, 'B'), (32, 11, 1, 'A'), (33, 11, 1, 'B'), (34, 11, 1, 'C'), (35, 11, 1, 'D'), (36, 12, 1, 'A'), (37, 13, 2, 'A'), (38, 13, 2, 'B'), (39, 13, 2, 'C'), (40, 13, 2, 'D'), (41, 13, 2, 'E'), (42, 14, 2, 'A'), (43, 14, 2, 'B'), (44, 14, 2, 'C'), (45, 14, 2, 'D'), (46, 15, 2, 'A'), (47, 15, 2, 'B'), (48, 15, 2, 'C'), (49, 16, 2, 'A'), (50, 17, 2, 'A'), (51, 17, 2, 'B'), (52, 17, 2, 'C'), (53, 18, 2, 'A'), (54, 18, 2, 'B'), (55, 18, 2, 'C'), (56, 19, 2, 'A'), (57, 19, 2, 'B'), (58, 19, 2, 'C'), (59, 19, 2, 'D'), (60, 20, 2, 'A'), (61, 20, 2, 'B'), (62, 20, 2, 'C'), (63, 20, 2, 'D'), (64, 20, 2, 'E'), (65, 21, 2, 'A'), (66, 22, 2, 'A'), (67, 22, 2, 'B'), (68, 22, 2, 'C'), (69, 22, 2, 'D'), (70, 22, 2, 'E'), (71, 23, 2, 'A'), (72, 23, 2, 'B'), (73, 23, 2, 'C'), (74, 23, 2, 'D'), (75, 24, 2, 'A'), (76, 25, 3, 'A'), (77, 25, 3, 'B'), (78, 25, 3, 'C'), (79, 25, 3, 'D'), (80, 26, 3, 'A'), (81, 27, 3, 'A'), (82, 27, 3, 'B'), (83, 27, 3, 'C'), (84, 27, 3, 'D'), (85, 27, 3, 'E'), (86, 28, 3, 'A'), (87, 28, 3, 'B'), (88, 29, 3, 'A'), (89, 29, 3, 'B'), (90, 29, 3, 'C'), (91, 29, 3, 'D'), (92, 29, 3, 'E'), (93, 30, 3, 'A'), (94, 30, 3, 'B'), (95, 30, 3, 'C'), (96, 30, 3, 'D'), (97, 31, 3, 'A'), (98, 31, 3, 'B'), (99, 31, 3, 'C'), (100, 31, 3, 'D'), (101, 31, 3, 'E'), (102, 32, 3, 'A'), (103, 33, 3, 'A'), (104, 33, 3, 'B'), (105, 33, 3, 'C'), (106, 33, 3, 'D'), (107, 33, 3, 'E'), (108, 34, 3, 'A'), (109, 34, 3, 'B'), (110, 35, 3, 'A'), (111, 35, 3, 'B'), (112, 35, 3, 'C'), (113, 35, 3, 'D'), (114, 36, 3, 'A'), (115, 37, 4, 'A'), (116, 37, 4, 'B'), (117, 37, 4, 'C'), (118, 37, 4, 'D'), (119, 37, 4, 'E'), (120, 38, 4, 'A'), (121, 38, 4, 'B'), (122, 38, 4, 'C'), (123, 38, 4, 'D'), (124, 38, 4, 'E'), (125, 39, 4, 'A'), (126, 39, 4, 'B'), (127, 39, 4, 'C'), (128, 40, 4, 'A'), (129, 40, 4, 'B'), (130, 41, 4, 'A'), (131, 41, 4, 'B'), (132, 42, 4, 'A'), (133, 43, 4, 'A'), (134, 44, 4, 'A'), (135, 44, 4, 'B'), (136, 44, 4, 'C'), (137, 44, 4, 'D'), (138, 45, 4, 'A'), (139, 45, 4, 'B'), (140, 45, 4, 'C'), (141, 46, 4, 'A'), (142, 46, 4, 'B'), (143, 46, 4, 'C'), (144, 46, 4, 'D'), (145, 46, 4, 'E'), (146, 47, 4, 'A'), (147, 47, 4, 'B'), (148, 48, 4, 'A'), (149, 48, 4, 'B'), (150, 48, 4, 'C'), (151, 49, 5, 'A'), (152, 49, 5, 'B'), (153, 50, 5, 'A'), (154, 50, 5, 'B'), (155, 50, 5, 'C'), (156, 50, 5, 'D'), (157, 50, 5, 'E'), (158, 51, 5, 'A'), (159, 51, 5, 'B'), (160, 51, 5, 'C'), (161, 51, 5, 'D'), (162, 51, 5, 'E'), (163, 52, 5, 'A'), (164, 53, 5, 'A'), (165, 54, 5, 'A'), (166, 54, 5, 'B'), (167, 54, 5, 'C'), (168, 55, 5, 'A'), (169, 55, 5, 'B'), (170, 55, 5, 'C'), (171, 55, 5, 'D'), (172, 55, 5, 'E'), (173, 56, 5, 'A'), (174, 57, 5, 'A'), (175, 57, 5, 'B'), (176, 58, 5, 'A'), (177, 58, 5, 'B'), (178, 58, 5, 'C'), (179, 58, 5, 'D'), (180, 59, 5, 'A'), (181, 59, 5, 'B'), (182, 59, 5, 'C'), (183, 59, 5, 'D'), (184, 59, 5, 'E'), (185, 60, 5, 'A'), (186, 61, 6, 'A'), (187, 61, 6, 'B'), (188, 62, 6, 'A'), (189, 62, 6, 'B'), (190, 62, 6, 'C'), (191, 62, 6, 'D'), (192, 63, 6, 'A'), (193, 63, 6, 'B'), (194, 63, 6, 'C'), (195, 64, 6, 'A'), (196, 64, 6, 'B'), (197, 64, 6, 'C'), (198, 65, 6, 'A'), (199, 65, 6, 'B'), (200, 65, 6, 'C'), (201, 65, 6, 'D'), (202, 65, 6, 'E'), (203, 66, 6, 'A'), (204, 67, 6, 'A'), (205, 68, 6, 'A'), (206, 68, 6, 'B'), (207, 68, 6, 'C'), (208, 69, 6, 'A'), (209, 70, 6, 'A'), (210, 70, 6, 'B'), (211, 70, 6, 'C'), (212, 70, 6, 'D'), (213, 71, 6, 'A'), (214, 71, 6, 'B'), (215, 72, 6, 'A'), (216, 72, 6, 'B'), (217, 72, 6, 'C');

insert into "scheduled_kelas" ("hari_kul", "id_dosen", "id_kelas", "kapasitas", "ruangan", "total_menit", "waktu_kul") values (1, 5, 1, 40, 'k2', 90, '12:00'), (3, 1, 2, 40, 'k2', 90, '09:00'), (5, 10, 3, 40, 'k3', 135, '13:00'), (3, 11, 4, 30, 'laboratorium komputer', 135, '14:00'), (1, 1, 5, 30, 'laboratorium komputer', 135, '07:00'), (3, 1, 6, 30, 'laboratorium komputer', 135, '12:00'), (1, 3, 7, 40, 'k5', 135, '09:00'), (4, 3, 8, 30, 'laboratorium komputer', 135, '15:00'), (2, 11, 9, 40, 'k3', 135, '15:00'), (2, 8, 10, 40, 'k5', 135, '11:00'), (3, 10, 11, 40, 'k3', 135, '10:00'), (6, 7, 12, 40, 'k1', 90, '12:00'), (3, 6, 13, 30, 'laboratorium komputer', 90, '15:00'), (3, 5, 14, 40, 'k2', 90, '11:00'), (3, 10, 15, 40, 'k3', 90, '15:00'), (6, 15, 16, 40, 'k1', 90, '15:00'), (5, 4, 17, 40, 'k3', 90, '10:00'), (4, 7, 18, 40, 'k4', 135, '15:00'), (3, 8, 19, 40, 'k1', 135, '09:00'), (1, 7, 20, 40, 'k2', 135, '11:00'), (1, 8, 21, 40, 'k3', 135, '15:00'), (5, 7, 22, 40, 'k2', 135, '10:00'), (2, 4, 23, 40, 'k4', 135, '07:00'), (3, 5, 24, 30, 'laboratorium komputer', 135, '10:00'), (6, 14, 25, 40, 'k3', 135, '15:00'), (2, 10, 26, 30, 'laboratorium komputer', 135, '11:00'), (2, 7, 27, 40, 'k1', 135, '13:00'), (6, 14, 28, 40, 'k3', 135, '13:00'), (4, 14, 29, 40, 'k1', 135, '10:00'), (4, 11, 30, 40, 'k1', 90, '13:00'), (1, 5, 31, 40, 'k2', 90, '12:00'), (5, 9, 32, 30, 'laboratorium komputer', 90, '12:00'), (3, 13, 33, 30, 'laboratorium komputer', 90, '12:00'), (4, 12, 34, 30, 'laboratorium komputer', 90, '07:00'), (2, 8, 35, 40, 'k3', 90, '08:00'), (6, 10, 36, 30, 'laboratorium komputer', 135, '07:00'), (5, 1, 37, 40, 'k3', 135, '14:00'), (3, 14, 38, 40, 'k4', 135, '11:00'), (4, 9, 39, 40, 'k4', 135, '10:00'), (1, 2, 40, 40, 'k1', 135, '13:00'), (4, 1, 41, 40, 'k1', 135, '08:00'), (3, 7, 42, 40, 'k4', 135, '09:00'), (6, 11, 43, 40, 'k4', 135, '13:00'), (6, 5, 44, 40, 'k4', 135, '07:00'), (6, 6, 45, 30, 'laboratorium komputer', 135, '10:00'), (3, 10, 46, 40, 'k3', 135, '14:00'), (6, 7, 47, 40, 'k5', 135, '14:00'), (2, 7, 48, 40, 'k2', 135, '13:00'), (5, 14, 49, 40, 'k3', 90, '09:00'), (4, 7, 50, 40, 'k1', 90, '15:00'), (4, 11, 51, 40, 'k3', 90, '11:00'), (2, 8, 52, 30, 'laboratorium komputer', 90, '14:00'), (2, 1, 53, 40, 'k1', 90, '14:00'), (2, 7, 54, 40, 'k2', 90, '13:00'), (2, 10, 55, 30, 'laboratorium komputer', 90, '14:00'), (1, 15, 56, 40, 'k4', 90, '11:00'), (5, 14, 57, 40, 'k3', 90, '15:00'), (6, 7, 58, 40, 'k4', 90, '07:00'), (6, 10, 59, 40, 'k2', 90, '10:00'), (1, 11, 60, 30, 'laboratorium komputer', 135, '07:00'), (5, 15, 61, 30, 'laboratorium komputer', 135, '08:00'), (1, 13, 62, 40, 'k4', 135, '15:00'), (2, 13, 63, 40, 'k5', 135, '15:00'), (1, 8, 64, 40, 'k5', 135, '13:00'), (4, 3, 65, 40, 'k5', 90, '12:00'), (4, 7, 66, 30, 'laboratorium komputer', 90, '09:00'), (4, 9, 67, 40, 'k5', 90, '15:00'), (3, 9, 68, 40, 'k1', 90, '09:00'), (4, 3, 69, 40, 'k3', 90, '10:00'), (6, 5, 70, 40, 'k5', 90, '07:00'), (5, 10, 71, 40, 'k2', 90, '07:00'), (4, 3, 72, 40, 'k1', 90, '10:00'), (3, 5, 73, 30, 'laboratorium komputer', 90, '12:00'), (1, 15, 74, 40, 'k2', 90, '11:00'), (1, 8, 75, 30, 'laboratorium komputer', 135, '09:00'), (4, 1, 76, 30, 'laboratorium komputer', 90, '13:00'), (6, 12, 77, 40, 'k3', 90, '11:00'), (1, 3, 78, 40, 'k3', 90, '08:00'), (3, 2, 79, 40, 'k2', 90, '15:00'), (2, 8, 80, 40, 'k3', 135, '10:00'), (5, 11, 81, 40, 'k2', 90, '10:00'), (1, 14, 82, 40, 'k4', 90, '15:00'), (6, 6, 83, 40, 'k1', 90, '15:00'), (3, 12, 84, 40, 'k1', 90, '08:00'), (5, 3, 85, 40, 'k2', 90, '12:00'), (2, 4, 86, 40, 'k4', 135, '12:00'), (6, 6, 87, 40, 'k3', 135, '12:00'), (5, 3, 88, 40, 'k1', 135, '09:00'), (4, 13, 89, 40, 'k5', 135, '10:00'), (1, 7, 90, 40, 'k3', 135, '11:00'), (2, 13, 91, 40, 'k3', 135, '11:00'), (3, 2, 92, 40, 'k3', 135, '15:00'), (5, 15, 93, 40, 'k2', 135, '13:00'), (6, 8, 94, 40, 'k4', 135, '11:00'), (6, 6, 95, 40, 'k1', 135, '13:00'), (6, 10, 96, 40, 'k5', 135, '14:00'), (4, 2, 97, 30, 'laboratorium komputer', 135, '08:00'), (1, 7, 98, 40, 'k3', 135, '10:00'), (6, 8, 99, 30, 'laboratorium komputer', 135, '08:00'), (1, 8, 100, 40, 'k2', 135, '11:00'), (5, 3, 101, 40, 'k4', 135, '08:00'), (1, 6, 102, 40, 'k3', 90, '08:00'), (6, 2, 103, 30, 'laboratorium komputer', 90, '14:00'), (3, 6, 104, 40, 'k5', 90, '07:00'), (4, 10, 105, 40, 'k4', 90, '10:00'), (5, 7, 106, 40, 'k1', 90, '13:00'), (3, 13, 107, 40, 'k1', 90, '09:00'), (6, 6, 108, 40, 'k3', 90, '10:00'), (4, 11, 109, 40, 'k1', 90, '08:00'), (5, 14, 110, 30, 'laboratorium komputer', 135, '11:00'), (4, 7, 111, 40, 'k3', 135, '11:00'), (2, 12, 112, 40, 'k1', 135, '10:00'), (1, 1, 113, 40, 'k1', 135, '14:00'), (5, 5, 114, 40, 'k1', 90, '13:00'), (3, 13, 115, 40, 'k5', 135, '15:00'), (3, 14, 116, 40, 'k2', 135, '15:00'), (2, 6, 117, 40, 'k5', 135, '12:00'), (2, 13, 118, 40, 'k1', 135, '15:00'), (2, 15, 119, 40, 'k2', 135, '09:00'), (1, 5, 120, 40, 'k4', 90, '14:00'), (1, 3, 121, 40, 'k3', 90, '08:00'), (3, 10, 122, 40, 'k5', 90, '09:00'), (1, 7, 123, 40, 'k1', 90, '09:00'), (6, 12, 124, 40, 'k4', 90, '11:00'), (2, 6, 125, 40, 'k2', 90, '14:00'), (6, 3, 126, 40, 'k3', 90, '13:00'), (6, 6, 127, 40, 'k1', 90, '09:00'), (1, 3, 128, 40, 'k5', 135, '15:00'), (6, 13, 129, 40, 'k3', 135, '15:00'), (6, 12, 130, 40, 'k3', 90, '11:00'), (3, 13, 131, 40, 'k2', 90, '09:00'), (6, 1, 132, 40, 'k4', 135, '07:00'), (6, 9, 133, 40, 'k3', 135, '09:00'), (6, 12, 134, 40, 'k5', 135, '08:00'), (5, 6, 135, 30, 'laboratorium komputer', 135, '07:00'), (3, 13, 136, 30, 'laboratorium komputer', 135, '13:00'), (6, 10, 137, 40, 'k5', 135, '13:00'), (1, 3, 138, 40, 'k1', 135, '11:00'), (5, 13, 139, 40, 'k5', 135, '14:00'), (3, 5, 140, 40, 'k4', 135, '09:00'), (3, 11, 141, 40, 'k1', 135, '12:00'), (6, 13, 142, 40, 'k2', 135, '12:00'), (1, 10, 143, 40, 'k3', 135, '12:00'), (1, 6, 144, 40, 'k2', 135, '10:00'), (6, 4, 145, 40, 'k1', 135, '10:00'), (3, 3, 146, 40, 'k3', 90, '10:00'), (1, 5, 147, 40, 'k3', 90, '12:00'), (6, 1, 148, 40, 'k4', 135, '13:00'), (3, 7, 149, 40, 'k4', 135, '12:00'), (3, 1, 150, 40, 'k2', 135, '12:00'), (3, 6, 151, 40, 'k3', 90, '13:00'), (4, 7, 152, 40, 'k1', 90, '07:00'), (2, 5, 153, 40, 'k2', 90, '12:00'), (4, 9, 154, 40, 'k4', 90, '14:00'), (5, 5, 155, 30, 'laboratorium komputer', 90, '12:00'), (3, 1, 156, 40, 'k3', 90, '07:00'), (3, 5, 157, 40, 'k3', 90, '11:00'), (5, 7, 158, 40, 'k4', 135, '07:00'), (5, 11, 159, 40, 'k3', 135, '12:00'), (2, 3, 160, 40, 'k2', 135, '08:00'), (4, 6, 161, 30, 'laboratorium komputer', 135, '12:00'), (1, 12, 162, 40, 'k2', 135, '15:00'), (2, 4, 163, 40, 'k2', 90, '07:00'), (4, 5, 164, 40, 'k4', 90, '10:00'), (2, 1, 165, 40, 'k4', 90, '08:00'), (1, 11, 166, 30, 'laboratorium komputer', 90, '07:00'), (3, 6, 167, 40, 'k4', 90, '15:00'), (6, 4, 168, 30, 'laboratorium komputer', 135, '09:00'), (1, 15, 169, 40, 'k3', 135, '14:00'), (4, 10, 170, 40, 'k1', 135, '15:00'), (3, 4, 171, 40, 'k1', 135, '15:00'), (6, 6, 172, 40, 'k5', 135, '14:00'), (1, 5, 173, 40, 'k2', 135, '13:00'), (5, 2, 174, 30, 'laboratorium komputer', 90, '09:00'), (3, 9, 175, 40, 'k3', 90, '09:00'), (3, 14, 176, 40, 'k3', 90, '09:00'), (6, 11, 177, 40, 'k3', 90, '13:00'), (1, 9, 178, 40, 'k1', 90, '14:00'), (3, 14, 179, 40, 'k3', 90, '12:00'), (2, 7, 180, 40, 'k3', 90, '11:00'), (2, 3, 181, 40, 'k5', 90, '07:00'), (4, 15, 182, 40, 'k3', 90, '07:00'), (2, 9, 183, 40, 'k2', 90, '14:00'), (4, 4, 184, 40, 'k4', 90, '11:00'), (5, 8, 185, 30, 'laboratorium komputer', 90, '12:00'), (3, 14, 186, 40, 'k4', 90, '07:00'), (3, 15, 187, 40, 'k2', 90, '09:00'), (6, 12, 188, 40, 'k5', 90, '07:00'), (3, 6, 189, 40, 'k1', 90, '11:00'), (2, 14, 190, 30, 'laboratorium komputer', 90, '11:00'), (5, 12, 191, 40, 'k3', 90, '09:00'), (1, 1, 192, 30, 'laboratorium komputer', 135, '08:00'), (1, 8, 193, 40, 'k5', 135, '13:00'), (6, 10, 194, 30, 'laboratorium komputer', 135, '08:00'), (6, 13, 195, 30, 'laboratorium komputer', 135, '14:00'), (1, 15, 196, 40, 'k1', 135, '15:00'), (1, 2, 197, 40, 'k3', 135, '09:00'), (1, 12, 198, 40, 'k3', 135, '10:00'), (5, 3, 199, 30, 'laboratorium komputer', 135, '12:00'), (2, 5, 200, 40, 'k4', 135, '10:00'), (5, 5, 201, 40, 'k1', 135, '12:00'), (3, 4, 202, 30, 'laboratorium komputer', 135, '14:00'), (3, 15, 203, 40, 'k4', 90, '12:00'), (5, 5, 204, 40, 'k2', 135, '10:00'), (1, 9, 205, 40, 'k3', 135, '14:00'), (2, 6, 206, 40, 'k1', 135, '13:00'), (5, 3, 207, 30, 'laboratorium komputer', 135, '13:00'), (2, 13, 208, 40, 'k3', 135, '14:00'), (2, 9, 209, 30, 'laboratorium komputer', 90, '15:00'), (6, 3, 210, 40, 'k2', 90, '07:00'), (3, 5, 211, 30, 'laboratorium komputer', 90, '10:00'), (6, 2, 212, 40, 'k1', 90, '12:00'), (6, 8, 213, 40, 'k2', 90, '11:00'), (6, 13, 214, 40, 'k4', 90, '10:00'), (3, 12, 215, 40, 'k3', 135, '07:00'), (5, 4, 216, 40, 'k5', 135, '08:00'), (5, 12, 217, 40, 'k5', 135, '15:00');

insert into "mahasiswa_kelas" ("id_kelas", "id_mhs", "nilai", "validated") values (24, 1, 23.6099, true), (7, 1, 38.9512, true), (21, 1, 60.9564, true), (35, 1, 61.0971, true), (20, 1, 91.2059, true), (8, 1, 85.9468, true), (13, 1, 8.2638, true), (13, 2, 93.754, true), (12, 2, 46.4399, true), (36, 2, 14.3616, true), (25, 2, 21.7944, true), (31, 2, 43.0498, true), (33, 2, 42.344, true), (14, 3, 61.6102, true), (23, 3, 85.6034, true), (17, 3, 78.2651, true), (30, 3, 29.9618, true), (9, 3, 50.4953, true), (13, 4, 99.1786, true), (15, 4, 68.3525, true), (17, 4, 79.047, true), (2, 4, 13.2094, true), (28, 4, 19.2087, true), (33, 4, 75.8171, true), (3, 4, 89.8365, true), (15, 5, 24.3435, true), (8, 5, 22.5818, true), (9, 5, 51.9733, true), (13, 5, 46.6836, true), (22, 5, 90.4554, true), (35, 5, 76.4269, true), (32, 6, 19.1801, true), (35, 6, 5.0135, true), (3, 6, 89.4232, true), (28, 6, 60.1741, true), (22, 6, 7.1324, true), (29, 7, 66.4468, true), (30, 7, 40.799, true), (22, 7, 68.7246, true), (23, 7, 58.7486, true), (7, 7, 72.5959, true), (3, 8, 40.8344, true), (32, 8, 87.305, true), (12, 8, 12.7959, true), (36, 8, 67.0809, true), (27, 9, 98.0625, true), (19, 9, 82.348, true), (5, 9, 59.9673, true), (12, 9, 60.9367, true), (35, 10, 64.1244, true), (13, 10, 33.9613, true), (14, 10, 98.4831, true), (20, 10, 76.6956, true), (22, 11, 72.1581, true), (15, 11, 36.6147, true), (27, 11, 64.6637, true), (2, 11, 18.4823, true), (18, 11, 80.8656, true), (36, 11, 45.0321, true), (5, 11, 0.532, true), (7, 12, 58.1538, true), (21, 12, 36.9556, true), (6, 12, 25.0062, true), (5, 12, 33.2923, true), (32, 12, 77.0057, true), (28, 13, 85.1626, true), (26, 13, 2.5963, true), (10, 13, 60.8038, true), (9, 13, 74.2504, true), (27, 13, 59.8503, true), (33, 13, 10.2818, true), (5, 14, 32.4501, true), (30, 14, 82.7097, true), (1, 14, 82.4378, true), (3, 14, 87.1616, true), (7, 15, 93.7219, true), (16, 15, 45.2963, true), (2, 15, 64.108, true), (8, 15, 34.0961, true), (20, 16, 16.9215, true), (4, 16, 63.8896, true), (34, 16, 90.204, true), (33, 16, 0.1443, true), (36, 16, 82.955, true), (33, 17, 74.3651, true), (28, 17, 7.5561, true), (18, 17, 10.9336, true), (26, 17, 75.0596, true), (19, 17, 58.7774, true), (9, 17, 39.254, true), (13, 17, 75.6346, true), (6, 18, 56.0212, true), (34, 18, 40.1452, true), (23, 18, 4.7682, true), (1, 18, 2.4409, true), (25, 19, 95.0831, true), (22, 19, 7.1168, true), (24, 19, 56.3108, true), (10, 19, 62.9194, true), (14, 19, 85.1387, true), (1, 19, 94.131, true), (31, 19, 26.5773, true), (21, 20, 15.7075, true), (30, 20, 64.6556, true), (35, 20, 24.6168, true), (5, 20, 73.5766, true), (1, 20, 99.7522, true), (8, 20, 48.8279, true), (28, 20, 3.0895, true), (11, 21, 0.6088, true), (4, 21, 91.0957, true), (14, 21, 26.4607, true), (35, 21, 76.6885, true), (36, 22, 93.1748, true), (10, 22, 95.2072, true), (3, 22, 64.4836, true), (27, 22, 23.3581, true), (9, 22, 19.4634, true), (13, 22, 98.801, true), (30, 22, 15.4535, true), (5, 23, 15.8874, true), (19, 23, 71.5097, true), (25, 23, 30.4691, true), (29, 23, 82.4471, true), (17, 23, 1.0076, true), (1, 23, 58.3498, true), (26, 24, 71.042, true), (6, 24, 52.2048, true), (32, 24, 85.1549, true), (31, 24, 95.8034, true), (10, 25, 45.1508, true), (27, 25, 49.9679, true), (5, 25, 83.8578, true), (8, 25, 30.2283, true), (11, 25, 60.4244, true), (15, 25, 1.2552, true), (6, 26, 14.6549, true), (22, 26, 67.2281, true), (4, 26, 34.0785, true), (1, 26, 95.5473, true), (5, 26, 9.7083, true), (24, 27, 16.3236, true), (14, 27, 31.4489, true), (21, 27, 5.3029, true), (17, 27, 13.493, true), (3, 27, 44.7437, true), (28, 28, 94.818, true), (24, 28, 68.1256, true), (35, 28, 96.8942, true), (25, 28, 14.9632, true), (4, 29, 88.76, true), (18, 29, 21.4476, true), (9, 29, 35.5569, true), (13, 29, 59.1788, true), (15, 30, 57.3966, true), (19, 30, 91.969, true), (5, 30, 35.1723, true), (10, 30, 38.4343, true), (35, 30, 23.8421, true), (33, 30, 83.4741, true), (23, 30, 16.7981, true), (3, 31, 47.6269, true), (29, 31, 58.337, true), (26, 31, 60.6178, true), (19, 31, 41.4078, true), (4, 32, 13.6912, true), (1, 32, 47.2449, true), (9, 32, 43.1914, true), (19, 32, 98.9306, true), (20, 33, 54.1233, true), (9, 33, 48.249, true), (29, 33, 41.2349, true), (24, 33, 92.5043, true), (31, 33, 10.9627, true), (13, 33, 59.6182, true), (19, 34, 85.4438, true), (25, 34, 41.093, true), (34, 34, 24.9805, true), (29, 34, 92.5357, true), (16, 34, 23.9987, true), (28, 34, 22.9668, true), (13, 35, 71.9875, true), (26, 35, 6.1512, true), (20, 35, 26.5618, true), (29, 35, 33.2677, true), (23, 35, 20.483, true), (11, 35, 75.021, true), (14, 35, 5.0639, true), (11, 36, 93.8079, true), (32, 36, 20.508, true), (6, 36, 33.4502, true), (3, 36, 9.558, true), (22, 36, 43.2952, true), (1, 37, 7.7844, true), (12, 37, 84.4972, true), (10, 37, 84.9798, true), (7, 37, 73.1413, true), (16, 37, 22.9593, true), (35, 38, 0.4552, true), (16, 38, 41.1896, true), (9, 38, 98.0467, true), (1, 38, 28.4903, true), (26, 38, 24.2973, true), (27, 38, 85.2357, true), (14, 38, 35.7794, true), (17, 39, 74.2066, true), (23, 39, 81.9412, true), (22, 39, 75.2551, true), (28, 39, 57.2396, true), (4, 39, 35.8286, true), (18, 39, 15.8235, true), (1, 40, 99.2725, true), (6, 40, 36.3694, true), (3, 40, 46.0158, true), (21, 40, 76.5839, true), (61, 1, 87.0938, true), (40, 1, 86.7682, true), (41, 1, 32.1476, true), (54, 1, 67.7038, true), (66, 1, 92.1028, true), (45, 1, 22.8618, true), (58, 1, 49.4798, true), (69, 2, 44.6881, true), (43, 2, 94.2118, true), (55, 2, 19.6307, true), (40, 2, 32.5892, true), (62, 3, 81.6324, true), (46, 3, 47.5602, true), (50, 3, 54.4278, true), (61, 3, 93.583, true), (64, 3, 73.2589, true), (40, 3, 95.0598, true), (52, 4, 83.9346, true), (50, 4, 41.2075, true), (64, 4, 95.5574, true), (71, 4, 45.1144, true), (54, 4, 41.2004, true), (72, 4, 91.6485, true), (71, 5, 88.8288, true), (39, 5, 79.0683, true), (49, 5, 88.5071, true), (54, 5, 8.9847, true), (55, 5, 39.5107, true), (59, 5, 80.9011, true), (51, 6, 20.3815, true), (48, 6, 20.1245, true), (61, 6, 22.0095, true), (74, 6, 74.2374, true), (65, 6, 44.9485, true), (54, 7, 2.8198, true), (53, 7, 30.5958, true), (55, 7, 13.7386, true), (64, 7, 25.4485, true), (67, 7, 43.5899, true), (37, 7, 40.3034, true), (44, 8, 92.4632, true), (40, 8, 12.7516, true), (54, 8, 47.5767, true), (70, 8, 67.1845, true), (71, 8, 96.8926, true), (62, 9, 33.9275, true), (59, 9, 1.692, true), (57, 9, 71.6646, true), (71, 9, 51.2675, true), (43, 9, 79.9604, true), (49, 9, 3.1968, true), (45, 10, 59.0153, true), (40, 10, 88.3902, true), (71, 10, 69.26, true), (53, 10, 81.2835, true), (66, 11, 86.1145, true), (51, 11, 81.3244, true), (58, 11, 24.373, true), (67, 11, 88.0776, true), (48, 11, 56.4195, true), (68, 11, 89.5922, true), (51, 12, 50.2674, true), (44, 12, 63.4297, true), (75, 12, 78.7904, true), (42, 12, 12.3809, true), (68, 12, 80.5288, true), (75, 13, 83.1763, true), (41, 13, 7.8611, true), (66, 13, 22.5932, true), (56, 13, 87.9479, true), (55, 13, 18.8012, true), (62, 13, 56.4461, true), (58, 13, 43.2664, true), (72, 14, 93.1738, true), (54, 14, 50.1244, true), (75, 14, 37.2204, true), (64, 14, 90.6002, true), (37, 14, 65.6846, true), (49, 14, 1.3843, true), (51, 14, 73.4185, true), (70, 15, 95.6843, true), (42, 15, 93.6243, true), (54, 15, 36.041, true), (47, 15, 55.1988, true), (41, 15, 12.3759, true), (49, 15, 45.847, true), (75, 15, 56.4238, true), (52, 16, 98.6076, true), (38, 16, 49.2966, true), (50, 16, 39.9434, true), (54, 16, 61.5645, true), (65, 16, 49.6465, true), (50, 17, 2.4531, true), (55, 17, 99.046, true), (43, 17, 76.6756, true), (65, 17, 85.5046, true), (61, 18, 20.6585, true), (75, 18, 88.086, true), (49, 18, 21.2904, true), (40, 18, 32.8151, true), (50, 18, 65.7037, true), (56, 18, 29.4373, true), (73, 19, 63.3988, true), (70, 19, 16.6504, true), (57, 19, 13.6118, true), (43, 19, 41.5373, true), (49, 19, 2.6974, true), (58, 19, 91.195, true), (50, 20, 50.7942, true), (43, 20, 64.2568, true), (42, 20, 14.7229, true), (52, 20, 6.0941, true), (52, 21, 74.3074, true), (59, 21, 99.6241, true), (71, 21, 74.9113, true), (62, 21, 8.3435, true), (48, 21, 88.651, true), (41, 21, 60.6342, true), (73, 22, 33.6814, true), (65, 22, 16.61, true), (39, 22, 41.1432, true), (50, 22, 70.9715, true), (70, 22, 47.8586, true), (41, 23, 9.4533, true), (38, 23, 4.4015, true), (53, 23, 90.185, true), (73, 23, 93.7406, true), (44, 24, 86.284, true), (55, 24, 6.9691, true), (73, 24, 69.7795, true), (45, 24, 19.2908, true), (49, 24, 10.9404, true), (73, 25, 23.0972, true), (55, 25, 43.2001, true), (63, 25, 30.2368, true), (58, 25, 83.9369, true), (75, 25, 11.9376, true), (47, 26, 15.2812, true), (54, 26, 49.3427, true), (67, 26, 77.8593, true), (42, 26, 33.506, true), (51, 26, 46.5152, true), (42, 27, 15.5271, true), (57, 27, 46.4313, true), (58, 27, 25.8931, true), (40, 27, 16.9747, true), (51, 27, 10.4731, true), (44, 28, 43.9136, true), (62, 28, 0.2384, true), (47, 28, 55.8568, true), (50, 28, 42.9871, true), (66, 28, 59.3143, true), (41, 28, 41.5807, true), (61, 28, 96.3533, true), (72, 29, 75.2092, true), (61, 29, 2.775, true), (75, 29, 24.766, true), (51, 29, 90.7301, true), (65, 29, 52.7484, true), (50, 29, 79.9887, true), (59, 30, 5.6025, true), (53, 30, 1.2683, true), (67, 30, 21.1192, true), (61, 30, 25.0288, true), (57, 30, 50.8476, true), (37, 30, 58.8118, true), (62, 31, 49.5665, true), (74, 31, 74.1959, true), (39, 31, 76.9528, true), (69, 31, 51.3388, true), (68, 32, 51.7486, true), (60, 32, 95.9811, true), (52, 32, 86.3791, true), (66, 32, 63.6249, true), (65, 32, 98.9837, true), (55, 32, 73.0134, true), (42, 32, 35.7306, true), (50, 33, 72.522, true), (66, 33, 91.0691, true), (71, 33, 55.6599, true), (44, 33, 20.6822, true), (42, 33, 29.2468, true), (65, 33, 21.3994, true), (45, 33, 11.7418, true), (59, 34, 81.17, true), (37, 34, 4.8771, true), (66, 34, 98.7643, true), (65, 34, 67.1034, true), (46, 34, 52.9348, true), (49, 35, 30.0369, true), (47, 35, 15.3745, true), (44, 35, 89.9435, true), (65, 35, 82.1551, true), (68, 35, 63.0096, true), (72, 35, 52.0288, true), (46, 35, 56.3996, true), (56, 36, 92.0005, true), (61, 36, 91.1479, true), (58, 36, 9.8057, true), (48, 36, 64.3912, true), (72, 36, 2.5676, true), (57, 37, 9.1647, true), (42, 37, 40.3927, true), (75, 37, 87.0332, true), (46, 37, 22.8238, true), (71, 37, 85.1436, true), (48, 37, 26.8455, true), (51, 38, 26.6396, true), (47, 38, 41.5247, true), (58, 38, 90.4248, true), (46, 38, 28.8003, true), (72, 38, 58.6725, true), (54, 38, 20.4325, true), (68, 39, 48.9109, true), (42, 39, 70.6548, true), (45, 39, 92.6905, true), (55, 39, 13.139, true), (63, 40, 50.7823, true), (44, 40, 67.6689, true), (40, 40, 3.8935, true), (74, 40, 61.4717, true), (72, 40, 68.4925, true), (52, 40, 59.1904, true), (101, 1, 83.5596, true), (80, 1, 4.9399, true), (103, 1, 62.9406, true), (93, 1, 74.6549, true), (111, 1, 20.1052, true), (79, 2, 54.834, true), (98, 2, 94.1387, true), (101, 2, 6.0369, true), (97, 2, 54.2788, true), (88, 2, 49.7251, true), (95, 2, 84.025, true), (109, 3, 40.5075, true), (80, 3, 86.2559, true), (89, 3, 78.0001, true), (84, 3, 73.8356, true), (110, 4, 81.0042, true), (76, 4, 53.5481, true), (87, 4, 47.9098, true), (83, 4, 0.4322, true), (100, 4, 41.1444, true), (89, 4, 55.4316, true), (100, 5, 12.5569, true), (76, 5, 58.1785, true), (97, 5, 78.6282, true), (84, 5, 23.3827, true), (106, 6, 34.3566, true), (89, 6, 34.2112, true), (86, 6, 38.2213, true), (108, 6, 13.5533, true), (110, 6, 52.306, true), (103, 6, 14.9049, true), (76, 7, 26.2498, true), (99, 7, 6.1751, true), (84, 7, 53.871, true), (107, 7, 33.3778, true), (109, 8, 70.844, true), (114, 8, 19.8592, true), (83, 8, 14.1761, true), (94, 8, 49.365, true), (82, 8, 83.0445, true), (81, 8, 34.9555, true), (85, 8, 37.5819, true), (96, 9, 41.3196, true), (109, 9, 33.297, true), (93, 9, 68.3686, true), (103, 9, 77.3306, true), (92, 9, 20.2832, true), (94, 9, 82.2573, true), (107, 10, 23.1127, true), (84, 10, 4.1823, true), (78, 10, 18.2488, true), (81, 10, 66.0916, true), (104, 10, 51.5847, true), (82, 10, 70.2065, true), (79, 10, 15.0684, true), (79, 11, 75.6357, true), (76, 11, 14.3818, true), (88, 11, 96.6123, true), (104, 11, 3.6975, true), (112, 11, 3.735, true), (104, 12, 41.0155, true), (91, 12, 93.1344, true), (80, 12, 13.8795, true), (112, 12, 14.4768, true), (109, 12, 69.1035, true), (107, 13, 67.6358, true), (105, 13, 89.5798, true), (103, 13, 37.0111, true), (90, 13, 20.644, true), (83, 13, 15.6127, true), (104, 13, 4.6737, true), (110, 14, 51.2886, true), (113, 14, 93.5079, true), (85, 14, 24.8316, true), (78, 14, 40.1688, true), (96, 14, 3.0259, true), (110, 15, 48.2867, true), (77, 15, 91.4845, true), (109, 15, 20.4457, true), (84, 15, 56.1349, true), (92, 16, 40.2258, true), (97, 16, 74.3702, true), (95, 16, 32.9509, true), (93, 16, 90.2156, true), (96, 16, 91.0404, true), (106, 17, 35.3767, true), (84, 17, 13.8874, true), (96, 17, 90.8842, true), (97, 17, 62.0517, true), (82, 17, 69.5387, true), (99, 17, 50.652, true), (101, 18, 57.2285, true), (90, 18, 26.7234, true), (111, 18, 90.438, true), (107, 18, 52.8144, true), (101, 19, 99.5959, true), (78, 19, 54.7802, true), (84, 19, 6.1338, true), (94, 19, 63.8044, true), (81, 19, 95.9437, true), (82, 20, 57.7221, true), (102, 20, 74.3161, true), (78, 20, 8.554, true), (91, 20, 70.5088, true), (90, 20, 73.5633, true), (79, 20, 11.695, true), (80, 21, 62.3447, true), (83, 21, 62.334, true), (82, 21, 88.8038, true), (108, 21, 59.5978, true), (90, 21, 73.3476, true), (92, 21, 67.4141, true), (95, 22, 36.5281, true), (88, 22, 30.3872, true), (91, 22, 17.9203, true), (100, 22, 7.7227, true), (87, 22, 36.8989, true), (102, 22, 21.2462, true), (99, 23, 73.4218, true), (98, 23, 81.2995, true), (88, 23, 45.5239, true), (87, 23, 62.5516, true), (113, 23, 81.829, true), (94, 23, 64.2221, true), (82, 24, 65.9073, true), (79, 24, 39.7756, true), (113, 24, 90.1789, true), (107, 24, 29.5309, true), (90, 24, 57.3393, true), (76, 24, 47.533, true), (102, 25, 4.9729, true), (95, 25, 52.0161, true), (92, 25, 52.3593, true), (98, 25, 61.3013, true), (92, 26, 58.3121, true), (87, 26, 16.4933, true), (98, 26, 29.9874, true), (101, 26, 54.41, true), (106, 26, 57.9832, true), (94, 27, 85.016, true), (88, 27, 43.1592, true), (77, 27, 0.5627, true), (99, 27, 95.9771, true), (91, 27, 60.5719, true), (83, 27, 84.9334, true), (89, 28, 43.4937, true), (93, 28, 63.318, true), (105, 28, 42.6206, true), (98, 28, 45.8765, true), (104, 29, 92.5793, true), (101, 29, 5.0833, true), (107, 29, 15.6112, true), (88, 29, 44.6084, true), (82, 29, 71.1625, true), (76, 29, 24.4081, true), (96, 30, 97.5987, true), (95, 30, 36.744, true), (87, 30, 19.6046, true), (81, 30, 22.4022, true), (79, 30, 91.9296, true), (102, 30, 14.0924, true), (95, 31, 28.4126, true), (85, 31, 0.1065, true), (113, 31, 86.3722, true), (96, 31, 28.8958, true), (80, 32, 72.5506, true), (104, 32, 33.8621, true), (88, 32, 16.2917, true), (107, 32, 62.3925, true), (93, 33, 73.8999, true), (98, 33, 76.7519, true), (84, 33, 68.7334, true), (106, 33, 98.7028, true), (80, 33, 42.8996, true), (108, 33, 60.1635, true), (76, 34, 71.4926, true), (101, 34, 84.3317, true), (91, 34, 21.5814, true), (78, 34, 99.945, true), (107, 34, 20.6495, true), (95, 34, 86.8094, true), (85, 35, 68.8396, true), (81, 35, 12.4487, true), (109, 35, 98.9302, true), (101, 35, 23.5933, true), (91, 35, 13.4423, true), (106, 35, 77.7336, true), (92, 35, 70.3406, true), (102, 36, 73.5706, true), (89, 36, 58.3992, true), (92, 36, 53.528, true), (100, 36, 56.058, true), (101, 36, 77.0307, true), (88, 36, 78.3385, true), (80, 36, 6.0234, true), (104, 37, 84.7173, true), (107, 37, 73.8315, true), (77, 37, 69.6897, true), (91, 37, 4.2872, true), (96, 38, 95.2996, true), (92, 38, 21.3419, true), (108, 38, 66.9775, true), (102, 38, 71.16, true), (82, 38, 3.6082, true), (77, 38, 74.3106, true), (103, 39, 21.3193, true), (109, 39, 27.8048, true), (111, 39, 81.4783, true), (98, 39, 18.7035, true), (89, 39, 9.4373, true), (96, 39, 73.8768, true), (101, 40, 11.6859, true), (106, 40, 9.5915, true), (89, 40, 57.0347, true), (105, 40, 25.9334, true), (123, 1, 61.9946, true), (121, 1, 8.8106, true), (149, 1, 4.0453, true), (126, 1, 88.953, true), (144, 1, 33.0636, true), (122, 2, 54.2254, true), (119, 2, 34.0924, true), (150, 2, 2.6188, true), (128, 2, 46.2348, true), (124, 2, 23.3415, true), (145, 2, 88.191, true), (116, 3, 77.4963, true), (146, 3, 42.4931, true), (134, 3, 43.9515, true), (137, 3, 21.0266, true), (115, 3, 90.6485, true), (128, 3, 31.7717, true), (126, 4, 7.5997, true), (132, 4, 0.1182, true), (149, 4, 44.8429, true), (147, 4, 21.0512, true), (148, 4, 27.4548, true), (147, 5, 23.9426, true), (124, 5, 65.3054, true), (140, 5, 25.5969, true), (118, 5, 98.9337, true), (131, 5, 60.1556, true), (132, 6, 8.7753, true), (131, 6, 1.9745, true), (133, 6, 84.0184, true), (115, 6, 10.9241, true), (122, 6, 93.8782, true), (142, 6, 27.0427, true), (147, 6, 34.2974, true), (143, 7, 36.2575, true), (150, 7, 59.0902, true), (147, 7, 8.3241, true), (135, 7, 5.1289, true), (119, 7, 75.0518, true), (128, 7, 34.6959, true), (131, 8, 64.8421, true), (123, 8, 66.6769, true), (143, 8, 68.5321, true), (119, 8, 24.4898, true), (139, 8, 53.6017, true), (134, 8, 42.2827, true), (150, 8, 46.8091, true), (133, 9, 55.7549, true), (129, 9, 68.5014, true), (130, 9, 58.282, true), (150, 9, 73.4828, true), (128, 9, 1.2978, true), (124, 9, 86.4596, true), (147, 10, 22.3149, true), (119, 10, 33.0204, true), (143, 10, 89.3351, true), (121, 10, 66.0386, true), (125, 10, 39.8313, true), (146, 11, 29.2972, true), (134, 11, 78.0997, true), (122, 11, 66.3528, true), (126, 11, 39.5141, true), (142, 12, 71.9112, true), (140, 12, 94.2139, true), (137, 12, 54.8797, true), (123, 12, 45.4327, true), (143, 12, 20.0598, true), (149, 12, 97.6572, true), (146, 13, 66.5981, true), (140, 13, 19.9389, true), (127, 13, 25.9394, true), (138, 13, 35.0764, true), (136, 13, 44.8694, true), (123, 13, 74.1419, true), (120, 13, 29.6636, true), (141, 14, 34.788, true), (145, 14, 33.8182, true), (132, 14, 49.4607, true), (140, 14, 26.4253, true), (143, 14, 35.7515, true), (131, 14, 34.9254, true), (146, 15, 34.149, true), (136, 15, 74.4996, true), (121, 15, 56.3491, true), (129, 15, 52.4826, true), (122, 15, 33.6136, true), (129, 16, 94.0924, true), (142, 16, 28.4271, true), (124, 16, 14.6605, true), (128, 16, 81.6952, true), (123, 17, 68.3787, true), (133, 17, 71.0304, true), (137, 17, 51.3848, true), (148, 17, 83.8716, true), (119, 17, 87.1318, true), (150, 18, 27.3078, true), (131, 18, 8.9102, true), (120, 18, 50.4339, true), (135, 18, 0.5424, true), (145, 18, 49.5137, true), (126, 19, 92.2194, true), (139, 19, 56.3739, true), (141, 19, 34.0498, true), (147, 19, 45.1234, true), (133, 19, 51.6669, true), (117, 20, 40.3899, true), (134, 20, 84.8306, true), (119, 20, 45.5705, true), (148, 20, 98.0453, true), (122, 20, 16.5429, true), (142, 20, 92.9081, true), (128, 21, 50.2326, true), (138, 21, 0.4997, true), (124, 21, 16.0931, true), (115, 21, 93.1708, true), (122, 21, 6.0354, true), (119, 21, 26.5583, true), (136, 22, 7.3227, true), (134, 22, 77.8103, true), (133, 22, 4.3313, true), (126, 22, 96.4154, true), (150, 22, 14.2482, true), (146, 23, 85.9237, true), (124, 23, 13.0904, true), (147, 23, 23.125, true), (140, 23, 0.977, true), (149, 23, 87.107, true), (115, 23, 68.8751, true), (117, 24, 0.4962, true), (144, 24, 15.2764, true), (136, 24, 23.9874, true), (127, 24, 12.4793, true), (131, 25, 79.8577, true), (136, 25, 93.0588, true), (150, 25, 87.7115, true), (128, 25, 79.1214, true), (148, 26, 57.5968, true), (131, 26, 59.2228, true), (124, 26, 10.1216, true), (141, 26, 56.9784, true), (138, 26, 76.5756, true), (117, 26, 46.468, true), (119, 27, 82.5068, true), (130, 27, 58.2316, true), (147, 27, 58.725, true), (139, 27, 9.2059, true), (132, 27, 78.2154, true), (126, 28, 96.4332, true), (130, 28, 42.7289, true), (128, 28, 91.0064, true), (134, 28, 78.4476, true), (140, 29, 44.879, true), (119, 29, 88.5535, true), (149, 29, 40.1339, true), (125, 29, 49.1704, true), (145, 29, 24.9237, true), (144, 29, 64.7065, true), (125, 30, 67.4308, true), (119, 30, 78.8456, true), (122, 30, 23.1443, true), (129, 30, 11.2701, true), (134, 30, 24.5289, true), (137, 31, 72.9167, true), (135, 31, 34.5716, true), (121, 31, 58.3414, true), (128, 31, 31.0387, true), (126, 31, 67.9639, true), (125, 32, 77.1941, true), (124, 32, 34.8471, true), (134, 32, 51.7458, true), (143, 32, 87.8276, true), (144, 32, 16.1829, true), (136, 32, 49.2942, true), (116, 32, 84.8945, true), (139, 33, 37.7757, true), (140, 33, 38.2096, true), (135, 33, 16.5947, true), (134, 33, 70.4633, true), (133, 33, 92.828, true), (123, 34, 52.2771, true), (142, 34, 15.1221, true), (136, 34, 7.3293, true), (118, 34, 82.6598, true), (125, 34, 78.6934, true), (133, 34, 78.7907, true), (147, 35, 63.2007, true), (129, 35, 82.9227, true), (119, 35, 72.2425, true), (148, 35, 82.1495, true), (137, 36, 48.8304, true), (128, 36, 9.0605, true), (130, 36, 28.6384, true), (122, 36, 67.2034, true), (135, 36, 18.5778, true), (149, 37, 50.3522, true), (145, 37, 41.4521, true), (125, 37, 54.6083, true), (147, 37, 31.3099, true), (146, 37, 94.9459, true), (130, 37, 94.2418, true), (125, 38, 96.9192, true), (127, 38, 80.6616, true), (128, 38, 51.3309, true), (119, 38, 77.297, true), (127, 39, 62.2254, true), (136, 39, 31.6736, true), (142, 39, 61.7916, true), (137, 39, 29.9721, true), (127, 40, 30.6157, true), (150, 40, 48.465, true), (123, 40, 69.4314, true), (148, 40, 78.1566, true), (130, 40, 26.391, true), (129, 40, 37.6403, true), (173, 1, 46.4988, true), (174, 1, 89.7722, true), (181, 1, 75.7011, true), (178, 1, 88.3104, true), (156, 1, 83.1217, true), (162, 1, 69.742, true), (162, 2, 63.868, true), (153, 2, 5.3356, true), (154, 2, 32.6094, true), (157, 2, 94.5765, true), (170, 2, 36.6727, true), (178, 2, 78.2729, true), (177, 3, 50.1972, true), (183, 3, 64.6905, true), (171, 3, 24.8397, true), (151, 3, 53.4821, true), (164, 4, 42.7906, true), (161, 4, 66.1537, true), (169, 4, 83.0132, true), (174, 4, 88.394, true), (152, 4, 90.0036, true), (182, 5, 75.9512, true), (154, 5, 93.7297, true), (169, 5, 94.0452, true), (168, 5, 20.1748, true), (179, 6, 25.2269, true), (174, 6, 59.0775, true), (158, 6, 6.11, true), (157, 6, 75.5328, true), (184, 7, 97.4963, true), (166, 7, 76.4962, true), (179, 7, 48.2706, true), (158, 7, 10.8866, true), (151, 7, 75.7968, true), (163, 8, 25.5396, true), (183, 8, 17.4059, true), (158, 8, 92.8709, true), (176, 8, 86.3241, true), (177, 8, 49.4697, true), (162, 9, 14.5022, true), (183, 9, 10.1955, true), (168, 9, 72.8481, true), (157, 9, 99.9428, true), (181, 10, 26.4469, true), (163, 10, 50.7754, true), (152, 10, 33.6824, true), (173, 10, 88.6875, true), (151, 11, 74.9235, true), (185, 11, 90.4883, true), (164, 11, 66.7467, true), (176, 11, 73.6896, true), (167, 11, 7.6128, true), (177, 11, 32.0796, true), (151, 12, 8.8836, true), (183, 12, 36.6202, true), (168, 12, 77.7952, true), (152, 12, 28.6276, true), (163, 12, 0.5705, true), (173, 12, 87.2853, true), (160, 13, 51.7953, true), (173, 13, 65.2482, true), (161, 13, 22.2508, true), (174, 13, 65.7489, true), (156, 13, 28.1115, true), (168, 13, 90.1574, true), (155, 14, 86.6767, true), (165, 14, 78.383, true), (179, 14, 55.0454, true), (180, 14, 45.9146, true), (156, 14, 47.6991, true), (178, 14, 50.3296, true), (176, 14, 77.3532, true), (158, 15, 8.5662, true), (162, 15, 56.5899, true), (167, 15, 62.8315, true), (155, 15, 20.5459, true), (171, 15, 60.3016, true), (172, 16, 18.3242, true), (155, 16, 59.4816, true), (158, 16, 45.0621, true), (179, 16, 69.4666, true), (157, 16, 50.7912, true), (176, 17, 42.1122, true), (163, 17, 29.4779, true), (154, 17, 56.0776, true), (156, 17, 26.4843, true), (182, 17, 4.8047, true), (168, 18, 74.2017, true), (173, 18, 94.3932, true), (155, 18, 37.0372, true), (169, 18, 13.576, true), (157, 18, 46.7131, true), (169, 19, 38.8568, true), (162, 19, 77.2324, true), (166, 19, 82.426, true), (156, 19, 65.9279, true), (174, 19, 77.7577, true), (174, 20, 32.4006, true), (172, 20, 38.1886, true), (181, 20, 84.393, true), (178, 20, 60.4061, true), (175, 20, 36.3422, true), (173, 21, 84.83, true), (184, 21, 25.1726, true), (152, 21, 23.2989, true), (185, 21, 35.3334, true), (181, 21, 54.3998, true), (168, 21, 32.8111, true), (167, 22, 3.0145, true), (155, 22, 98.1619, true), (157, 22, 71.544, true), (154, 22, 40.6912, true), (165, 22, 53.455, true), (175, 22, 50.0821, true), (183, 22, 56.5983, true), (167, 23, 66.7535, true), (184, 23, 70.0923, true), (171, 23, 18.3704, true), (169, 23, 42.2512, true), (175, 23, 23.501, true), (163, 24, 99.8142, true), (185, 24, 88.0115, true), (183, 24, 2.6697, true), (184, 24, 30.0101, true), (161, 24, 10.4827, true), (153, 24, 60.8766, true), (183, 25, 12.7485, true), (152, 25, 79.642, true), (184, 25, 93.274, true), (182, 25, 43.8251, true), (175, 25, 9.9574, true), (155, 25, 9.4682, true), (177, 26, 41.2823, true), (175, 26, 4.7004, true), (154, 26, 75.4881, true), (156, 26, 56.651, true), (174, 26, 64.8439, true), (180, 26, 3.3109, true), (184, 27, 67.7354, true), (154, 27, 55.3737, true), (182, 27, 98.3977, true), (152, 27, 38.3584, true), (153, 28, 71.6811, true), (167, 28, 1.697, true), (172, 28, 75.3798, true), (164, 28, 75.9427, true), (165, 28, 67.3037, true), (174, 29, 71.1594, true), (158, 29, 81.0916, true), (173, 29, 37.7381, true), (160, 29, 30.5178, true), (178, 29, 54.0449, true), (164, 30, 57.288, true), (158, 30, 25.7372, true), (184, 30, 60.0592, true), (172, 30, 20.7547, true), (156, 30, 9.125, true), (166, 30, 2.7792, true), (173, 30, 50.193, true), (168, 31, 95.6983, true), (151, 31, 56.8832, true), (158, 31, 96.7719, true), (181, 31, 4.8776, true), (183, 31, 5.3681, true), (176, 32, 30.2607, true), (185, 32, 69.6477, true), (165, 32, 57.8057, true), (157, 32, 47.5523, true), (156, 33, 72.0395, true), (181, 33, 99.5588, true), (171, 33, 48.2007, true), (169, 33, 27.5041, true), (170, 34, 20.8109, true), (154, 34, 75.3404, true), (164, 34, 56.7729, true), (160, 34, 76.9572, true), (167, 35, 24.3184, true), (178, 35, 17.5841, true), (152, 35, 80.0107, true), (155, 35, 66.2442, true), (163, 35, 36.0593, true), (181, 36, 64.4457, true), (155, 36, 88.4515, true), (169, 36, 42.8878, true), (160, 36, 22.9926, true), (164, 36, 56.8328, true), (164, 37, 48.3161, true), (163, 37, 25.229, true), (174, 37, 67.646, true), (159, 37, 74.2168, true), (157, 37, 19.5773, true), (177, 38, 4.2825, true), (172, 38, 98.3526, true), (160, 38, 43.1496, true), (175, 38, 86.2141, true), (184, 38, 62.6635, true), (185, 39, 60.6287, true), (164, 39, 1.9444, true), (159, 39, 36.8849, true), (181, 39, 69.0011, true), (167, 39, 7.2229, true), (164, 40, 31.2014, true), (172, 40, 63.9869, true), (168, 40, 71.188, true), (170, 40, 50.5695, true), (184, 40, 62.4955, true), (180, 40, 50.2937, true), (186, 1, 25.1728, true), (202, 1, 90.1662, true), (216, 1, 37.5428, true), (196, 1, 76.532, true), (215, 1, 79.6785, true), (203, 1, 61.0817, true), (207, 1, 58.7228, true), (199, 2, 22.5132, true), (192, 2, 64.9403, true), (210, 2, 81.0781, true), (204, 2, 4.5022, true), (211, 2, 27.3841, true), (194, 2, 10.1176, true), (203, 3, 23.271, true), (205, 3, 56.9344, true), (195, 3, 29.6195, true), (208, 3, 17.3377, true), (187, 3, 12.7665, true), (186, 4, 56.6369, true), (204, 4, 6.8675, true), (209, 4, 71.2285, true), (196, 4, 72.6774, true), (203, 5, 90.729, true), (208, 5, 45.2801, true), (214, 5, 43.0643, true), (199, 5, 97.5468, true), (212, 5, 15.8472, true), (193, 5, 48.0078, true), (206, 5, 11.3192, true), (205, 6, 20.3067, true), (190, 6, 57.5268, true), (203, 6, 20.4234, true), (191, 6, 20.8612, true), (206, 6, 40.4081, true), (197, 6, 41.828, true), (194, 6, 19.0972, true), (189, 7, 43.3217, true), (209, 7, 68.9725, true), (207, 7, 86.6328, true), (217, 7, 73.5789, true), (197, 7, 54.3228, true), (203, 8, 16.1433, true), (198, 8, 27.8637, true), (207, 8, 77.4689, true), (212, 8, 73.2985, true), (197, 8, 44.5108, true), (196, 8, 58.6078, true), (186, 9, 66.2145, true), (217, 9, 50.9819, true), (187, 9, 5.2516, true), (194, 9, 53.3696, true), (216, 10, 5.6894, true), (217, 10, 45.5871, true), (189, 10, 10.0071, true), (195, 10, 31.2792, true), (211, 10, 65.2618, true), (193, 10, 46.0498, true), (186, 10, 56.624, true), (193, 11, 90.8859, true), (217, 11, 13.3422, true), (199, 11, 26.1441, true), (189, 11, 84.4299, true), (215, 11, 46.1795, true), (210, 11, 90.9689, true), (196, 12, 49.325, true), (192, 12, 93.3681, true), (198, 12, 92.185, true), (206, 12, 79.7448, true), (216, 13, 93.8217, true), (212, 13, 32.2069, true), (215, 13, 50.5851, true), (193, 13, 86.1242, true), (204, 13, 43.6915, true), (206, 13, 72.2331, true), (208, 14, 72.6564, true), (200, 14, 19.1026, true), (191, 14, 61.4795, true), (190, 14, 99.3688, true), (201, 15, 68.6667, true), (187, 15, 81.2245, true), (192, 15, 0.7818, true), (207, 15, 37.9536, true), (213, 15, 39.052, true), (203, 15, 45.09, true), (213, 16, 8.8749, true), (189, 16, 91.6171, true), (209, 16, 23.893, true), (194, 16, 25.588, true), (192, 16, 1.8542, true), (191, 17, 55.0939, true), (188, 17, 69.9699, true), (215, 17, 82.2373, true), (201, 17, 74.0632, true), (205, 17, 96.5427, true), (204, 17, 9.2052, true), (206, 18, 29.7721, true), (197, 18, 90.2593, true), (204, 18, 61.5364, true), (188, 18, 87.6254, true), (210, 18, 90.5709, true), (216, 19, 25.8379, true), (211, 19, 13.0073, true), (189, 19, 87.6262, true), (190, 19, 39.1573, true), (205, 19, 12.5072, true), (196, 19, 31.5481, true), (187, 20, 59.3081, true), (193, 20, 85.502, true), (190, 20, 31.8041, true), (192, 20, 89.9026, true), (194, 20, 31.8627, true), (209, 20, 36.3601, true), (193, 21, 6.4343, true), (187, 21, 21.7533, true), (216, 21, 41.4651, true), (210, 21, 86.4701, true), (214, 22, 28.4953, true), (206, 22, 23.843, true), (186, 22, 40.2088, true), (187, 22, 44.0378, true), (193, 22, 57.5373, true), (192, 22, 0.6966, true), (209, 22, 92.3229, true), (194, 23, 24.8602, true), (193, 23, 52.6557, true), (190, 23, 77.8376, true), (199, 23, 18.6846, true), (187, 23, 2.1177, true), (216, 24, 9.8482, true), (190, 24, 84.1682, true), (211, 24, 6.7915, true), (188, 24, 7.2447, true), (203, 25, 48.9518, true), (204, 25, 6.4553, true), (198, 25, 74.1922, true), (190, 25, 94.068, true), (217, 25, 2.1841, true), (200, 26, 21.4106, true), (191, 26, 72.7831, true), (213, 26, 96.8587, true), (198, 26, 96.745, true), (202, 26, 29.2168, true), (195, 26, 91.7202, true), (188, 27, 85.5263, true), (214, 27, 57.8874, true), (186, 27, 75.2045, true), (208, 27, 80.992, true), (210, 27, 33.6262, true), (195, 27, 36.8736, true), (205, 27, 75.9153, true), (195, 28, 89.3315, true), (198, 28, 2.1581, true), (207, 28, 50.2322, true), (194, 28, 43.5374, true), (199, 28, 58.9633, true), (200, 28, 3.1392, true), (215, 29, 94.9802, true), (214, 29, 39.9017, true), (201, 29, 14.8449, true), (196, 29, 21.4551, true), (205, 30, 50.7649, true), (214, 30, 3.7988, true), (202, 30, 86.8125, true), (213, 30, 75.0996, true), (206, 30, 59.0164, true), (196, 30, 86.0053, true), (217, 31, 9.5337, true), (191, 31, 26.0737, true), (192, 31, 18.8607, true), (200, 31, 36.318, true), (198, 31, 85.8644, true), (201, 32, 91.6991, true), (202, 32, 29.208, true), (193, 32, 8.3068, true), (189, 32, 31.8788, true), (205, 32, 26.628, true), (188, 33, 44.38, true), (190, 33, 55.405, true), (217, 33, 43.3576, true), (186, 33, 41.708, true), (189, 33, 55.4089, true), (202, 33, 49.9247, true), (216, 34, 7.48, true), (199, 34, 45.3419, true), (198, 34, 61.9491, true), (203, 34, 65.3944, true), (194, 34, 86.7916, true), (215, 34, 18.3124, true), (188, 35, 45.8289, true), (209, 35, 28.1812, true), (215, 35, 72.8062, true), (217, 35, 80.7586, true), (212, 35, 91.9941, true), (213, 36, 67.3312, true), (214, 36, 14.3355, true), (188, 36, 38.3435, true), (186, 36, 83.3103, true), (192, 36, 87.1639, true), (195, 37, 39.9044, true), (198, 37, 62.8172, true), (199, 37, 92.4052, true), (210, 37, 66.8325, true), (217, 37, 47.0685, true), (209, 37, 14.6565, true), (202, 37, 71.4927, true), (214, 38, 92.8107, true), (206, 38, 21.7975, true), (196, 38, 38.8951, true), (187, 38, 51.858, true), (202, 39, 41.6245, true), (206, 39, 1.6782, true), (211, 39, 94.7378, true), (189, 39, 9.5009, true), (191, 40, 39.3981, true), (205, 40, 58.1788, true), (206, 40, 7.9488, true), (211, 40, 17.8492, true), (202, 40, 19.7349, true), (194, 40, 88.8928, true), (199, 40, 42.8336, true);


    insert into app_settings (setting_key, setting_value)
      values 
        ('id_active_periode', '{"value": 6}'),
        ('current_phase', '{"value": "registration"}');
  ;


call new_user(
  _username => 'adminzero',
  _password => 'adminzero',
  _tipe_user => 'admin',
  _scopes => '{admin}'::user_scope[],
  _target_id => null
);;

