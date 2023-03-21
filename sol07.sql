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

-- 25 =====
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
