USE master;
GO

-- Set the database to single-user mode
ALTER DATABASE Lab03_QLNXHH
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Drop the database
DROP DATABASE Lab03_QLNXHH;
GO

CREATE DATABASE Lab03_QLNXHH

go
use Lab03_QLNXHH


CREATE TABLE HangHoa (
    MAHH varchar(5) PRIMARY KEY,
    TENHH varchar(40) NOT NULL,
    DVT nvarchar(10),
    SOLUONGTON int CHECK (SOLUONGTON >= 0)
);


CREATE TABLE DoiTac (
    MADT char(5) PRIMARY KEY,
    TENDT nvarchar(30) NOT NULL,
    DIACHI nvarchar(40) NOT NULL,
    DIENTHOAI varchar(12),
    CONSTRAINT CHK_DIENTHOAI CHECK (DIENTHOAI LIKE '[0-9]%')
);


SET DATEFORMAT dmy;
CREATE TABLE HoaDon (
    SOHD char(5) PRIMARY KEY,
    NGAYLAPHD datetime,
    MADT char(5) REFERENCES DoiTac(MADT),
    TONGTG int,
    CONSTRAINT CHK_NGAYLAPHD CHECK (NGAYLAPHD <= GETDATE())
);


CREATE TABLE KhaNangCC (
    MADT char(5) REFERENCES DoiTac(MADT),
    MAHH varchar(5) REFERENCES HangHoa(MAHH),
    PRIMARY KEY(MADT, MAHH)
);


CREATE TABLE CT_HoaDon (
    SOHD char(5) REFERENCES HoaDon(SOHD),
    MAHH varchar(5) REFERENCES HangHoa(MAHH),
    DONGIA int,
    SOLUONG int,
    PRIMARY KEY (SOHD, MAHH),
    CONSTRAINT CHK_DONGIA CHECK (DONGIA > 0),
    CONSTRAINT CHK_SOLUONG CHECK (SOLUONG > 0)
);

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
insert into CT_HoaDon values('X0001','CPU01',67,2)
insert into CT_HoaDon values('X0001','HDD03',100,2)
insert into CT_HoaDon values('X0001','KB01', 5,2)
insert into CT_HoaDon values('X0001','MB02', 62,1)
insert into CT_HoaDon values('X0002','CPU01',67,1)
insert into CT_HoaDon values('X0002','KB02', 7,3)
insert into CT_HoaDon values('X0002','MNT01',115,2)
insert into CT_HoaDon values('X0003','CPU01',67,1)
insert into CT_HoaDon values('X0003','MNT03',115,2)

SELECT * FROM CT_HoaDon

-- 1.
SELECT * FROM HangHoa WHERE MAHH LIKE 'HDD%';

-- 2.
SELECT * FROM HangHoa WHERE SOLUONGTON > 10;

-- 3.
SELECT * FROM DoiTac WHERE DIACHI LIKE '%TP.HCM%';

-- 4.
SELECT
	hd.SOHD,
	hd.NGAYLAPHD,
	dt.TENDT, 
	dt.DIACHI, 
	dt.DIENTHOAI, 
	(SELECT COUNT(*) FROM CT_HoaDon WHERE (SOHD = hd.SOHD))
FROM
	HoaDon AS hd JOIN DoiTac AS dt ON hd.MADT = dt.MADT
WHERE
	hd.SOHD LIKE 'N%' AND
	MONTH(hd.NGAYLAPHD) = 5
	AND YEAR(hd.NGAYLAPHD) = 2006;

-- 5
SELECT * FROM DoiTac WHERE MADT IN (
	SELECT MADT FROM KhaNangCC WHERE MAHH LIKE 'HDD%'
);

-- 6
SELECT
	dt.TENDT
FROM
	KhaNangCC as kncc join DoiTac as dt ON dt.MADT = kncc.MADT
WHERE
	MAHH LIKE 'HDD%'
GROUP BY
	dt.MADT, dt.TENDT
HAVING
	COUNT(MAHH) = (
		SELECT
			COUNT(MAHH)
		FROM
			HangHoa
		WHERE
			MAHH LIKE 'HDD%');

-- 7. Cho biết tên nhà cung cấp không cung cấp đĩa cứng
SELECT TENDT FROM DoiTac WHERE MADT NOT IN (SELECT MADT FROM KhaNangCC WHERE MAHH LIKE 'HDD%');

-- 8. Cho biết thông tin của mặt hàng chưa bán được
SELECT * FROM HangHoa WHERE MAHH NOT IN (SELECT DISTINCT(MAHH) FROM CT_HoaDon WHERE SOHD LIKE 'X%');

-- 9. Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất
WITH ThongKe AS (SELECT MAHH, SUM(SOLUONG) as TongSL FROM CT_HoaDon WHERE SOHD LIKE 'X%' GROUP BY MAHH)
SELECT hh.TENHH, tk.TongSL 
	FROM HangHoa AS hh 
	JOIN ThongKe AS tk ON tk.MAHH = hh.MAHH
	WHERE TongSL = (SELECT MAX(TongSL) FROM ThongKe);

-- 10. Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
WITH ThongKe AS (SELECT MAHH, SUM(SOLUONG) AS TongSL from CT_HoaDon WHERE SOHD LIKE 'N%' GROUP BY MAHH)
SELECT hh.TENHH, tk.TongSL 
	FROM HangHoa AS hh
	JOIN ThongKe AS tk ON tk.MAHH = hh.MAHH
	WHERE TongSL = (SELECT MIN(TongSL) FROM ThongKe);

-- 11. Cho biết hóa đơn nhập nhiều mặt hàng nhất
WITH ThongKe AS (SELECT SOHD, COUNT(MAHH) AS SLMH from CT_HoaDon WHERE SOHD LIKE 'N%' GROUP BY SOHD)
SELECT * from HoaDon 
	WHERE SOHD IN (
		SELECT SOHD FROM ThongKe WHERE SLMH = (SELECT MAX(SLMH) FROM ThongKe)
	);

-- 12. Cho biết mặt hàng k được nhập trong tháng 01/2006
SELECT * FROM HangHoa WHERE MAHH IN (
	SELECT MAHH FROM CT_HoaDon WHERE SOHD NOT IN (
		SELECT SOHD FROM HoaDon WHERE SOHD LIKE 'N%' AND MONTH(NGAYLAPHD)=1 AND YEAR(NGAYLAPHD)=2006
	)
);

-- 13. Cho biết các mặt hàng không bán được trong tháng 06/2006
SELECT * FROM HangHoa WHERE MAHH IN (
	SELECT MAHH FROM CT_HoaDon WHERE SOHD NOT IN (
		SELECT SOHD FROM HoaDon WHERE SOHD LIKE 'X%' AND MONTH(NGAYLAPHD)=6 AND YEAR(NGAYLAPHD)=2006
	)
);

-- 14. Cho biết cửa hàng bán bao nhiêu mặt hàng
SELECT COUNT(DISTINCT(MAHH)) FROM CT_HoaDon;

-- 15. Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
SELECT MADT, COUNT(MAHH) FROM KhaNangCC GROUP BY MADT;


-- 16. Cho biết thông tin khách hàng có nhiều giao dịch với cửa hàng nhất
WITH ThongKe AS (SELECT MADT, COUNT(*) AS SLGD FROM HoaDon GROUP BY MADT) 
SELECT * FROM DoiTac WHERE MADT IN (SELECT MADT FROM ThongKe WHERE SLGD = (
	SELECT MAX(SLGD) FROM ThongKe
));

-- 17. Tính tổng doanh thu năm 2006
SELECT SUM(DONGIA*SOLUONG) AS SoTien FROM CT_HoaDon WHERE SOHD LIKE 'X%';

-- 18. Cho biết loại mặt hàng bán chạy nhất
WITH ThongKe AS (SELECT LEFT(MAHH, LEN(MAHH)-2) AS Loai, SUM(SOLUONG) TongSL FROM CT_HoaDon WHERE SOHD LIKE 'X%' GROUP BY LEFT(MAHH, LEN(MAHH)-2))
SELECT * FROM ThongKe WHERE TongSL = (SELECT MAX(TongSL) FROM ThongKe);

-- 19. Liệt kê thông tin bán hàng của tháng 05/2006
WITH ThongKe AS (SELECT *, DONGIA*SOLUONG AS SoTien FROM CT_HoaDon WHERE SOHD IN (
	SELECT SOHD FROM HoaDon WHERE SOHD LIKE 'X%' AND MONTH(NGAYLAPHD)=5 AND YEAR(NGAYLAPHD)=2006
))
SELECT hh.MAHH, hh.TENHH, hh.DVT, SUM(SOLUONG) AS TongSL, SUM(SoTien) AS ThanhTien FROM ThongKe as tk JOIN HangHoa as hh ON hh.MAHH = tk.MAHH GROUP BY hh.MAHH, hh.DVT, hh.TENHH;

-- 20. Liệt kê thông tin của mặt hàng có nhiều người mua nhất
WITH ThongKe AS (SELECT MAHH, COUNT(SOHD) AS SoNM FROM CT_HoaDon WHERE SOHD LIKE 'X%' GROUP BY MAHH)
SELECT * FROM HangHoa WHERE MAHH IN (SELECT MAHH FROM ThongKe WHERE SoNM = (SELECT MAX(SoNM) FROM ThongKe));

-- 21. Tính và cập nhật tổng trị giá của các hóa đơn.
WITH TongKet AS (SELECT SOHD, SUM(DONGIA*SOLUONG) AS TongTG FROM CT_HoaDon GROUP BY SOHD)
UPDATE HoaDon SET HoaDon.TONGTG = TongKet.TongTG FROM HoaDon, TongKet;


-- A.a 
IF OBJECT_ID('TongSoLuongNhap') IS NOT NULL DROP FUNCTION TongSoLuongNhap;
GO
CREATE FUNCTION TongSoLuongNhap(
	@MAHH char(5),
	@From datetime,
	@To   datetime
)
RETURNS INT
AS
BEGIN
	DECLARE @sum INT;
	SELECT @sum = SUM(SOLUONG) FROM CT_HoaDon 
	WHERE 	MAHH = @MAHH AND 
		LEFT(SOHD, 1) = 'N' AND
		SOHD IN (SELECT SOHD FROM HoaDon WHERE NGAYLAPHD >= @From AND NGAYLAPHD <= @To)
	RETURN @sum
END;
GO
SELECT dbo.TongSoLuongNhap('CPU01', '2006/01/01', '2006/07/01');

-- A.b 
IF OBJECT_ID('TongSoLuongXuat') IS NOT NULL DROP FUNCTION TongSoLuongXuat;
GO
CREATE FUNCTION TongSoLuongXuat (
    @MAHH char(5),
    @From datetime,
    @To   datetime
)
RETURNS INT
AS
BEGIN
    DECLARE @sum INT;
    SELECT @sum = SUM(SOLUONG) FROM CT_HoaDon 
    WHERE  MAHH = @MAHH AND 
        LEFT(SOHD, 1) = 'X' AND
        SOHD IN (SELECT SOHD FROM HoaDon WHERE NGAYLAPHD >= @From AND NGAYLAPHD <= @To)
    RETURN @sum;
END;
GO
SELECT dbo.TongSoLuongXuat('CPU01', '2006/01/01', '2006/07/01');

-- A.c 
IF OBJECT_ID('TongDoanhThuThang') IS NOT NULL DROP FUNCTION TongDoanhThuThang;
GO
CREATE FUNCTION TongDoanhThuThang (
    @Thang int,
    @Nam   int
)
RETURNS INT
AS
BEGIN
    DECLARE @sum INT;
    SELECT @sum = ISNULL(SUM(DONGIA*SOLUONG), 0) FROM CT_HoaDon 
    WHERE   LEFT(SOHD, 1)='X' AND 
        SOHD IN (SELECT SOHD FROM HoaDon WHERE MONTH(NGAYLAPHD)=@Thang AND YEAR(NGAYLAPHD)=@Nam)
    RETURN @sum;
END;
GO
SELECT dbo.TongDoanhThuThang(5, 2006);

-- A.d 
IF OBJECT_ID('TongDoanhThuHangHoa') IS NOT NULL DROP FUNCTION TongDoanhThuHangHoa;
GO
CREATE FUNCTION TongDoanhThuHangHoa(
	@MAHH char(5),
	@From datetime,
	@To   datetime
)
RETURNS INT
AS
BEGIN
	DECLARE @sum INT;
	SELECT @sum = ISNULL(SUM(DONGIA*SOLUONG), 0) FROM CT_HoaDon 
	WHERE 	LEFT(SOHD, 1)='X' AND 
		MAHH = @MAHH AND
		SOHD IN (SELECT SOHD FROM HoaDon WHERE NGAYLAPHD >= @From AND NGAYLAPHD <= @To)
	RETURN @sum;
END;
GO
SELECT dbo.TongDoanhThuHangHoa('CPU01', '2006/01/01', '2006/07/01');

-- A.e 
IF OBJECT_ID('TongTienNhapHang') IS NOT NULL DROP FUNCTION TongTienNhapHang;
GO
CREATE FUNCTION TongTienNhapHang (
	@From datetime,
	@To   datetime
)
RETURNS INT
AS
BEGIN
	DECLARE @sum INT;
	SELECT @sum = ISNULL(SUM(DONGIA*SOLUONG), 0) FROM CT_HoaDon 
	WHERE 	LEFT(SOHD, 1)='X' AND 
		SOHD IN (SELECT SOHD FROM HoaDon WHERE NGAYLAPHD >= @From AND NGAYLAPHD <= @To)
	RETURN @sum
END;
GO
SELECT dbo.TongTienNhapHang('2006/01/01', '2006/07/01');

-- A.f
IF OBJECT_ID('TongTienHoaDon') IS NOT NULL DROP FUNCTION TongTienHoaDon;
GO
CREATE FUNCTION TongTienHoaDon (
	@SOHD char(5)
)
RETURNS INT
AS
BEGIN
	DECLARE @sum INT;
	SELECT @sum = ISNULL(SUM(DONGIA*SOLUONG), 0) FROM CT_HoaDon 
	WHERE 	SOHD = @SOHD
	RETURN @sum
END;
GO
SELECT dbo.TongTienHoaDon('N0001');

-- B.a 
IF OBJECT_ID('CapNhatSoLuongTon') IS NOT NULL DROP PROCEDURE CapNhatSoLuongTon;
GO
CREATE PROCEDURE CapNhatSoLuongTon
	@SOHD char(5)
AS
BEGIN
WITH t AS (
	SELECT MAHH, SOLUONG*(CASE WHEN LEFT(SOHD, 1)='N' THEN 1 ELSE -1 END) AS Delta
	FROM CT_HoaDon WHERE SOHD = @SOHD
)
UPDATE HangHoa SET SOLUONGTON = SOLUONGTON+t.Delta FROM t WHERE t.MAHH = HangHoa.MAHH;
END;
GO
EXEC CapNhatSoLuongTon 'N0001';

-- B.b
IF OBJECT_ID('TinhTongTG') IS NOT NULL DROP PROCEDURE TinhTongTG;
GO
CREATE PROCEDURE TinhTongTG
	@SOHD char(5)
AS
BEGIN
UPDATE HoaDon SET TONGTG = (SELECT ISNULL(SUM(DONGIA*SOLUONG), 0) FROM CT_HoaDon WHERE SOHD = @SOHD) WHERE SOHD = @SOHD
END;
GO
EXEC TinhTongTG 'N0001';

-- B.c
IF OBJECT_ID('XuatHoaDon') IS NOT NULL DROP PROCEDURE XuatHoaDon;
GO
CREATE PROCEDURE XuatHoaDon
	@SOHD char(5)
AS
BEGIN
SELECT
	hd.SOHD,
	hd.NGAYLAPHD,
	hd.TONGTG,
	ct.MAHH,
	ct.DONGIA,
	ct.SOLUONG
FROM HoaDon AS hd
JOIN CT_HoaDon AS ct ON hd.SOHD = ct.SOHD
WHERE ct.SOHD = @SOHD
END;
GO
EXEC XuatHoaDon 'N0001';