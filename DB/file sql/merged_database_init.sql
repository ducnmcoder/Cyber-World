CREATE DATABASE  IF NOT EXISTS `laptopshop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laptopshop`;

-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS `cart_detail`;
DROP TABLE IF EXISTS `carts`;
DROP TABLE IF EXISTS `order_detail`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `product_specifications`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `roles`;

-- Table structure for table `product_specifications`
CREATE TABLE `product_specifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cpu_company` varchar(255) DEFAULT NULL,
  `cpu_technology` varchar(255) DEFAULT NULL,
  `cpu_type` varchar(255) DEFAULT NULL,
  `cpu_speed` varchar(255) DEFAULT NULL,
  `cpu_max_speed` varchar(255) DEFAULT NULL,
  `gpu_company` varchar(255) DEFAULT NULL,
  `gpu_model` varchar(255) DEFAULT NULL,
  `gpu_full_name` varchar(255) DEFAULT NULL,
  `ram_capacity` varchar(255) DEFAULT NULL,
  `ram_type` varchar(255) DEFAULT NULL,
  `ram_slots` varchar(255) DEFAULT NULL,
  `ram_remaining_slots` varchar(255) DEFAULT NULL,
  `ram_max_support` varchar(255) DEFAULT NULL,
  `storage_type` varchar(255) DEFAULT NULL,
  `storage_total_slots` varchar(255) DEFAULT NULL,
  `storage_remaining_slots` varchar(255) DEFAULT NULL,
  `storage_max_upgrade` varchar(255) DEFAULT NULL,
  `storage_ssd_type` varchar(255) DEFAULT NULL,
  `storage_capacity` varchar(255) DEFAULT NULL,
  `screen_technology` varchar(255) DEFAULT NULL,
  `screen_resolution` varchar(255) DEFAULT NULL,
  `screen_refresh_rate` varchar(255) DEFAULT NULL,
  `screen_panel` varchar(255) DEFAULT NULL,
  `screen_brightness` varchar(255) DEFAULT NULL,
  `screen_color_coverage` varchar(255) DEFAULT NULL,
  `screen_ratio` varchar(255) DEFAULT NULL,
  `ports` varchar(255) DEFAULT NULL,
  `wifi` varchar(255) DEFAULT NULL,
  `bluetooth` varchar(255) DEFAULT NULL,
  `webcam` varchar(255) DEFAULT NULL,
  `os_name` varchar(255) DEFAULT NULL,
  `os_version` varchar(255) DEFAULT NULL,
  `security` varchar(255) DEFAULT NULL,
  `keyboard_type` varchar(255) DEFAULT NULL,
  `numpad` varchar(255) DEFAULT NULL,
  `keyboard_light` varchar(255) DEFAULT NULL,
  `touchpad` varchar(255) DEFAULT NULL,
  `battery_capacity` varchar(255) DEFAULT NULL,
  `power_supply` varchar(255) DEFAULT NULL,
  `accessories` varchar(255) DEFAULT NULL,
  `audio_technology` varchar(255) DEFAULT NULL,
  `card_reader` varchar(255) DEFAULT NULL,
  `material_top` varchar(255) DEFAULT NULL,
  `material_bottom` varchar(255) DEFAULT NULL,
  `special_features` varchar(255) DEFAULT NULL,
  `dimensions` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `material` varchar(255) DEFAULT NULL,
  `part_number` varchar(255) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `release_year` varchar(255) DEFAULT NULL,
  `warranty` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `product_specifications`
LOCK TABLES `product_specifications` WRITE;
INSERT INTO `product_specifications` (`id`, `cpu_technology`, `gpu_model`, `ram_capacity`, `storage_capacity`, `screen_refresh_rate`) VALUES 
(1, 'Intel Core i5', 'RTX 2050', '16 GB', '512 GB', '144 Hz'),
(2, 'Intel Core i5', 'Intel Iris Xe', '16 GB', '512 GB', '120 Hz'),
(3, 'Intel Core i7', 'RTX 3050', '8 GB', '512 GB', '120 Hz'),
(4, 'Intel Core i7', 'GTX 950M', '8 GB', '256 GB', '120 Hz'),
(5, 'Apple M1 Series', 'Apple GPU 7-core', '8 GB', '256 GB', '120 Hz'),
(6, 'Intel Core i7', 'Intel Iris Plus', '16 GB', '1 TB', '120 Hz'),
(7, 'Apple M2 Series', 'Apple GPU 8-core', '8 GB', '256 GB','120 Hz'),
(8, 'Intel Core i7', 'RTX 3050', '8 GB', '512 GB', '144 Hz'),
(9, 'Intel Core i5', 'RTX 4050', '8 GB', '512 GB', '144 Hz'),
(10, 'Intel Core i3', 'Intel UHD', '8 GB', '256 GB', '120 Hz');
UNLOCK TABLES;

-- Table structure for table `products`
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `detail_desc` mediumtext NOT NULL,
  `factory` varchar(255) DEFAULT NULL,
  `image` mediumtext,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `quantity` bigint NOT NULL,
  `short_desc` varchar(255) NOT NULL,
  `sold` bigint DEFAULT 0,
  `target` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `cpu` varchar(255) DEFAULT NULL,
  `original_price` double DEFAULT NULL,
  `promo_end_date` varchar(255) DEFAULT NULL,
  `ram` varchar(255) DEFAULT NULL,
  `screen_size` varchar(255) DEFAULT NULL,
  `storage` varchar(255) DEFAULT NULL,
  `specification_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_products_specification` FOREIGN KEY (`specification_id`) REFERENCES `product_specifications` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `products`
LOCK TABLES `products` WRITE;
INSERT INTO `products` (`id`, `name`, `factory`, `target`, `price`, `original_price`, `quantity`, `sold`, `short_desc`, `detail_desc`, `color`, `cpu`, `ram`, `storage`, `screen_size`, `specification_id`, `image`) VALUES 
(1, 'Laptop Asus TUF Gaming', 'ASUS', 'GAMING', 17490000, 18490000, 100, 0, 'Intel Core i5-11400H', 'ASUS TUF Gaming F15 FX506HF HN017W is an affordable yet highly powerful gaming laptop...', 'Black', 'Intel Core i5', '16 GB', '512 GB', '15.6', 1, '1711078092373-asus-01.png'),
(2, 'Laptop Dell Inspiron 15', 'DELL', 'SINHVIEN-VANPHONG', 15490000, 16000000, 200, 0, 'i5 1235U/16GB/512GB/15.6" FHD', 'Discover the ultimate performance with the Dell Inspiron 15 N3520...', 'Silver', 'Intel Core i5', '16 GB', '512 GB', '15.6', 2, '1711078452562-dell-01.png'),
(3, 'Lenovo IdeaPad Gaming 3', 'LENOVO', 'GAMING', 19500000, 20000000, 150, 0, 'i5-10300H, 8GB RAM', 'Lenovo has recently launched a new generation gaming laptop to the market...', 'Black', 'Intel Core i7', '8 GB', '512 GB', '15.6', 3, '1711079073759-lenovo-01.png'),
(4, 'Asus K501UX', 'ASUS', 'THIET-KE-DO-HOA', 11900000, 12500000, 99, 0, 'VGA NVIDIA GTX 950M- 4GB', 'Enjoy a cool, stylish experience with a premium metallic design...', 'Blue', 'Intel Core i7', '8 GB', '256 GB', '15.6', 4, '1711079496409-asus-02.png'),
(5, 'MacBook Air 13 M1', 'APPLE', 'MONG-NHE', 17690000, 18500000, 99, 0, 'Apple M1 7-core GPU', 'The MacBook Air featuring the most groundbreaking performance ever has arrived...', 'Silver', 'Apple M1 Series', '8 GB', '256 GB', '13.3', 5, '1711079954090-apple-01.png'),
(6, 'Laptop LG Gram Style', 'LG', 'DOANH-NHAN', 31490000, 32900000, 99, 0, 'Intel Iris Plus Graphics', 'Main 14.0-inch display, 2880 x 1800 Pixels, OLED, 90 Hz...', 'White', 'Intel Core i7', '16 GB', '1 TB', '14.0', 6, '1711080386941-lg-01.png'),
(7, 'MacBook Air 13 M2', 'APPLE', 'MONG-NHE', 24990000, 26000000, 99, 0, 'Apple M2 8-core GPU', 'Inspiring users through its redesigned, modern aesthetics...', 'Midnight', 'Apple M2 Series', '8 GB', '256 GB', '13.6', 7, '1711080787179-apple-02.png'),
(8, 'Laptop Acer Nitro 5', 'ACER', 'GAMING', 23490000, 24500000, 99, 0, 'AN515-58-769J i7 12700H', 'The latest generation gaming laptop from the Acer Nitro 5 lineup...', 'Black', 'Intel Core i7', '8 GB', '512 GB', '15.6', 8, '1711080948771-acer-01.png'),
(9, 'Laptop Acer Nitro V', 'ACER', 'GAMING', 26999000, 28000000, 99, 0, 'NVIDIA GeForce RTX 4050', '15.6 inch, FHD (1920 x 1080), IPS, 144 Hz, 250 nits...', 'Black', 'Intel Core i5', '8 GB', '512 GB', '15.6', 9, '1711081080930-asus-03.png'),
(10, 'Laptop Dell Latitude 3420', 'DELL', 'DOANH-NHAN', 21399000, 22000000, 99, 0, 'Intel Iris Xe Graphics', 'An ideal everyday laptop for work and productivity...', 'Black', 'Intel Core i3', '8 GB', '256 GB', '14.0', 10, '1711081278418-dell-02.png');
UNLOCK TABLES;

-- Table structure for table `roles`
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `roles`
LOCK TABLES `roles` WRITE;
INSERT INTO `roles` (`id`, `description`, `name`) VALUES 
(1, 'Admin role', 'ADMIN'),
(2, 'Owner role', 'OWNER'),
(3, 'Staff role', 'STAFF'),
(4, 'User role', 'USER');
UNLOCK TABLES;

CREATE TABLE `blogs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` mediumtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `users`
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `users`
LOCK TABLES `users` WRITE;
INSERT INTO `users` (`id`, `email`, `full_name`, `password`, `role_id`) VALUES 
(1, 'admin@gmail.com', 'Admin User', '$2a$10$oClXt1y512M.0YeGKA1s5utpmusrAIGHHv/NP4nD9aiMsZfknx8HW', 1),
(2, 'owner@gmail.com', 'Owner User', '$2a$10$oClXt1y512M.0YeGKA1s5utpmusrAIGHHv/NP4nD9aiMsZfknx8HW', 2),
(3, 'staff@gmail.com', 'Staff User', '$2a$10$oClXt1y512M.0YeGKA1s5utpmusrAIGHHv/NP4nD9aiMsZfknx8HW', 3);
UNLOCK TABLES;

-- Insert Specification 1 (Apple)
INSERT INTO product_specifications (
    id, cpu_technology, gpu_model, ram_capacity, storage_capacity, screen_refresh_rate
) VALUES (
    11, 'Apple M3 Pro', 'Apple GPU 14-core', '18 GB', '512 GB', '120 Hz'
);

-- Insert Product 1 (Apple)
INSERT INTO products (
    id, name, factory, target, price, original_price, quantity, sold, short_desc, detail_desc, color, cpu, ram, storage, screen_size, specification_id, image
) VALUES (
    11, 'MacBook Pro 14 M3 Pro', 'APPLE', 'DOANH-NHAN', 39990000, 39990000, 10, 0, 'MacBook Pro 14 inch M3 Pro', 'Chi tiết MacBook Pro 14 M3 Pro...', 'Silver', 'Apple M3 Pro', '18 GB', '512 GB', '14.2', 11, 'macbook.jpg'
);

-- Insert Specification 2 (Asus)
INSERT INTO product_specifications (
    id, cpu_technology, gpu_model, ram_capacity, storage_capacity, screen_refresh_rate
) VALUES (
    12, 'Intel Core i7 13620H', 'RTX 4060', '16 GB', '512 GB', '144 Hz'
);

-- Insert Product 2 (Asus)
INSERT INTO products (
    id, name, factory, target, price, original_price, quantity, sold, short_desc, detail_desc, color, cpu, ram, storage, screen_size, specification_id, image
) VALUES (
    12, 'Laptop Asus TUF Gaming F15', 'ASUS', 'GAMING', 25000000, 26000000, 20, 0, 'Asus TUF Gaming manh me', 'Chi tiet Asus TUF...', 'Black', 'Intel Core i7 13620H', '16 GB', '512 GB', '15.6', 12, 'asus_tuf.jpg'
);

-- Insert Specification 3 (Dell)
INSERT INTO product_specifications (
    id, cpu_technology, gpu_model, ram_capacity, storage_capacity, screen_refresh_rate
) VALUES (
    13, 'Intel Core i5 1235U', 'Intel Iris Xe', '8 GB', '256 GB', '60 Hz'
);

-- Insert Product 3 (Dell)
INSERT INTO products (
    id, name, factory, target, price, original_price, quantity, sold, short_desc, detail_desc, color, cpu, ram, storage, screen_size, specification_id, image
) VALUES (
    13, 'Laptop Dell Inspiron 15', 'DELL', 'SINHVIEN-VANPHONG', 15000000, 15500000, 15, 0, 'Dell Inspiron ben bi', 'Chi tiet Dell Inspiron...', 'Silver', 'Intel Core i5 1235U', '8 GB', '256 GB', '15.6', 13, 'dell.jpg'
);
INSERT IGNORE INTO roles (id, description, name) VALUES (1, 'Admin role', 'ADMIN');
INSERT IGNORE INTO roles (id, description, name) VALUES (2, 'Owner role', 'OWNER');
INSERT IGNORE INTO roles (id, description, name) VALUES (3, 'Staff role', 'STAFF');
INSERT IGNORE INTO roles (id, description, name) VALUES (4, 'User role', 'USER');


-- Lệnh tạo bảng Spring Session
CREATE TABLE IF NOT EXISTS SPRING_SESSION (
	PRIMARY_ID CHAR(36) NOT NULL,
	SESSION_ID CHAR(36) NOT NULL,
	CREATION_TIME BIGINT NOT NULL,
	LAST_ACCESS_TIME BIGINT NOT NULL,
	MAX_INACTIVE_INTERVAL INT NOT NULL,
	EXPIRY_TIME BIGINT NOT NULL,
	PRINCIPAL_NAME VARCHAR(100),
	CONSTRAINT SPRING_SESSION_PK PRIMARY KEY (PRIMARY_ID)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

CREATE UNIQUE INDEX SPRING_SESSION_IX1 ON SPRING_SESSION (SESSION_ID);
CREATE INDEX SPRING_SESSION_IX2 ON SPRING_SESSION (EXPIRY_TIME);
CREATE INDEX SPRING_SESSION_IX3 ON SPRING_SESSION (PRINCIPAL_NAME);

CREATE TABLE IF NOT EXISTS SPRING_SESSION_ATTRIBUTES (
	SESSION_PRIMARY_ID CHAR(36) NOT NULL,
	ATTRIBUTE_NAME VARCHAR(200) NOT NULL,
	ATTRIBUTE_BYTES BLOB NOT NULL,
	CONSTRAINT SPRING_SESSION_ATTRIBUTES_PK PRIMARY KEY (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),
	CONSTRAINT SPRING_SESSION_ATTRIBUTES_FK FOREIGN KEY (SESSION_PRIMARY_ID) REFERENCES SPRING_SESSION(PRIMARY_ID) ON DELETE CASCADE
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;