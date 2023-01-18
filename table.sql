CREATE 
--DROP
DATABASE DOAN_HQTCSDL
GO


USE DOAN_HQTCSDL
GO


CREATE
--ALTER
TABLE HOPDONG (
	HD_MA CHAR(10) PRIMARY KEY,
	HD_NGAYLAP DATETIME,
	HD_STK CHAR(50) NOT NULL UNIQUE,
	HD_NGANHANG NVARCHAR(100),
	HD_CHINHANHNGANHANG NVARCHAR(100),
	HD_TINHTRANG NVARCHAR(50),
	HD_HOAHONG FLOAT,
	HD_TGHIEULUC DATE,
	DT_MA CHAR(10),
	NV_MA CHAR(10) 
)
GO

CREATE 
--ALTER
TABLE HOSODANGKY (
	HSDK_MA CHAR(10) PRIMARY KEY,
	HD_MA CHAR(10),
	HSDK_EMAIL NVARCHAR(50) UNIQUE,
	HSDK_TENQUAN NVARCHAR(100),
	HSDK_THANHPHO NVARCHAR(50),
	HSDK_QUAN NVARCHAR(50),
	HSDK_SLCHINHANH INT,
	HSDK_SLDONHANGTOITHIEU INT,
	HSDK_LOAIAMTHUC NVARCHAR(100),
	HSDK_NGUOIDAIDIEN NVARCHAR(100),
	NV_MA CHAR(10),
	DT_MA CHAR(10) 
)
GO

CREATE 
--ALTER
TABLE DOITAC ( 
	DT_MA CHAR(10) PRIMARY KEY,
	DT_TEN NVARCHAR(100),
	DT_SDT CHAR(10) UNIQUE,
	DT_EMAIL NVARCHAR(100)
)
GO

CREATE 
--ALTER
TABLE NHANVIEN (
	NV_MA CHAR(10) PRIMARY KEY,
	NV_TEN NVARCHAR(50),
	NV_NGAYSINH DATE,
	NV_CMND CHAR(20) UNIQUE,
	NV_SDT CHAR(10) UNIQUE,
	NV_GIOITINH NVARCHAR(10),
	NV_MAIL NVARCHAR(100) UNIQUE,
	--DIACHI
	DC_MATINH CHAR(10),
	DC_MAHUYEN CHAR(10),
	DC_MAXA CHAR(10)
) 
GO

CREATE
--ALTER
TABLE PHIHOAHONG (
	DH_MA CHAR(10),
	PHH_TONGTIEN MONEY,
	PHH_NGAYNOP DATETIME,
	PHH_PHITHANG INT, -- NOP TIEN CHO THANG ... NAM ...
	NV_MA CHAR(10)
	CONSTRAINT PK_PHH PRIMARY KEY (DH_MA,NV_MA)
)
GO

CREATE 
--ALTER
TABLE CUAHANG (
	CH_MA CHAR(10) PRIMARY KEY,
	DT_MA CHAR(10),
	CH_TEN CHAR(100), 
	CH_TGMOCUA TIME,
	CH_TGDONGCUA TIME,
	CH_SDT CHAR(10),
	CH_TINHTRANGHOATDONG NVARCHAR(50)
)
GO

CREATE 
--ALTER
TABLE CHINHANH (
	CN_MA CHAR(10), 
	CH_MA CHAR(10),
	DC_MATINH CHAR(10),
	DC_MAHUYEN CHAR(10),
	DC_MAXA CHAR(10),
	CN_TEN NVARCHAR(100)
	CONSTRAINT PK_CHINHANH PRIMARY KEY (CN_MA,CH_MA)
)
GO

CREATE 
--ALTER
TABLE THUCDON (
	TD_MA CHAR(10),		
	CN_MA CHAR(10), 
	CH_MA CHAR(10),
	TD_TEN CHAR(10)
	CONSTRAINT PK_THUCDON PRIMARY KEY (TD_MA,CN_MA,CH_MA)
)
GO

CREATE 
--ALTER
TABLE MONAN (
	MAN_MA CHAR(10),
	TD_MA CHAR(10),
	CN_MA CHAR(10), 
	CH_MA CHAR(10),
	MAN_TEN NVARCHAR(100) UNIQUE,
	MAN_MIEUTA NVARCHAR(100),
	MAN_TINHTRANG NVARCHAR(100),
	MAN_IMGPATH NVARCHAR(100),
	MAN_GIA MONEY
	CONSTRAINT PK_MONAN PRIMARY KEY (MAN_MA, TD_MA,CN_MA,CH_MA)
)
GO

CREATE
--ALTER
TABLE DONHANG (
	DH_MA CHAR(10) PRIMARY KEY,
	DH_NGAYDAT DATETIME,
	DH_PHUONGTHUCTHANHTOAN NVARCHAR(100),
	DH_TONGTIEN MONEY,
	KH_MA CHAR(10), 
	CH_MA CHAR(10),
	DH_PHIVANCHUYEN MONEY,
	DH_TINHTRANG  NVARCHAR(50),
	TX_MA CHAR(10),
	--DIACHI
	DC_MATINH CHAR(10),
	DC_MAHUYEN CHAR(10),
	DC_MAXA CHAR(10),
)
GO


CREATE
--ALTER
TABLE CHITIETDONHANG (
	DH_MA CHAR(10),
	MAN_MA CHAR(10),
	TD_MA CHAR(10),
	CN_MA CHAR(10), 
	CH_MA CHAR(10),
	CTDH_SOLUONG CHAR(10),
	CTDH_GIATIEN MONEY,
	CTDH_GHICHU NVARCHAR(100)
	CONSTRAINT PK_CTDH PRIMARY KEY (DH_MA,MAN_MA,TD_MA,CN_MA,CH_MA)
)
GO

CREATE
--ALTER
TABLE TAIXE (
	TX_MA CHAR(10) PRIMARY KEY,
	TX_TEN NVARCHAR(100),
	TX_CMND CHAR(20) UNIQUE NOT NULL,
	TX_SDT CHAR(10),
	TX_BIENSOXE CHAR(20) UNIQUE NOT NULL,
	TX_STK CHAR(20) UNIQUE NOT NULL,
	TX_NGANHANG NVARCHAR(100),
	TX_GIOITINH NVARCHAR(10),
	--DIACHI
	DC_MATINH CHAR(10),
	DC_MAHUYEN CHAR(10),
	DC_MAXA CHAR(10),
)
GO

CREATE 
--ALTER 
TABLE TINHTRANGGIAOHANG (
	TX_MA CHAR(10),
	DH_MA CHAR(10),
	TTGH_TINHTRANG NVARCHAR(50),

	--vi tri tai xe giao hang hien tai
	DC_MATINH CHAR(10),
	DC_MAHUYEN CHAR(10),
	DC_MAXA CHAR(10),
	CONSTRAINT PK_TINHTRANGGIAOHANG PRIMARY KEY (TX_MA, DH_MA)
)
GO

CREATE 
--ALTER 
TABLE KHACHHANG (
	KH_MA CHAR(10) PRIMARY KEY,
	KH_TEN NVARCHAR(100),
	KH_SDT CHAR(100),
	KH_MAIL CHAR(100),
	KH_GIOITINH NVARCHAR(10),
	KH_ANH NVARCHAR(50),
	--DIACHI
	DC_MATINH CHAR(10),
	DC_MAHUYEN CHAR(10),
	DC_MAXA CHAR(10),
	DC_SONHA NVARCHAR(100)
)
GO



CREATE
--ALTER
TABLE DIACHI (
	DC_MATINH CHAR(10) NOT NULL UNIQUE,
	DC_MAHUYEN CHAR(10) NOT NULL UNIQUE,
	DC_MAXA CHAR(10) NOT NULL UNIQUE,
	DC_TENTINH NVARCHAR(100),
	DC_TENHUYEN NVARCHAR(100),
	DC_TENXA NVARCHAR(100),
	CONSTRAINT PK_DIACHI PRIMARY KEY (DC_MATINH, DC_MAHUYEN, DC_MAXA)
)
GO

CREATE
--ALTER
TABLE TAIKHOAN(
	MA CHAR(10) NOT NULL PRIMARY KEY,
	UNAME CHAR(20) NOT NULL,
	PWD CHAR(10) NOT NULL,
	LOAI CHAR(10) NOT NULL
)

CREATE 
--ALTER
--DROP
TABLE GIOHANG(
	MAN_MA CHAR(10) NOT NULL,
	TD_MA CHAR(10) NOT NULL,
	CN_MA CHAR(10) NOT NULL,
	CH_MA CHAR(10) NOT NULL,
	KH_MA CHAR(10) NOT NULL,
	SOLUONG INT NOT NULL,
	NOTES NVARCHAR(100),
	CONSTRAINT PK_GIOHANG PRIMARY KEY (MAN_MA, KH_MA),
	CONSTRAINT FK_GIOHANG_KHACHHANG FOREIGN KEY (KH_MA) REFERENCES dbo.KHACHHANG(KH_MA),
	CONSTRAINT FK_GIOHANG_MONAN FOREIGN KEY (MAN_MA,TD_MA,CN_MA,CH_MA) REFERENCES dbo.MONAN (MAN_MA,TD_MA,CN_MA,CH_MA)
)


--=====================================================================================================================
----KHÓA NGOẠI
-- HOSODANGKY -> HOPDONG 1: CHITIETHOPDONG
ALTER TABLE HOSODANGKY
ADD CONSTRAINT FK_HOSODK_HOPDONG
FOREIGN KEY (HD_MA)
REFERENCES HOPDONG(HD_MA)

-- HOSODANGKY -> DOITAC 2: DANGKYCUAHANG
ALTER TABLE HOSODANGKY
ADD CONSTRAINT FK_HOSODK_DOITAC	
FOREIGN KEY (DT_MA)
REFERENCES DOITAC(DT_MA)

--HOSODANGKY -> NHANVIEN 3: KYHOPDONG
ALTER TABLE HOSODANGKY
ADD CONSTRAINT FK_HOSODK_NHANVIEN	
FOREIGN KEY (NV_MA)
REFERENCES NHANVIEN(NV_MA)

--NHANVIEN -> DIACHI 4: DIACHINHANVIEN
ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_DIACHI
FOREIGN KEY (DC_MATINH,DC_MAHUYEN,DC_MAXA)
REFERENCES DIACHI(DC_MATINH,DC_MAHUYEN,DC_MAXA)

--PHIHOAHONG -> DONHANG 5: NOPPHH
ALTER TABLE PHIHOAHONG
ADD CONSTRAINT FK_PHIHOAHONG_DONHANG
FOREIGN KEY (DH_MA)
REFERENCES DONHANG(DH_MA)

-- PHIHOAHONG -> NHANVIEN 6: THUPHH
ALTER TABLE PHIHOAHONG
ADD CONSTRAINT FK_PHIHOAHONG_NHANVIEN
FOREIGN KEY (NV_MA)
REFERENCES NHANVIEN(NV_MA)

-- CUAHANG -> DOITAC 7: SOHUU
ALTER TABLE CUAHANG
ADD CONSTRAINT FK_CUAHANG_DOITAC
FOREIGN KEY (DT_MA)
REFERENCES DOITAC(DT_MA)

--CHINHANH -> CUAHNANG 8: CHINHANHCON
ALTER TABLE CHINHANH
ADD CONSTRAINT FK_CHINHANH_CUAHANG
FOREIGN KEY (CH_MA)
REFERENCES CUAHANG(CH_MA)

--THUCDON -> CHINHANH 9: THUCDONCHINHANH
ALTER TABLE THUCDON
ADD CONSTRAINT FK_THUCDON_CHINHANH
FOREIGN KEY (CN_MA,CH_MA)
REFERENCES CHINHANH(CN_MA,CH_MA)

--MONAN -> THUCDON 10: CHITIETTHUCDON
ALTER TABLE MONAN
ADD CONSTRAINT FK_MONAN_THUCDON
FOREIGN KEY (TD_MA, CN_MA, CH_MA)
REFERENCES THUCDON(TD_MA, CN_MA, CH_MA)

--DONHANG -> CUAHANG 11: DONTHUOCCUAHANG
ALTER TABLE DONHANG
ADD CONSTRAINT FK_DONHANG_CUAHANG
FOREIGN KEY (CH_MA)
REFERENCES CUAHANG(CH_MA)

--DONHANG ->KHACHHANG 12: DATHANG
ALTER TABLE DONHANG
ADD CONSTRAINT FK_DONHANG_KHACHHANG
FOREIGN KEY (KH_MA)
REFERENCES KHACHHANG(KH_MA)

--CHITIETDONHANG -> DONHANG 13: CHITIETDONHANG
ALTER TABLE CHITIETDONHANG
ADD CONSTRAINT FK_CHITIETDONHANG_DONHANG
FOREIGN KEY (DH_MA)
REFERENCES DONHANG(DH_MA)

--CHITIETDONHANG -> MONAN 14: MONANDUOCDAT ------------------LOI
ALTER TABLE CHITIETDONHANG
ADD CONSTRAINT FK_CHITIETDONHANG_MONAN
FOREIGN KEY (MAN_MA, TD_MA, CN_MA, CH_MA)
REFERENCES MONAN(MAN_MA, TD_MA, CN_MA, CH_MA)

--TINHTRANGGIAOHANG -> TAIXE 15: CAPNHAT_TTGH
ALTER TABLE TINHTRANGGIAOHANG
ADD CONSTRAINT FK_TINHTRANGGIAOHANG_TAIXE
FOREIGN KEY (TX_MA)
REFERENCES TAIXE(TX_MA)

--TINHTRANGGIAOHANG -> DONHANG 16: TINHTRANGCUADONHANG
ALTER TABLE TINHTRANGGIAOHANG
ADD CONSTRAINT FK_TINHTRANGGIAOHANG_KHACHHANG
FOREIGN KEY (DH_MA)
REFERENCES DONHANG(DH_MA)

--KHACHHANG-> DIACHI 17: DIACHIKHACHHANG
ALTER TABLE KHACHHANG
ADD CONSTRAINT FK_KHACHHANG_DIACHI
FOREIGN KEY (DC_MATINH,DC_MAHUYEN,DC_MAXA)
REFERENCES DIACHI(DC_MATINH,DC_MAHUYEN,DC_MAXA)

--TAIXE-> DIACHI 18: KHUVUCHOATDONG
ALTER TABLE TAIXE
ADD CONSTRAINT FK_TAIXE_DIACHI
FOREIGN KEY (DC_MATINH,DC_MAHUYEN,DC_MAXA)
REFERENCES DIACHI(DC_MATINH,DC_MAHUYEN,DC_MAXA)


--TINHTRANGDONHANG-> DIACHI 19: VITRIHIENTAI---------LOI
ALTER TABLE TINHTRANGGIAOHANG
ADD CONSTRAINT FK_TINHTRANGGIAOHANG_DIACHI
FOREIGN KEY (DC_MATINH,DC_MAHUYEN,DC_MAXA)
REFERENCES DIACHI(DC_MATINH,DC_MAHUYEN,DC_MAXA)

--HOPDONG -> NHANVIEN 20: DANGKY
ALTER TABLE HOPDONG
ADD CONSTRAINT FK_HOPDONG_NHANVIEN
FOREIGN KEY (NV_MA)
REFERENCES NHANVIEN(NV_MA)

--CHINHANH-> DIACHI 21: DIACHICHINHANH
ALTER TABLE CHINHANH
ADD CONSTRAINT FK_CHINHANH_DIACHI
FOREIGN KEY (DC_MATINH,DC_MAHUYEN,DC_MAXA)
REFERENCES DIACHI(DC_MATINH,DC_MAHUYEN,DC_MAXA)

--DONHANG -> DIACHI 22: DIACHIGIAOHANG
ALTER TABLE DONHANG
ADD CONSTRAINT FK_DONHANG_DIACHI
FOREIGN KEY (DC_MATINH,DC_MAHUYEN,DC_MAXA)
REFERENCES DIACHI(DC_MATINH,DC_MAHUYEN,DC_MAXA)
GO 
--================================================================================================================================

---	RÀNG BUỘC TOÀN VẸN

--ngày nộp phí hoa hồng phải lớn hơn ngày lập hợp đồng
CREATE
--ALTER
--DROP
trigger tg_checkNgayNopPHH
on PHIHOAHONG
for insert ,update
as
begin 
	if exists (select *
				from inserted i, HOPDONG hd,NHANVIEN nv
				where hd.NV_MA = nv.NV_MA and nv.NV_MA = i.NV_MA and i.PHH_NGAYNOP < hd.HD_NGAYLAP)
	begin
		raiserror(N'ngày nộp phí hoa hồng phải lớn hơn ngày ngày lập hợp đồng',16,1)
		rollback
	end
END
go

--ngày sinh của nhân viên phải nhỏ hơn ngày lập hợp đồng
CREATE
--ALTER
--DROP
TRIGGER tg_checkNamSinhNhanVien
on NHANVIEN
for insert,update
as
begin
	if exists (select *
				from inserted i ,HOPDONG hd, HOSODANGKY hsdk
				where hd.HD_MA =hsdk.HD_MA and hsdk.NV_MA = i.NV_MA
				and i.NV_NGAYSINH > hd.HD_NGAYLAP)
	begin
		raiserror(N'ngày sinh của nhân viên nhập sai',16,1)
		rollback
	end
END
go

-- tình trạng hoạt động của cửa hàng phải là mở cửa
alter table CUAHANG add constraint check_TinhTrangHoatDong check(CH_TINHTRANGHOATDONG = N'Mở cửa'
OR CH_TINHTRANGHOATDONG = N'Đóng cửa')
go

-- tên các món ăn không được trùng nhau

CREATE
--ALTER
--DROP
TRIGGER tg_checkTenMonAn
on MONAN
for insert,update
as
begin
	if exists (select *
				from inserted i ,MONAN ma
				WHERE  i.MAN_TEN = ma.MAN_TEN AND i.MAN_MA != ma.MAN_MA )
	BEGIN
		RAISERROR(N'các món ăn phải có tên khác nhau',16,1)
		ROLLBACK
	END
END
go

--tình trạng của hợp đồng là còn hiệu lực và hết hết hiệu lực
alter table HOPDONG add constraint check_TinhTrangHopDong 
check (HD_TINHTRANG = N'Hiệu lực' or HD_TINHTRANG = N'Hết hiệu lực')
go
--tình trạng đơn đạt hàng phải là đang xác thực hoặc chưa xác thực
ALTER table DONHANG ADD CONSTRAINT check_TinhTrangDonHang
check (DH_TINHTRANG = N'Đã xác nhận' or DH_TINHTRANG = N'Chưa xác nhân' OR DH_TINHTRANG = N'Đang giao' OR DH_TINHTRANG = N'Đã giao thành công' OR DH_TINHTRANG = N'Đã hủy')
GO 
--tình trạng các món ăn phải là có bán ,hết hàng hôm nay ,tạm ngừng, ngừng bán
alter table MONAN add constraint check_TinhTrangMonAn
check (MAN_TINHTRANG = N'Có bán' or MAN_TINHTRANG = N'Hết hàng hôm ngay' 
or MAN_TINHTRANG = N'Tạm ngừng' or MAN_TINHTRANG = N'Ngừng bán')
GO 
--tình trạng  giao hàng là đã nhận đơn hàng hoặc chưa nhận đơn hàng, đã giao thành công
alter table TINHTRANGGIAOHANG add constraint check_ChiTietGiaoHang 
check (TTGH_TINHTRANG = N'Đã nhận đơn hàng'or TTGH_TINHTRANG = N'chưa nhận đơn hàng' OR TTGH_TINHTRANG = N'Đã giao thành công')

-- phí tháng của PHIHOAHONG phải từ 1->12
alter table PHIHOAHONG add constraint check_PhiThangHoaHong 
check (PHH_PHITHANG >=1 and PHH_PHITHANG <= 12)
GO 
--phương thức thanh toán của đơn đặt hàng là thanh toán online hoặc thanh toán khi nhận hàng
alter table DONHANG add constraint check_PhuongThucThanhToan
check(DH_PHUONGTHUCTHANHTOAN = N'Thanh toán online' or DH_PHUONGTHUCTHANHTOAN = N'Thanh toán khi nhận hàng')
GO 
--phí vận chuyển phải nhỏ hơn tổng tiền của đơn hàng
create trigger tg_checkPhiVanChuyen
on DONHANG
for insert,update
as
begin
	if exists (select *
				from inserted i 
				where i.DH_TONGTIEN <= i.DH_PHIVANCHUYEN)
	begin
		raiserror(N'phí vận chuyển không được lớn hơn tổng tiền của đơn hàng',16,1)
		rollback
	end
end
GO 
-- Tên món tối đa 80 ký tự
alter table MONAN
ADD CONSTRAINT CHECK_TENMONAN
CHECK(LEN(MAN_TEN) < 80)
GO
-- Khách hang chỉ được đặt món ăn trong thực đơn
CREATE 
--ALTER
TRIGGER TR_DATHANG
ON CHITIETDONHANG
FOR INSERT, UPDATE
AS
BEGIN 
	IF NOT EXISTS (SELECT * FROM inserted I, MONAN MAN
					WHERE I.CH_MA= MAN.CH_MA AND I.CN_MA = MAN.CN_MA AND I.TD_MA = MAN.TD_MA
					AND I.MAN_MA = MAN.MAN_MA)
	BEGIN 
		raiserror(N'MON AN KHONG CO TRONG THUC DON',16,1)
		rollback
	END

END
GO

--giới tính của tài xế phải là Nam hoặc Nữ
alter table TAIXE add constraint check_PhaiTaiXe check(TX_GIOITINH = N'Nam' or TX_GIOITINH = N'Nữ')
GO 
--giới tính của Khách hàng phải là Nam hoặc Nữ
alter table KHACHHANG ADD constraint check_PhaiKhachHang check(KH_GIOITINH = N'Nam' or KH_GIOITINH = N'Nữ')
GO
----phí hoa hồng bằng 10% doanh thu
--CREATE
----ALTER
----DROP
--TRIGGER tg_PhiHoaHong
--on PHIHOAHONG
--for insert,update
--as
--if update(PHH_TONGTIEN)
--begin
--	update PHIHOAHONG
--	set PHH_TONGTIEN = (select sum(dh.DH_TONGTIEN)*0,1
--						from DONHANG dh
--						where PHIHOAHONG.DH_MA = dh.DH_MA and PHIHOAHONG.PHH_PHITHANG = month(dh.DH_NGAYDAT))	
--	where exists (select* 
--					from inserted i
--					where i.DH_MA = PHIHOAHONG.DH_MA and i.NV_MA = PHIHOAHONG.NV_MA)
--end
--GO 
--giá tiền trong chi tiết đơn hàng phải bằng giá tiền của món ăn
create trigger tg_GiaTienChiTietDonHang
on CHITIETDONHANG
for insert, update
as
begin
	update CHITIETDONHANG
	set CTDH_GIATIEN = (select ma.MAN_GIA
						from MONAN ma
						where ma.MAN_MA = CHITIETDONHANG.MAN_MA)
	where exists (select * 
					from inserted i
					where i.DH_MA = CHITIETDONHANG.DH_MA and i.MAN_MA = CHITIETDONHANG.MAN_MA)
end
GO 

--tổng tiền của một đơn hàng bằng tổng giá tất cả các món trong chi tiết  đơn hàng
CREATE 
-- alter 
-- DROP 
TRIGGER tg_TongTienDonHang
on DONHANG
for insert ,update
as
begin
	UPDATE DONHANG
	set DH_TONGTIEN =  (select sum(ctdh.CTDH_SOLUONG * ctdh.CTDH_GIATIEN)
						from CHITIETDONHANG ctdh
						where ctdh.DH_MA = DONHANG.DH_MA)
	where exists (select *
					from inserted i
					where i.DH_MA = DONHANG.DH_MA)
end
GO 
--tổng tiền của 1 đơn hàng trừ đi 20% hoa hồng
--DROP TRIGGER tg_TongTienSauCungCuaDonHang
--create trigger tg_TongTienSauCungCuaDonHang
--on DONHANG
--for insert,update
--as
--begin
--	update DONHANG
--	set DH_TONGTIEN =DH_TONGTIEN *0.8
--	where exists (select *
--					from inserted i
--					where DONHANG.DH_MA = i.DH_MA)
--end

--thời gian mở của của một của hàng phải sớm hơn thời gian đóng cửa
alter table CUAHANG add constraint check_ThoiGianDongMoCuaHang check(CH_TGMOCUA <CH_TGDONGCUA)
GO 

--thời gian mở của của một của hàng phải sớm hơn thời gian đóng cửa
--alter table CUAHANG add constraint check_ThoiGianDongMoCuaHang check(CH_TGMOCUA <CH_TGDONGCUA)
--GO 
--================================================================================================================================================
--tao role
EXEC sp_addrole 'DoiTac'
go

exec sp_addrole 'NhanVien'
go

exec sp_addrole 'TaiXe'
go

exec sp_addrole 'admin', 'dbo'
go

exec sp_addrole 'KhachHang'
go
-- cap quyen cho cac role
-- doi tac
Grant insert, update
on HOSODANGKY
to DoiTac
go

grant select
on HOPDONG
TO DoiTac
GO

grant select, update
on CUAHANG
to DoiTac
go

grant insert, update, delete, select
on THUCDON
to DoiTac
go

grant insert, update, delete, select
on MONAN
to DoiTac
go

grant select
on DONHANG
to DoiTac
go

grant select, update
on dbo.TINHTRANGGIAOHANG
to DoiTac
go

-- nhan vien
Grant insert, update
on KHACHHANG
to KhachHang
go

Grant select
on DOITAC
to KhachHang
go

Grant select
on THUCDON
to KhachHang
go

Grant select
on MONAN
to KhachHang
go

Grant insert
on CHITIETDONHANG
to KhachHang
go

Grant insert, delete
on DONHANG
to KhachHang
go

Grant insert
on dbo.TINHTRANGGIAOHANG
to KhachHang
go

-- tai xe
Grant insert, update
on TAIXE
to TaiXe
go

Grant insert, update, delete
on dbo.TINHTRANGGIAOHANG
to TaiXe
go

-- nhan vien
Grant select, insert, update, delete
on HOPDONG 
to NhanVien
go

Grant select
on dbo.HOSODANGKY
to NhanVien
GO
--=========================================================================================================================================
---------------------------------------- NHANVIEN 
--xem danh sach doi tac CUA NHAN VIEN PHU TRACH
create
--alter
proc pr_xemdanhsachdoitac 
	@NV_MA CHAR(10)
as
BEGIN TRANSACTION
	BEGIN TRY
		IF EXISTS(SELECT * FROM dbo.NHANVIEN WHERE NV_MA = @NV_MA)
		BEGIN 
			PRINT N'Loi thong tin dau vao khong hop le'
			ROLLBACK
		END 
		SELECT * FROM dbo.DOITAC JOIN dbo.HOPDONG HD ON HD.DT_MA = HD.DT_MA WHERE HD.NV_MA = @NV_MA
	END TRY
	BEGIN CATCH
	END CATCH
COMMIT TRANSACTION
GO



------------------------------------------KHACHHANG
--thêm thông tin cho khách hàng mới
CREATE
--ALTER
PROC sp_ThemThongTinKhachHang
	@tenkh nvarchar(100),
	@sdtkh char(10),
	@mailkh char(100),
	@gioitinhkh nvarchar(10),
	@dc_matinh CHAR(10),
	@dc_mahuyen CHAR(10),
	@dc_maxa CHAR(10),
	@kh_sonha NVARCHAR(100)
AS
BEGIN TRAN
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM DIACHI dc WHERE dc.DC_MATINH = @dc_matinh)
		BEGIN 
			PRINT N'mã tỉnh không tồn tại'
			ROLLBACK TRAN
		END

		IF NOT EXISTS (SELECT * FROM DIACHI dc WHERE dc.DC_MAHUYEN = @dc_mahuyen)
		BEGIN 
			PRINT N'mã huyện không tồn tại'
			ROLLBACK TRAN
		END

		IF NOT EXISTS (SELECT * FROM DIACHI dc WHERE dc.DC_MAXA = @dc_maxa)
		BEGIN 
			PRINT N'mã xã không tồn tại'
			ROLLBACK TRAN
		END
		DECLARE @MAKH CHAR(10)
		DECLARE @TMP INT
		SELECT @TMP = COUNT(*) + 2 FROM dbo.KHACHHANG
		SET @MAKH = 'KH_' + CAST(@TMP AS CHAR(20));

		INSERT INTO DBO.KHACHHANG VALUES (@MAKH, @tenkh,@sdtkh,@mailkh,@gioitinhkh,null,@dc_matinh,@dc_mahuyen,@dc_maxa, @kh_sonha)
	END TRY
	BEGIN CATCH
		PRINT N'lỗi hệ thống'
		ROLLBACK tran
	END CATCH
COMMIT TRAN
GO

create proc sp_CapNhatThongTinKhachHang
	@makh CHAR(10),
	@tenkh nvarchar(100),
	@sdtkh char(10),
	@mailkh char(10),
	@gioitinhkh nvarchar(10),
	@dc_matinh CHAR(10),
	@dc_mahuyen CHAR(10),
	@dc_maxa CHAR(10)
as
begin tran
	begin try
		--mã khách hàng không tồn tại
		if not exists (select *
						from KHACHHANG kh
						where  kh.KH_MA = @makh)
		begin 
			print N'mã khách hàng không tồn tại'
			rollback tran
		end

		--kiểm tra địa chỉ tồn tại
		if not exists (select *
						from DIACHI dc
						where dc.DC_MATINH = @dc_matinh)
		begin 
			print N'mã tỉnh không tồn tại'
			rollback tran
		end

		if not exists (select *
						from DIACHI dc
						where dc.DC_MAHUYEN = @dc_mahuyen)
		begin 
			print N'mã huyện không tồn tại'
			rollback tran
		end

		if not exists (select *
						from DIACHI dc
						where dc.DC_MAXA = @dc_maxa)
		begin 
			print N'mã xã không tồn tại'
			rollback tran
		end
		
		update KHACHHANG
		set KH_TEN = @tenkh, KH_SDT = @sdtkh, KH_MAIL = @mailkh, KH_GIOITINH = @gioitinhkh,
		DC_MAHUYEN = @dc_mahuyen, DC_MATINH = @dc_matinh, DC_MAXA = @dc_maxa
		where KH_MA = @makh
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit tran
GO 


--thêm chi tiets đơn đặt hàng
create proc sp_ThemChiTietDonHang
	@DH_MA CHAR(10),
	@MAN_MA CHAR(10),
	@TD_MA CHAR(10),
	@CN_MA CHAR(10), 
	@CH_MA CHAR(10),
	@CTDH_SOLUONG INT,
	@CTDH_GIATIEN MONEY,
	@CTDH_GHICHU NVARCHAR(100)
as
begin tran
	begin try
		--kiểm tra của hàng tồn tại
		if not exists (select *
						from CUAHANG ch
						where ch.CH_MA = @CH_MA)
		begin
			print N'cửa hàng không tồn tại'
			rollback tran
		end

		--kiểm tra món ăn tồn tại
		if not exists (select *
						from MONAN ma
						where ma.MAN_MA = @MAN_MA)
		begin
			print N'món ăn không tồn tại'
			rollback tran
		end
		--kiểm tra đơn hàng tồn tại
		if not exists (select *
						from DONHANG dh
						where dh.DH_MA = @DH_MA)
		begin
			print N'đơn hàng không tồn tại'
			rollback tran
		end
		--kiểm tra thực đơn tồn tại
		if not exists (select *
						from THUCDON td
						where td.TD_MA = @TD_MA)
		begin
			print N'thực đơn không tồn tại'
			rollback tran
		end
		--kiểm tra chi nhánh tồn tại
		if not exists (select *
						from CHINHANH cn
						where cn.CN_MA = @CN_MA)
		begin
			print N'chi nhánh không tồn tại'
			rollback tran
		end

		--kiểm tra số lượng phải >=1
		if @CTDH_SOLUONG <1
		begin
			print N'Số lượng ít nhất là 1'
			rollback tran
		end
		insert CHITIETDONHANG
		values(@DH_MA,@MAN_MA,@TD_MA,@CN_MA,@CH_MA,@CTDH_SOLUONG,@CTDH_GIATIEN,@CTDH_GHICHU)
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit tran
GO 

create proc sp_DanSachMonAnKhachHangTimKiem
	@tenmonan nvarchar(10)
as
begin tran
	begin try
		
		if not exists (select*
						from MONAN mn
						where  mn.MAN_TEN =@tenmonan)
		begin
			print N'Món ăn không tồn tại'
			rollback tran
		end

		select *
		from MONAN mn
		where mn.MAN_TEN = @tenmonan
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit TRAN
GO 


-- in danh sách đối tác cho khách hàng
create proc sp_DanhSachDoiTacChoKhachHang
	@makh CHAR(10)
as
	begin tran
	begin try
		if not exists (select * 
						from KHACHHANG kh
						where kh.KH_MA = @makh)
		begin
			print N'Khách hàng không tồn tại'
			rollback tran
		end

		select * 
		from DOITAC
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit tran
GO 


--in thực đơn theo đối tác mà khách hàng chọn
create proc sp_ThucDonTheoDoiTac
	@madt CHAR(10),
	@makh CHAR(10)
as
begin tran
	begin try
		if not exists (select * 
						from KHACHHANG kh
						where kh.KH_MA = @makh)
		begin
			print N'Khách hàng không tồn tại'
			rollback tran
		end

		if not exists (select * 
						from DOITAC dt
						where dt.DT_MA = @madt)
		begin
			print N'Đối tác không tồn tại'
			rollback tran
		end

		select td.*
		from DOITAC dt join CUAHANG ch on dt.DT_MA = ch.DT_MA
		join CHINHANH cn on ch.CH_MA = cn.CH_MA
		join THUCDON td on cn.CN_MA = td.CN_MA
		where dt.DT_MA = @madt
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit TRAN
GO 

--hủy đơn hàng mà khách hàng muốn hủy\

create proc sp_huyDonHang
	@madh char(10)
as
begin tran
	begin try
		if not exists (select * from DONHANG dh where dh.DH_MA = @madh)
		begin
			print N'Đơn hàng ' + @madh + N' không tồn tại'
			rollback tran
		end
		if not exists (select * from DONHANG dh where dh.DH_MA = @madh AND dh.DH_TINHTRANG = N'Chưa xác nhận')
		begin
			print N'Không thể hủy đơn hàng'
			rollback tran
		END
        
		UPDATE dbo.DONHANG 
		SET DH_TINHTRANG = N'Đã hủy'
		WHERE DH_MA = @madh
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit TRAN
GO 

--khách hàng theo dõi quá trình vận chuyển đơn hàng
create proc sp_QuaTrinhVanChuyenChoKhachHang
	@makh CHAR(10),
	@madh CHAR(10) 
as
begin tran
	begin try
		if not exists (select * 
						from KHACHHANG kh
						where kh.KH_MA = @makh)
		begin
			print N'Khách hàng không tồn tại'
			rollback tran
		end

		if not exists (select * 
					from DONHANG dh
					where dh.DH_MA = @madh)
		begin
			print N'Đơn hàng không tồn tại'
			rollback tran
		end

		select ttgh.TTGH_TINHTRANG
		from TINHTRANGGIAOHANG ttgh 
		where ttgh.DH_MA = @madh
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit TRAN
GO 

--khách hàng có thể xem được danh sách các đơn hàng đã đặt
create proc sp_XemDanhSachDonHangCuaKhachHang
	@makh char(10)
as
begin tran
	begin try
		if not exists (select * from KHACHHANG kh where kh.KH_MA = @makh)
		begin
			print N'Khách hàng không tồn tại'
			rollback tran
		end

		select *
		from DONHANG dh
		where dh.KH_MA = @makh
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit TRAN
GO 
-- them do ăn vào bảng 
CREATE 
--alter
PROC sp_ThemVaoGioHang 
	@MAN_MA CHAR(10),
	@TD_MA CHAR(10),
	@CN_MA CHAR(10),
	@CH_MA CHAR(10),
	@KH_MA CHAR(10),
	@SOLUONG INT,
	@NOTES NVARCHAR(100)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF NOT EXISTS(SELECT * FROM dbo.KHACHHANG WHERE KH_MA = @KH_MA)
		BEGIN 
			PRINT N'KHACH HANG KHONG TON TAI'
			ROLLBACK
		END
		IF NOT EXISTS (SELECT * FROM dbo.MONAN WHERE MAN_MA = @MAN_MA)
		BEGIN 
			PRINT N'MON AN KHONG TON TAI'
			ROLLBACK
		END 
		INSERT INTO dbo.GIOHANG
		(
		    MAN_MA,
		    TD_MA,
		    CN_MA,
		    CH_MA,
		    KH_MA,
		    SOLUONG,
		    NOTES
		)
		VALUES
		(   @MAN_MA,
			@TD_MA,
			@CN_MA,
			@CH_MA,
			@KH_MA,
			@SOLUONG ,
			@NOTES
		    )
	END TRY
	BEGIN CATCH
		PRINT N'LOI INSERT'
		ROLLBACK
	END CATCH
COMMIT TRANSACTION
GO

-- KHACH HANG DAT HANG
CREATE 
--ALTER
PROC SP_KHDATHANG
	@kH_MA CHAR(10), 
	@PHUONGTHUCTHANHTOAN NVARCHAR(100)
AS
BEGIN TRAN
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM dbo.KHACHHANG WHERE KH_MA = @kH_MA)
		BEGIN 
			PRINT N'KHACH HANG KHONG TON TAI'
			ROLLBACK
		END


		PRINT 'BAT DAU PROC DAT HANG'
		-- lay dia chi khach hang
		DECLARE @XA CHAR(10), @HUYEN CHAR(10), @TINH CHAR(10)
		SELECT @XA = DC_MAXA, @HUYEN = DC_MAHUYEN, @TINH = DC_MATINH  FROM dbo.KHACHHANG WHERE KH_MA = @KH_MA
		
		-- PHAN LOAI MON AN THEO CUA HANG
		DECLARE D CURSOR FOR SELECT DISTINCT MN.CH_MA FROM dbo.MONAN MN, dbo.GIOHANG GH WHERE GH.KH_MA = @KH_MA AND GH.MAN_MA = MN.MAN_MA
		OPEN D
		DECLARE @CH_MA CHAR(10) 
		FETCH NEXT FROM D INTO @CH_MA
		
		SELECT * FROM dbo.MONAN
		SELECT * FROM dbo.GIOHANG
		PRINT @CH_MA
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- MA DON HANG
			DECLARE @DH_MA CHAR(10), @TMP INT;
			SELECT @TMP = COUNT(*) + 1 FROM dbo.DONHANG;
			SET @DH_MA = 'DH_' + CAST(@TMP AS CHAR(10));
			-- TONG TIEN
			DECLARE @TONGTIEN MONEY 
			SET @TONGTIEN = 0;
			-- INSERT DONHANG
			INSERT INTO dbo.DONHANG
			(
				DH_MA,
				DH_NGAYDAT,
				DH_PHUONGTHUCTHANHTOAN,
				DH_TONGTIEN,
				KH_MA,
				CH_MA,
				DH_PHIVANCHUYEN,
				DH_TINHTRANG,
				TX_MA,
				DC_MATINH,
				DC_MAHUYEN,
				DC_MAXA
			)
			VALUES
			(   @DH_MA,   -- DH_MA - char(10)
				GETDATE(), -- DH_NGAYDAT - datetime
				@PHUONGTHUCTHANHTOAN, -- DH_PHUONGTHUCTHANHTOAN - nvarchar(100)
				1000000, -- DH_TONGTIEN - money
				@KH_MA, -- KH_MA - char(10)
				@CH_MA, -- CH_MA - char(10)
				10000, -- DH_PHIVANCHUYEN - money
				N'Chưa xác nhân', -- DH_TINHTRANG - nvarchar(50)
				NULL, -- TX_MA - char(10)
				@TINH, -- DC_MATINH - char(10)
				@HUYEN, -- DC_MAHUYEN - char(10)
				@XA  -- DC_MAXA - char(10)
				)
			DECLARE C CURSOR FOR SELECT GH.MAN_MA, GH.SOLUONG, GH.NOTES FROM dbo.GIOHANG GH, dbo.MONAN MN
										WHERE KH_MA = @kH_MA AND MN.MAN_MA = GH.MAN_MA AND MN.CH_MA = @CH_MA

			OPEN C
			DECLARE @MAN_MA CHAR(10), @SOLUONG INT, @NOTES NVARCHAR(100)
			FETCH NEXT FROM C INTO @MAN_MA, @SOLUONG, @NOTES
			WHILE @@FETCH_STATUS = 0
				BEGIN
					PRINT @MAN_MA
					-- LAY THONG TIN MON AN
					DECLARE @TD_MA CHAR(10), @CN_MA CHAR(10), @GIA MONEY
					SELECT @TD_MA = TD_MA, @CN_MA = CN_MA, @GIA = MAN_GIA FROM dbo.MONAN WHERE MAN_MA = @MAN_MA 
					--TINH TONG TIEN
					SET @TONGTIEN = @TONGTIEN + @SOLUONG * @GIA
					PRINT @CH_MA + ' - ' + @MAN_MA 
					INSERT INTO dbo.CHITIETDONHANG
					(
						DH_MA,
						MAN_MA,
						TD_MA,
						CN_MA,
						CH_MA,
						CTDH_SOLUONG,
						CTDH_GIATIEN,
						CTDH_GHICHU
					)
					VALUES
					(   @DH_MA,   -- DH_MA - char(10)
						@MAN_MA, -- MAN_MA - char(10)
						@TD_MA, -- TD_MA - char(10)
						@CN_MA, -- CN_MA - char(10)
						@CH_MA, -- CH_MA - char(10)
						@SOLUONG, -- CTDH_SOLUONG - char(10)
						NULL, -- CTDH_GIATIEN - money
						@NOTES  -- CTDH_GHICHU - nvarchar(100)
						)
					PRINT 'CHEN THANH CONG'
					DELETE dbo.GIOHANG WHERE KH_MA = @kH_MA AND MAN_MA = @MAN_MA
					FETCH NEXT FROM C INTO @MAN_MA, @SOLUONG, @NOTES
				END
			CLOSE C
			DEALLOCATE C
			-- UPDATE TONG TIEN
			UPDATE dbo.DONHANG
			SET DH_TONGTIEN = @TONGTIEN
			WHERE DH_MA = @DH_MA
			PRINT 'UPDATE THANH CONG'
			--TIEP TUC VONG LAP MOI
			FETCH NEXT FROM D INTO @CH_MA
		END

		CLOSE D
		DEALLOCATE D

	END TRY
	BEGIN CATCH
		PRINT N'LOI THUC THI'
		CLOSE D
		DEALLOCATE D
		CLOSE C
		DEALLOCATE C
		ROLLBACK
	END CATCH
COMMIT TRANSACTION
GO  
--Tài xế
--Chức năng của tài xế
--Thêm thông tin tài xế
create 
--ALTER
--drop
PROC sp_themthongtintaixe
	@ten nvarchar(10),
	@cmnd char(20),
	@sdt char(10),
	@bien_so_xe char(10),
	@stk char(20),
	@ngan_hang nvarchar(100),
	@gioi_tinh nvarchar(10),
	@ma_tinh CHAR(10),
	@ma_huyen CHAR(10) ,
	@ma_xa CHAR(10) 
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF (@sdt is NULL and @ten is NULL and @cmnd is NULL and @bien_so_xe is NULL)
		BEGIN
			PRINT N'LOI DAU VAO'
			ROLLBACK
			RETURN
		END
		
		--Insert
		DECLARE @MATX CHAR(10), @TMP INT
		SELECT @TMP = COUNT(*) + 1 FROM dbo.TAIXE
		SET @MATX = 'TX_'+CAST(@TMP AS CHAR(20))
		insert into TAIXE(TX_MA,TX_TEN,TX_CMND,TX_SDT,TX_BIENSOXE,TX_STK,TX_NGANHANG,TX_GIOITINH,DC_MATINH,DC_MAHUYEN,DC_MAXA) values(@MATX, @ten, @cmnd, @sdt, @bien_so_xe, @stk, @ngan_hang,@gioi_tinh,@ma_tinh,@ma_huyen,@ma_xa)
	END TRY
	BEGIN CATCH 
		PRINT N'LOI INSERT'
		rollback tran
	END CATCH
commit transaction
GO

--Xem thông tin của tài xế
create proc sp_xemthongtintaixe
	@ma CHAR(10)
as
begin transaction
	BEGIN TRY
		if(@ma = NULL )
		begin
			print N'Không nhận được mã'
			rollback transaction
			return
		end
		if not exists(select * from TAIXE where TX_MA=@ma)
		begin
			print N'Mã tài xế không tồn tại'
			rollback transaction
			return
		end
		--Select
		select * from TAIXE where TX_MA=@ma
	END TRY
	BEGIN CATCH
		PRINT N'Không xem được thông tin khách hàng'
		ROLLBACK TRANSACTION
	END CATCH
commit transaction
GO

--EXEC dbo.sp_xemthongtintaixe  @ma = 'KH_1' -- char(10)

--Cập nhật thông tin tài xế
create proc sp_capnhatthongtintaixe
@ma CHAR(10),
@ten nvarchar(100),
@cmnd char(20),
@sdt char(10),
@bien_so_xe char(20),
@stk char(20),
@gioi_tinh nvarchar(10)
as
begin transaction
	BEGIN TRY
		if(@ma = NULL or @sdt = NULL or @ten = NULL or @cmnd = NULL or @bien_so_xe = NULL)
		begin
			print N'Không được để trống các thông tin quan trọng'
			rollback transaction
			return
		end
		if not exists(select * from TAIXE where TX_MA=@ma)
		begin
			print N'Mã tài xế không tồn tại'
			rollback transaction
			return
		end
		--Update
		update TAIXE set
		TX_TEN=@ten, 
		TX_CMND=@cmnd, 
		TX_SDT=@sdt, 
		TX_BIENSOXE=@bien_so_xe, 
		TX_STK=@stk, 
		TX_GIOITINH=@gioi_tinh
		WHERE TX_MA = @ma
	END TRY
	BEGIN CATCH
		PRINT N'Loi update'
		ROLLBACK tran
	END CATCH
commit transaction
go




--Tiền đơn hàng tài xế nhận
create proc sp_tiendonhangtaixenhan
@ma_tx CHAR(10),
@ma_dh CHAR(10),
@money CHAR(10) out
as
begin transaction
	BEGIN TRY
		if(@ma_tx = NULL)
		begin
			print N'Không nhận được mã'
			rollback transaction
			return
		end
		if not exists(select * from TAIXE where TX_MA=@ma_tx)
		begin
			print N'Mã tài xế không tồn tại'
			rollback transaction
			return
		end
		--Select
		select @money=DH_TONGTIEN from DONHANG where DH_MA=@ma_dh
	END TRY
	BEGIN CATCH
		PRINT N'Loi select'
		ROLLBACK
	END CATCH
commit transaction
GO


--Tổng tiền đơn đã giao
create proc sp_tongtien
@ma_tx CHAR(10),
@sum_money int out
as
begin transaction
	BEGIN TRY
		if(@ma_tx = NULL )
		begin
			print N'Không nhận được mã'
			rollback transaction
			return
		end
		if not exists(select * from TAIXE where TX_MA=@ma_tx)
		begin
			print N'Mã tài xế không tồn tại'
			rollback transaction
			return
		end
		--Select
		select @sum_money=sum(DH_TONGTIEN) from TINHTRANGGIAOHANG left join DONHANG 
		ON TINHTRANGGIAOHANG.DH_MA=DONHANG.DH_MA where TINHTRANGGIAOHANG.TX_MA=@ma_tx 
		AND TINHTRANGGIAOHANG.TTGH_TINHTRANG=N'Đã nhận đơn hàng'
	END TRY
	BEGIN CATCH
		PRINT N'Loi select'
		ROLLBACK
	END CATCH
commit transaction
GO

--------------- đối tác
go
create 
--drop
proc sp_dscuahangdoitac
@ma_dt char(10)
as
begin tran
	begin try
		if(not exists(select * from DOITAC where DT_MA=@ma_dt))
		begin
			raiserror('ma doi tac la null', 16, 1)
			rollback tran
			return
		end
		select * from CUAHANG where DT_MA=@ma_dt
	end try
	begin catch
		raiserror('khong hien thi duoc thong tin cua hang', 16, 1)
		rollback tran
		return
	end catch
commit tran
go

create 
--drop
proc sp_chinhanhcuahangdoitac
@ma_dt char(10), @ma_ch char(10)
as
begin tran
	begin try
		if(not exists(select * from DOITAC where DT_MA=@ma_dt))
		begin
			raiserror('ma doi tac la null', 16, 1)
			rollback tran
			return
		end
		if(not exists(select * from CUAHANG where CH_MA=@ma_ch))
		begin
			raiserror('ma cua hang la null', 16, 1)
			rollback tran
			return
		end
	select * from CHINHANH where CH_MA=@ma_ch
	end try
	begin catch
		raiserror('khong hien thi duoc thong tin chi nhanh', 16, 1)
		rollback tran
		return
	end catch
commit tran
go

--theo doi don hang theo trang thai
create 
--alter
proc pr_danhsachdonhangchuaxacnhan
	@ch_ma char(10)
as
begin transaction
	begin try
		SELECT * FROM dbo.DONHANG DH WHERE DH.DH_TINHTRANG = N'Chưa xác nhận'
	end try
	begin catch
		PRINT 'loi he thong'
		ROLLBACK
	end catch
commit transaction
GO

create
--alter
proc pr_donhangtheodate
	@date date,
	@ch_ma char(10)
as
begin 
	BEGIN TRY
		IF NOT EXISTS(SELECT * FROM dbo.DONHANG WHERE CH_MA = @ch_ma)
		BEGIN 
			PRINT N'CUA HANG KHONG TON TAI'
			ROLLBACK
		END
		SELECT * FROM DONHANG WHERE CH_MA = @ch_ma and  DH_NGAYDAT = @date
	END TRY
	BEGIN CATCH
		PRINT 'LOI HE THONG'
		ROLLBACK
	END CATCH
end
GO

-- xem doanh thu tung ngay, thang nam
create
--alter
proc pr_doanhthutheodate
	@date date,
	@ch_ma char(10),
	@TONGDOANHTHU MONEY OUT
as
BEGIN 
	BEGIN TRY
		IF NOT EXISTS(SELECT * FROM dbo.DONHANG WHERE CH_MA = @ch_ma)
		BEGIN 
			PRINT N'CUA HANG KHONG TON TAI'
			ROLLBACK
		END
		SELECT * FROM DONHANG WHERE CH_MA = @ch_ma and  DH_NGAYDAT = @date AND DH_TINHTRANG = N'Đã giao thành công'
		select @TONGDOANHTHU = sum(DH_TONGTIEN) from DONHANG WHERE CH_MA = @ch_ma and  DH_NGAYDAT = @date AND DH_TINHTRANG = N'Đã giao thành công'
	END TRY
	BEGIN CATCH
		PRINT 'LOI HE THONG'
		ROLLBACK
	END CATCH
END
GO

-- chinh sua thong tin cua hang
create 
--alter
proc pr_updatecuahang 
	@ch_ma char(10),
	@ch_tgmocua time,
	@ch_tgdongcua time,
	@ch_sdt char(10),
	@ch_tinhtranghoatdong nvarchar(100)
as
begin transaction
	begin try
		if(@ch_tgdongcua is null)
		begin
			raiserror('thong tin nhap vao la null', 16, 1)
			rollback transaction
			return
		end
		if(@ch_tgmocua is null)
		begin
			raiserror('thong tin nhap vao la null', 16, 1)
			rollback transaction
			return
		end
		if(@ch_sdt is null)
		begin
			raiserror('thong tin nhap vao la null', 16, 1)
			rollback transaction
			return
		end
		if(@ch_tinhtranghoatdong is null)
		begin
			raiserror('thong tin nhap vao la null', 16, 1)
			rollback transaction
			return
		end
		update CUAHANG
		set CH_TGDONGCUA = @ch_tgdongcua, CH_TGMOCUA = @ch_tgmocua, CH_SDT = @ch_sdt, CH_TINHTRANGHOATDONG = @ch_tinhtranghoatdong
		where CH_MA = @ch_ma
	end try
	begin catch
		raiserror('khong cap nhat duoc thong tin', 16, 1)
		rollback transaction
		return
	end catch
	print 'update thanh cong'
commit transaction
go

-- cap nhat mon an
CREATE 
--alter
proc pr_capnhatmonan
	@man_ma char(10),
	@ch_ma char(10),
	@td_ma char(10),
	@cn_ma char(10),
	@man_ten nvarchar(50),
	@man_mieuta nvarchar(100),
	@man_tinhtrang nvarchar(50),
	@man_gia money
as
begin tran
	begin try
		if(@man_ma is null)
		begin 
			raiserror('ma mon an la null', 16, 1)
			rollback tran
			return
		end
		if(@man_ten is null)
		begin 
			raiserror('ten mon an la null', 16, 1)
			rollback tran
			return
		end
		if(@td_ma is null)
		begin 
			raiserror('ma thuc don la null', 16, 1)
			rollback tran
			return
		end
		if(@ch_ma is null)
		begin 
			raiserror('ma cua hang la null', 16, 1)
			rollback tran
			return
		end
		if(@cn_ma is null)
		begin 
			raiserror('ma chi nhanh la null', 16, 1)
			rollback tran
			return
		end
		if(@man_gia is null)
		begin 
			raiserror('ma mon an la null', 16, 1)
			rollback tran
			return
		end
		if(@man_tinhtrang is null)
		begin 
			raiserror('ma mon an la null', 16, 1)
			rollback tran
			return
		end
		-- ten mon an khong duoc trung
		if exists (select * from MONAN where @man_ma = MAN_MA and @man_ten = MAN_TEN)
		begin
			raiserror('ten mon an da ton tai', 16, 1)
			rollback tran
			return
		end
		-- cap nhat
		update MONAN
		set MAN_TEN = @man_ten, MAN_MIEUTA = @man_mieuta, MAN_TINHTRANG = @man_tinhtrang, MAN_GIA = @man_gia
		where MAN_MA = @man_ma and CH_MA = @ch_ma and TD_MA = @td_ma and CN_MA = @cn_ma
	end try
	begin catch
			raiserror('khong cap nhat duoc mon an', 16, 1)
			rollback tran
			return
	end catch
	print 'cap nhat mon an thanh cong'
commit tran
GO

-- xoa mon an
create 
--alter
proc pr_xoamonan
	@man_ma char(10),
	@ch_ma char(10),
	@cn_ma char(10),
	@td_ma char(10)
as
begin tran
	begin try
		if(@man_ma is null)
		begin 
			raiserror('ma mon an la null', 16, 1)
			rollback tran
			return
		end
		if(@td_ma is null)
		begin 
			raiserror('ma thuc don la null', 16, 1)
			rollback tran
			return
		end
		if(@ch_ma is null)
		begin 
			raiserror('ma cua hang la null', 16, 1)
			rollback tran
			return
		end
		if(@cn_ma is null)
		begin 
			raiserror('ma chi nhanh la null', 16, 1)
			rollback tran
			return
		end

		delete from MONAN
		where MAN_MA = @man_ma and CH_MA = @ch_ma and TD_MA = @td_ma and CN_MA = @cn_ma 
	end try
	begin catch
		raiserror('khong cap nhat duoc mon an', 16, 1)
		rollback tran
		return
	end catch
	print 'xoa thanh cong'
commit tran
GO

create 
--alter
proc pr_capnhattrangthaidh
	@ch_ma char(10),
	@dh_ma char(10),
	@dh_trangthai nvarchar(100)
as
begin tran
	begin try
		if(@ch_ma is null)
		begin 
			raiserror('ma cua hang la null', 16, 1)
			rollback tran
			return
		end
		if(@dh_ma is null)
		begin 
			raiserror('ma don hang la null', 16, 1)
			rollback tran
			return
		end
		if(@dh_trangthai is null)
		begin 
			raiserror('tinh trang don hang la null', 16, 1)
			rollback tran
			return
		end
		update DONHANG
		set DH_TINHTRANG = @dh_trangthai
		where DH_MA = @dh_ma and CH_MA = @ch_ma
	end try
	begin catch
		raiserror(' cap nhat duoc tinh trang don hang that bai', 16, 1)
		rollback tran
		return
	end catch
	print 'cap nhat duoc tinh trang don hang thanh cong'
commit tran
go

-- tinh trang giao hang cua don hang
create
--alter
proc pr_tinhtranggiaohangdh
	@dh_ma char(10)
as
begin tran
	begin try
		if(@dh_ma is null)
		begin 
			raiserror('ma cua hang la null', 16, 1)
			rollback tran
			return
		end
		-- don hang co ton tai
		if not exists (select * from DONHANG where DH_MA = @dh_ma) 
		begin 
			raiserror('don hang khong ton tai', 16, 1)
			rollback tran
			return
		end
		if not exists (select * from TINHTRANGGIAOHANG where DH_MA = @dh_ma) 
		begin 
			raiserror('don hang khong ton tai', 16, 1)
			rollback tran
			return
		end

		select * from TINHTRANGGIAOHANG where DH_MA = @dh_ma
	END TRY
	begin catch
		raiserror('khong hien thi duoc tinh trang giao hang', 16, 1)
		rollback tran
		return
	end catch
commit tran
go


create 
--alter
proc pr_chitietdonhang
	@dh_ma char(10)
as
begin tran
	begin try
		if(@dh_ma is null)
		begin 
			raiserror('ma cua hang la null', 16, 1)
			rollback tran
			return
		end
		-- don hang co ton tai
		if not exists (select * from DONHANG where DH_MA = @dh_ma) 
		begin 
			raiserror('don hang khong ton tai', 16, 1)
			rollback tran
			return
		end

		if not exists (select * from CHITIETDONHANG where DH_MA = @dh_ma) 
		begin 
			raiserror('don hang khong ton tai', 16, 1)
			rollback tran
			return
		end

		select MA.MAN_TEN, CTDH_SOLUONG, CTDH_GHICHU from CHITIETDONHANG CT, dbo.MONAN MA where DH_MA = @dh_ma AND MA.MAN_MA = CT.MAN_MA
	end try
	begin catch
		raiserror('khong hien thi duoc chi tiet don hang', 16, 1)
		rollback tran
		return
	end catch
commit tran
GO


-- xem thong tin cua hang
create
--alter
proc pr_thongtincuahang
	@dt_ma char(10)
as
begin tran
	begin try
		if(@dt_ma is null)
		begin
			raiserror('ma doi tac la null', 16, 1)
			rollback tran
			return
		end
		select * from HOSODANGKY where DT_MA = @dt_ma
		
	end try
	begin catch
		raiserror('khong hien thi duoc thong tin khach hang', 16, 1)
		rollback tran
		return
	end catch
commit tran
GO

-- chấp nhận đơn hàng
CREATE 
--alter
PROC sp_chapnhandonhang 
	@ma CHAR(10)
AS 
BEGIN TRANSACTION
	BEGIN TRY 
		IF NOT EXISTS(SELECT * FROM dbo.DONHANG WHERE DH_MA = @ma AND DH_TINHTRANG LIKE N'Chưa xác nhân')
		BEGIN
			PRINT N'DON HANG KHONG HOP LE'
			ROLLBACK
		END
		UPDATE dbo.DONHANG
		SET DH_TINHTRANG = N'Đã xác nhận'
		WHERE DH_MA = @ma
	END TRY
	BEGIN CATCH
		RAISERROR('khong hien thi duoc thong tin khach hang', 16, 1)
		ROLLBACK tran
		RETURN
	END CATCH
COMMIT TRANSACTION
GO 
----------------ADMIN
--THEM VAO ROLE
create
--alter
proc pr_themvaorole
	@ma_person char(10), -- ma nv, tai xe khach hang, admim
	@role char(20) -- ten role
as
begin transaction
	begin try
		--ma khach hang khac null
		if(@ma_person is null)
		begin
			RAISERROR('Ma khong hop le',16,1)
			rollback transaction
			return
		end
		-- ma khach hang co ton tai
		if(not exists (select * from dbo.KHACHHANG kh where kh.KH_MA = @ma_person))
		begin
			RAISERROR('Ma khong co trong du lieu',16,1)
			rollback transaction
			return
		end
		exec sp_addsrvrolemember @ma_person, @role
	end try
	begin catch
		RAISERROR('loi cap quyen',16,1)
		rollback transaction
		return
	end  catch

commit transaction
GO
-- xoa khoi cac role
create
--alter
proc pr_xoakhoirole
	@ma_person char(10),
	@role char(20)
as
begin transaction
	begin try
		--ma khach hang khac null
		if(@ma_person is null)
		begin
			RAISERROR('Ma khong hop le',16,1)
			rollback transaction
			return
		end
		-- ma khach hang co ton tai
		if(not exists (select * from dbo.KHACHHANG kh where kh.KH_MA = @ma_person))
		begin
			RAISERROR('Ma khong hop le',16,1)
			rollback transaction
			return
		end
		exec sp_dropsrvrolemember @ma_person, @role
	end try
	begin catch
		RAISERROR('loi huy quyen role',16,1)
		rollback transaction
		return
	end  catch
commit transaction
go


----===========================================================================================================================================================





insert into DIACHI values('11','1','101',N'Cao Bằng','abc','bcd');
insert into DIACHI values('70','51','501',N'Tây Ninh','efg','abs');
insert into DIACHI values('59','81','1001',N'TP. Hồ Chí Minh','ekj','lop');
insert into DIACHI values('12','D1','1',N'Tây Ninh','Châu Thành','Thị Trấn');

select * from DIACHI

insert into dbo.KHACHHANG
(
	KH_MA,
    KH_TEN,
    KH_SDT,
    KH_MAIL,
    KH_GIOITINH,
    DC_MATINH,
    DC_MAHUYEN,
    DC_MAXA,
    DC_SONHA
)
VALUES
(	N'KH_1',  
	N'Nguyễn A', -- KH_TEN - nvarchar(100)
    '0395639633', -- KH_SDT - char(100)
    'abc@gmail', -- KH_MAIL - char(100)
    N'Nam', -- KH_GIOITINH - nvarchar(10)
	'/images/profile pic/pic-1.png',
    11, -- DC_MATINH - int
    1, -- DC_MAHUYEN - int
    101, -- DC_MAXA - int
    'SO 4 DUONG 321'  -- DC_SONHA - nvarchar(100)
)

--------------------------------------- ADMIN


insert into KHACHHANG values('KH_1', N'Nguyễn A','0395639633','abc@gmail',N'Nam','/images/profile pic/pic-1.png','11','1','101', NULL);
insert into KHACHHANG values('KH_2', N'Nguyễn C','0395639612','abc2@gmail',N'Nữ','/images/profile pic/pic-2.png','70','51','501', NULL);
insert into KHACHHANG values('KH_3', N'Nguyễn D','0395639613','abc3@gmail',N'Nam','/images/profile pic/pic-3.png','11','1','101', NULL);
insert into KHACHHANG values('KH_4', N'Nguyễn E','0395639614','abc4@gmail',N'Nữ','/images/profile pic/pic-4.png','59','81','1001', NULL);

insert into DOITAC values('DT_1',N'Nguyễn Văn F','0395639615','ab5c@gmail.com');
insert into DOITAC values('DT_2',N'Nguyễn Văn G','0395639616','abc6@gmail.com');
insert into DOITAC values('DT_3',N'Nguyễn Văn Y','0395639689','abc09@gmail.com');

insert into NHANVIEN values('NV_1',N'Nguyễn Văn H','2002-01-11','5809237594','0395639617',N'Nam','abc7@gmail.com','11','1','101');
insert into NHANVIEN values('NV_2',N'Nguyễn Văn J','2002-02-22','5809345367','0395639618',N'Nam','abc8@gmail.com','70','51','501');

insert into TAIXE values('TX_1',N'Nguyễn K','134804358','0395639619','j29-4565','1458912432',N'MB Bank',N'Nam','59','81','1001');
insert into TAIXE values('TX_2',N'Nguyễn L','134809135','0395639620','j29-3479','1458947598',N'Agribank',N'Nam','59','81','1001');

insert into CUAHANG values('CH_1','DT_1','Hambu đê','05:59:59','23:59:59','1999999990',NULL);
insert into CUAHANG values('CH_4','DT_2','Hambu đê','05:59:59','23:59:59','1999999990',NULL);
insert into CUAHANG values('CH_5','DT_2','Pizza đê','05:59:59','23:59:59','1989898989',NULL);


insert into CHINHANH values('CN_3','CH_1','59','81','1001',N'Chi Nhánh Tây Ninh');
insert into CHINHANH values('CN_2','CH_4','70','51','501',N'Chi Nhánh TP Hồ Chí Minh');
insert into CHINHANH values('CN_1','CH_4','59','81','1001',N'Chi Nhánh Tây Ninh');
insert into CHINHANH values('CN_1','CH_1','11','1','101',N'Chi Nhánh Cao Bằng');
insert into CHINHANH values('CN_2','CH_1','70','51','501',N'Chi Nhánh TP Hồ Chí Minh');

insert into THUCDON values('TD_1','CN_3','CH_1',N'Menu Hambu');
insert into THUCDON values('TD_2','CN_2','CH_4',N'Menu Pizza');

insert into MONAN values('MN_1','TD_1','CN_3','CH_1',N'Hamburger Cá','abc',NULL,'/images/foods/dish-1.png',89999);
insert into MONAN values('MN_2','TD_1','CN_3','CH_1',N'Hamburger Bò','efg',NULL,'/images/foods/menu-2.jpg',99999);
insert into MONAN values('MN_3','TD_2','CN_2','CH_4',N'Pizza Thập Cẩm','ekj',NULL,'/images/foods/dish-4.png',199999);
INSERT into MONAN values('MN_4','TD_2','CN_2','CH_4',N'Gà Nướng','ekj',NULL,'/images/foods/dish-3.png',99999);

insert into TAIKHOAN values('KH_1','zp19d0z','1234','KHACHHANG');
insert into TAIKHOAN values('KH_2','20120429','1234','KHACHHANG');
insert into TAIKHOAN values('KH_3','20120000','1234','KHACHHANG');
insert into TAIKHOAN values('KH_4','20120001','1234','KHACHHANG');
insert into TAIKHOAN values('KH_5','20120002','1234','KHACHHANG');

insert into TAIKHOAN values('DT_1','20120008','1234','DOITAC');
insert into TAIKHOAN values('DT_2','20120007','1234','DOITAC');

insert into TAIKHOAN values('NV_1','20120003','1234','NHANVIEN');
insert into TAIKHOAN values('NV_2','20120004','1234','NHANVIEN');

insert into TAIKHOAN values('TX_1','20120005','1234','TAIXE');
insert into TAIKHOAN values('TX_2','20120006','1234','TAIXE');


INSERT INTO dbo.GIOHANG
(
    MAN_MA,
    TD_MA,
    CN_MA,
    CH_MA,
    KH_MA,
    SOLUONG,
    NOTES
)
VALUES
(   'MN_1','TD_1','CN_3','CH_1',
    'KH_4',  -- KH_MA - char(10)
    5,   -- SOLUONG - int
    N'KHONG CO' -- NOTES - nvarchar(100)
    )
	GO

INSERT INTO dbo.GIOHANG
(
    MAN_MA,
    TD_MA,
    CN_MA,
    CH_MA,
    KH_MA,
    SOLUONG,
    NOTES
)
VALUES
(   'MN_3','TD_2','CN_2','CH_4',
    'KH_4',  -- KH_MA - char(10)
    5,   -- SOLUONG - int
    N'KHONG CO' -- NOTES - nvarchar(100)
    )
	GO

--TEST============================================================================================================
EXEC dbo.sp_chapnhandonhang @ma = 'DH_4' -- char(10)

select * from TAIKHOAN

select* from GIOHANG
select * from KHACHHANG


exec SP_KHDATHANG 'KH_1',N'Thanh toán khi nhận hàng'
select * from DONHANG
delete from DONHANG where DH_MA='DH_1'
select * from GIOHANG where KH_MA='KH_1'

exec sp_huyDonHang 'DH_2'
exec sp_XemDanhSachDonHangCuaKhachHang 'KH_1'

CREATE 
--alter
PROC sp_themMonAn 
	@DT_MA CHAR(10),	
    @TD_MA CHAR(10),
    @CN_MA CHAR(10),
    @CH_MA CHAR(10),
    @MAN_TEN NVARCHAR(100),
    @MAN_MIEUTA NVARCHAR(100),
    @MAN_TINHTRANG NVARCHAR(100),
    @MAN_IMGPATH NVARCHAR(100),
    @MAN_GIA MONEY
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF (@TD_MA IS NULL OR @CN_MA IS NULL OR @CH_MA IS NULL OR @MAN_TEN IS NULL  OR @MAN_GIA IS NULL)
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 
		IF NOT EXISTS (SELECT * FROM dbo.CUAHANG WHERE CH_MA = @CH_MA AND DT_MA = @DT_MA)
		BEGIN
			PRINT N'sai ma cua hang'
			ROLLBACK
			RETURN
		END

		IF NOT EXISTS (SELECT * FROM dbo.THUCDON WHERE TD_MA = @TD_MA AND CN_MA = @CN_MA AND CH_MA = @CH_MA)
		BEGIN
			PRINT N'THONG TIN VE THUC DON KHONG DUNG'
			ROLLBACK
			RETURN
		END

		DECLARE @MAN_MA CHAR(10), @TMP INT
		SELECT @TMP = COUNT(*) + 1 FROM dbo.MONAN
		SET @MAN_MA = 'MN_' + CAST(@TMP AS CHAR(10));

		INSERT INTO dbo.MONAN
		(
			MAN_MA,
			TD_MA,
			CN_MA,
			CH_MA,
			MAN_TEN,
			MAN_MIEUTA,
			MAN_TINHTRANG,
			MAN_IMGPATH,
			MAN_GIA
		)
		VALUES
		(   @MAN_MA,   -- MAN_MA - char(10)
			@TD_MA,   -- TD_MA - char(10)
			@CN_MA,   -- CN_MA - char(10)
			@CH_MA,   -- CH_MA - char(10)
			@MAN_TEN, -- MAN_TEN - nvarchar(100)
			@MAN_MIEUTA, -- MAN_MIEUTA - nvarchar(100)
			@MAN_TINHTRANG, -- MAN_TINHTRANG - nvarchar(100)
			@MAN_IMGPATH, -- MAN_IMGPATH - nvarchar(100)
			@MAN_GIA  -- MAN_GIA - money
			)
        
	END TRY
	BEGIN CATCH
		PRINT N'LOI CHEN'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

EXEC dbo.sp_themMonAn @DT_MA = 'DT_1',          -- char(10)
                      @TD_MA = 'TD_2',          -- char(10)
                      @CN_MA = 'CN_2',          -- char(10)
                      @CH_MA = 'CH_4',          -- char(10)
                      @MAN_TEN = N'BANH TRANG NUONG',       -- nvarchar(100)
                      @MAN_MIEUTA = N'NGON VAI',    -- nvarchar(100)
                      @MAN_TINHTRANG = N'Có bán', -- nvarchar(100)
                      @MAN_IMGPATH = NULL,   -- nvarchar(100)
                      @MAN_GIA = 100000       -- money


go
create 
--drop
proc sp_chinhanhcuadoitac
@ma_dt char(10),@ma_ch char(10)
as
begin transaction
BEGIN TRY
		IF (not exists(select * from DOITAC where DT_MA=@ma_dt))
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 	
		IF (not exists(select * from CUAHANG where DT_MA=@ma_dt and CH_MA=@ma_ch))
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 	
		select * from CHINHANH where CH_MA=@ma_ch	
	END TRY
	BEGIN CATCH
		PRINT N'loi'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

create 
--drop
proc sp_monancuacuahang
@ma_dt char(10),@ma_ch char(10)
as
begin transaction
BEGIN TRY
		IF (not exists(select * from DOITAC where DT_MA=@ma_dt))
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 	
		IF (not exists(select * from CUAHANG where DT_MA=@ma_dt and CH_MA=@ma_ch))
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 	
		select * from MONAN where CH_MA=@ma_ch	
	END TRY
	BEGIN CATCH
		PRINT N'loi'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO


select * from MONAN
select * from THUCDON

exec sp_monancuacuahang 'DT_1','CH_1'

exec sp_monancuacuahangdoitac 'DT_1','CH_1'

-- Món ăn của chi nhánh cửa hàng của đối tác
create 
--drop
proc sp_monanchinhanhcuahang
@ma_dt char(10),@ma_ch char(10),@ma_cn char(10)
as
begin transaction
BEGIN TRY
		IF (not exists(select * from DOITAC where DT_MA=@ma_dt))
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 	
		IF (not exists(select * from CUAHANG where DT_MA=@ma_dt and CH_MA=@ma_ch))
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 
		IF (not exists(select * from CHINHANH where CN_MA=@ma_cn and CH_MA=@ma_ch))
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 	
		select * from MONAN where CH_MA=@ma_ch and CN_MA=@ma_cn
	END TRY
	BEGIN CATCH
		PRINT N'loi'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

--=================================================================================================================================================================
--=================================================================================================================================================================
--=================================================================================================================================================================
-- THEM MON AN
CREATE 
--drop
PROC sp_themMonAn 
	@DT_MA CHAR(10),	
    @TD_MA CHAR(10),
    @CN_MA CHAR(10),
    @CH_MA CHAR(10),
    @MAN_TEN NVARCHAR(100),
    @MAN_MIEUTA NVARCHAR(100),
    @MAN_IMGPATH NVARCHAR(100),
    @MAN_GIA MONEY
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF (@TD_MA IS NULL OR @CN_MA IS NULL OR @CH_MA IS NULL OR @MAN_TEN IS NULL  OR @MAN_GIA IS NULL)
		BEGIN 
			PRINT N'thong tin dau vao khong hop le'
			ROLLBACK
			RETURN
		END 
		IF NOT EXISTS (SELECT * FROM dbo.CUAHANG WHERE CH_MA = @CH_MA AND DT_MA = @DT_MA)
		BEGIN
			PRINT N'sai ma cua hang'
			ROLLBACK
			RETURN
		END

		IF NOT EXISTS (SELECT * FROM dbo.THUCDON WHERE TD_MA = @TD_MA AND CN_MA = @CN_MA AND CH_MA = @CH_MA)
		BEGIN
			PRINT N'THONG TIN VE THUC DON KHONG DUNG'
			ROLLBACK
			RETURN
		END

		DECLARE @MAN_MA CHAR(10), @TMP INT
		SELECT @TMP = COUNT(*) + 1 FROM dbo.MONAN
		SET @MAN_MA = 'MN_' + CAST(@TMP AS CHAR(10));

		INSERT INTO dbo.MONAN
		(
			MAN_MA,
			TD_MA,
			CN_MA,
			CH_MA,
			MAN_TEN,
			MAN_MIEUTA,
			MAN_IMGPATH,
			MAN_GIA
		)
		VALUES
		(   @MAN_MA,   -- MAN_MA - char(10)
			@TD_MA,   -- TD_MA - char(10)
			@CN_MA,   -- CN_MA - char(10)
			@CH_MA,   -- CH_MA - char(10)
			@MAN_TEN, -- MAN_TEN - nvarchar(100)
			@MAN_MIEUTA, -- MAN_MIEUTA - nvarchar(100)
			@MAN_IMGPATH, -- MAN_IMGPATH - nvarchar(100)
			@MAN_GIA  -- MAN_GIA - money
			)
        
	END TRY
	BEGIN CATCH
		PRINT N'LOI UPDATE'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

--THEM HO SO DANG Ky
CREATE 
--ALTER
PROC sp_themHoSoDangKy
	@HSDK_EMAIL NVARCHAR(50),
    @HSDK_TENQUAN NVARCHAR(100),
    @HSDK_THANHPHO NVARCHAR(50),
    @HSDK_QUAN NVARCHAR(50),
    @HSDK_SLCHINHANH INT,
    @HSDK_SLDONHANGTOITHIEU INT,
    @HSDK_LOAIAMTHUC NVARCHAR(100),
    @HSDK_NGUOIDAIDIEN NVARCHAR(100),
	@SDT CHAR(10),
	@PWD NVARCHAR(100),
	@BSNESSADDR NVARCHAR(100) 
AS 
BEGIN TRANSACTION
	BEGIN TRY
		IF (@HSDK_EMAIL IS NULL AND @HSDK_TENQUAN IS NULL AND @HSDK_SLCHINHANH IS NULL AND @HSDK_THANHPHO IS NULL AND @HSDK_QUAN IS NULL 
			AND @HSDK_SLDONHANGTOITHIEU IS NULL AND @HSDK_LOAIAMTHUC IS NULL AND @HSDK_NGUOIDAIDIEN IS NULL AND @SDT IS NULL AND @PWD IS NULL AND @BSNESSADDR IS NULL)
		BEGIN
			PRINT N'LOI DAU VAO'
			ROLLBACK
			RETURN
		END
		DECLARE @HSDK_MA CHAR(10), @TMP INT
		SELECT @TMP = COUNT(*) + 1 FROM dbo.HOSODANGKY
		SET @HSDK_MA = 'HSDK_' + CAST(@TMP AS CHAR(10))
		INSERT INTO dbo.HOSODANGKY
		(
		    HSDK_MA,
		    HD_MA,
		    HSDK_EMAIL,
		    HSDK_TENQUAN,
		    HSDK_THANHPHO,
		    HSDK_QUAN,
		    HSDK_SLCHINHANH,
		    HSDK_SLDONHANGTOITHIEU,
		    HSDK_LOAIAMTHUC,
		    HSDK_NGUOIDAIDIEN,
		    NV_MA,
		    DT_MA
		)
		VALUES
		(   @HSDK_MA,   -- HSDK_MA - char(10)
		    NULL, -- HD_MA - char(10)
		    @HSDK_EMAIL, -- HSDK_EMAIL - nvarchar(50)
		    @HSDK_TENQUAN, -- HSDK_TENQUAN - nvarchar(100)
		    @HSDK_THANHPHO, -- HSDK_THANHPHO - nvarchar(50)
		    @HSDK_QUAN, -- HSDK_QUAN - nvarchar(50)
		    @HSDK_SLCHINHANH, -- HSDK_SLCHINHANH - int
		    @HSDK_SLDONHANGTOITHIEU, -- HSDK_SLDONHANGTOITHIEU - int
		    @HSDK_LOAIAMTHUC, -- HSDK_LOAIAMTHUC - nvarchar(100)
		    @HSDK_NGUOIDAIDIEN, -- HSDK_NGUOIDAIDIEN - nvarchar(100)
		    NULL, -- NV_MA - char(10)
		    NULL  -- DT_MA - char(10)
		    )

		DECLARE @dt_ma CHAR(10), @tmp2 INT
		SELECT @tmp2 = COUNT(*) + 1 FROM dbo.DOITAC
		SET @dt_ma = 'DT_' + CAST(@tmp2 AS CHAR(10))

		INSERT INTO dbo.DOITAC
		(
		    DT_MA,
		    DT_TEN,
		    DT_SDT,
		    DT_EMAIL
		)
		VALUES
		(   @dt_ma,   -- DT_MA - char(10)
		    @HSDK_TENQUAN, -- DT_TEN - nvarchar(100)
		    @SDT, -- DT_SDT - char(10)
		    @HSDK_EMAIL  -- DT_EMAIL - nvarchar(100)
		    )
 	END TRY
	BEGIN CATCH
		PRINT 'LOI CHEN'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO


-- THEM CUA HANG
CREATE 
--alter
PROC sp_ThemCuaHang
	@DT_MA CHAR(10),
    @CH_TEN CHAR(100),
    @CH_TGMOCUA TIME,
    @CH_TGDONGCUA TIME,
    @CH_SDT CHAR(10),
    @CH_TINHTRANGHOATDONG NVARCHAR(100)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM dbo.DOITAC WHERE DT_MA = @DT_MA)
		BEGIN 
			PRINT 'DOI TAC KHONG KHONG TON TAI'
			ROLLBACK
			RETURN
		END

		IF (@DT_MA IS NULL AND @CH_TEN IS NULL AND @CH_SDT IS NULL AND @CH_TINHTRANGHOATDONG IS NULL)
		BEGIN 
			PRINT N'THONG TIN DAU VAO BI SAI'
		END

		DECLARE @CH_MA CHAR(10), @TMP INT
		SELECT @TMP = COUNT(*) + 1 FROM dbo.CUAHANG
		SET @CH_MA = 'CH_' + CAST(@TMP AS CHAR(10))

		INSERT INTO dbo.CUAHANG
		(
		    CH_MA,
		    DT_MA,
		    CH_TEN,
		    CH_TGMOCUA,
		    CH_TGDONGCUA,
		    CH_SDT,
		    CH_TINHTRANGHOATDONG
		)
		VALUES
		(   @CH_MA,   -- CH_MA - char(10)
		    @DT_MA, -- DT_MA - char(10)
		    @CH_TEN, -- CH_TEN - char(100)
		    @CH_TGMOCUA, -- CH_TGMOCUA - time(7)
		    @CH_TGDONGCUA, -- CH_TGDONGCUA - time(7)
		    @CH_SDT, -- CH_SDT - char(10)
		    @CH_TINHTRANGHOATDONG  -- CH_TINHTRANGHOATDONG - nvarchar(50)
		    )
	END TRY
	BEGIN CATCH
		PRINT N'LOI CHEN'
		ROLLBACK 
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

-- THEM CHI NHANH
CREATE 
--ALTER
PROC sp_themChiNhanh
	@DT_MA CHAR(10),
    @CH_MA CHAR(10),
    @DC_MATINH CHAR(10),
    @DC_MAHUYEN CHAR(10),
    @DC_MAXA CHAR(10),
    @CN_TEN NVARCHAR(100)
AS 
BEGIN TRANSACTION
	BEGIN TRY
		IF (@CH_MA IS NULL AND @CN_TEN IS NULL AND @DC_MATINH IS NULL AND @DC_MAHUYEN IS NULL AND @DC_MAXA IS NULL)
		BEGIN
		    PRINT 'THONG TIN DAU VAO LOI'
			ROLLBACK
			RETURN
		END
		IF NOT EXISTS (SELECT * FROM dbo.DIACHI WHERE DC_MATINH = @DC_MATINH AND
						DC_MAHUYEN = @DC_MAHUYEN AND DC_MAXA = @DC_MAXA)
		BEGIN
			PRINT 'DIA CHI KHONG TON TAI'
			ROLLBACK
			RETURN
		END 
		DECLARE @CN_MA CHAR(10), @TMP INT
		SELECT * FROM dbo.CHINHANH
		SET @CN_MA = 'CN_' + CAST(@TMP AS CHAR(10))

		INSERT INTO dbo.CHINHANH
		(
		    CN_MA,
		    CH_MA,
		    DC_MATINH,
		    DC_MAHUYEN,
		    DC_MAXA,
		    CN_TEN
		)
		VALUES
		(   @CN_MA,   -- CN_MA - char(10)
		    @CH_MA,   -- CH_MA - char(10)
		    @DC_MATINH, -- DC_MATINH - char(10)
		    @DC_MAHUYEN, -- DC_MAHUYEN - char(10)
		    @DC_MAXA, -- DC_MAXA - char(10)
		    @CN_TEN  -- CN_TEN - nvarchar(100)
		    )
	END TRY
	BEGIN CATCH
		PRINT 'LOI CHEN'
		ROLLBACK
		RETURN 
	END CATCH
COMMIT TRANSACTION
GO

--Thêm thực đơn
CREATE 
--ALTER
PROC sp_themThucDon 
	@CN_MA CHAR(10),
    @CH_MA CHAR(10),
    @TD_TEN CHAR(10)
AS
BEGIN TRANSACTION
	BEGIN TRY
	    IF (@CN_MA IS NULL AND @CH_MA IS NULL AND @TD_TEN IS NULL)
		BEGIN
			PRINT N'THONG TIN DAU VAO KHONG HOP LE'
			ROLLBACK
			RETURN
		END
		IF NOT EXISTS(SELECT * FROM dbo.CHINHANH WHERE CN_MA = @CN_MA AND @CH_MA = CH_MA)
		BEGIN
		    PRINT N'CHI NHANH KHONG TON TAI'
			ROLLBACK
			RETURN
		END
		DECLARE @TD_MA CHAR(10), @TMP INT
		SELECT @TMP = COUNT(*) + 1 FROM dbo.THUCDON
		SET @TD_MA = 'TD_' + CAST(@TMP AS CHAR(10))
		INSERT INTO dbo.THUCDON
		(
		    TD_MA,
		    CN_MA,
		    CH_MA,
		    TD_TEN
		)
		VALUES
		(   @TD_MA,  -- TD_MA - char(10)
		    @CN_MA,  -- CN_MA - char(10)
		    @CH_MA,  -- CH_MA - char(10)
		    @TD_TEN -- TD_TEN - char(10)
		    )
	END TRY
	BEGIN CATCH
		PRINT N'LOI CHEN'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO 

-- UPDATE CUA HANG
CREATE 
--drop
PROC sp_updateCuaHang
	@DT_MA CHAR(10),
	@CH_MA CHAR(10),
    @CH_TEN CHAR(100),
    @CH_SDT CHAR(10),
    @CH_TINHTRANGHOATDONG NVARCHAR(100)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF NOT EXISTS (SELECT * FROM dbo.DOITAC WHERE DT_MA = @DT_MA)
		BEGIN 
			PRINT 'DOI TAC KHONG KHONG TON TAI'
			ROLLBACK
			RETURN
		END

		IF (@DT_MA IS NULL AND @CH_TEN IS NULL AND @CH_SDT IS NULL AND @CH_TINHTRANGHOATDONG IS NULL)
		BEGIN 
			PRINT N'THONG TIN DAU VAO BI SAI'
		END

		UPDATE dbo.CUAHANG SET
		CH_TEN = @CH_TEN,
		CH_SDT=@CH_SDT,
		CH_TINHTRANGHOATDONG = @CH_TINHTRANGHOATDONG
		WHERE DT_MA = @DT_MA AND CH_MA = @CH_MA
		
	END TRY
	BEGIN CATCH
		PRINT N'LOI CHEN'
		ROLLBACK 
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

-- UPDATE THUC DON
CREATE 
--ALTER
PROC sp_updateThucDon 
	@TD_MA CHAR(10),
	@CN_MA CHAR(10),
    @CH_MA CHAR(10),
    @TD_TEN CHAR(10)
AS
BEGIN TRANSACTION
	BEGIN TRY
	    IF (@CN_MA IS NULL AND @CH_MA IS NULL AND @TD_TEN IS NULL)
		BEGIN
			PRINT N'THONG TIN DAU VAO KHONG HOP LE'
			ROLLBACK
			RETURN
		END
		IF NOT EXISTS(SELECT * FROM dbo.CHINHANH WHERE CN_MA = @CN_MA AND @CH_MA = CH_MA)
		BEGIN
		    PRINT N'CHI NHANH KHONG TON TAI'
			ROLLBACK
			RETURN
		END
		UPDATE dbo.THUCDON SET TD_TEN = @TD_TEN
		WHERE CH_MA = CH_MA AND CN_MA = @CN_MA AND CH_MA = CH_MA
	END TRY
	BEGIN CATCH
		PRINT N'LOI CHEN'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO 

--Update Chi Nhánh
CREATE 
--ALTER
PROC sp_updateChiNhanh
	@CN_MA CHAR(10),
	@DT_MA CHAR(10),
    @CH_MA CHAR(10),
    @CN_TEN NVARCHAR(100)
AS 
BEGIN TRANSACTION
	BEGIN TRY
		IF (@CH_MA IS NULL AND @CN_TEN IS NULL )
		BEGIN
		    PRINT 'THONG TIN DAU VAO LOI'
			ROLLBACK
			RETURN
		END
		
		UPDATE dbo.CHINHANH SET
		CN_TEN = @CN_TEN
		WHERE CN_MA = @CH_MA AND CH_MA = @CH_MA    
	END TRY
	BEGIN CATCH
		PRINT 'LOI UPDATE'
		ROLLBACK
		RETURN 
	END CATCH
COMMIT TRANSACTION
GO


--NHẬN ĐƠN HÀNG
create
--drop
proc sp_acceptOrder
@TX_MA char(10),
@DH_MA char(10),
@TTGH_TINHTRANG nvarchar(50),
@DC_MATINH char(10),
@DC_MAHUYEN char(10),
@DC_MAXA char(10)
as
BEGIN TRANSACTION
	BEGIN TRY
		IF (@TX_MA IS NULL AND @DH_MA IS NULL)
		BEGIN
		    PRINT N'THONG TIN KHONG HOP LE'
			ROLLBACK
			RETURN
		END
		IF (not exists(select* from DONHANG where DH_MA=@DH_MA))
		BEGIN
		    PRINT N'THONG TIN KHONG HOP LE'
			ROLLBACK
			RETURN
		END
		insert into TINHTRANGGIAOHANG(TX_MA,DH_MA,TTGH_TINHTRANG,DC_MATINH,DC_MAHUYEN,DC_MAXA) values(@TX_MA,@DH_MA,@TTGH_TINHTRANG,@DC_MATINH,@DC_MAHUYEN,@DC_MAXA)
		update DONHANG set DH_TINHTRANG=N'Đang giao' where DH_MA=@DH_MA
	END TRY
	BEGIN CATCH
		PRINT N'error!'
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

--xu ly đăng ký
create 
--alter
--drop
proc pr_taoUSER
	@user char(20),
	@password char(10),
	@loaitk CHAR(10)
as
begin transaction
	begin try
		-- user khac null
		if(@user is null)
		begin
			RAISERROR('user khong hop le',16,1)
			rollback transaction
			return
		end

		-- password khac null
		if(@password is null)
		begin
			RAISERROR('password khong hop le',16,1)
			rollback transaction
			return
		end
		declare @ma char(10)
		if(@loaitk = 'KHACHHANG')
		begin
			select @ma = 'KH_' + cast((count(tk.MA)+1) as char(10)) from TAIKHOAN tk where tk.MA like'KH_%'
		end

		if(@loaitk = 'TAIXE')
		begin
			select @ma = 'TX_' + cast((count(tk.MA)+1) as char(10)) from TAIKHOAN tk where tk.MA like'TX_%'
		end
		insert into TAIKHOAN values(@ma,@user,@password,@loaitk)
	end try
	begin catch 
		RAISERROR('tao login that bai',16,1)
		rollback transaction
		return
	end catch
commit transaction
go

--DUYỆT HỒ SƠ ĐĂNG KÝ
CREATE 
--alter
PROC sp_duyetHSDK 
	@HSDK_MA CHAR(10),
	@NV_MA CHAR(10)
AS
BEGIN TRANSACTION 
	BEGIN TRY
		IF NOT EXISTS(SELECT * FROM dbo.HOSODANGKY  WHERE  HSDK_MA = @HSDK_MA)
		BEGIN
		    ROLLBACK
			RETURN
		END 
		IF NOT EXISTS(SELECT * FROM dbo.NHANVIEN WHERE NV_MA = @NV_MA)
		BEGIN
		    ROLLBACK
			RETURN
		END 
		UPDATE dbo.HOSODANGKY
		SET NV_MA = @NV_MA
		WHERE HSDK_MA = @HSDK_MA

	END TRY
	BEGIN CATCH
		ROLLBACK
		RETURN
	END CATCH
COMMIT TRANSACTION
GO

create proc sp_CapNhatThongTinNhanVien
	@manv CHAR(10),
	@tennv nvarchar(100),
	@mailnv char(10),
	@gioitinhnv nvarchar(10),
	@cmndnv char(20),
	@sdtnv char(10)
as
begin tran
	begin try
		--mã khách hàng không tồn tại
		if not exists (select * from NHANVIEN where  NV_MA = @manv)
		begin 
			print N'Thông tin sai'
			rollback tran
		end
		update NHANVIEN
		set NV_TEN = @tennv, NV_SDT = @sdtnv, NV_MAIL = @mailnv, NV_GIOITINH = @gioitinhnv,
		NV_CMND=@cmndnv
		where NV_MA = @manv
	end try
	begin catch
		print N'lỗi hệ thống'
		rollback tran
	end catch
commit tran
GO 

select * from TAIKHOAN
select * from KHACHHANG
select * from DIACHI
select * from MONAN
select * from GIOHANG
select * from DONHANG
select * from CUAHANG
