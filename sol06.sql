USE master;
GO

-- Set the database to single-user mode
ALTER DATABASE Lab06_QLHV
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Drop the database
DROP DATABASE Lab06_QLHV;
GO

CREATE DATABASE Lab06_QLHV

GO

use Lab06_QLHV

GO

create table CaHoc
(
	Ca		    int primary key,		
	GioBatDau	time not null,
	GioKetThuc	time not null
)

GO

create table GiaoVien
(
	MSGV		char(4) primary key,		
	HoGV		nvarchar(30) not null,
	TenGV		nvarchar(30) not null,
	DienThoai 	varchar(16)
)

GO

create table Lop
(
	MaLop	char(4) primary key,
	TenLop	nvarchar(30) not null,		
	NgayKG  datetime not null,
	HocPhi	int not null CHECK (HocPhi > 0),
	Ca		int not null FOREIGN KEY REFERENCES CaHoc(Ca),
	SoTiet	int not null CHECK (SoTiet > 0),
	SoHV    int not null,
	MSGV	char(4) FOREIGN KEY REFERENCES GiaoVien(MSGV)
)

GO

create table HocVien
(
	MSHV		char(6) primary key,
	Ho			nvarchar(30) not null,
    Ten			nvarchar(30) not null,
	NgaySinh	datetime not null,
	Phai        nvarchar(3) CHECK (Phai IN (N'Nam', N'Nữ')),
	MaLop		char(4) FOREIGN KEY REFERENCES Lop(MaLop)
)

GO

create table HocPhi
(
	SoBL		char(4) primary key,
	MSHV		char(6) not null FOREIGN KEY REFERENCES HocVien(MSHV),
	NgayThu		datetime not null,
	SoTien		int not null CHECK (SoTien > 0),
	NoiDung		nvarchar(30) not null,
    NguoiThu	nvarchar(30) not null
)

GO

insert into Cahoc values(1,  '7:30', '10:45')
insert into Cahoc values(2, '13:30', '16:45')
insert into Cahoc values(3, '17:30', '20:45')
select * from Cahoc

insert into GiaoVien values('G001', N'Lê Hoàng',    N'Anh',   '858936')
insert into GiaoVien values('G002', N'Nguyễn Ngọc', N'Lan',   '845623')
insert into GiaoVien values('G003', N'Trần Minh',   N'Hùng',  '823456')
insert into GiaoVien values('G004', N'Võ Thanh',    N'Trung', '841256')
select * from GiaoVien

set dateformat dmy
GO
insert into Lop values('E114', 'Excel 3-5-7', '02/01/2008', 120000, 1, 45, 3, 'G003')
insert into Lop values('E115', 'Excel 2-4-6', '22/01/2008', 120000, 3, 45, 0, 'G001')
insert into Lop values('W123', 'Word 2-4-6',  '18/02/2008', 100000, 3, 30, 1, 'G001')
insert into Lop values('W124', 'Word 3-5-7',  '01/03/2008', 100000, 1, 30, 0, 'G002')
insert into Lop values('A075', 'Access 2-4-6','18/12/2008', 150000, 3, 60, 3, 'G003')
select * from Lop

set dateformat dmy
GO
insert into HocVien values('A07501', N'Lê Văn',      N'Minh',  '10/06/1998', N'Nam', 'A075')
insert into HocVien values('A07502', N'Nguyễn Thị',  N'Mai',   '20/04/1998', N'Nữ',  'A075')
insert into HocVien values('A07503', N'Lê Ngọc',     N'Tuấn',  '10/06/1994', N'Nam', 'A075')
insert into HocVien values('E11401', N'Vương Tuấn',  N'Vũ',    '25/03/1999', N'Nam', 'E114')
insert into HocVien values('E11402', N'Lý Ngọc',     N'Hân',   '01/12/1995', N'Nữ',  'E114')
insert into HocVien values('E11403', N'Trần Mai',    N'Linh',  '04/06/1990', N'Nữ',  'E114')
insert into HocVien values('W12301', N'Nguyễn Ngọc', N'Tuyết', '12/05/1996', N'Nữ',  'W123')
select * from HocVien

set dateformat dmy
GO
insert into HocPhi values('0001', 'E11401', '02/01/2008', 120000, 'HP Excel 3-5-7',  N'Vân')
insert into HocPhi values('0002', 'E11402', '02/01/2008', 120000, 'HP Excel 3-5-7',  N'Vân')
insert into HocPhi values('0003', 'E11403', '02/01/2008', 80000,  'HP Excel 3-5-7',  N'Vân')
insert into HocPhi values('0004', 'W12301', '18/02/2008', 100000, 'HP Word 2-4-6',   N'Lan')
insert into HocPhi values('0005', 'A07501', '16/12/2008', 150000, 'HP Access 2-4-6', N'Lan')
insert into HocPhi values('0006', 'A07502', '16/12/2008', 100000, 'HP Access 2-4-6', N'Lan')
insert into HocPhi values('0007', 'A07503', '18/12/2008', 150000, 'HP Access 2-4-6', N'Vân')
insert into HocPhi values('0008', 'A07502', '15/01/2009', 50000,  'HP Access 2-4-6', N'Vân')
select * from HocPhi
----------------------------------------------------------------------

-- 3. Bổ sung thêm các ràng buộc toàn vẹn:

insert into Cahoc values(4,  '7:30', '10:45')
insert into Cahoc values(5, '13:30', '16:45')
insert into Cahoc values(6, '17:30', '20:45')

insert into GiaoVien values('G005', N'Nguyễn Văn',   N'Đức',   '855321')
insert into GiaoVien values('G006', N'Trần Thị',     N'Thúy',  '842556')
insert into GiaoVien values('G007', N'Phạm Thị',     N'Hồng',  '823789')
insert into GiaoVien values('G008', N'Lê Thị',       N'Phương','842196')

-- Set date format to dmy
set dateformat dmy
GO

-- Insert more example data into Lop
insert into Lop values('E116', 'Excel 2-4-6', '15/03/2008', 120000, 1, 45, 2, 'G005')
insert into Lop values('W125', 'Word 3-5-7',  '01/04/2008', 100000, 2, 30, 1, 'G006')
insert into Lop values('A076', 'Access 3-5-7','25/12/2008', 150000, 3, 60, 2, 'G007')

-- Insert more example data into HocVien
insert into HocVien values('E11601', N'Trương Văn',   N'Tuấn', '10/08/1996', N'Nam', 'E116')
insert into HocVien values('E11602', N'Nguyễn Thị',   N'Ly',   '02/11/1997', N'Nữ',  'E116')
insert into HocVien values('W12501', N'Phạm Thị',     N'An',   '05/12/1998', N'Nữ',  'W125')
insert into HocVien values('A07601', N'Lưu Văn',      N'Khoa', '20/07/1995', N'Nam', 'A076')
insert into HocVien values('A07602', N'Trần Thị',     N'Hà',   '15/03/1999', N'Nữ',  'A076')

insert into HocPhi values('0012', 'A07601', '25/12/2008', 10000, 'HP Access 3-5-7', N'Vân')
insert into HocPhi values('0013', 'A07602', '25/12/2008', 10000, 'HP Access 3-5-7', N'Vân')
insert into HocPhi values('0014', 'E11601', '15/04/2008', 4000,  'HP Excel 2-4-6',  N'Lan')
insert into HocPhi values('0015', 'E11602', '15/04/2008', 4000,  'HP Excel 2-4-6',  N'Lan')
insert into HocPhi values('0016', 'W12501', '01/05/2008', 5000,  'HP Word 3-5-7',   N'Vân')
insert into HocPhi values('0017', 'A07601', '25/01/2009', 5000,  'HP Access 3-5-7', N'Vân')
insert into HocPhi values('0018', 'A07602', '25/01/2009', 5000,  'HP Access 3-5-7', N'Vân')


ALTER TABLE GiaoVien DROP CONSTRAINT IF EXISTS UQ_DienThoai;
ALTER TABLE GiaoVien ADD CONSTRAINT UQ_DienThoai UNIQUE (DienThoai);

ALTER TABLE HocVien DROP CONSTRAINT IF EXISTS CHK_NgaySinh;
ALTER TABLE HocVien ADD CONSTRAINT CHK_NgaySinh CHECK (NgaySinh >= '1900-01-01' AND NgaySinh <= CURRENT_TIMESTAMP);

ALTER TABLE Lop DROP CONSTRAINT IF EXISTS CHK_NgayKG;
ALTER TABLE Lop ADD CONSTRAINT CHK_NgayKG CHECK (NgayKG <= CURRENT_TIMESTAMP);

ALTER TABLE HocPhi DROP CONSTRAINT IF EXISTS CHK_NgayThu;
ALTER TABLE HocPhi ADD CONSTRAINT CHK_NgayThu CHECK (NgayThu <= CURRENT_TIMESTAMP);

-- 4a Giờ kết thúc của một ca học không được trước giờ bắt đầu của ca học đó
ALTER TABLE CaHoc DROP CONSTRAINT IF EXISTS CHK_GioBatDauKetThuc;
ALTER TABLE CaHoc ADD CONSTRAINT CHK_GioBatDauKetThuc CHECK (GioKetThuc >= GioBatDau);

-- 4b Sỉ số của một lớp học không quá 30 và đúng bằng số học viên thuộc lớp đó.
IF OBJECT_ID('TongSoHVLop') IS NOT NULL DROP FUNCTION TongSoHVLop;
GO
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

GO

ALTER TABLE Lop ADD CONSTRAINT CHK_SoHV CHECK (SoHV <= 30 AND SoHV = dbo.TongSoHVLop(MaLop));

-- 4.c Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng kí học
GO

IF OBJECT_ID('HocPhiLop') IS NOT NULL DROP FUNCTION HocPhiLop;
GO
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
GO

SELECT dbo.HocPhiLop('A075');
GO

IF OBJECT_ID('TongTienHV') IS NOT NULL DROP FUNCTION TongTienHV;
GO

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
GO

ALTER TABLE HocPhi DROP CONSTRAINT IF EXISTS CHK_TongTienHV;
GO

ALTER TABLE HocPhi ADD CONSTRAINT CHK_TongTienHV CHECK(dbo.TongTienHV(MSHV) <= dbo.HocPhiLop(LEFT(MSHV, 4)));
GO

-- 5.a Thêm dữ liệu vào bảng và đảm bảo các ràng buộc toàn vẹn liên quan.
IF OBJECT_ID('ThemHV') IS NOT NULL DROP PROCEDURE ThemHV;
GO

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
GO

-- 5b Cập nhật thông tin của một học viên cho trước
IF OBJECT_ID('CapNhatHV') IS NOT NULL DROP PROCEDURE CapNhatHV;
GO

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
set dateformat dmy
EXEC CapNhatHV '123456', N'A', N'B', '06/10/1998', N'Nam', '1234';
GO

-- 5c Xóa một học viên cho trước.
IF OBJECT_ID('XoaHV') IS NOT NULL DROP PROCEDURE XoaHV;
GO
CREATE PROCEDURE XoaHV
	@MSHV	    char(6)
AS
BEGIN
	DELETE FROM HocVien WHERE MSHV = @MSHV
END;
GO
-- 5d Cập nhật thông tin của 1 lớp cho trước
IF OBJECT_ID('CapNhatLop') IS NOT NULL DROP PROCEDURE CapNhatLop;
GO

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
GO
set dateformat dmy
EXEC CapNhatLop '1234', N'A', '06/10/1998', '123', 1234, 123, 12, '1234';
GO
-- 5e: Xóa 1 lớp học cho trước nếu lớp học này không có học viên.
IF OBJECT_ID('XoaLopTrong') IS NOT NULL DROP PROCEDURE XoaLopTrong;
GO
CREATE PROCEDURE XoaLopTrong
	@MaLop char(4)
AS
BEGIN
	IF (SELECT COUNT(*) FROM HocVien WHERE MaLop = @MaLop) = 0
	BEGIN
		DELETE FROM Lop WHERE MaLop = @MaLop
	END
END;
GO
EXEC XoaLopTrong 'A075';
GO

-- 5f: Lập danh sách học viên của lớp cho trước
IF OBJECT_ID('DanhSachHV') IS NOT NULL DROP PROCEDURE DanhSachHV;
GO
CREATE PROCEDURE DanhSachHV
	@MaLop char(4)
AS
BEGIN
	SELECT * FROM HocVien WHERE MaLop = @MaLop
END;
GO
EXEC DanhSachHV 'A075';
GO
-- 5g: Lập danh sách học viên chưa đóng đủ học phí của một lớp cho trước
IF OBJECT_ID('DanhSachHVNoHP') IS NOT NULL DROP PROCEDURE DanhSachHVNoHP;
GO
CREATE PROCEDURE DanhSachHVNoHP
	@MaLop char(4)
AS
BEGIN
	SELECT MSHV, Ho, Ten 
	FROM HocVien 
	WHERE MaLop = @MaLop AND
			MSHV IN (SELECT MSHV FROM HocPhi WHERE dbo.TongTienHV(MSHV) < dbo.HocPhiLop(NoiDung));
END;
GO
EXEC DanhSachHVNoHP 'W123';
GO

-- 6a: Cho mã lớp, tính tổng số học phí đã thu khi biết mã lớp
IF OBJECT_ID('DoanhThuLop') IS NOT NULL DROP FUNCTION DoanhThuLop;
GO
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
GO
SELECT dbo.DoanhThuLop('A075');
GO

-- 6b: Tính tổng số học phí thu được trong khoảng thời gian cho trước.
IF OBJECT_ID('TongHocPhiTrongKhoang') IS NOT NULL DROP FUNCTION TongHocPhiTrongKhoang;
GO
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
GO
set dateformat dmy
SELECT dbo.TongHocPhiTrongKhoang('A075', '02/01/2008', '31/12/2008');
GO

-- 6c: Cho biết 1 học viên cho trước đã đóng đủ học phí hay chưa.
IF OBJECT_ID('DaDongDuHP') IS NOT NULL DROP FUNCTION DaDongDuHP;
GO
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
GO
SELECT dbo.DaDongDuHP('E11403');
GO

-- 6d: Hàm sinh MSHV theo quy tắc MaLop + STT của học viên trong lớp đó
IF OBJECT_ID('SinhMAHV') IS NOT NULL DROP FUNCTION SinhMAHV;
GO
CREATE FUNCTION SinhMAHV(
	@MaLop char(4)
)
RETURNS CHAR(6)
AS
BEGIN
	DECLARE @Count INT;
	SELECT @Count = COUNT(*)+1 FROM HocVien WHERE MaLop = @MaLop;
	RETURN CONCAT(@MaLop, RIGHT( REPLICATE('0', 2)+CAST(@Count AS VARCHAR), 2) );
END;
GO
SELECT dbo.SinhMAHV('E114');
GO