create database s04_bt3;
use s04_bt3;
create table vattu(
	ma_vt int primary key auto_increment,
    ten_vt varchar(255)
);
create table phieu_xuat(
	so_px int primary key auto_increment,
    ngay_xuat datetime
);
create table phieu_xuat_chi_tiet(
	so_px int,
    ma_vt int,
    don_gia_xuat double,
    so_luong_xuat int,
    constraint fk_phieu01 foreign key (so_px) references phieu_xuat(so_px),
    constraint fk_phieu02 foreign key (ma_vt) references vattu(ma_vt)
);
create table phieu_nhap(
	so_pn int primary key auto_increment,
    ngay_nhap datetime
);
create table phieu_nhap_chi_tiet(
	so_pn int,
    ma_vt int,
    primary key(so_pn,ma_vt),
    don_gia_nhap double,
    so_luong_nhap int,
    constraint fk_nhap01 foreign key (so_pn) references phieu_nhap(so_pn),
    constraint fk_nhap02 foreign key (ma_vt) references vattu(ma_vt)
);
create table ngay_cung_cap(
	ma_ncc int primary key auto_increment,
    ten_ncc varchar(255),
    dia_chi varchar(255),
    so_dt varchar(11)
);
create table chi_tiet_don_hang(
	ma_vt int,
    so_dh int primary key,
    constraint fk_chi_tiet_don_hang foreign key (ma_vt) references vattu(ma_vt)
);
create table don_dat_hang(
	so_dh int,
    ma_ncc int,
    primary key(so_dh,ma_ncc),
    ngay_dh datetime,
    constraint fk_don01 foreign key (so_dh) references chi_tiet_don_hang(so_dh),
    constraint fk_don02 foreign key (ma_ncc) references ngay_cung_cap(ma_ncc)
);
insert into vattu(ten_vt) values
('Xi Mang'),('Sat'),('Thep'),('Son'),('Dong');
insert into phieu_xuat(ngay_xuat) values
(str_to_date('12/5/1990','%d/%c/%Y')),(str_to_date('10/6/1990','%d/%c/%Y')),(str_to_date('28/4/1990','%d/%c/%Y')),
(str_to_date('15/6/1992','%d/%c/%Y')),(str_to_date('09/8/1994','%d/%c/%Y'));
insert into phieu_xuat_chi_tiet(so_px,ma_vt,don_gia_xuat,so_luong_xuat) values
(1,2,140,3),(1,4,200,2),(2,1,100,5),(3,3,170,1),(5,2,400,4);
insert into chi_tiet_don_hang(ma_vt,so_dh) values
(1,1),(1,2),(4,3),(2,4),(5,5);
insert into phieu_nhap(ngay_nhap) values
(str_to_date('1/5/1990','%d/%c/%Y')),(str_to_date('14/5/1990','%d/%c/%Y')),(str_to_date('12/5/1990','%d/%c/%Y')),
(str_to_date('29/5/1990','%d/%c/%Y')),(str_to_date('17/5/1990','%d/%c/%Y'));
insert into phieu_nhap_chi_tiet(so_pn,ma_vt,don_gia_nhap,so_luong_nhap) values
(1,1,50,4),(1,2,60,2),(2,4,50,7),(5,5,20,4),(4,3,50,4);
insert into ngay_cung_cap(ten_ncc,dia_chi,so_dt) values
('Duc Anh','Lang','1234567'),('Quang Tran','Co Bi','12313'),('Duc Tran','My Dinh','012335'),
('Tac Tran','Thai Binh','091238'),('Vien Nguyen','Hai Duong','09874637');
insert into don_dat_hang(so_dh,ma_ncc,ngay_dh) values
(2,4,str_to_date('12/8/1990','%d/%c/%Y')),(1,3,str_to_date('12/9/1990','%d/%c/%Y')),(1,2,str_to_date('12/4/1990','%d/%c/%Y')),
(3,3,str_to_date('20/9/1990','%d/%c/%Y')),(4,3,str_to_date('12/1/1990','%d/%c/%Y'));

select ten_vt from(select vt.ten_vt from phieu_xuat_chi_tiet as pxct
inner join vattu as vt on vt.ma_vt = pxct.ma_vt
where pxct.so_luong_xuat > 2) as tenvt group by ten_vt;

select ten_vt from(select vt.ten_vt from phieu_xuat_chi_tiet as pxct
inner join vattu as vt on vt.ma_vt = pxct.ma_vt
inner join phieu_xuat as px on px.so_px = pxct.so_px
where px.ngay_xuat = str_to_date('12/5/1990','%d/%c/%Y')) as tenvt group by ten_vt;

select ten_vt from(select vt.ten_vt from phieu_nhap_chi_tiet as pnct
inner join vattu as vt on vt.ma_vt = pnct.ma_vt
where pnct.don_gia_nhap >20) as tenvt group by ten_vt;

select ten_vt from(select vt.ten_vt from phieu_nhap_chi_tiet as pnct
inner join vattu as vt on vt.ma_vt = pnct.ma_vt
where pnct.don_gia_nhap >20) as tenvt group by ten_vt;
insert into phieu_xuat_chi_tiet(so_px,ma_vt,don_gia_xuat,so_luong_xuat) values
(1,2,140,3),(1,4,200,2),(2,1,100,5),(3,3,170,1),(5,2,400,4);

select ten_vt from(
select v.ten_vt from phieu_xuat_chi_tiet as pxct
inner join vattu as v on v.ma_vt = pxct.ma_vt
where pxct.so_luong_xuat > 2) as tenvt  
group by ten_vt;

select * from ngay_cung_cap
where dia_chi = "Thai Binh" AND so_dt LIKE '09%';
