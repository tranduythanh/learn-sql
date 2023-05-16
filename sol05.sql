USE master;
GO

-- Set the database to single-user mode
ALTER DATABASE Lab05_QLDL
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Drop the database
DROP DATABASE Lab05_QLDL;
GO

CREATE DATABASE Lab05_QLDL -- lenh khai bao CSDL

GO
--lenh su dung CSDL
use Lab05_QLDL

GO

--lenh tao cac bang
create table Tour
(
	MaTour		char(4) PRIMARY KEY,		
	TongSoNgay	int CHECK (TongSoNgay > 0)
)

GO

create table ThanhPho
(
	MaTP	char(2) PRIMARY KEY,		
	TenTP	nvarchar(30) not null
)

GO

create table Tour_TP
(
	MaTour	char(4) NOT NULL FOREIGN KEY REFERENCES Tour(MaTour),
	MaTP	char(2) NOT NULL FOREIGN KEY REFERENCES ThanhPho(MaTP),		
	SoNgay	int,
    
    PRIMARY KEY (MaTour, MaTP)
)

GO

create table Lich_TourDL
(
	MaTour			char(4) NOT NULL FOREIGN KEY REFERENCES Tour(MaTour),
	NgayKhoihanh	datetime,		
	TenHDV          nvarchar(30),
	SoNguoi         int,
	TenKH			nvarchar(30),

    PRIMARY KEY (MaTour, NgayKhoihanh)
)

GO

-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhap du lieu cho cac bang
insert into Tour values('T001', 3)
insert into Tour values('T002', 4)
insert into Tour values('T003', 5)
insert into Tour values('T004', 7)

--xem bảng ToSanXuat
select * from Tour

--Nhap bang SamPham
insert into ThanhPho values('01',N'Đà Lạt')
insert into ThanhPho values('02',N'Nha Trang')
insert into ThanhPho values('03',N'Phan Thiết')
insert into ThanhPho values('04',N'Huế')
insert into ThanhPho values('05',N'Đà Nẵng')
--xem bảng SanPham
select * from ThanhPho
--Nhap bang CongNhan
set dateformat dmy
GO
insert into Tour_TP values('T001', '01', 2)
insert into Tour_TP values('T001', '03', 1)
insert into Tour_TP values('T002', '01', 2)
insert into Tour_TP values('T002', '02', 2)
insert into Tour_TP values('T003', '02', 2)
insert into Tour_TP values('T003', '01', 1)
insert into Tour_TP values('T003', '04', 2)
insert into Tour_TP values('T004', '02', 2)
insert into Tour_TP values('T004', '05', 2)
insert into Tour_TP values('T004', '04', 3)
--xem bảng SanPham
select * from Tour_TP
--Nhap bang ThanhPham
set dateformat dmy
GO
insert into Lich_TourDL values('T001','14/02/2017', N'Vân',  20, N'Nguyễn Hoàng')
insert into Lich_TourDL values('T002','14/02/2017', N'Nam',  30, N'Lê Ngọc')
insert into Lich_TourDL values('T002','06/03/2017', N'Hùng', 20, N'Lý Dũng')
insert into Lich_TourDL values('T003','18/02/2017', N'Dũng', 20, N'Lý Dũng')
insert into Lich_TourDL values('T004','18/02/2017', N'Hùng', 30, N'Dũng Nam')
insert into Lich_TourDL values('T003','10/03/2017', N'Nam',  45, N'Nguyễn An')
insert into Lich_TourDL values('T002','28/04/2017', N'Vân',  25, N'Ngọc Dung')
insert into Lich_TourDL values('T004','29/04/2017', N'Dũng', 35, N'Lê Ngọc')
insert into Lich_TourDL values('T001','30/04/2017', N'Nam',  25, N'Trần Nam')
insert into Lich_TourDL values('T003','15/06/2017', N'Vân',  20, N'Trịnh Bá')

select * from Lich_TourDL;
----------------------------------------------------------------------
GO

-- 3: Các thủ tục thêm dữ liệu vào các bản (có kiểm tra ràng buộc trước khi thêm)
CREATE PROCEDURE sp_InsertTour
    @MaTour CHAR(4),
    @TongSoNgay INT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Tour WHERE MaTour = @MaTour)
    BEGIN
        IF @TongSoNgay > 0
        BEGIN
            INSERT INTO Tour (MaTour, TongSoNgay)
            VALUES (@MaTour, @TongSoNgay);
        END
        ELSE
        BEGIN
            PRINT 'Error: TongSoNgay must be greater than 0';
        END
    END
    ELSE
    BEGIN
        PRINT 'Error: MaTour already exists';
    END
END;

GO

CREATE PROCEDURE sp_InsertThanhPho
    @MaTP CHAR(2),
    @TenTP NVARCHAR(30)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM ThanhPho WHERE MaTP = @MaTP)
    BEGIN
        INSERT INTO ThanhPho (MaTP, TenTP)
        VALUES (@MaTP, @TenTP);
    END
    ELSE
    BEGIN
        PRINT 'Error: MaTP already exists';
    END
END;

GO

CREATE PROCEDURE sp_InsertTour_TP
    @MaTour CHAR(4),
    @MaTP CHAR(2),
    @SoNgay INT
AS
BEGIN
    IF EXISTS (SELECT * FROM Tour WHERE MaTour = @MaTour) AND EXISTS (SELECT * FROM ThanhPho WHERE MaTP = @MaTP)
    BEGIN
        IF NOT EXISTS (SELECT * FROM Tour_TP WHERE MaTour = @MaTour AND MaTP = @MaTP)
        BEGIN
            IF @SoNgay > 0
            BEGIN
                INSERT INTO Tour_TP (MaTour, MaTP, SoNgay)
                VALUES (@MaTour, @MaTP, @SoNgay);
            END
            ELSE
            BEGIN
                PRINT 'Error: SoNgay must be greater than 0';
            END
        END
        ELSE
        BEGIN
            PRINT 'Error: The combination of MaTour and MaTP already exists';
        END
    END
    ELSE
    BEGIN
        PRINT 'Error: MaTour or MaTP does not exist';
    END
END;

GO

CREATE PROCEDURE sp_InsertLich_TourDL
    @MaTour CHAR(4),
    @NgayKhoiHanh DATETIME,
    @TenHDV NVARCHAR(30),
    @SoNguoi INT,
    @TenKH NVARCHAR(30)
AS
BEGIN
    IF EXISTS (SELECT * FROM Tour WHERE MaTour = @MaTour)
    BEGIN
        IF NOT EXISTS (SELECT * FROM Lich_TourDL WHERE MaTour = @MaTour AND NgayKhoiHanh = @NgayKhoiHanh)
        BEGIN
            INSERT INTO Lich_TourDL (MaTour, NgayKhoiHanh, TenHDV, SoNguoi, TenKH)
            VALUES (@MaTour, @NgayKhoiHanh, @TenHDV, @SoNguoi, @TenKH);
        END
        ELSE
        BEGIN
            PRINT 'Error: The combination of MaTour and NgayKhoiHanh already exists';
        END
    END
    ELSE
    BEGIN
        PRINT 'Error: MaTour does not exist';
    END
END;

GO
----------------------------------------------------------------------
-- Thêm dữ liệu
-- Add a city that all tours go through
insert into ThanhPho values('06', N'Hà Nội')

-- Add the corresponding entries in Tour_TP to ensure all tours go through the new city
insert into Tour_TP values('T001', '06', 1)
insert into Tour_TP values('T002', '06', 1)
insert into Tour_TP values('T003', '06', 1)
insert into Tour_TP values('T004', '06', 1)

-- Add a tour that goes through all cities
insert into Tour values('T005', 5)

-- Add the corresponding entries in Tour_TP to ensure the new tour goes through all cities
insert into Tour_TP values('T005', '01', 1)
insert into Tour_TP values('T005', '02', 1)
insert into Tour_TP values('T005', '03', 1)
insert into Tour_TP values('T005', '04', 1)
insert into Tour_TP values('T005', '05', 1)
insert into Tour_TP values('T005', '06', 1)

GO

-- 4a. Cho biết các tour du lịch có tổng số ngày từ 3-5
SELECT * FROM Tour WHERE TongSoNgay >= 3 AND TongSoNgay <= 5;

-- 4b. Cho biết thông tin các tour được tổ chức trong tháng 02/2017
SELECT * FROM Lich_TourDL WHERE YEAR(NgayKhoihanh) = 2017 AND MONTH(NgayKhoihanh) = 2;

-- 4c. Cho biết các tour KHÔNG đi qua Nha Trang.
SELECT ttp.MaTour, ttp.SoNgay, tp.TenTP FROM Tour_TP as ttp JOIN ThanhPho as tp on ttp.MaTP = tp.MaTP 
	WHERE tp.TenTP != N'Nha Trang';

-- 4d. Cho biết số lượng thành phố mà mỗi tour du lịch đi qua.
SELECT MaTour, COUNT(*) AS 'SoLuongTP' FROM Tour_TP GROUP BY MaTour;

-- 4e. Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn.
SELECT TenHDV, COUNT(*) AS "SoLuongTour" FROM Lich_TourDL GROUP BY TenHDV;

-- 4f. Cho biết tên thành phố có nhiều tour du lịch đi qua nhất.
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

-- 4g. Cho biết thông tin của tour du lịch đi qua tất cả các thành phố.
SELECT MaTour, COUNT(*) AS "SoLuongTP" FROM Tour_TP GROUP BY MaTour HAVING COUNT(*) = (SELECT COUNT(*) FROM ThanhPho);

-- 4h. Lập danh sách các tour đi qua thành phố Đà Lạt, thông tin cần hiển thị bao gồm: Mã tour, Số ngày.
SELECT MaTour, SUM(SoNgay) AS "Tổng số ngày"
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

-- 4i. Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất.
SELECT * FROM Lich_TourDL WHERE SoNguoi = (SELECT MAX(SoNguoi) FROM Lich_TourDL);

-- 4j. Cho biết tên thành phố mà tất cả các tour du lịch đề đi qua.
SELECT MaTP, TenTP FROM ThanhPho
WHERE MaTP IN (
  SELECT MaTP FROM Tour_TP
  GROUP BY MaTP
  HAVING COUNT(DISTINCT MaTour) = (SELECT COUNT(*) FROM Tour)
);