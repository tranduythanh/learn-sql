USE master;
GO

-- Set the database to single-user mode
ALTER DATABASE Lab07_QLSV
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Drop the database
DROP DATABASE Lab07_QLSV;
GO

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
	MSLop	 char(4) primary key,
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


-- 1
SELECT MSSV, Ho, Ten, DiaChi FROM SinhVien;

-- 2
SELECT MSSV, Ho, Ten, MSTinh FROM SinhVien ORDER BY MSTinh ASC, Ho ASC, Ten ASC;

-- 3
SELECT sv.* FROM SinhVien AS sv JOIN Tinh AS t ON sv.MSTinh = t.MSTinh WHERE t.TenTinh = N'Long An' AND sv.Phai = 'No';

-- 4
SELECT * FROM SinhVien WHERE month(NgaySinh) = 01;

-- 5
SELECT * FROM SinhVien WHERE MONTH(NgaySinh) = 01 AND DAY(NgaySinh) = 01;

-- 6 
SELECT * FROM SinhVien WHERE DienThoai IS NOT NULL AND DienThoai != '';

-- 7
SELECT * FROM SinhVien WHERE DienThoai IS NOT NULL AND DienThoai LIKE '0%';

-- 8
SELECT * FROM SinhVien WHERE Ten = N'Minh' AND MSLop = '99TH';

-- 9
SELECT * FROM SinhVien WHERE DiaChi LIKE '%Tran Hung Dao%';

-- 10
SELECT * FROM SinhVien WHERE Ho LIKE '% Van %';

-- 11
SELECT
	sv.MSSV,
	sv.Ho + ' ' + sv.Ten AS "Ho Ten",
	YEAR(GETDATE ()) - YEAR(NgaySinh) AS Tuoi
FROM
	SinhVien AS sv
	JOIN Tinh AS t ON sv.MSTinh = t.MSTinh
WHERE
	t.TenTinh = N'Long An';

-- 12
SELECT
	*,
	YEAR(GETDATE ()) - YEAR(NgaySinh) AS Tuoi
FROM
	SinhVien
WHERE
	Phai = 'Yes' 
	AND YEAR(GETDATE ()) - YEAR(NgaySinh) >= 40
	AND YEAR(GETDATE ()) - YEAR(NgaySinh) < 45;

-- 13
SELECT
	*,
	YEAR(GETDATE ()) - YEAR(NgaySinh) AS Tuoi
FROM
	SinhVien
WHERE
	   (Phai = 'Yes'  AND YEAR(GETDATE ()) - YEAR(NgaySinh) >= 40)
	OR (Phai = 'No'   AND YEAR(GETDATE ()) - YEAR(NgaySinh) >= 32)
ORDER BY Phai, Tuoi;

-- 14
SELECT
	*, 
	YEAR(NgayNhapHoc) - YEAR(NgaySinh) as Tuoi
FROM
	SinhVien
WHERE
	YEAR(NgayNhapHoc) - YEAR(NgaySinh) < 19
	OR YEAR(NgayNhapHoc) - YEAR(NgaySinh) > 25
ORDER BY Tuoi;

-- 15
SELECT * FROM SinhVien WHERE MSSV LIKE '99%';

-- 16
SELECT
	sv.MSSV,
	bd.Diem
FROM
	SinhVien AS sv
	JOIN BangDiem AS bd ON sv.MSSV = bd.MSSV
	JOIN MonHoc AS mh ON mh.MSMH = bd.MSMH
WHERE
	bd.LanThi = 1 AND mh.TenMH = 'Co so du lieu' AND sv.MSLop = '99TH';

-- 17
SELECT
	sv.MSSV,
	sv.Ho+' '+sv.Ten as "Ho Ten",
	bd.Diem
FROM
	SinhVien AS sv
	JOIN BangDiem AS bd ON sv.MSSV = bd.MSSV
	JOIN MonHoc AS mh ON mh.MSMH = bd.MSMH
WHERE
	bd.LanThi = 1 AND mh.TenMH = 'Co so du lieu' AND sv.MSLop = '99TH' AND bd.Diem < 5;

-- 18
SELECT
	mh.MSMH,
	mh.TenMH,
	bd.LanThi,
	bd.Diem
FROM
	SinhVien AS sv
	JOIN BangDiem AS bd ON sv.MSSV = bd.MSSV
	JOIN MonHoc AS mh ON mh.MSMH = bd.MSMH
WHERE
	sv.MSSV = '99TH001';

-- 19
SELECT
	sv.MSSV,
	sv.Ho+' '+sv.Ten as "Ho Ten",
	sv.MSLop,
	bd.Diem
FROM
	SinhVien AS sv
	JOIN BangDiem AS bd ON sv.MSSV = bd.MSSV
	JOIN MonHoc AS mh ON mh.MSMH = bd.MSMH
WHERE
	bd.LanThi = 1 AND mh.TenMH = 'Co so du lieu' AND bd.Diem >= 8;

-- 20
SELECT * FROM Tinh WHERE MSTinh NOT IN (SELECT DISTINCT(MSTinh) FROM SinhVien);

-- 21
SELECT * FROM SinhVien WHERE MSSV NOT IN (SELECT DISTINCT(MSSV) FROM BangDiem);

-- 22
SELECT
	l.MSLop,
	l.TenLop,
	count(*) AS SoLuongSV
FROM
	SinhVien AS sv
	JOIN Lop AS l ON l.MSLop = sv.MSLop
GROUP BY
	l.MSLop,
	l.TenLop
ORDER BY count(*);

-- 23
SELECT
	t.MSTinh,
	t.TenTinh,
	COUNT(
		CASE WHEN sv.Phai = 'Yes' THEN
			1
		END) AS "SoSVNam",
	COUNT(
		CASE WHEN sv.Phai = 'No' THEN
			1
		END) AS "SoSVNu"
FROM
	Tinh AS t
	JOIN SinhVien AS sv ON sv.MSTinh = t.MSTinh
GROUP BY
	t.MSTinh,
	t.TenTinh;

-- 24
SELECT
	l.MSLop,
	l.TenLop,
	COUNT(CASE WHEN bd.Diem >= 5 THEN 1 END) AS "SoSVDat",
	CAST(COUNT(CASE WHEN bd.Diem >= 5 THEN 1 END) AS float)/COUNT(*)*100 AS "TiLeDat",
	COUNT(CASE WHEN bd.Diem <  5 THEN 1 END) AS "SoSVKhongDat",
	CAST(COUNT(CASE WHEN bd.Diem <  5 THEN 1 END) AS float)/COUNT(*)*100 AS "TiLeKhongDat"
FROM
	SinhVien AS sv
	JOIN Lop AS l ON l.MSLop = sv.MSLop
	JOIN BangDiem AS bd ON sv.MSSV = bd.MSSV
	JOIN MonHoc AS mh ON mh.MSMH = bd.MSMH
GROUP BY l.MSLop, l.TenLop;

-- 25

SELECT bd.MSSV, bd.MSMH, mh.TenMH, MAX(Diem) as Diem, MAX(Diem)*mh.HeSo AS "Diem x HeSo"
	FROM BangDiem as bd
	JOIN MonHoc as mh ON mh.MSMH = bd.MSMH
GROUP BY bd.MSSV, bd.MSMH, mh.TenMH, mh.HeSo
ORDER BY bd.MSSV;

-- 26 =====
SELECT
	bd.LanThi,
	bd.MSSV,
	mh.MSMH,
	mh.TenMH,
	mh.HeSo,
	MAX(bd.Diem),
	MAX(bd.Diem) * mh.HeSo AS "Diem x HeSO"
FROM
	BangDiem as bd
	JOIN MonHoc as mh ON mh.MSMH = bd.MSMH
GROUP BY bd.LanThi, mh.MSMH, mh.TenMH, mh.HeSo, bd.MSSV;

SELECT
	sv.MSSV,
	sv.Ho,
	sv.Ten,
	(SELECT 
		SUM(DiemLe) / COUNT(DiemLe)
		FROM (
			SELECT MAX(bd2.Diem) * mh2.HeSo AS DiemLe
			FROM BangDiem AS bd2 JOIN MonHoc AS mh2 ON mh2.MSMH = bd2.MSMH 
			WHERE bd2.MSSV = sv.MSSV 
			GROUP BY bd2.MSMH, mh2.HeSo
		) as TongDiem
	) AS DTB
FROM
	SinhVien AS sv
	JOIN BangDiem AS bd ON bd.MSSV = sv.MSSV
GROUP BY sv.MSSV, sv.Ho, sv.Ten
ORDER BY
	sv.MSSV;

-- 27
SELECT l.NienKhoa, k.MSKhoa, k.TenKhoa, COUNT(sv.MSSV)
	FROM SinhVien AS sv
	JOIN Lop AS l ON l.MSLop = sv.MSLop
	JOIN Khoa AS k ON l.MSKhoa = k.MSKhoa
	GROUP BY l.NienKhoa, k.MSKhoa, k.TenKhoa;