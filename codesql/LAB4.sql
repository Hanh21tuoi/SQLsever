--Tạo cơ sỡ dữ liệu
use master
	if exists(select name from master .sys.databases where name ='hanh')
		begin
	--xoa csdl
			drop database hanh
			create database hanh
				on(Name = hanh ,Filename = 'C:\SQL\hanh',
					Size=3MB,Maxsize=10MB ,Filegrowth=10%)
		end
	else
		create database hanh
		on(Name = hanh ,Filename = 'C:\SQL\hanh',
					Size=3MB,Maxsize=10MB ,Filegrowth=10%)
	go
use hanh
	go
--TAO BANG
create table KhachHang(
	Makh char(4) not null,
	Hoten varchar(40)not null,
	DiaChi varchar(50)not null,
	Sodt varchar(20)not null,
	Ngaysinh date,
	NGDK date,
	Doanhso money
	)
create table NhanVien(
	Manv char(4) not null,
	Hoten varchar(40)not null,
	Sodt varchar(20)not null,
	NGVL date 
	)
create table SanPham(
	MaSP char(4) not null,
	TenSP varchar(40)not null,
	DVT varchar(20)not null,
	NuocSX varchar(40)not null,
	Gia money
	)
create table HoaDon(
	SoHD int not null,
	NgMH date not null,
	Makh Char(4) not null,
	Manv char(4) not null,
	TriGia money
	)
create table CTHD(
	SoHD int not null,
	MaSP char(4)not null,
	SL int
	)
--Khoa chinh ,khoa ngoai
alter table KhachHang
	add
		constraint pk_KhachHang primary key (Makh)
alter table NhanVien
	add
		constraint pk_NhanVien primary key (Manv)
alter table SanPham
	add
		constraint pk_SanPham primary key (MaSP)
alter table HoaDon
	add
		constraint pk_HoaDon primary key (SoHD),
		constraint fk_HoaDon_Makh foreign key (Makh) references KhachHang(Makh),
		constraint fk_HoaDon_Manv foreign key (Manv) references NhanVien(Manv)
alter table CTHD
	add
		constraint pk_CTHD primary key (SoHD,MaSP),
		constraint fk_CTHD_SoHD foreign key (SoHD) references HoaDon(SoHD),		
		constraint fk_CTHD_MaSP foreign key (MaSP) references SanPham(MaSP)
		
--theme
alter table SanPham
	add
		GhiChu varchar(20)
alter table KhachHang
	add
		LoaiKh tinyint
--doi kieu du lieu
alter table SanPham
alter column GhiChu varchar(100)
--xoa
alter table SanPham
	drop column GhiChu
alter table SanPham
	add
		Constraint chk_SanPham_Gia check (Gia>=500)
alter table CTHD
	add
		Constraint chk_CTHD_SL check(SL>=1)
alter table KhachHang
	add
		constraint chk_KhachHang_NGDK check (NGDK > Ngaysinh)
go
set dateformat dmy
go
insert into KhachHang (Makh,Hoten,DiaChi,Sodt,Ngaysinh,NGDK,Doanhso)
	values
		('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','8823451','22/10/1960','22/07/2006',13060000),
		('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','908256478','03/04/1974','30/07/2006',280000),
		('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','938776266','12/06/1980','08/05/2006',3860000),
		('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','917325476','09/03/1965','10/02/2006',250000),
		('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','8246108','10/03/1950','28/10/2006',21000),
		('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','8631738','31/12/1981','24/11/2006',915000)
		

insert into NhanVien (Manv,Hoten,Sodt,NGVL) 
values
('NV01','Nguyen Nhu Nhut','927345678','13/04/2006'),
('NV02','Le Thi Phi Yen','987567390','21/04/2006'),
('NV03','Nguyen Van B','997047382','27/04/2006'),
('NV04','Ngo Thanh Tuan','913758498','24/06/2006'),
('NV05','Nguyen Thi Truc Thanh','918590387','20/07/2006')

insert into SanPham ( MaSP,TenSP,DVT,NuocSX,Gia)
values('BC01','But chi','cay','Singapore',3000),
		('BC02','But chi','cay','Singapore',5000),
		('BC03','But chi','cay','Viet Nam',3500),
		('BC04','But chi','hop','Viet Nam',30000),
		('BB01','But bi','cay','Viet Nam',5000),
		('BB02','But bi','cay','Trung Quoc',7000),
		('BB03','But bi','hop','Thai Lan',100000),
		('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)


insert into  HoaDon (SoHD,NgMH,Makh,Manv,TriGia)
values
(1001,'23/07/2006','KH01','NV01',320000),
(1002,'12/08/2006','KH01','NV02',840000),
(1003,'23/08/2006','KH02','NV01',100000),
(1004,'01/09/2006','KH02','NV01',180000),
(1005,'20/10/2006','KH01','NV02',3800000),
(1006,'16/10/2006','KH01','NV03',2430000),
(1007,'28/10/2006','KH03','NV03',510000),
(1008,'28/10/2006','KH01','NV03',440000)


insert into CTHD (SoHD,MaSP,SL)
values
(1001,'TV01',10),
(1001,'BC03',5),
(1001,'BC01',5),
(1001,'BC02',10),
(1001,'BB03',10),
(1002,'BC04',20)


UPDATE SanPham--7 
SET Gia=Gia+Gia/(100/5) 
WHERE NuocSX='Thai Lan'
UPDATE SanPham--8 
SET Gia=Gia/(100/5)+Gia 
WHERE NuocSX='Thai Lan' AND Gia>1000
select * from SanPham
--7
update SanPham
set Gia = Gia + Gia*0.05
where NuocSX = 'Thai Lan'
--8
update SanPham
set Gia = Gia*0.95
where NuocSX = 'Trung Quoc' and Gia <= 10000
--bài tập ngày 28/2
--1
SELECT MaSP,TenSP
from SanPham
where NuocSX = 'Trung Quoc'
--2
select MaSP,TenSP
from SanPham
where DVT in ('cay','quyen')
--3
select MaSP,TenSP
from SanPham
where MaSP like 'B%' and MaSP like '%01'
--4
select MaSP,TenSP
from SanPham
where NuocSX = 'Trung Quoc' and (Gia between  30000 and 40000)
--5
select MaSP,TenSP
from SanPham
where NuocSX in ('Trung Quoc', 'Thai Lan') and  Gia between  30000 and 40000
--6
select * from HoaDon
select SoHD,TriGia
from HoaDon
where NgMH between '1-1-2007' and ' 1-2-2007'
--7
select SoHD,TriGia
from HoaDon
where NgMH between '1-1-2007' and ' 31-1-2007'
--8
select kh.Makh,kh.Hoten
from KhachHang as kh
	inner join HoaDon as hd
	on kh.Makh=hd.Makh
where NgMH = '1-1-2007'
--9
select hd.SoHD,hd.TriGia
from HoaDon as hd
	inner join KhachHang as kh
	on kh.Makh = hd.Makh
where kh.Hoten = 'Nguyen nhu nha'
--10
select sp.MaSP,sp.TenSP
from SANPHAM as sp
	inner join CTHD as ct
	on sp.MaSP = ct.MaSP
	inner join HoaDon as hd
	on hd.SoHD =ct.SoHD
	inner join KhachHang as kh
	on hd.Makh = kh.Makh
where kh.Hoten = 'Nguyen nhu nha' and hd.NgMH between '1-10-2006' and '31-10-2006'
--11

select hd.SoHD
from HoaDon as hd
	inner join CTHD as ct
	on hd.SoHD = ct.SoHD
where ct.MaSP='BC01' or ct.MaSP = 'BC02'
--12
select hd.SoHD
from HoaDon as hd
	inner join CTHD as ct
	on hd.SoHD = ct.SoHD
where (ct.MaSP='BC01' or ct.MaSP = 'BC02') and (ct.SL between 10 and 20)
--13
select hd.SoHD
from HOADON as hd
	inner join CTHD as ct
	on hd.SoHD = ct.SoHD
where ct.MaSP='BC01'  and (ct.SL between 10 and 20) and hd.SoHD in (select hd.SOHD 
							from HoaDon as hd
								inner join CTHD as ct
								on hd.SoHD = ct.SoHD
							where ct.MaSP = 'BC02'  and (ct.SL between 10 and 20))
--14
select *from SanPham
select sp.MaSP,sp.TenSP
from SanPham as sp
	inner join CTHD as ct
	on ct.MaSP = sp.MaSP
	inner join HoaDon as hd
	on hd.SoHD = ct.SoHD
where sp.NuocSX = 'Trung Quoc' or hd.NgMH = '1-1-2007'
--15
select sp.MaSP,sp.TenSP
from SanPham as sp
	right join CTHD as ct
	on sp.MaSP = ct.MaSP
where ct.SL <1
select *from SanPham
select *from HoaDon
--16
select sp.MaSP,sp.TenSP
from SANPHAM as sp
	right join CTHD as ct
	on sp.MaSP = ct.MaSP
	inner join HoaDon as hd
	on hd.SoHD=ct.SoHD
where ct.SL <1 and (YEAR(hd.NgMH) = 2006)
--17
select sp.MaSP,sp.TenSP
from SANPHAM as sp
	right join CTHD as ct
	on sp.MaSP = ct.MaSP
	inner join HoaDon as hd
	on hd.SoHD=ct.SoHD
where (sp.NuocSX = 'Trung Quoc') and (YEAR(hd.NgMH) = 2006) and (ct.SL<1)	
		

--18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.		
select  cthd.SoHD, hd.Makh, sp.NuocSX from HoaDon as hd
	inner join CTHD as cthd
	on hd.SoHD = cthd.SoHD
	inner join SanPham as sp
	on cthd.MaSP = sp.MaSP
	where sp.NuocSX = 'Singapore'
	group by cthd.SoHD, hd.Makh, sp.NuocSX

	--19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
select  cthd.SoHD, hd.Makh, sp.NuocSX, count(hd.SoHD) as SoLanMua from HoaDon as hd
	inner join CTHD as cthd
	on hd.SoHD = cthd.SoHD
	inner join SanPham as sp
	on cthd.MaSP = sp.MaSP
	where year(hd.NgMH) = 2006 and sp.NuocSX = 'Singapore'
	group by cthd.SoHD, hd.Makh, sp.NuocSX
	having count(hd.SoHD) > 0

	--20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
select kh.Makh, kh.Hoten from KhachHang as kh
	right join HoaDon as hd
	on kh.Makh = hd.Makh
	where hd.Makh is null
	group by kh.Makh, kh.Hoten

	--21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
select  sp.NuocSX from HoaDon as hd
	inner join CTHD as cthd
	on hd.SoHD = cthd.SoHD
	inner join SanPham as sp
	on cthd.MaSP = sp.MaSP
	where year(hd.NgMH) = 2006
	group by  sp.NuocSX

	--22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
select max(hd.TriGia) as TGCN, min(hd.TriGia) as TGTN from HoaDon as hd

	--23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
select avg(hd.TriGia) as TGTB from HoaDon as hd
where year(hd.NgMH) = 2006

	--24. Tính doanh thu bán hàng trong năm 2006.
select  DoanhThu = sum(hd.TriGia) from HoaDon as hd
	inner join CTHD as cthd
	on hd.SoHD = cthd.SoHD
	where year(hd.NgMH) = 2006

	--25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
select * from HoaDon as hd
	left join CTHD as cthd
	on hd.SoHD = cthd.SoHD

	--26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
select kh.Hoten, max(hd.TriGia) from HoaDon as hd
	inner join KhachHang kh
	on hd.Makh = kh.Makh
	where hd.TriGia = (select max(hd.TriGia) from HoaDon as hd)
	group by kh.Hoten
	-- 27 In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
select top 3 kh.MaKH,kh.HoTen,kh.DoanhSo  from KhachHang as kh

    




	


