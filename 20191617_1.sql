CREATE TABLE Customer
( 
	customer_id 	integer  NOT NULL ,
	name           	varchar(18)  NOT NULL ,
    address            varchar(50)  NOT NULL ,
	PRIMARY KEY  (customer_id)
);
CREATE TABLE Shipper
( 
	shipper_id  	integer  NOT NULL ,
	name           	varchar(18)  NOT NULL ,
	account_number 	varchar(50)  NOT NULL ,
	PRIMARY KEY  (shipper_id)
);
CREATE TABLE Service
( 
	service_id         	integer  NOT NULL ,
	weight           	integer  NOT NULL ,
	type_of_package   	varchar(18)  NOT NULL ,
	timeliness      	datetime  NOT NULL ,
	arrive_time      	datetime  NULL ,
	PRIMARY KEY  (service_id)
);
CREATE TABLE Recipient
( 
	recipient_id       integer  NOT NULL ,
	name               varchar(18)  NOT NULL ,
	address            varchar(50)  NOT NULL ,
	PRIMARY KEY (recipient_id)
);
CREATE TABLE Package
( 
	package_id			integer  NOT NULL ,
	is_delivered       	boolean  NOT NULL ,
	customer_id        	integer  NOT NULL ,
	shipper_id         	integer  NOT NULL ,
	service_id         	integer  NOT NULL ,
	recipient_id       	integer  NOT NULL ,
	PRIMARY KEY (package_id),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	FOREIGN KEY (shipper_id) REFERENCES Shipper(shipper_id),
	FOREIGN KEY (service_id) REFERENCES Service(service_id),
	FOREIGN KEY (recipient_id) REFERENCES Recipient(recipient_id)
);
CREATE TABLE Shippment
( 
	shippment_id   	integer  NOT NULL ,
	PRIMARY KEY  (shippment_id)
);
CREATE TABLE Pack_ship
( 
	package_id    	integer  NOT NULL ,
	shippment_id   	integer  NOT NULL ,
	PRIMARY KEY  (package_id,shippment_id),
	FOREIGN KEY  (package_id) REFERENCES Package(package_id),
	FOREIGN KEY (shippment_id) REFERENCES Shippment(shippment_id)
);
CREATE TABLE International
( 
	customs_declaration_id integer  NOT NULL ,
	package_id         integer  NOT NULL ,
	content            varchar(18)  NOT NULL ,
	value             integer  NOT NULL 
		constraint value check (value >= 800),
	PRIMARY KEY  (customs_declaration_id),
	FOREIGN KEY (package_id) REFERENCES Package(package_id)
);
CREATE TABLE Hazardous
( 
	package_id         integer  NOT NULL ,
	hazardous_type     varchar(18)  NOT NULL ,
	PRIMARY KEY  (package_id, hazardous_type),
	 FOREIGN KEY (package_id) REFERENCES Package(package_id)
);
CREATE TABLE Transportation
( 
	transportation_id	integer  NOT NULL ,
    type_of_transport  	varchar(18)  NOT NULL ,
	PRIMARY KEY  (transportation_id)
);
CREATE TABLE Warehouse
( 
	warehouse_id	integer  NOT NULL ,
	PRIMARY KEY  (warehouse_id)
);
CREATE TABLE Trans_use
( 
	shippment_id       	integer  NOT NULL ,
	transportation_id  	integer  NOT NULL ,
	start_time	    	datetime  NOT NULL ,
	end_time           	datetime  NULL ,
	PRIMARY KEY  (shippment_id, transportation_id),
	FOREIGN KEY (shippment_id) REFERENCES Shippment(shippment_id),
	FOREIGN KEY (transportation_id) REFERENCES Transportation(transportation_id)
);
CREATE TABLE Ware_visit
( 
	shippment_id       	integer  NOT NULL ,
	warehouse_id       	integer  NOT NULL ,
	start_time         	datetime  NOT NULL ,
	end_time          	datetime  NULL ,
	PRIMARY KEY  (shippment_id, warehouse_id),
	FOREIGN KEY (shippment_id) REFERENCES Shippment(shippment_id),
	FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);
CREATE TABLE Payment
( 
	payment_id       	integer  NOT NULL ,
	is_prepaid         	boolean  NOT NULL ,
	amount             	integer  NOT NULL ,
	pay_method         	varchar(18)  NOT NULL ,
	pay_date         	datetime  NOT NULL ,
	customer_id        	integer  NOT NULL ,
	shipper_id         	integer  NOT NULL ,
    package_id         	integer  NOT NULL ,
	PRIMARY KEY (payment_id),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	FOREIGN KEY (shipper_id) REFERENCES Shipper(shipper_id),
	FOREIGN KEY (package_id) REFERENCES Package(package_id)
);
CREATE TABLE Bill
( 
	bill_id        	integer  NOT NULL ,
	bill_date      	datetime  NOT NULL ,
	customer_id    	integer  NOT NULL ,
	PRIMARY KEY  (bill_id),
	 FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE Bill_pay
( 
	payment_id     	integer  NOT NULL ,
	bill_id    		integer  NOT NULL ,
	PRIMARY KEY  (payment_id),
	 FOREIGN KEY (payment_id) REFERENCES Payment(payment_id),
	 FOREIGN KEY (bill_id) REFERENCES Bill(bill_id)
);
insert into Customer values(1001, 'John Smith','123 Main Street, CityA, StateX');
insert into Customer values(1002, 'Jane Doe','789 Oak Drive, CityC, StateZ');
insert into Customer values(1003, 'Emily Johnson','456 Elm Avenue, CityB, StateY');
insert into Customer values(1004, 'Michael Brown','321 Maple Court, CityE, StateW');
insert into Customer values(1005, 'Sophia Lee','987 Pine Lane, CityD, StateV');
insert into Customer values(1006, 'Daniel Johnson','654 Cedar Road, CityF, StateU');
insert into Shipper values(2001, 'Tony Stark', 'SH123456');
insert into Shipper values(2002, 'Won Ik', 'SH789012');
insert into Shipper values(2003, 'Harry Styles', 'SH789012');
insert into Shipper values(2004, 'Emma Watson', 'KM345678');
insert into Shipper values(2005, 'Park Ji-sung', 'KM901234');
insert into Shipper values(2006, 'Alexandra Kim', 'WR567890');
insert into Shipper values(2007, 'frank ocean', 'WR123789');
insert into Service values(3001, 2, 'envelope', '2023-06-08 10:00:00', NULL);
insert into Service values(3002, 5, 'small box', '2023-06-08 14:30:00', '2023-06-09 14:00:00');
insert into Service values(3003, 15, 'medium box', '2023-06-11 08:00:00', NULL);
insert into Service values(3004, 8, 'envelope', '2023-06-10 09:00:00', NULL);
insert into Service values(3005, 12, 'medium box', '2023-06-12 13:30:00', '2023-06-09 14:00:00');
insert into Service values(3006, 20, 'large box', '2023-06-12 15:00:00', NULL);
insert into Service values(3007, 7, 'envelope', '2023-06-13 12:30:00', '2023-06-09 14:00:00');
insert into Service values(3008, 14, 'large box', '2023-06-13 13:00:00', NULL);
insert into Service values(3009, 15, 'large box', '2023-06-14 13:00:00', NULL);
insert into Service values(3010, 8, 'small box', '2023-06-17 13:00:00', NULL);
insert into Service values(3011, 1, 'envelope', '2023-06-15 13:00:00', NULL);
insert into Service values(3012, 10, 'medium box', '2023-06-13 13:00:00', NULL);
insert into Service values(3013, 11, 'medium box', '2023-05-18 15:00:00', '2023-05-19 16:00:00');
insert into Service values(3014, 15, 'large box', '2023-05-20 13:00:00', '2023-05-19 16:00:00');
insert into Service values(3015, 16, 'large box', '2023-05-17 16:00:00', '2023-05-19 16:00:00');
insert into Service values(3016, 1, 'envelope box', '2023-05-18 17:00:00', '2023-05-19 16:00:00');
insert into Service values(3017, 3, 'small box', '2023-05-20 16:00:00', '2023-05-19 17:00:00');
insert into Service values(3018, 5, 'small box', '2023-05-17 15:00:00', '2023-05-19 17:00:00');
insert into Service values(3019, 4, 'small box', '2023-05-21 18:00:00', '2023-05-20 18:00:00');
insert into Service values(3020, 6, 'medium box', '2023-05-22 11:00:00', '2023-05-20 18:00:00');
insert into Service values(3021, 7, 'medium box', '2023-05-19 12:00:00', '2023-05-20 18:00:00');
insert into Service values(3022, 10, 'medium box', '2023-05-16 15:00:00', '2023-05-20 16:00:00');
insert into Service values(3023, 15, 'large box', '2023-05-21 16:00:00', '2023-05-20 16:00:00');
insert into Service values(3024, 12, 'large box', '2023-05-22 17:00:00', '2023-05-20 16:00:00');
insert into Recipient values(4001, 'David Johnson', '789 Maple Avenue');
insert into Recipient values(4002, 'Sarah Williams', '321 Oak Street');
insert into Recipient values(4003, 'kyuho Lee', '321 yeouido Street');
insert into Recipient values(4004, 'Alexis Brown', '456 Pine Street');
insert into Recipient values(4005, 'Ryan Wilson', '789 Elm Avenue');
insert into Recipient values(4006, 'Alexis Brown', '456 Pine Street');
insert into Recipient values(4007, 'Ryan Wilson', '789 Elm Avenue');
insert into Package values(1, false, 1001, 2001, 3001, 4001);
insert into Package values(2, true, 1002, 2002, 3002, 4002);
insert into Package values(3, false, 1002, 2003, 3003, 4003);
insert into Package values(4, false, 1003, 2004, 3006, 4004);
insert into Package values(5, true, 1004, 2005, 3005, 4005);
insert into Package values(6, true, 1005, 2004, 3007, 4004);
insert into Package values(7, false, 1006, 2007, 3004, 4005);
insert into Package values(8, false, 1006, 2002, 3008, 4007);
insert into Package values(9, false, 1003, 2001, 3009, 4001);
insert into Package values(10, false, 1001, 2003, 3011, 4006);
insert into Package values(11, false, 1004, 2003, 3010, 4007);
insert into Package values(12, false, 1006, 2006, 3012, 4002);
insert into Package values(13, true, 1002, 2001, 3013, 4006);
insert into Package values(14, true, 1003, 2002, 3014, 4007);
insert into Package values(15, true, 1004, 2003, 3015, 4002);
insert into Package values(16, true, 1001, 2004, 3016, 4003);
insert into Package values(17, true, 1005, 2005, 3017, 4001);
insert into Package values(18, true, 1006, 2004, 3018, 4004);
insert into Package values(19, true, 1002, 2007, 3019, 4007);
insert into Package values(20, true, 1004, 2002, 3020, 4005);
insert into Package values(21, true, 1004, 2001, 3021, 4004);
insert into Package values(22, true, 1002, 2003, 3022, 4001);
insert into Package values(23, true, 1003, 2003, 3023, 4004);
insert into Package values(24, true, 1006, 2006, 3024, 4003);
insert into Shippment values(101);
insert into Shippment values(102);
insert into Shippment values(103);
insert into Shippment values(104);
insert into Shippment values(105);
insert into Shippment values(106);
insert into Shippment values(107);
insert into Shippment values(108);
insert into Shippment values(109);
insert into Shippment values(110);
insert into Shippment values(111);
insert into Shippment values(112);
insert into Shippment values(113);
insert into Shippment values(114);
insert into Shippment values(115);
insert into Shippment values(116);
insert into Pack_ship values(1,101);
insert into Pack_ship values(3,101); 
insert into Pack_ship values(4,101);
insert into Pack_ship values(2, 102);
insert into Pack_ship values(5, 102);
insert into Pack_ship values(6, 102);
insert into Pack_ship values(2, 103);
insert into Pack_ship values(5, 103);
insert into Pack_ship values(6, 103);
insert into Pack_ship values(7, 104);
insert into Pack_ship values(8, 104);
insert into Pack_ship values(7, 105);
insert into Pack_ship values(1, 106);
insert into Pack_ship values(3, 106);
insert into Pack_ship values(4, 106);
insert into Pack_ship values(9, 107);
insert into Pack_ship values(10, 107);
insert into Pack_ship values(11, 107);
insert into Pack_ship values(12, 107);
insert into Pack_ship values(9, 108);
insert into Pack_ship values(10, 108);
insert into Pack_ship values(11, 108);
insert into Pack_ship values(12, 109);
insert into Pack_ship values(12, 110);
insert into Pack_ship values(13, 111);
insert into Pack_ship values(14, 111);
insert into Pack_ship values(15, 111);
insert into Pack_ship values(16, 111);
insert into Pack_ship values(17, 111);
insert into Pack_ship values(18, 111);
insert into Pack_ship values(19, 112);
insert into Pack_ship values(20, 112);
insert into Pack_ship values(21, 112);
insert into Pack_ship values(22, 112);
insert into Pack_ship values(23, 112);
insert into Pack_ship values(24, 112);
insert into Pack_ship values(13, 113);
insert into Pack_ship values(14, 113);
insert into Pack_ship values(15, 113);
insert into Pack_ship values(16, 113);
insert into Pack_ship values(17, 114);
insert into Pack_ship values(18, 114);
insert into Pack_ship values(19, 115);
insert into Pack_ship values(20, 115);
insert into Pack_ship values(21, 115);
insert into Pack_ship values(22, 116);
insert into Pack_ship values(23, 116);
insert into Pack_ship values(24, 116);
insert into International values(9001, 7, 'alcohol', 1000);
insert into Hazardous values(2, 'explosive');
insert into Hazardous values(7, 'flammable');
insert into Hazardous values(19, 'flammable');
insert into Transportation values(201, 'truck');
insert into Transportation values(202, 'truck');
insert into Transportation values(203, 'truck');
insert into Transportation values(204, 'truck');
insert into Transportation values(205, 'airplane');
insert into Transportation values(206, 'truck');
insert into Warehouse values(301);
insert into Warehouse values(302);
insert into Warehouse values(303);
insert into Warehouse values(304);
insert into Warehouse values(305);
insert into Trans_use values(103, 201, '2023-06-09 09:00:00', '2023-06-09 14:00:00');
insert into Trans_use values(102, 203, '2023-06-08 11:00:00', '2023-06-08 16:00:00');
insert into Trans_use values(105, 205, '2023-06-09 10:00:00', NULL);
insert into Trans_use values(106, 203, '2023-06-09 09:00:00', NULL);
insert into Trans_use values(108, 202, '2023-06-12 10:00:00', '2023-06-12 15:00:00');
insert into Trans_use values(109, 204, '2023-06-12 10:00:00', NULL);
insert into Trans_use values(113, 201, '2023-05-19 07:00:00', '2023-05-19 16:00:00');
insert into Trans_use values(114, 202, '2023-05-19 07:00:00', '2023-05-19 17:00:00');
insert into Trans_use values(115, 203, '2023-05-20 09:00:00', '2023-05-20 18:00:00');
insert into Trans_use values(116, 206, '2023-05-20 09:00:00', '2023-05-20 16:00:00');
insert into Ware_visit values(101, 301, '2023-06-07 15:00:00', '2023-06-09 09:00:00');
insert into Ware_visit values(102, 302, '2023-06-08 16:00:00', '2023-06-09 09:00:00');
insert into Ware_visit values(104, 303, '2023-06-08 17:00:00', '2023-06-09 10:00:00');
insert into Ware_visit values(107, 305, '2023-06-11 18:00:00', '2023-06-12 10:00:00');
insert into Ware_visit values(110, 304, '2023-06-12 15:00:00', NULL);
insert into Ware_visit values(111, 303, '2023-05-18 14:00:00', '2023-05-19 07:00:00');
insert into Ware_visit values(112, 305, '2023-05-19 09:00:00', '2023-05-20 09:00:00');
insert into Payment values(7001, false, 130, 'bill','2023-06-15 10:00:00',1001,2001, 1);
insert into Payment values(7002, false, 110, 'bill','2023-06-15 10:00:00',1002,2002, 2);
insert into Payment values(7003, false, 210, 'bill','2023-06-15 10:00:00',1002,2003, 3);
insert into Payment values(7004, false, 90, 'bill', '2023-06-15 10:00:00', 1003, 2004, 4);
insert into Payment values(7005, false, 150, 'bill', '2023-06-15 10:00:00', 1004, 2005, 5);
insert into Payment values(7006, true, 90, 'credit card', '2023-06-05 21:00:00', 1005, 2004, 6);
insert into Payment values(7007, false, 1000, 'bill', '2023-06-15 10:00:00', 1006, 2007, 7);
insert into Payment values(7008, false, 250, 'bill', '2023-06-15 10:00:00', 1006, 2002, 8);
insert into Payment values(7009, false, 200, 'bill', '2023-06-15 10:00:00', 1003, 2001, 9);
insert into Payment values(7010, false, 350, 'bill', '2023-06-15 10:00:00', 1001, 2003, 10);
insert into Payment values(7011, false, 30, 'bill', '2023-06-15 10:00:00', 1004, 2003, 11);
insert into Payment values(7012, false, 140, 'bill', '2023-06-15 10:00:00', 1006, 2006, 12);
insert into Payment values(7013, false, 210, 'bill','2023-05-15 10:00:00',1002,2001, 13);
insert into Payment values(7014, false, 240, 'bill','2023-05-15 10:00:00',1003,2002, 14);
insert into Payment values(7015, false, 90, 'bill','2023-05-15 10:00:00',1004,2003, 15);
insert into Payment values(7016, false, 120, 'bill', '2023-05-15 10:00:00', 1001, 2004, 16);
insert into Payment values(7017, false, 150, 'credit card', '2023-05-01 16:00:00', 1005, 2005, 17);
insert into Payment values(7018, false, 100, 'bill', '2023-05-15 10:00:00', 1006, 2004, 18);
insert into Payment values(7019, false, 400, 'bill', '2023-05-15 10:00:00', 1002, 2007, 19);
insert into Payment values(7020, false, 550, 'bill', '2023-05-15 10:00:00', 1004, 2002, 20);
insert into Payment values(7021, false, 210, 'bill', '2023-05-15 10:00:00', 1004, 2001, 21);
insert into Payment values(7022, false, 270, 'bill', '2023-05-15 10:00:00', 1002, 2003, 22);
insert into Payment values(7023, false, 60, 'bill', '2023-05-15 10:00:00', 1003, 2003, 23);
insert into Payment values(7024, false, 170, 'bill', '2023-05-15 10:00:00', 1006, 2006, 24);
insert into Bill values(5001, '2023-06-15 10:00:00',1001);
insert into Bill values(5002, '2023-06-15 10:00:00', 1002);
insert into Bill values(5003, '2023-06-15 10:00:00', 1003);
insert into Bill values(5004, '2023-06-15 10:00:00', 1004);
insert into Bill values(5005, '2023-06-15 10:00:00', 1006);
insert into Bill values(5006, '2023-05-15 10:00:00',1001);
insert into Bill values(5007, '2023-05-15 10:00:00', 1002);
insert into Bill values(5008, '2023-05-15 10:00:00', 1003);
insert into Bill values(5009, '2023-05-15 10:00:00', 1004);
insert into Bill values(5010, '2023-05-15 10:00:00', 1006);
insert into Bill_pay values(7001, 5001);
insert into Bill_pay values(7002, 5002);
insert into Bill_pay values(7003, 5002);
insert into Bill_pay values(7004, 5003);
insert into Bill_pay values(7005, 5004);
insert into Bill_pay values(7007, 5005);
insert into Bill_pay values(7008, 5005);
insert into Bill_pay values(7009, 5003);
insert into Bill_pay values(7010, 5001);
insert into Bill_pay values(7011, 5004);
insert into Bill_pay values(7012, 5005);
insert into Bill_pay values(7013, 5007);
insert into Bill_pay values(7014, 5008);
insert into Bill_pay values(7015, 5009);
insert into Bill_pay values(7016, 5006);
insert into Bill_pay values(7018, 5010);
insert into Bill_pay values(7019, 5007);
insert into Bill_pay values(7020, 5009);
insert into Bill_pay values(7021, 5009);
insert into Bill_pay values(7022, 5007);
insert into Bill_pay values(7023, 5008);
insert into Bill_pay values(7024, 5010);
insert into Service values(3025, 6, 'envelope', '2022-10-08 10:00:00', NULL);
insert into Service values(3026, 15, 'large box', '2022-10-08 14:30:00', '2022-10-09 14:00:00');
insert into Service values(3027, 15, 'large box', '2022-10-11 08:00:00', NULL);
insert into Service values(3028, 8, 'envelope', '2022-10-10 09:00:00', NULL);
insert into Service values(3029, 12, 'medium box', '2022-10-12 13:30:00', '2022-10-09 14:00:00');
insert into Service values(3030, 20, 'large box', '2022-10-12 15:00:00', NULL);
insert into Service values(3031, 7, 'envelope', '2022-10-13 12:30:00', '2022-10-09 14:00:00');
insert into Service values(3032, 14, 'large box', '2022-10-13 13:00:00', NULL);
insert into Service values(3033, 11, 'large box', '2022-10-14 13:00:00', NULL);
insert into Service values(3034, 3, 'small box', '2022-10-17 13:00:00', NULL);
insert into Service values(3035, 6, 'envelope', '2022-10-15 13:00:00', NULL);
insert into Service values(3036, 14, 'medium box', '2022-10-13 13:00:00', NULL);
insert into Service values(3037, 1, 'small box', '2022-11-18 15:00:00', '2022-11-19 16:00:00');
insert into Service values(3038, 12, 'large box', '2022-11-20 13:00:00', '2022-11-19 16:00:00');
insert into Service values(3039, 5, 'large box', '2022-11-17 16:00:00', '2022-11-19 16:00:00');
insert into Service values(3040, 3, 'envelope box', '2022-11-18 17:00:00', '2022-11-19 16:00:00');
insert into Service values(3041, 15, 'large box', '2022-11-20 16:00:00', '2022-11-19 17:00:00');
insert into Service values(3042, 1, 'envelope', '2022-11-17 15:00:00', '2022-11-19 17:00:00');
insert into Service values(3043, 2, 'medium box', '2022-11-21 18:00:00', '2022-11-20 18:00:00');
insert into Service values(3044, 4, 'small box', '2022-11-22 11:00:00', '2022-11-20 18:00:00');
insert into Service values(3045, 6, 'small box', '2022-11-19 12:00:00', '2022-11-20 18:00:00');
insert into Service values(3046, 11, 'large box', '2022-11-16 15:00:00', '2022-11-20 16:00:00');
insert into Service values(3047, 12, 'small box', '2022-11-21 16:00:00', '2022-11-20 16:00:00');
insert into Service values(3048, 14, 'large box', '2022-11-22 17:00:00', '2022-11-20 16:00:00');
insert into Package values(25, false, 1001, 2001, 3025, 4003);
insert into Package values(26, true, 1002, 2002, 3026, 4004);
insert into Package values(27, false, 1002, 2003, 3027, 4001);
insert into Package values(28, false, 1003, 2004, 3028, 4002);
insert into Package values(29, true, 1004, 2005, 3029, 4002);
insert into Package values(30, true, 1005, 2004, 3030, 4007);
insert into Package values(31, false, 1006, 2007, 3031, 4007);
insert into Package values(32, false, 1006, 2002, 3032, 4001);
insert into Package values(33, false, 1002, 2002, 3033, 4005);
insert into Package values(34, false, 1001, 2003, 3034, 4002);
insert into Package values(35, false, 1004, 2003, 3035, 4004);
insert into Package values(36, false, 1006, 2006, 3036, 4003);
insert into Package values(37, true, 1002, 2001, 3037, 4005);
insert into Package values(38, true, 1003, 2002, 3038, 4006);
insert into Package values(39, true, 1004, 2003, 3039, 4001);
insert into Package values(40, true, 1001, 2004, 3040, 4001);
insert into Package values(41, true, 1005, 2005, 3041, 4002);
insert into Package values(42, true, 1006, 2004, 3042, 4004);
insert into Package values(43, true, 1002, 2007, 3043, 4005);
insert into Package values(44, true, 1001, 2005, 3044, 4003);
insert into Package values(45, true, 1004, 2001, 3045, 4002);
insert into Package values(46, true, 1002, 2003, 3046, 4001);
insert into Package values(47, true, 1003, 2003, 3047, 4004);
insert into Package values(48, true, 1006, 2006, 3048, 4003);
insert into Shippment values(117);
insert into Shippment values(118);
insert into Shippment values(119);
insert into Shippment values(120);
insert into Shippment values(121);
insert into Shippment values(122);
insert into Shippment values(123);
insert into Shippment values(124);
insert into Shippment values(125);
insert into Shippment values(126);
insert into Shippment values(127);
insert into Shippment values(128);
insert into Shippment values(129);
insert into Shippment values(130);
insert into Shippment values(131);
insert into Shippment values(132);
insert into Pack_ship values(1,117);
insert into Pack_ship values(3,117); 
insert into Pack_ship values(4,117);
insert into Pack_ship values(2, 118);
insert into Pack_ship values(5, 118);
insert into Pack_ship values(6, 118);
insert into Pack_ship values(2, 119);
insert into Pack_ship values(5, 119);
insert into Pack_ship values(6, 119);
insert into Pack_ship values(7, 120);
insert into Pack_ship values(8, 120);
insert into Pack_ship values(7, 121);
insert into Pack_ship values(1, 122);
insert into Pack_ship values(3, 122);
insert into Pack_ship values(4, 122);
insert into Pack_ship values(9, 123);
insert into Pack_ship values(10, 123);
insert into Pack_ship values(11, 123);
insert into Pack_ship values(12, 123);
insert into Pack_ship values(9, 124);
insert into Pack_ship values(10, 124);
insert into Pack_ship values(11, 124);
insert into Pack_ship values(12, 125);
insert into Pack_ship values(12, 126);
insert into Pack_ship values(13, 127);
insert into Pack_ship values(14, 127);
insert into Pack_ship values(15, 127);
insert into Pack_ship values(16, 127);
insert into Pack_ship values(17, 127);
insert into Pack_ship values(18, 127);
insert into Pack_ship values(19, 128);
insert into Pack_ship values(20, 128);
insert into Pack_ship values(21, 128);
insert into Pack_ship values(22, 128);
insert into Pack_ship values(23, 128);
insert into Pack_ship values(24, 128);
insert into Pack_ship values(13, 129);
insert into Pack_ship values(14, 129);
insert into Pack_ship values(15, 129);
insert into Pack_ship values(16, 129);
insert into Pack_ship values(17, 130);
insert into Pack_ship values(18, 130);
insert into Pack_ship values(19, 131);
insert into Pack_ship values(20, 131);
insert into Pack_ship values(21, 131);
insert into Pack_ship values(22, 132);
insert into Pack_ship values(23, 132);
insert into Pack_ship values(24, 132);
insert into International values(9002, 31, 'alcohol', 1200);
insert into Hazardous values(37, 'flammable');
insert into Hazardous values(45, 'explosive');
insert into Trans_use values(119, 204, '2022-11-09 09:00:00', '2022-11-09 14:00:00');
insert into Trans_use values(118, 201, '2022-11-08 11:00:00', '2022-11-08 16:00:00');
insert into Trans_use values(121, 205, '2022-11-09 10:00:00', '2022-11-09 12:00:00');
insert into Trans_use values(122, 202, '2022-11-09 09:00:00', '2022-11-09 14:00:00');
insert into Trans_use values(124, 203, '2022-11-12 10:00:00', '2022-11-12 15:00:00');
insert into Trans_use values(125, 201, '2022-11-12 10:00:00', '2022-11-12 12:00:00');
insert into Trans_use values(129, 206, '2022-10-19 07:00:00', '2022-10-19 16:00:00');
insert into Trans_use values(130, 202, '2022-10-19 07:00:00', '2022-10-19 17:00:00');
insert into Trans_use values(131, 206, '2022-10-20 09:00:00', '2022-10-20 18:00:00');
insert into Trans_use values(132, 202, '2022-10-20 09:00:00', '2022-10-20 16:00:00');
insert into Ware_visit values(117, 302, '2022-11-07 15:00:00', '2022-11-09 09:00:00');
insert into Ware_visit values(118, 303, '2022-11-08 16:00:00', '2022-11-09 09:00:00');
insert into Ware_visit values(120, 304, '2022-11-08 17:00:00', '2022-11-09 10:00:00');
insert into Ware_visit values(123, 301, '2022-11-11 18:00:00', '2022-11-12 10:00:00');
insert into Ware_visit values(126, 302, '2022-11-12 15:00:00', '2022-11-13 15:00:00');
insert into Ware_visit values(127, 303, '2022-10-18 14:00:00', '2022-10-19 07:00:00');
insert into Ware_visit values(128, 305, '2022-10-19 09:00:00', '2022-10-20 09:00:00');
insert into Payment values(7025, false, 140, 'bill','2022-11-15 10:00:00',1001,2001, 25);
insert into Payment values(7026, false, 200, 'bill','2022-11-15 10:00:00',1002,2002, 26);
insert into Payment values(7027, false, 540, 'bill','2022-11-15 10:00:00',1002,2003, 27);
insert into Payment values(7028, false, 50, 'bill', '2022-11-15 10:00:00', 1003, 2004, 28);
insert into Payment values(7029, false, 760, 'bill', '2022-11-15 10:00:00', 1004, 2005, 29);
insert into Payment values(7030, true, 60, 'credit card', '2022-11-05 21:00:00', 1005, 2004, 30);
insert into Payment values(7031, false, 600, 'bill', '2022-11-15 10:00:00', 1006, 2007, 31);
insert into Payment values(7032, false, 240, 'bill', '2022-11-15 10:00:00', 1006, 2002, 32);
insert into Payment values(7033, false, 20, 'bill', '2022-11-15 10:00:00', 1002, 2002, 33);
insert into Payment values(7034, false, 420, 'bill', '2022-11-15 10:00:00', 1001, 2003, 34);
insert into Payment values(7035, false, 80, 'bill', '2022-11-15 10:00:00', 1004, 2003, 35);
insert into Payment values(7036, false, 130, 'bill', '2022-11-15 10:00:00', 1006, 2006, 36);
insert into Payment values(7037, false, 40, 'bill','2022-10-15 10:00:00',1002,2001, 37);
insert into Payment values(7038, false, 230, 'bill','2022-10-15 10:00:00',1003,2002, 38);
insert into Payment values(7039, false, 640, 'bill','2022-10-15 10:00:00',1004,2003, 39);
insert into Payment values(7040, false, 30, 'bill', '2022-10-15 10:00:00', 1001, 2004, 40);
insert into Payment values(7041, false, 640, 'credit card', '2022-10-01 16:00:00', 1005, 2005, 41);
insert into Payment values(7042, false, 890, 'bill', '2022-10-15 10:00:00', 1006, 2004, 42);
insert into Payment values(7043, false, 10, 'bill', '2022-10-15 10:00:00', 1002, 2007, 43);
insert into Payment values(7044, false, 240, 'bill', '2022-10-15 10:00:00', 1001, 2005, 44);
insert into Payment values(7045, false, 530, 'bill', '2022-10-15 10:00:00', 1004, 2001, 45);
insert into Payment values(7046, false, 60, 'bill', '2022-10-15 10:00:00', 1002, 2003, 46);
insert into Payment values(7047, false, 10, 'bill', '2022-10-15 10:00:00', 1003, 2003, 47);
insert into Payment values(7048, false, 140, 'bill', '2022-10-15 10:00:00', 1006, 2006, 48);
insert into Bill values(5011, '2022-11-15 10:00:00',1001);
insert into Bill values(5012, '2022-11-15 10:00:00', 1002);
insert into Bill values(5013, '2022-11-15 10:00:00', 1003);
insert into Bill values(5014, '2022-11-15 10:00:00', 1004);
insert into Bill values(5015, '2022-11-15 10:00:00', 1006);
insert into Bill values(5016, '2022-10-15 10:00:00',1001);
insert into Bill values(5017, '2022-10-15 10:00:00', 1002);
insert into Bill values(5018, '2022-10-15 10:00:00', 1003);
insert into Bill values(5019, '2022-10-15 10:00:00', 1004);
insert into Bill values(5020, '2022-10-15 10:00:00', 1006);
insert into Bill_pay values(7025, 5011);
insert into Bill_pay values(7026, 5012);
insert into Bill_pay values(7027, 5012);
insert into Bill_pay values(7028, 5013);
insert into Bill_pay values(7029, 5014);
insert into Bill_pay values(7031, 5015);
insert into Bill_pay values(7032, 5015);
insert into Bill_pay values(7033, 5012);
insert into Bill_pay values(7034, 5011);
insert into Bill_pay values(7035, 5014);
insert into Bill_pay values(7036, 5015);
insert into Bill_pay values(7037, 5017);
insert into Bill_pay values(7038, 5018);
insert into Bill_pay values(7039, 5019);
insert into Bill_pay values(7041, 5016);
insert into Bill_pay values(7042, 5020);
insert into Bill_pay values(7043, 5017);
insert into Bill_pay values(7044, 5016);
insert into Bill_pay values(7045, 5019);
insert into Bill_pay values(7046, 5017);
insert into Bill_pay values(7047, 5018);
insert into Bill_pay values(7048, 5020);