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
