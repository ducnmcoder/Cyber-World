--  Roles
INSERT INTO roles (id, description, name) VALUES 
(1, 'Admin role', 'ADMIN'),
(2, 'Owner role', 'OWNER'),
(3, 'Staff role', 'STAFF'),
(4, 'User role', 'USER');

-- Users (Mật khẩu: 123456)
INSERT INTO users (id, email, full_name, password, role_id) VALUES 
(1, 'admin@gmail.com', 'Admin User', '$2a$10$oClXt1y512M.0YeGKA1s5utpmusrAIGHHv/NP4nD9aiMsZfknx8HW', 1),
(2, 'owner@gmail.com', 'Owner User', '$2a$10$oClXt1y512M.0YeGKA1s5utpmusrAIGHHv/NP4nD9aiMsZfknx8HW', 2),
(3, 'staff@gmail.com', 'Staff User', '$2a$10$oClXt1y512M.0YeGKA1s5utpmusrAIGHHv/NP4nD9aiMsZfknx8HW', 3);

--  Specifications
INSERT INTO product_specifications (id, cpu_technology, gpu_model, ram_capacity, storage_capacity, screen_refresh_rate) VALUES 
(1, 'Intel Core i5', 'RTX 2050', '16 GB', '512 GB', '144 Hz'),
(2, 'Intel Core i5', 'Intel Iris Xe', '16 GB', '512 GB', '60 Hz'),
(3, 'Intel Core i7', 'RTX 3050', '8 GB', '512 GB', '120 Hz'),
(4, 'Intel Core i7', 'GTX 950M', '8 GB', '256 GB', '60 Hz'),
(5, 'Apple M1 Series', 'Apple GPU 7-core', '8 GB', '256 GB', '60 Hz'),
(6, 'Intel Core i7', 'Intel Iris Plus', '16 GB', '1 TB', '60 Hz'),
(7, 'Apple M2 Series', 'Apple GPU 8-core', '8 GB', '256 GB', '60 Hz'),
(8, 'Intel Core i7', 'RTX 3050', '8 GB', '512 GB', '144 Hz'),
(9, 'Intel Core i5', 'RTX 4050', '8 GB', '512 GB', '144 Hz'),
(10, 'Intel Core i3', 'Intel UHD', '8 GB', '256 GB', '60 Hz'),
(11, 'Apple M3 Pro', 'Apple GPU 14-core', '18 GB', '512 GB', '120 Hz'),
(12, 'Intel Core i7 13620H', 'RTX 4060', '16 GB', '512 GB', '144 Hz'),
(13, 'Intel Core i5 1235U', 'Intel Iris Xe', '8 GB', '256 GB', '60 Hz');

--  Products
INSERT INTO products (id, name, factory, target, price, original_price, quantity, sold, short_desc, detail_desc, color, cpu, ram, storage, screen_size, specification_id, image) VALUES 
(1, 'Asus TUF Gaming Laptop', 'ASUS', 'GAMING', 17490000, 18490000, 100, 0, 'Intel, Core i5, 11400H', 'ASUS TUF Gaming F15 FX506HF HN017W is an affordable yet extremely powerful gaming laptop...', 'Black', 'Intel Core i5', '16 GB', '512 GB', '15.6', 1, '1711078092373-asus-01.png'),
(2, 'Dell Inspiron 15 Laptop', 'DELL', 'STUDENT-OFFICE', 15490000, 16000000, 200, 0, 'i5 1235U/16GB/512GB/15.6 inch FHD', 'Discover ultimate performance from Dell Inspiron 15 N3520...', 'Silver', 'Intel Core i5', '16 GB', '512 GB', '15.6', 2, '1711078452562-dell-01.png'),
(3, 'Lenovo IdeaPad Gaming 3', 'LENOVO', 'GAMING', 19500000, 20000000, 150, 0, 'i5-10300H, RAM 8G', 'Lenovo has recently launched a next-generation gaming product to the market...', 'Black', 'Intel Core i7', '8 GB', '512 GB', '15.6', 3, '1711079073759-lenovo-01.png'),
(4, 'Asus K501UX', 'ASUS', 'GRAPHIC-DESIGN', 11900000, 12500000, 99, 0, 'VGA NVIDIA GTX 950M- 4G', 'Enjoy a stylish cool feel with a sleek metallic design...', 'Blue', 'Intel Core i7', '8 GB', '256 GB', '15.6', 4, '1711079496409-asus-02.png'),
(5, 'MacBook Air 13 M1', 'APPLE', 'THIN-LIGHT', 17690000, 18500000, 99, 0, 'Apple M1 7-core GPU', 'The most breakthrough performance MacBook Air ever has arrived...', 'Silver', 'Apple M1 Series', '8 GB', '256 GB', '13.3', 5, '1711079954090-apple-01.png'),
(6, 'LG Gram Style Laptop', 'LG', 'BUSINESS', 31490000, 32900000, 99, 0, 'Intel Iris Plus Graphics', '14.0 Main: inch, 2880 x 1800 Pixels, OLED, 90 Hz...', 'White', 'Intel Core i7', '16 GB', '1 TB', '14.0', 6, '1711080386941-lg-01.png'),
(7, 'MacBook Air 13 M2', 'APPLE', 'THIN-LIGHT', 24990000, 26000000, 99, 0, 'Apple M2 8-core GPU', 'Not only inspiring through design innovation...', 'Midnight', 'Apple M2 Series', '8 GB', '256 GB', '13.6', 7, '1711080787179-apple-02.png'),
(8, 'Acer Nitro 5 Laptop', 'ACER', 'GAMING', 23490000, 24500000, 99, 0, 'AN515-58-769J i7 12700H', 'The latest generation gaming laptop from the Nitro 5 series...', 'Black', 'Intel Core i7', '8 GB', '512 GB', '15.6', 8, '1711080948771-acer-01.png'),
(9, 'Acer Nitro V Laptop', 'ACER', 'GAMING', 26999000, 28000000, 99, 0, 'NVIDIA GeForce RTX 4050', '15.6 inch, FHD (1920 x 1080), IPS, 144 Hz, 250 nits...', 'Black', 'Intel Core i5', '8 GB', '512 GB', '15.6', 9, '1711081080930-asus-03.png'),
(10, 'Dell Latitude 3420 Laptop', 'DELL', 'BUSINESS', 21399000, 22000000, 99, 0, 'Intel Iris Xe Graphics', 'Dell Inspiron N3520 is the ideal laptop for daily tasks...', 'Black', 'Intel Core i3', '8 GB', '256 GB', '14.0', 10, '1711081278418-dell-02.png'),
(11, 'MacBook Pro 14 M3 Pro', 'APPLE', 'BUSINESS', 39990000, 39990000, 10, 0, 'MacBook Pro 14 inch M3 Pro', 'MacBook Pro 14 M3 Pro details...', 'Silver', 'Apple M3 Pro', '18 GB', '512 GB', '14.2', 11, 'macbook.jpg'),
(12, 'Asus TUF Gaming F15 Laptop', 'ASUS', 'GAMING', 25000000, 26000000, 20, 0, 'Powerful Asus TUF Gaming', 'Asus TUF details...', 'Black', 'Intel Core i7 13620H', '16 GB', '512 GB', '15.6', 12, 'asus_tuf.jpg'),
(13, 'Dell Inspiron 15 Laptop', 'DELL', 'STUDENT-OFFICE', 15000000, 15500000, 15, 0, 'Durable Dell Inspiron', 'Dell Inspiron details...', 'Silver', 'Intel Core i5 1235U', '8 GB', '256 GB', '15.6', 13, 'dell.jpg');
