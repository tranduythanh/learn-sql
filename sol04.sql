USE master;
GO

-- Set the database to single-user mode
ALTER DATABASE Lab04_QLDB
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Drop the database
DROP DATABASE Lab04_QLDB;
GO

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
	SoLuong int CHECK (SoLuong >= 0),
	GiaBan int CHECK (GiaBan >= 0)
)

--2
go
create table PhatHanh
(
	MaBaoTC char(4) references Bao_TChi(MaBaoTC),
	SoBaoTC	int CHECK (SoBaoTC > 0),
	NgayPH datetime CHECK (NgayPH <= GETDATE()),
	primary key (SoBaoTC,MaBaoTC)
)

--3
go
create table KhachHang
(
	MaKH char(4) primary key,
	TenKH nvarchar(10) CHECK (TenKH NOT LIKE '%[0-9]%'),
	DiaChi varchar(10) CHECK (LEN(DiaChi) > 0)
)

--4
go 
create table DatBao
(
	MaKH char(4) references KhachHang(MaKH),
	MaBaoTC char(4) references Bao_TChi(MaBaoTC),
	SLMua int CHECK (SLMua >= 0),
	NgayDM datetime CHECK (NgayDM <= GETDATE()),
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



-- 1
SELECT
	ph.MaBaoTC,
	bt.Ten,
	bt.GiaBan
FROM
	PhatHanh AS ph
	JOIN Bao_TChi AS bt ON ph.MaBaoTC = bt.MaBaoTC
WHERE
	bt.DinhKy = N'Tuần báo';

-- 2
SELECT
	*
FROM
	Bao_TChi
WHERE
	MaBaoTC LIKE 'PN%';

-- 3
SELECT DISTINCT
	(kh.TenKH)
FROM
	DatBao AS db
	JOIN KhachHang AS kh ON db.MaKH = kh.MaKH
WHERE
	db.MaBaoTC LIKE 'PN%';

-- 4. Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ
SELECT DISTINCT
	(kh.TenKH)
FROM
	DatBao AS db
	JOIN KhachHang AS kh ON db.MaKH = kh.MaKH
WHERE
	db.MaBaoTC LIKE 'PN%' GROUP BY kh.MaKH, kh.TenKH HAVING COUNT(DISTINCT(db.MaBaoTC))=(SELECT COUNT(*) FROM Bao_TChi WHERE MaBaoTC LIKE 'PN%');

-- 5. Cho biết các khách hàng KHÔNG đặt mua báo Thanh Niên
SELECT
	*
FROM
	KhachHang
WHERE
	MaKH IN( SELECT DISTINCT
			(MaKH)
			FROM DatBao
		WHERE
			MaBaoTC NOT LIKE 'TN%');

-- 6. Cho biết số tờ báo mà mỗi khách hàng đã đặt mua
SELECT
	db.MaKH,
	kh.TenKH,
	SUM(db.SLMua)
FROM
	DatBao AS db
	JOIN KhachHang AS kh ON db.MaKH = kh.MaKH
GROUP BY
	db.MaKH,
	kh.TenKH;

-- 7. Cho biết số khách hàng đặt mua báo trong năm 2004
SELECT
	COUNT(DISTINCT (MaKH))
FROM
	DatBao
WHERE
	YEAR(NgayDM) = 2004;

-- 8.
SELECT
	kh.TenKH, bt.Ten, bt.DinhKy, db.SLMua, SoLuong*GiaBan AS SoTien
FROM
	DatBao AS db
	JOIN KhachHang AS kh ON kh.MaKH = db.MaKH
	JOIN Bao_TChi AS bt ON db.MaBaoTC = bt.MaBaoTC;

-- 9.
SELECT
	bt.Ten,
	bt.DinhKy,
	SUM(db.SLMua)
FROM
	DatBao AS db
	JOIN Bao_TChi AS bt ON db.MaBaoTC = bt.MaBaoTC
GROUP BY
	db.MaBaoTC,
	bt.Ten,
	bt.DinhKy;

-- 10.
SELECT
	*
FROM
	Bao_TChi
WHERE
	MaBaoTC LIKE 'HS%';

-- 11. Cho biết những tờ báo không có người mua.
SELECT
	*
FROM
	Bao_TChi
WHERE
	MaBaoTC NOT IN(
		SELECT
			MaBaoTC FROM DatBao);

-- 12. Cho biết tên, định kì, của những tờ báo có nhiều người đặt mua nhất. 
WITH ThongKe AS (
	SELECT
		MaBaoTC,
		COUNT(MaKH) AS SLKH
	FROM
		DatBao
	GROUP BY
		MaBaoTC
)
SELECT
	Ten, DinhKy
FROM
	Bao_TChi
WHERE
	MaBaoTC IN(
		SELECT
			MaBaoTC FROM ThongKe
		WHERE
			SLKH = (SELECT MAX(SLKH) FROM ThongKe));


-- 13. Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất WITH ThongKe AS (
WITH ThongKe AS (
	SELECT
		MaKH,
		SUM(SLMua) AS TongSL
	FROM
		DatBao
	GROUP BY
		MaKH
)
SELECT
	*
FROM
	KhachHang
WHERE
	MaKH IN(
		SELECT
			MaKH FROM ThongKe
		WHERE
			TongSL = (
				SELECT
					MAX(TongSL)
					FROM ThongKe));

-- 14. Cho biết các tờ báo phát hành định kì 1 tháng 2 lần
SELECT * FROM Bao_TChi WHERE DinhKy = N'Bán nguyệt san';

-- 15. Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên 
WITH ThongKe AS (SELECT MaBaoTC, COUNT(MaKH) AS SLKH FROM DatBao GROUP BY MaBaoTC)
SELECT * FROM Bao_TChi WHERE MaBaoTC IN (
	SELECT MaBaoTC FROM ThongKe WHERE SLKH >= 3
);



-- A.1 Tính tổng số tiền mua báo/tạp chí của một khách hàng cho trước
IF OBJECT_ID('TongTienMuaBao') IS NOT NULL DROP FUNCTION TongTienMuaBao;
GO
CREATE FUNCTION dbo.TongTienMuaBao (
	@MaKH char(4)
)
RETURNS INT
AS 
BEGIN
	DECLARE @sum INT;
	SELECT @sum = SUM(db.SLMua*btc.GiaBan) FROM DatBao AS db 
	JOIN Bao_TChi AS btc ON db.MaBaoTC = btc.MaBaoTC 
	WHERE MaKH = @MaKH
	RETURN @sum
END;
GO
SELECT dbo.TongTienMuaBao('KH01');


-- A.2 Tính tổng doanh thu của tờ báo/tạp chí cho trước
IF OBJECT_ID('TongDoanhThu') IS NOT NULL DROP FUNCTION TongDoanhThu;
GO
CREATE FUNCTION dbo.TongDoanhThu (
	@MaBaoTC char(4)
)
RETURNS INT
AS 
BEGIN
	DECLARE @sum INT;
	SELECT @sum = SUM(db.SLMua*btc.GiaBan) FROM DatBao AS db 
	JOIN Bao_TChi AS btc ON db.MaBaoTC = btc.MaBaoTC 
	WHERE btc.MaBaoTC = @MaBaoTC;
	RETURN @sum
END;
GO
SELECT dbo.TongDoanhThu('PN01');

-- B.1 In danh mục báo/tạp chí phải giao cho 1 khách hàng cho trước.
IF OBJECT_ID('DanhMucCuaKhach') IS NOT NULL DROP PROCEDURE DanhMucCuaKhach;
GO
CREATE PROCEDURE DanhMucCuaKhach
	@MaKH char(4)
AS
BEGIN
	SELECT * FROM Bao_TChi 
	WHERE MaBaoTC IN (SELECT DISTINCT(MaBaoTC) FROM DatBao WHERE MaKH = @MaKH)
END;
GO
EXEC DanhMucCuaKhach 'KH01';
	

-- B.2 In danh sách khách hàng đặt mua báo/tạp chí cho trước.
IF OBJECT_ID('DSKhachCanGiao') IS NOT NULL DROP PROCEDURE DSKhachCanGiao;
GO
CREATE PROCEDURE DSKhachCanGiao
	@MaBaoTC char(4)
AS
BEGIN
	SELECT * FROM KhachHang 
	WHERE MaKH IN (SELECT DISTINCT(MaKH) FROM DatBao WHERE MaBaoTC = @MaBaoTC)
END;
GO
EXEC DSKhachCanGiao 'PN01';
