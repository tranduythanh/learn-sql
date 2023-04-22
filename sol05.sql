-- a 
SELECT * FROM Tour WHERE TongSoNgay >= 3 AND TongSoNgay <= 5;

-- b
SELECT * FROM Lich_TourDL WHERE YEAR(NgayKhoihanh) = 2017 AND MONTH(NgayKhoihanh) = 2;

-- c 
SELECT ttp.MaTour, ttp.SoNgay, tp.TenTP FROM Tour_TP as ttp JOIN ThanhPho as tp on ttp.MaTP = tp.MaTP 
	WHERE tp.TenTP != N'Nha Trang';

-- d
SELECT MaTour, COUNT(*) AS 'SoLuongTP' FROM Tour_TP GROUP BY MaTour;

-- e
SELECT TenHDV, COUNT(*) AS "SoLuongTour" FROM Lich_TourDL GROUP BY TenHDV;

-- f
WITH tmp AS (
	SELECT
		tp.TenTP,
		COUNT(*) AS "SoTourDiQua"
	FROM
		Tour_TP AS ttp
		JOIN ThanhPho AS tp ON ttp.MaTP = tp.MaTP
	GROUP BY
		tp.MaTP,
		tp.TenTP
)
SELECT * FROM tmp WHERE SoTourDiQua = (SELECT MAX(SoTourDiQua) FROM tmp);

-- g 
SELECT MaTour, COUNT(*) AS "SoLuongTP" FROM Tour_TP GROUP BY MaTour HAVING COUNT(*) = (SELECT COUNT(*) FROM ThanhPho);

-- h
SELECT MaTour, SUM(SoNgay)
FROM Tour_TP 
WHERE MaTour IN (
	SELECT
	ttp.MaTour
	FROM
		Tour_TP AS ttp
		JOIN ThanhPho AS tp ON ttp.MaTP = tp.MaTP
	WHERE tp.TenTP = N'Đà Lạt'
)
GROUP BY MaTour;

-- i 
SELECT * FROM Lich_TourDL WHERE SoNguoi = (SELECT MAX(SoNguoi) FROM Lich_TourDL);

-- j 
SELECT * FROM Tour_TP WHERE MaTour IN (SELECT MaTP FROM Tour_TP GROUP BY MaTP HAVING COUNT(MaTour) = (SELECT COUNT(*) FROM Tour));
