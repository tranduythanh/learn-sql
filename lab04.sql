/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Trần Đạt Tín
   MSSV: 2011345
   Lớp: TNK44
   Ngày bắt đầu: 14/03/2023
*/	

CREATE DATABASE Lab04_QLDB

go
use Lab04_QLDB

--1
go 
create table Bao_TChi
(
	MaBaoTC char(4) primary key,
	Ten nvarchar(30) not null,
	DinhKy nvarchar(20) not null,
	SoLuong int,
	GiaBan int
)

--2
go
create table PhatHanh
(
	MaBaoTC char(4) references Bao_TChi(MaBaoTC),
	SoBaoTC	int,
	NgayPH datetime,
	primary key (SoBaoTC,MaBaoTC)
)

--3
go
create table KhachHang
(
	MaKH char(4) primary key,
	TenKH nvarchar(10),
	DiaChi varchar(10)
)

--4
go 
create table DatBao
(
	MaKH char(4) references KhachHang(MaKH),
	MaBaoTC char(4) references Bao_TChi(MaBaoTC),
	SLMua int,
	NgayDM datetime,
	primary key(MaKH,MaBaoTC)
)

-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhập dữ liệu cho bảng Bao_TChi
insert into Bao_TChi values('TT01',N'Tuổi Trẻ',N'Nhật Báo',1000,1500)
insert into Bao_TChi values('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san',3000,6000)
insert into Bao_TChi values('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
insert into Bao_TChi values('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
insert into Bao_TChi values('PN02',N'Phụ nữ',N'Nhật báo',1000,4000)


--Nhập dữ liệu cho bảng PhatHanh
set dateformat dmy
go
insert into PhatHanh values('TT01', 123, '15/12/2005')
insert into PhatHanh values('KT01', 70, '15/12/2005')
insert into PhatHanh values('TT01', 124, '16/12/2005')
insert into PhatHanh values('TN01', 256, '17/12/2005')
insert into PhatHanh values('PN01', 45, '23/12/2005')
insert into PhatHanh values('PN02', 111, '18/12/2005')
insert into PhatHanh values('PN02', 112, '19/12/2005')
insert into PhatHanh values('TT01', 125, '17/12/2005')
insert into PhatHanh values('PN01', 46, '30/12/2005')

insert into KhachHang values('KH01', N'LAN', '2 NCT')
insert into KhachHang values('KH02', N'NAM', '32 THĐ')
insert into KhachHang values('KH03', N'NGỌC', '16 LHP')

set dateformat dmy
go
insert into DatBao values('KH01', 'TT01', 100,'12/01/2000')
insert into DatBao values('KH02', 'TN01', 150,'01/05/2001')
insert into DatBao values('KH01', 'PN01', 200,'25/06/2001')
insert into DatBao values('KH03', 'KT01', 200,'17/03/2002')
insert into DatBao values('KH03', 'PN02', 250,'26/08/2003')
insert into DatBao values('KH02', 'TT01', 250,'15/01/2004')
insert into DatBao values('KH01', 'KT01', 300,'14/10/2004')

SELECT * FROM Bao_TChi
SELECT * FROM PhatHanh
SELECT * FROM KhachHang
SELECT * FROM DatBao

