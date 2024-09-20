﻿-- Tạo database quản lí bán hàng
CREATE DATABASE QUANLIBANHANG 

USE QUANLIBANHANG

-- Tạo các bảng của database
CREATE TABLE KHACHHANG(
	MAKH char(4) PRIMARY KEY,
	HOTEN varchar(40),
	DIACHI varchar(50),
	SDT varchar(20),
	NGSINH smalldatetime,
	DOANHSO money,
	NGDK smalldatetime,
);

CREATE TABLE NHANVIEN(
	MANV char(4) PRIMARY KEY,
	HOTEN varchar(40),
	NGVL smalldatetime,
	SDT varchar(20),
);

CREATE TABLE SANPHAM(
	MASP char(4) PRIMARY KEY,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(20),
	GIA money,
);

CREATE TABLE HOADON(
	SOHD int PRIMARY KEY,
	NGHD smalldatetime,
	MAKH char(4) REFERENCES KHACHHANG(MAKH),
	MANV char(4) REFERENCES NHANVIEN(MANV),
	TRIGIA money,
);

CREATE TABLE CTHD(
	SOHD int REFERENCES HOADON(SOHD),
	MASP char(4) REFERENCES SANPHAM(MASP),
	SL int CHECK (SL >= 1),
	PRIMARY KEY (SOHD, MASP),
);

-- 2.	Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
ALTER TABLE SANPHAM
ADD GHICHU VARCHAR(20)

-- 3.	Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
ALTER TABLE KHACHHANG
ADD LOAIKH TINYINT

-- 4.	Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU VARCHAR(100)

-- 5.	Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
ALTER TABLE SANPHAM
DROP COLUMN GHICHU

-- 6.	Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, …
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH VARCHAR(20)

-- 7.	Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
ALTER TABLE SANPHAM ADD 
CONSTRAINT CK_DVT CHECK(DVT in ('cay', 'hop', 'cai', 'quyen', 'chuc'))

-- 8.	Giá bán của sản phẩm từ 500 đồng trở lên.
ALTER TABLE SANPHAM ADD
CONSTRAINT CK_GIA CHECK (GIA > 500)

-- 9.	Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm. Đã thêm sẵn trên quan hệ.

-- 10.	Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
ALTER TABLE KHACHHANG ADD 
CONSTRAINT CK_NGDK CHECK(NGDK > NGSINH)