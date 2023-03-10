-- Câu a
SELECT
	MANV,
	Ho + ' ' + Ten AS "Họ và tên",
	year(getdate ()) - year(NgayVaoLam) AS "Thâm niên"
FROM
	NhanVien;


-- Câu b
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

-- Câu c
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

-- Câu d
SELECT
	nv.Ho + ' ' + nv.Ten AS "Họ và tên",
	kn.TenKN
FROM
	NhanVien AS nv,
	NhanVienKyNang AS nvkn,
	KyNang AS kn
WHERE
	nv.MANV = nvkn.MANV AND kn.MSKN = nvkn.MSKN AND nv.Ho+' '+nv.Ten = N'Lê Anh Tuấn';