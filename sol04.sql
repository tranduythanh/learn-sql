-- 1
SELECT
	ph.MaBaoTC,
	bt.Ten,
	bt.GiaBan
FROM
	PhatHanh AS ph
	JOIN Bao_TChi AS bt ON ph.MaBaoTC = bt.MaBaoTC
WHERE
	bt.DinhKy = N 'Tuần báo';

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
SELECT dbo.TongTienMuaBao('KH01');


-- A.2 Tính tổng doanh thu của tờ báo/tạp chí cho trước
IF OBJECT_ID('TongDoanhThu') IS NOT NULL DROP FUNCTION TongDoanhThu;
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
SELECT dbo.TongDoanhThu('PN01');

-- B.1 In danh mục báo/tạp chí phải giao cho 1 khách hàng cho trước.
IF OBJECT_ID('DanhMucCuaKhach') IS NOT NULL DROP PROCEDURE DanhMucCuaKhach;
CREATE PROCEDURE DanhMucCuaKhach
	@MaKH char(4)
AS
BEGIN
	SELECT * FROM Bao_TChi 
	WHERE MaBaoTC IN (SELECT DISTINCT(MaBaoTC) FROM DatBao WHERE MaKH = @MaKH)
END;
EXEC DanhMucCuaKhach 'KH01';
	

-- B.2 In danh sách khách hàng đặt mua báo/tạp chí cho trước.
IF OBJECT_ID('DSKhachCanGiao') IS NOT NULL DROP PROCEDURE DSKhachCanGiao;
CREATE PROCEDURE DSKhachCanGiao
	@MaBaoTC char(4)
AS
BEGIN
	SELECT * FROM KhachHang 
	WHERE MaKH IN (SELECT DISTINCT(MaKH) FROM DatBao WHERE MaBaoTC = @MaBaoTC)
END;
EXEC DSKhachCanGiao 'PN01';
