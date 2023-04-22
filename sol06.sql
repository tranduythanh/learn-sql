-- 4a 
ALTER TABLE CaHoc ADD CONSTRAINT CHK_GioBatDauKetThuc CHECK (GioKetThuc >= GioBatDau);

-- 4b 
IF OBJECT_ID('TongSoHVLop') IS NOT NULL DROP FUNCTION TongSoHVLop;
CREATE FUNCTION TongSoHVLop(
	@MaLop char(4)
)
RETURNS INT
AS
BEGIN
	DECLARE @total INT;
	(SELECT @total = COUNT(*) FROM HocVien WHERE MaLop = @MaLop)
	RETURN @total
END;
ALTER TABLE Lop ADD CONSTRAINT CHK_SoHV CHECK (SoHV <= 30 AND SoHV = dbo.TongSoHVLop(MaLop));

-- 4c
IF OBJECT_ID('HocPhiLop') IS NOT NULL DROP FUNCTION HocPhiLop;
CREATE FUNCTION HocPhiLop(
	@MaLop char(4)
)
RETURNS INT 
AS
BEGIN 
	DECLARE @n INT;
	SELECT @n = HocPhi FROM Lop WHERE MaLop = @MaLop
	RETURN @n
END;

SELECT dbo.HocPhiLop('A075');

IF OBJECT_ID('TongTienHV') IS NOT NULL DROP FUNCTION TongTienHV;
CREATE FUNCTION TongTienHV(
	@MSHV char(6)
)
RETURNS INT 
AS
BEGIN 
	DECLARE @n INT;
	SELECT @n = SUM(SoTien) FROM HocPhi WHERE MSHV = @MSHV
	RETURN @n
END;
ALTER TABLE HocPhi DROP CONSTRAINT IF EXISTS CHK_TongTienHV;
ALTER TABLE HocPhi ADD CONSTRAINT CHK_TongTienHV CHECK(dbo.TongTienHV(MSHV) <= dbo.HocPhiLop(LEFT(MSHV, 4)));

-- 5.a 
IF OBJECT_ID('ThemHV') IS NOT NULL DROP PROCEDURE ThemHV;
CREATE PROCEDURE ThemHV
	@MSHV	    char(6),
	@Ho	        nvarchar(30),
	@Ten	    nvarchar(30),
	@NgaySinh	datetime,
	@Phai	    nvarchar(3),
	@MaLop	    char(4)
AS
BEGIN
	BEGIN TRY
	INSERT INTO HocVien (MSHV, Ho, Ten, NgaySinh, Phai, MaLop) VALUES (@MSHV, @Ho, @Ten, @NgaySinh, @Phai, @MaLop)
	END TRY
	BEGIN CATCH
	-- 	do nothing
	END CATCH
END;

-- 5b
IF OBJECT_ID('CapNhatHV') IS NOT NULL DROP PROCEDURE CapNhatHV;
CREATE PROCEDURE CapNhatHV
	@MSHV	    char(6),
	@Ho	        nvarchar(30),
	@Ten	    nvarchar(30),
	@NgaySinh	datetime,
	@Phai	    nvarchar(3),
	@MaLop	    char(4)
AS
BEGIN
	UPDATE HocVien 
		SET Ho = @Ho, 
			Ten = @Ten,
			NgaySinh = @NgaySinh,
			Phai = @Phai,
			MaLop = @MaLop
	WHERE MSHV = @MSHV
END;
EXEC CapNhatHV '123456', N'A', N'B', '1998-06-10', N'Nam', '1234';

-- 5c
IF OBJECT_ID('XoaHV') IS NOT NULL DROP PROCEDURE XoaHV;
CREATE PROCEDURE XoaHV
	@MSHV	    char(6)
AS
BEGIN
	DELETE FROM HocVien WHERE MSHV = @MSHV
END;

-- 5d 
IF OBJECT_ID('CapNhatLop') IS NOT NULL DROP PROCEDURE CapNhatLop;
CREATE PROCEDURE CapNhatLop
	@MaLop	char(4),
	@TenLop	nvarchar(30),
	@NgayKG	datetime,
	@HocPhi	int,
	@Ca	    int,
	@SoTiet	int,
	@SoHV	int,
	@MSGV	char(4)
AS
BEGIN
	UPDATE Lop 
		SET
			TenLop	= @TenLop,
			NgayKG	= @NgayKG,
			HocPhi	= @HocPhi,
			Ca		= @Ca,
			SoTiet	= @SoTiet,
			SoHV	= @SoHV,
			MSGV	= @MSGV
	WHERE MaLop = @MaLop
END;
EXEC CapNhatLop '1234', N'A', '1998-06-10', '123', 1234, 123, 12, '1234';

-- 5e: Xóa 1 lớp học cho trước nếu lớp học này không có học viên.
IF OBJECT_ID('XoaLopTrong') IS NOT NULL DROP PROCEDURE XoaLopTrong;
CREATE PROCEDURE XoaLopTrong
	@MaLop char(4)
AS
BEGIN
	IF (SELECT COUNT(*) FROM HocVien WHERE MaLop = @MaLop) = 0
	BEGIN
		DELETE FROM Lop WHERE MaLop = @MaLop
	END
END;
EXEC XoaLopTrong 'A075';

-- 5f: Lập danh sách học viên của lớp cho trước
IF OBJECT_ID('DanhSachHV') IS NOT NULL DROP PROCEDURE DanhSachHV;
CREATE PROCEDURE DanhSachHV
	@MaLop char(4)
AS
BEGIN
	SELECT * FROM HocVien WHERE MaLop = @MaLop
END;
EXEC DanhSachHV 'A075';

-- 5g: Lập danh sách học viên chưa đóng đủ học phí
IF OBJECT_ID('DanhSachHVNoHP') IS NOT NULL DROP PROCEDURE DanhSachHVNoHP;
CREATE PROCEDURE DanhSachHVNoHP
AS
BEGIN
	SELECT MSHV, Ho, Ten FROM HocVien WHERE MSHV IN (SELECT MSHV FROM HocPhi WHERE dbo.TongTienHV(MSHV) < dbo.HocPhiLop(NoiDung));
END;
EXEC DanhSachHVNoHP;


-- 6a: Cho mã lớp, tính tổng số học phí đã thu
IF OBJECT_ID('DoanhThuLop') IS NOT NULL DROP FUNCTION DoanhThuLop;
CREATE FUNCTION DoanhThuLop(
	@MaLop char(4)
)
RETURNS INT
AS
BEGIN
	DECLARE @total INT;
	SELECT @total = SUM(SoTien) from HocPhi WHERE LEFT(MSHV, 4) = @MaLop
	RETURN @total
END;
SELECT dbo.DoanhThuLop('A075');

-- 6b: Tính tổng số học phí thu được trong khoảng thời gian cho trước.
IF OBJECT_ID('TongHocPhiTrongKhoang') IS NOT NULL DROP FUNCTION TongHocPhiTrongKhoang;
CREATE FUNCTION TongHocPhiTrongKhoang(
	@MaLop char(4),
	@From  datetime, 
	@To    datetime
)
RETURNS INT
AS
BEGIN
	DECLARE @total INT;
	SELECT @total = SUM(SoTien) from HocPhi WHERE LEFT(MSHV, 4) = @MaLop AND NgayThu >= @FROM AND NgayThu <= @To
	RETURN @total
END;
SELECT dbo.TongHocPhiTrongKhoang('A075', '2008-01-02', '2008-12-31');

-- 6c: Cho biết 1 học viên cho trước đã đóng đủ học phí hay chưa.
IF OBJECT_ID('DaDongDuHP') IS NOT NULL DROP FUNCTION DaDongDuHP;
CREATE FUNCTION DaDongDuHP(
	@MSHV char(6)
)
RETURNS BIT
AS
BEGIN
	IF dbo.TongTienHV(@MSHV) < dbo.HocPhiLop(LEFT(@MSHV, 4))
	BEGIN
		RETURN 0;
	END
	RETURN 1;
END;
SELECT dbo.DaDongDuHP('E11403');


-- 6d: Hàm sinh MSHV theo quy tắc MaLop + STT
