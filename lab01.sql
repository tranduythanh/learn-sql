-- Câu 1a
SELECT
	MANV,
	Ho + ' ' + Ten AS "Họ và tên",
	year(getdate ()) - year(NgayVaoLam) AS "Thâm niên"
FROM
	NhanVien;


-- Câu 1b
SELECT
	nv.Ho + ' ' + nv.Ten AS "Họ và tên",
	nv.NgaySinh,
	nv.NgayVaoLam,
	cn.TenCN
FROM
	NhanVien AS nv,
	ChiNhanh AS cn
WHERE
	nv.MSCN = cn.MSCN;

-- Câu 1c
SELECT
	nv.Ho + ' ' + nv.Ten AS "Họ và tên",
	kn.TenKN,
	nvkn.MucDo
FROM
	NhanVien AS nv,
	NhanVienKyNang AS nvkn,
	KyNang AS kn
WHERE
	nv.MANV = nvkn.MANV AND kn.MSKN = nvkn.MSKN;

-- Câu 1d
SELECT
	nv.Ho + ' ' + nv.Ten AS "Họ và tên",
	kn.TenKN
FROM
	NhanVien AS nv,
	NhanVienKyNang AS nvkn,
	KyNang AS kn
WHERE
	nv.MANV = nvkn.MANV AND kn.MSKN = nvkn.MSKN AND nv.Ho+' '+nv.Ten = N'Lê Anh Tuấn';


-- Câu 3a
SELECT
	cn.TenCN AS "Tên kĩ năng",
	count(nv.MANV) AS "Số lượng nhân viên"
FROM
	ChiNhanh AS cn,
	NhanVien AS nv
WHERE
	cn.MSCN = nv.MSCN
GROUP BY
	cn.TenCN;

-- Câu 3b
SELECT
	kn.TenKN AS "Tên kĩ năng",
	count(nvkn.MANV) AS "Số người dùng"
FROM
	KyNang AS kn,
	NhanVienKyNang AS nvkn
WHERE
	kn.MSKN = nvkn.MSKN
GROUP BY
	kn.TenKN;

-- Câu 3c
SELECT
	kn.TenKN AS "Tên kĩ năng",
	count(nvkn.MANV) AS "SoNguoiDung"
FROM
	KyNang AS kn,
	NhanVienKyNang AS nvkn
WHERE
	kn.MSKN = nvkn.MSKN
GROUP BY
	kn.TenKN
HAVING COUNT(nvkn.MANV) >= 3;

-- Câu 3f
SELECT
	nv.MANV, nv.Ho+' '+nv.Ten, COUNT(nvkn.MSKN)
FROM
	NhanVien as nv,
	NhanVienKyNang AS nvkn
WHERE
	nv.MANV = nvkn.MANV
GROUP BY
	nv.MANV, nv.Ho+' '+nv.Ten;
