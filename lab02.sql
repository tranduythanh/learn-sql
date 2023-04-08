----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab02_QLSX -- lenh khai bao CSDL

go

--lenh su dung CSDL
use Lab02_QLSX

go

create table ToSanXuat
(
	MaTSX	char(4) primary key,
	TenTSX	nvarchar(10) not null
)

go

--lenh tao cac bang
create table CongNhan
(
	MACN	 char(5) primary key,		
    Ho       nvarchar(30) not null,
    Ten      nvarchar(30) not null,
    Phai     nvarchar(3) not null,
    NgaySinh datetime,
	MaTSX    char(4) NOT NULL references ToSanXuat(MaTSX)
)

go

create table SanPham
(
	MASP	 char(5) primary key,
	TenSP	 nvarchar(30) not null,
	DVT      nvarchar(30) not null,
    TienCong int not null
)

go

create table ThanhPham
(
	MACN	char(5) not null references CongNhan(MACN),
	MaSP    char(5) not null references SanPham(MaSP),
    Ngay    datetime not null,
    SoLuong int not null,
    primary key (MACN, MaSP, Ngay)
)

set dateformat dmy
go
insert into ToSanXuat values('TS01', 'Tổ 1')
insert into ToSanXuat values('TS02', 'Tổ 2')
select * from ToSanXuat

go

set dateformat dmy
insert into CongNhan values('CN001', N'Nguyễn Trường', N'An',    N'Nam', '12/05/1981', 'TS01')
insert into CongNhan values('CN002', N'Lê Thị Hồng',   N'Gấm',   N'Nữ',  '04/06/1980', 'TS01')
insert into CongNhan values('CN003', N'Nguyễn Công',   N'Thành', N'Nam', '04/05/1981', 'TS02')
insert into CongNhan values('CN004', N'Võ Hữu',        N'Hạnh',  N'Nam', '15/02/1980', 'TS02')
insert into CongNhan values('CN005', N'Lý Thanh',      N'Hân',   N'Nữ',  '03/12/1981', 'TS01')
select * from CongNhan

insert into SanPham values('SP001',N'Nồi Đất',      N'cái', 10000)
insert into SanPham values('SP002',N'Chén',         N'cái', 2000)
insert into SanPham values('SP003',N'Bình gốm nhỏ', N'cái', 20000)
insert into SanPham values('SP004',N'Bình gốm lớn', N'cái', 25000)
select * from SanPham

set dateformat dmy
go
insert into ThanhPham values('CN001', 'SP001', '01/02/2007', 10)
insert into ThanhPham values('CN002', 'SP001', '01/02/2007', 5)
insert into ThanhPham values('CN003', 'SP002', '10/01/2007', 50)
insert into ThanhPham values('CN004', 'SP003', '12/01/2007', 10)
insert into ThanhPham values('CN005', 'SP002', '12/01/2007', 100)
insert into ThanhPham values('CN002', 'SP004', '13/02/2007', 10)
insert into ThanhPham values('CN001', 'SP003', '14/02/2007', 15)
insert into ThanhPham values('CN003', 'SP001', '15/01/2007', 20)
insert into ThanhPham values('CN003', 'SP004', '14/02/2007', 15)
insert into ThanhPham values('CN004', 'SP002', '30/01/2007', 100)
insert into ThanhPham values('CN005', 'SP003', '01/02/2007', 50)
insert into ThanhPham values('CN001', 'SP001', '20/02/2007', 30)
select * from ThanhPham
----------------------------------------------------------------------