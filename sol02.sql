USE master;
GO

-- Set the database to single-user mode
ALTER DATABASE Lab02_QLSX
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Drop the database
DROP DATABASE Lab02_QLSX;
GO

----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab02_QLSX -- lenh khai bao CSDL

go

--lenh su dung CSDL
use Lab02_QLSX

go

create table ToSanXuat
(
	MaTSX	char(4) primary key,
	TenTSX	nvarchar(10) not null unique
)

go

--lenh tao cac bang
create table CongNhan
(
	MACN	 char(5) primary key,		
    Ho       nvarchar(30) not null,
    Ten      nvarchar(30) not null,
    Phai     nvarchar(3) not null check (Phai = N'Nam' or Phai = N'Nữ'),
    NgaySinh datetime,
	MaTSX    char(4) NOT NULL references ToSanXuat(MaTSX)
)

go

create table SanPham
(
	MASP	 char(5) primary key,
	TenSP	 nvarchar(30) not null,
	DVT      nvarchar(30) not null,
    TienCong int not null check (TienCong > 0)
)

go

create table ThanhPham
(
	MACN	char(5) not null references CongNhan(MACN),
	MaSP    char(5) not null references SanPham(MaSP),
    Ngay    datetime not null,
    SoLuong int not null check (SoLuong > 0),
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

-- 1
SELECT
	tsx.TenTSX,
	cn.Ho + ' ' + cn.Ten,
	cn.NgaySinh,
	cn.Phai
FROM
	CongNhan AS cn
	JOIN ToSanXuat AS tsx ON cn.MaTSX = tsx.MaTSX
ORDER BY
	tsx.TenTSX,
	cn.Ho,
	cn.Ten;


-- 2
SELECT
	sp.TenSP,
	tp.Ngay,
	tp.SoLuong,
	sp.TienCong * tp.SoLuong
FROM
	ThanhPham AS tp
	JOIN CongNhan AS cn ON tp.MACN = cn.MACN
	JOIN SanPham AS sp ON tp.MaSP = sp.MASP
WHERE
	cn.Ho + ' ' + cn.Ten = N'Nguyễn Trường An';

-- 3
SELECT
	*
FROM
	CongNhan
WHERE
	MACN NOT IN(
		SELECT
			MACN FROM ThanhPham
		WHERE
			MaSP = (
				SELECT
					MaSP FROM SanPham
				WHERE
					TenSP = N'Bình gốm lớn'));

-- 4
SELECT
	*
FROM
	CongNhan
WHERE
	MACN IN(
		SELECT
			MACN FROM ThanhPham
		WHERE
			MaSP IN(
				SELECT
					MaSP FROM SanPham
				WHERE
					TenSP IN(N'Nồi đất', N'Bình gốm nhỏ')));

-- 5
SELECT
	tsx.MaTSX,
	tsx.TenTSX,
	count(*)
FROM
	ToSanXuat AS tsx
	JOIN CongNhan AS cn ON tsx.MaTSX = cn.MaTSX
GROUP BY
	tsx.MaTSX,
	tsx.TenTSX;

-- 6 
WITH tmp AS (
	SELECT
		cn.Ho,
		cn.Ten,
		sp.TenSP,
		tp.SoLuong,
		tp.SoLuong * sp.TienCong AS ThanhTien
	FROM
		ThanhPham AS tp
		JOIN CongNhan AS cn ON tp.MACN = cn.MACN
		JOIN SanPham AS sp ON tp.MaSP = sp.MASP
	GROUP BY
		cn.MACN,
		cn.Ho,
		cn.Ten,
		sp.TenSP,
		tp.SoLuong,
		sp.TienCong
)
SELECT
	tmp.Ho,
	tmp.Ten,
	tmp.TenSP,
	sum(SoLuong),
	sum(ThanhTien)
FROM
	tmp
GROUP BY
	Ho,
	Ten,
	TenSP
ORDER BY
	Ho,
	Ten;

-- 7
SELECT
	SUM(tp.SoLuong * sp.TienCong)
FROM
	ThanhPham AS tp
	JOIN SanPham AS sp ON tp.MaSP = sp.MASP
WHERE
	YEAR(tp.Ngay) = 2007
	AND MONTH(tp.Ngay) = 1;

-- 8
WITH t AS (
	SELECT
		*
	FROM
		ThanhPham AS tp
	WHERE
		YEAR(tp.Ngay) = 2007
		AND MONTH(tp.Ngay) = 2
)
SELECT
	*
FROM
	SanPham
WHERE
	MaSP IN(
		SELECT
			MaSP FROM t
		WHERE
			SoLuong = (
				SELECT
					MAX(SoLuong)
					FROM t));

-- 9 
WITH t AS (
	SELECT
		*
	FROM
		ThanhPham
	WHERE
		MaSP = (
			SELECT
				MaSP
			FROM
				SanPham
			WHERE
				TenSP = N'Chén')
)
SELECT
	*
FROM
	CongNhan
WHERE
	MACN IN(
		SELECT
			MACN FROM t
		WHERE
			SoLuong = (
				SELECT
					MAX(SoLuong)
					FROM t));

-- 10 
SELECT SUM(SoLuong*TienCong) FROM ThanhPham AS tp JOIN SanPham AS sp ON tp.MaSP = sp.MASP WHERE MACN = 'CN002' AND YEAR(tp.Ngay)=2006 AND MONTH(tp.Ngay)=2;

-- 11 
SELECT * FROM CongNhan WHERE MACN IN (SELECT MACN FROM ThanhPham GROUP BY MACN HAVING COUNT(*) >= 3);

-- 12
UPDATE SanPham SET TienCong = TienCong+1000;

-- 13
INSERT INTO CongNhan VALUES('CN006', N'Lê Thị', N'Lan', N'Nữ', '06/06/1999', 'TS02');


-- A.a
IF OBJECT_ID('fn_TotalCongNhanByToSanXuat') IS NOT NULL DROP FUNCTION fn_TotalCongNhanByToSanXuat;
GO
CREATE FUNCTION dbo.fn_TotalCongNhanByToSanXuat
	(@MaTSX char(4))
RETURNS int
AS
BEGIN
	DECLARE @Total int;
	SELECT @Total = COUNT(*) 
	FROM CongNhan
	WHERE MaTSX = @MaTSX;
	RETURN @Total;
END;
GO
SELECT dbo.fn_TotalCongNhanByToSanXuat('TS01');


-- A.b
IF OBJECT_ID('fn_TotalSoLuong') IS NOT NULL DROP FUNCTION fn_TotalSoLuong;
GO
CREATE FUNCTION dbo.fn_TotalSoLuong
	(@MaSP  char(5),
	 @Thang int,
	 @Nam   int)
RETURNS int
AS
BEGIN
	DECLARE @Total int;
	SELECT @Total = SUM(SoLuong)
	FROM ThanhPham
	WHERE MaSP = @MaSP AND MONTH(Ngay) = @Thang AND YEAR(Ngay) = @Nam;
	RETURN @Total;
END;
GO
SELECT dbo.fn_TotalSoLuong('SP001', 1, 2007);

-- A.c 
IF OBJECT_ID('fn_TienLuongThang') IS NOT NULL DROP FUNCTION fn_TienLuongThang;
GO
CREATE FUNCTION dbo.fn_TienLuongThang
	(@MACN  char(5),
	 @Thang int,
	 @Nam   int)
RETURNS int
AS
BEGIN
	DECLARE @Total int;
	SELECT @Total = SUM(tp.SoLuong*sp.TienCong)
	FROM ThanhPham AS tp 
	JOIN SanPham AS sp ON tp.MaSP = sp.MASP 
	WHERE YEAR(tp.Ngay)=@Nam AND MONTH(tp.Ngay)=@Thang AND tp.MACN=@MACN;
	RETURN @Total;
END;
GO
SELECT dbo.fn_TienLuongThang('CN001', 2, 2007);

-- A.d 
IF OBJECT_ID('fn_TongThuNhapTo') IS NOT NULL DROP FUNCTION fn_TongThuNhapTo;
GO
CREATE FUNCTION dbo.fn_TongThuNhapTo
	(@MaTSX  char(5),
	 @Nam   int)
RETURNS int
AS
BEGIN
	DECLARE @Total int;
	SELECT @Total = SUM(tp.SoLuong*sp.TienCong)
	FROM ThanhPham AS tp 
	JOIN SanPham AS sp ON tp.MaSP = sp.MASP 
	JOIN CongNhan AS cn ON tp.MACN = cn.MACN
	WHERE YEAR(tp.Ngay)=@Nam AND cn.MaTSX = @MaTSX;
	RETURN @Total;
END;
GO
SELECT dbo.fn_TongThuNhapTo('TS02', 2007);

-- A.e 
IF OBJECT_ID('fn_TongSoLuongSX') IS NOT NULL DROP FUNCTION fn_TongSoLuongSX;
GO
CREATE FUNCTION dbo.fn_TongSoLuongSX
	(@MaSP  char(5),
	 @From  datetime,
	 @To    datetime)
RETURNS TABLE
AS
RETURN (
	SELECT * 
	FROM ThanhPham 
	WHERE MaSP=@MaSP AND Ngay >= @From AND Ngay <= @To
);
GO
SET dateformat dmy;
SELECT * FROM dbo.fn_TongSoLuongSX('SP001', '01/01/2007', '19/02/2007');




-- B.a
IF OBJECT_ID('PrintCongNhan') IS NOT NULL DROP PROCEDURE PrintCongNhan;
GO
CREATE PROCEDURE dbo.PrintCongNhan
	@MaTSX char(4)
AS
BEGIN
	SELECT * FROM CongNhan WHERE MaTSX = @MaTSX;
END;
GO
EXEC dbo.PrintCongNhan 'TS01';

-- B.b 
IF OBJECT_ID('ChamCong') IS NOT NULL DROP PROCEDURE ChamCong;
GO
CREATE PROCEDURE dbo.ChamCong
	@MACN  char(5),
	@Thang int,
	@Nam   int
AS
BEGIN
	SELECT sp.TenSP, sp.DVT, tp.SoLuong,
		tp.SoLuong*sp.TienCong AS ThanhTien 
		FROM ThanhPham AS tp 
		JOIN SanPham AS sp ON tp.MaSP = sp.MASP 
		WHERE tp.MACN = @MACN AND MONTH(Ngay) = @Thang AND YEAR(Ngay) = @Nam;
END;
GO
EXEC dbo.ChamCong 'CN001', 2, 2007;
