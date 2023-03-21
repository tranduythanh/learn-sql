----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab07_QLSV -- lenh khai bao CSDL

go
--lenh su dung CSDL
use Lab07_QLSV

go

create table Khoa
(
	MSKhoa		char(2) primary key,		
	TenKhoa	varchar(50) not null,
	TenTat	nvarchar(4) not null
)

go

create table Lop

(
	MALop	 char(4) primary key,
	TenLop	 nvarchar(50) not null,		
	MSKhoa   char(2) not null ,
	NienKhoa int
)

go

create table Tinh

(
	MSTinh	 char(2) primary key,
	TenTinh	 nvarchar(30) not null
)

go

create table MonHoc

(
	MSMH	 char(4) primary key,
	TenMH	 nvarchar(50) not null,
	HeSo	 int not null
)

go

create table BangDiem

(
	MSSV	 char(7) not null,
	MSMH	 char(4) not null,
	LanThi	 int     not null,
	Diem	 float   not null
)

go

create table SinhVien
(
	MSSV		char(7) primary key,
	Ho			nvarchar(30) not null,
    Ten			nvarchar(30) not null,
	NgaySinh	datetime not null,
	MSTinh		char(2) not null,
	NgayNhapHoc	datetime not null,
	MSLop		char(4) not null,
	Phai        nvarchar(3),
	DiaChi		nvarchar(50),
	DienThoai   varchar(16)
)

go

insert into Khoa values('01', N'Công nghệ thông tin', 'CNTT')
insert into Khoa values('02', N'Điện tử viễn thông',  'DTVT')
insert into Khoa values('03', N'Quản trị kinh doanh', 'QTKD')
insert into Khoa values('04', N'Công nghệ sinh học',  'CNSH')
select * from Khoa

insert into Lop values('98TH', N'Tin hoc khoa 1998',    '01', 1998)
insert into Lop values('98VT', N'Vien thong khoa 1998', '02', 1998)
insert into Lop values('99TH', N'Tin hoc khoa 1999',    '01', 1999)
insert into Lop values('99VT', N'Vien thong khoa 1999', '02', 1999)
insert into Lop values('99QT', N'Quan tri khoa 1999',   '03', 1999)
select * from Lop

insert into Tinh values('01', N'An Giang')
insert into Tinh values('02', N'TPHCM')
insert into Tinh values('03', N'Dong Nai')
insert into Tinh values('04', N'Long An')
insert into Tinh values('05', N'Hue')
insert into Tinh values('06', N'Ca Mau')
select * from Tinh

insert into MonHoc values('TA01', N'Nhan mon tin hoc',    2)
insert into MonHoc values('TA02', N'Lap trinh co ban',    3)
insert into MonHoc values('TB01', N'Cau truc du lieu',    2)
insert into MonHoc values('TB02', N'Co so du lieu',       2)
insert into MonHoc values('QA01', N'Kinh te vi mo',       2)
insert into MonHoc values('QA02', N'Quan tri chat luong', 3)
insert into MonHoc values('VA01', N'Dien tu co ban',      2)
insert into MonHoc values('VA02', N'Mach so',             3)
insert into MonHoc values('VB01', N'Truyen so lieu',      3)
insert into MonHoc values('XA01', N'Vat ly dai cuong',    2)
select * from MonHoc

insert into BangDiem values('98TH001', 'TA01', 1, 8.5)
insert into BangDiem values('98TH001', 'TA02', 1, 8)
insert into BangDiem values('98TH002', 'TA01', 1, 4)
insert into BangDiem values('98TH002', 'TA01', 2, 5.5)
insert into BangDiem values('98TH001', 'TB01', 1, 7.5)
insert into BangDiem values('98TH002', 'TB01', 1, 8)
insert into BangDiem values('98VT001', 'VA01', 1, 4)
insert into BangDiem values('98VT001', 'VA01', 2, 5)
insert into BangDiem values('98VT002', 'VA02', 1, 7.5)
insert into BangDiem values('99TH001', 'TA01', 1, 4)
insert into BangDiem values('99TH001', 'TA01', 2, 6)
insert into BangDiem values('99TH001', 'TB01', 1, 6.5)
insert into BangDiem values('99TH002', 'TB01', 1, 10)
insert into BangDiem values('99TH002', 'TB01', 1, 9)
insert into BangDiem values('99TH003', 'TA02', 1, 7.5)
insert into BangDiem values('99TH003', 'TB01', 1, 3)
insert into BangDiem values('99TH003', 'TB01', 2, 6)
insert into BangDiem values('99TH003', 'TB02', 1, 8)
insert into BangDiem values('99TH004', 'TB02', 1, 2)
insert into BangDiem values('99TH004', 'TB02', 2, 4)
insert into BangDiem values('99TH004', 'TB02', 3, 3)
insert into BangDiem values('99QT001', 'QA01', 1, 7)
insert into BangDiem values('99QT001', 'QA02', 1, 6.5)
insert into BangDiem values('99QT002', 'QA01', 1, 8.5)
insert into BangDiem values('99QT002', 'QA02', 1, 9)
select * from BangDiem

set dateformat dmy
go
insert into SinhVien values('98TH001', N'Nguyen Van',  N'An',    '06/08/80', '01', '03/09/98', '98TH', 'Yes', '12 Tran Hung Dao, Q.1',   '8234512') 
insert into SinhVien values('98TH002', N'Le Thi',      N'An',    '17/10/79', '01', '03/09/98', '98TH', 'No',  '12 CMT8, Q.Tan Binh',     '0303234342')
insert into SinhVien values('98VT001', N'Nguyen Duc',  N'Binh',  '25/11/81', '02', '03/09/98', '98VT', 'Yes', '12 Lac Long Quan, Q.11',  '8234512') 
insert into SinhVien values('98VT002', N'Tran Ngoc',   N'Anh',   '19/08/80', '02', '03/09/98', '98VT', 'No',  '12 Tran Hung Dao, Q.1',    NULL)
insert into SinhVien values('99TH001', N'Ly Van Hung', N'Dung',  '27/09/81', '03', '05/10/99', '99TH', 'Yes', '12 CMT8, Q.Tan Binh',     '8234512') 
insert into SinhVien values('99TH002', N'Van Minh',    N'Hoang', '01/01/81', '04', '05/10/99', '99TH', 'Yes', '12 Ly Thuong Kiet, Q.10', '8234512') 
insert into SinhVien values('99TH003', N'Nguyen', 	   N'Tuan',  '12/01/80', '03', '05/10/99', '99TH', 'Yes', '12 Tran Hung Dao, Q.5',    NULL)
insert into SinhVien values('99TH004', N'Tran Van',    N'Minh',  '25/06/81', '04', '05/10/99', '99TH', 'Yes', '12 Dien Bien Phu, Q.3',   '8234512') 
insert into SinhVien values('99TH005', N'Nguyen Thai', N'Minh',  '01/01/80', '04', '05/10/99', '99TH', 'Yes', '12 Le Dai Hanh, Q.11',     NULL)
insert into SinhVien values('99VT001', N'Le Ngoc',     N'Mai',   '21/06/82', '01', '05/10/99', '99VT', 'No',  '12 Tran Hung Dao, Q.1',   '0903124534')
insert into SinhVien values('99QT001', N'Nguyen Thi',  N'Oanh',  '19/08/73', '04', '05/10/99', '99QT', 'No',  '12 Hung Vuong, Q.5',      '0901656324')
insert into SinhVien values('99QT002', N'Le My',       N'Thanh', '20/05/76', '04', '05/10/99', '99QT', 'No',  '12 Pham Ngoc Thach, Q.3',  NULL)
select * from SinhVien
----------------------------------------------------------------------
