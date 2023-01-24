DROP DATABASE CoffeeL;
CREATE DATABASE CoffeeL;
USE CoffeeL;

-- **********************************************************************************

-- 客户表
CREATE TABLE Customer (
	id CHAR (20) PRIMARY KEY,
	name CHAR (10),
	tel CHAR (11),
	pwd CHAR (128)
);

-- 管理员表
CREATE TABLE Admin (
	id CHAR (20) PRIMARY KEY,
	pwd CHAR (128),
	privilege SMALLINT
);

-- 收货地址表
CREATE TABLE ShipAddr (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	cust_id CHAR (16),
	addr VARCHAR (100),
	FOREIGN KEY (cust_id) REFERENCES Customer (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX cust_id_index ON ShipAddr (cust_id(8));

-- 商品品牌表
CREATE TABLE Brand (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	name CHAR (20)
);

-- 商品类别表
CREATE TABLE Category (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	name CHAR (20)
);

-- 商品表
CREATE TABLE Goods (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	name CHAR (30)
);

-- 商品细节信息表
CREATE TABLE GoodsDetail (
	id INT  PRIMARY KEY,
	cate_id INT ,
	brand_id INT ,
	purchase_price DECIMAL (8, 2),
	sale_price DECIMAL (8, 2),
	stock INT ,
	real_stock INT,
	sales_num INT ,
	description VARCHAR (500),
	FOREIGN KEY (id) REFERENCES Goods (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (cate_id) REFERENCES Category (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES Brand (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX cate_id_index ON GoodsDetail (cate_id);
CREATE INDEX brand_id_index ON GoodsDetail (brand_id);

-- 商品图片表
CREATE TABLE Image (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	url VARCHAR (100),
	goods_id INT ,
	FOREIGN KEY (goods_id) REFERENCES GoodsDetail (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX goods_id_index ON Image (goods_id);

-- 商品图片表
CREATE TABLE Cover (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	url VARCHAR (100),
	goods_id INT ,
	FOREIGN KEY (goods_id) REFERENCES GoodsDetail (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX goods_id_index ON Cover (goods_id);

-- 订单表
CREATE TABLE CustOrder (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	create_time DATETIME,
	pay_time DATETIME,
	goods_id INT ,
	cust_id CHAR (16),
	admin_id CHAR (16),
	shipaddr_id INT ,
	-- status: 0 已创建 1 已付款 2 已发货 3 已签收 4 已评价
	status SMALLINT ,
	quantity SMALLINT ,
	cost DECIMAL (8, 2),
	FOREIGN KEY (goods_id) REFERENCES Goods (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (cust_id) REFERENCES Customer (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (admin_id) REFERENCES Admin (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (shipaddr_id) REFERENCES ShipAddr (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK (status >= 0 AND status <= 4)
);
CREATE INDEX cust_id_index ON CustOrder (cust_id(16));
CREATE INDEX admin_id_index ON CustOrder (admin_id(16));
CREATE INDEX goods_id_index ON CustOrder (goods_id);

-- 客户评价表
CREATE TABLE Appraisal (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	score SMALLINT,
	order_id INT ,
	create_time DATETIME,
	content VARCHAR (100),
	FOREIGN KEY (order_id) REFERENCES CustOrder (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK (score >= 1 AND score <= 5)
);
CREATE INDEX order_id_index ON Appraisal (order_id);

-- 管理员盘点表
CREATE TABLE Inventory (
	id INT  PRIMARY KEY AUTO_INCREMENT,
	create_time DATETIME,
	goods_id INT ,
	admin_id CHAR (16),
	goods_stock INT,
	stock INT ,
	FOREIGN KEY (goods_id) REFERENCES Goods (id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (admin_id) REFERENCES Admin (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Admin VALUES ("admin", "pbkdf2:sha256:150000$ReEVRMsw$9b4d878541ab4090097fe16889dbd8c52375c05c6d48e02d71fee944c607a8ac", 100);
INSERT INTO Category (name) VALUES ("速溶咖啡"), ("咖啡豆"), ("植脂末");
INSERT INTO Brand (name) VALUES ("雀巢 Nescafe"), ("麦斯威尔 Maxwell"), ("星巴克 Starbucks"), ("吉意欧 GEO"), ("拉瓦萨 LAVAZZA");
