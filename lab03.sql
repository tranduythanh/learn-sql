/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Trần Đạt Tín
   MSSV: 2011345
   Lớp: TNK44
   Ngày bắt đầu: 14/03/2023
*/	

CREATE DATABASE Lab03_QLNXHH

go
use Lab03_QLNXHH

--1
go 
create table HangHoa
(
	MAHH varchar(5) primary key,
	TENHH varchar(40) not null,
	DVT nvarchar(10),
	SOLUONGTON int,
)

--2
go 
create table DoiTac
(
	MADT char(5) primary key,
	TENDT nvarchar(30) not null,
	DIACHI nvarchar(40) not null,
	DIENTHOAI varchar(12)
)

--3
go 
set dateformat dmy
create table HoaDon
(
	SOHD char(5) primary key,
	NGAYLAPHD datetime,
	MADT char(5) references DoiTac(MADT),
	TONGTG int
)

--4
go 
create table KhaNangCC
(
	MADT char(5) references DoiTac(MADT),
	MAHH varchar(5) references HangHoa(MAHH),
	primary key(MADT,MAHH)
)

--5
go
create table CT_HoaDon
(
	SOHD char(5) references HoaDon(SOHD),
	MAHH varchar(5) references HangHoa(MAHH),
	DONGIA int,
	SOLUONG int,
	primary key (SOHD,MAHH)
)

-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhập dữ liệu cho bảng Hàng Hoá
insert into HangHoa values('CPU01','CPU INTEL, CELERON 600 BOX',N'CÁI',5)
insert into HangHoa values('CPU02','CPU INTEL, PIII 700',       N'CÁI',10)
insert into HangHoa values('CPU03','CPU AMD K7 ATHL,ON 600',    N'CÁI',8)
insert into HangHoa values('HDD01','HDD 10.2 GB QUANTUM',       N'CÁI',10)
insert into HangHoa values('HDD02','HDD 13.6 GB SEAGATE',       N'CÁI',15)
insert into HangHoa values('HDD03','HDD 20 GB QUANTUM',         N'CÁI',6)
insert into HangHoa values('KB01', 'KB GENIUS',                 N'CÁI',12)
insert into HangHoa values('KB02', 'KB MITSUMIMI',              N'CÁI',5)
insert into HangHoa values('MB01', 'GIGABYTE CHIPSET INTEL',    N'CÁI',10)
insert into HangHoa values('MB02', 'ACOPR BX CHIPSET VIA',      N'CÁI',10)
insert into HangHoa values('MB03', 'INTEL PHI CHIPSET INTEL',   N'CÁI',10)
insert into HangHoa values('MB04', 'ECS CHIPSET SIS',           N'CÁI',10)
insert into HangHoa values('MB05', 'ECS CHIPSET VIA',           N'CÁI',10)
insert into HangHoa values('MNT01','SAMSUNG 14" SYNCMASTER',    N'CÁI',5)
insert into HangHoa values('MNT02','LG 14"',                    N'CÁI',5)
insert into HangHoa values('MNT03','ACER 14"',                  N'CÁI',8)
insert into HangHoa values('MNT04','PHILIPS 14"',               N'CÁI',6)
insert into HangHoa values('MNT05','VIEWSONIC 14"',             N'CÁI',7)

SELECT * FROM HangHoa
--DELETE FROM HangHoa

insert into DoiTac values('CC001',N'Cty TNC',N'176 BTX Q1 - TP.HCM',                          '08.8250259')
insert into DoiTac values('CC002',N'Cty Hoàng Long',N'15A TTT Q1 - TP.HCM',                   '08.8250898')
insert into DoiTac values('CC003',N'Cty Hợp Nhất',N'152 BTX Q1 - TP.HCM',                     '08.8252376')
insert into DoiTac values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.Đà Lạt',         '063.831129')
insert into DoiTac values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang',                  '058590270')
insert into DoiTac values('K0003',N'Trần Nhật Duật',N'Lê Lợi TP.Huế',                         '054.848376')
insert into DoiTac values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi Nghĩa - TP.Đà lạt','063.823409')

SELECT * FROM DoiTac
--DELETE FROM DoiTac

set dateformat dmy 
go
insert into HoaDon values('N0001','25/01/2006','CC001',null)
insert into HoaDon values('N0002','01/05/2006','CC002',null)
insert into HoaDon values('X0001','12/05/2006','K0001',null)
insert into HoaDon values('X0002','16/06/2006','K0002',null)
insert into HoaDon values('X0003','20/04/2006','K0001',null)

SELECT * FROM HoaDon

insert into KhaNangCC values('CC001','CPU01')
insert into KhaNangCC values('CC001','HDD03')
insert into KhaNangCC values('CC001','KB01')
insert into KhaNangCC values('CC001','MB02')
insert into KhaNangCC values('CC001','MB04')
insert into KhaNangCC values('CC001','MNT01')
insert into KhaNangCC values('CC002','CPU01')
insert into KhaNangCC values('CC002','CPU02')
insert into KhaNangCC values('CC002','CPU03')
insert into KhaNangCC values('CC002','KB02')
insert into KhaNangCC values('CC002','MB01')
insert into KhaNangCC values('CC002','MB05')
insert into KhaNangCC values('CC002','MNT03')
insert into KhaNangCC values('CC003','HDD01')
insert into KhaNangCC values('CC003','HDD02')
insert into KhaNangCC values('CC003','HDD03')
insert into KhaNangCC values('CC003','MB03')

SELECT * FROM KhaNangCC

insert into CT_HoaDon values('N0001','CPU01',63,10)
insert into CT_HoaDon values('N0001','HDD03',97,7)
insert into CT_HoaDon values('N0001','KB01', 3,5)
insert into CT_HoaDon values('N0001','MB02', 57,5)
insert into CT_HoaDon values('N0001','MNT01',112,3)
insert into CT_HoaDon values('N0002','CPU02',115,3)
insert into CT_HoaDon values('N0002','KB02', 5,7)
insert into CT_HoaDon values('N0002','MNT03',111,5)
insert into CT_HoaDon values('N0002','CPU02',67,2)
insert into CT_HoaDon values('X0001','HDD03',100,2)
insert into CT_HoaDon values('X0001','KB01', 5,2)
insert into CT_HoaDon values('X0001','MB02', 62,1)
insert into CT_HoaDon values('X0002','CPU01',67,1)
insert into CT_HoaDon values('X0002','KB02', 7,3)
insert into CT_HoaDon values('X0002','MNT01',115,2)
insert into CT_HoaDon values('X0003','CPU01',67,1)
insert into CT_HoaDon values('X0003','MNT03',115,2)

SELECT * FROM CT_HoaDon