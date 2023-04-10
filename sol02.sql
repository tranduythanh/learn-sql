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

-- 6 WITH tmp AS (
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
IF OBJECT_ID('sp_TotalCongNhanByToSanXuat', 'P') IS NOT NULL
  DROP PROCEDURE sp_TotalCongNhanByToSanXuat;

CREATE PROCEDURE sp_TotalCongNhanByToSanXuat
	@MaTSX char(4)
AS
BEGIN
	SELECT COUNT(*) AS Total
	FROM CongNhan
	WHERE MaTSX = @MaTSX
END;

EXEC sp_TotalCongNhanByToSanXuat 'TS01';


-- A.b
IF OBJECT_ID('tp_TotalSoluon', 'P') IS NOT NULL
DROP PROCEDURE tp_TotalSoLuong;

CREATE PROCEDURE tp_TotalSoLuong
	@MaSP  char(5),
	@Thang int,
	@Nam   int
AS
BEGIN
	SELECT SUM(SoLuong)
	FROM ThanhPham
	WHERE MaSP = @MaSP AND MONTH(Ngay) = @Thang AND YEAR(Ngay) = @Nam
END;

EXEC tp_TotalSoLuong 'SP001', 1, 2007;

-- A.c 
IF OBJECT_ID('TienLuongThang') IS NOT NULL
DROP PROCEDURE TienLuongThang;

CREATE PROCEDURE TienLuongThang
	@MACN  char(5),
	@Thang int,
	@Nam   int
AS
BEGIN
	SELECT SUM(tp.SoLuong*sp.TienCong)
	FROM ThanhPham AS tp 
	JOIN SanPham AS sp ON tp.MaSP = sp.MASP 
	WHERE YEAR(tp.Ngay)=@Nam AND MONTH(tp.Ngay)=@Thang AND tp.MACN=@MACN
END;

EXEC TienLuongThang 'CN001', 2, 2007;

-- A.d 
IF OBJECT_ID('TongThuNhapTo') IS NOT NULL
DROP PROCEDURE TongThuNhapTo;

CREATE PROCEDURE TongThuNhapTo
	@MaTSX  char(5),
	@Nam   int
AS
BEGIN
	SELECT SUM(tp.SoLuong*sp.TienCong)
	FROM ThanhPham AS tp 
	JOIN SanPham AS sp ON tp.MaSP = sp.MASP 
	JOIN CongNhan AS cn ON tp.MACN = cn.MACN
	WHERE YEAR(tp.Ngay)=@Nam AND cn.MaTSX = @MaTSX
END;

EXEC TongThuNhapTo 'TS02', 2007;

-- A.e 
IF OBJECT_ID('TongSoLuongSX') IS NOT NULL
DROP PROCEDURE TongSoLuongSX;

CREATE PROCEDURE TongSoLuongSX
	@MaSP  char(5),
	@From  datetime,
	@To    datetime
AS
BEGIN
	SELECT * 
	FROM ThanhPham 
	WHERE MaSP=@MaSP AND Ngay >= @From AND Ngay <= @To
END;

EXEC TongSoLuongSX 'SP001', '2007/01/01', '2007/02/19';

;