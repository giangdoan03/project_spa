-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 24, 2025 at 06:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `giang_ci4`
--

-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--

CREATE TABLE `businesses` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `tax_code` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `ward` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `career` varchar(255) DEFAULT NULL,
  `facebook_link` varchar(255) DEFAULT NULL,
  `other_links` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`other_links`)),
  `logo` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `library_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`library_images`)),
  `video_intro` varchar(255) DEFAULT NULL,
  `certificate_file` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `extra_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`extra_info`)),
  `status` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `businesses`
--

INSERT INTO `businesses` (`id`, `name`, `tax_code`, `country`, `city`, `district`, `ward`, `address`, `phone`, `email`, `website`, `description`, `career`, `facebook_link`, `other_links`, `logo`, `cover_image`, `library_images`, `video_intro`, `certificate_file`, `lat`, `lng`, `extra_info`, `status`, `created_at`, `updated_at`, `deleted_at`, `user_id`) VALUES
(1, 'xxx', '32423234', 'việt nam', 'ha noi', 'ba đình', 'cống vị ba đình', 'xóm liều', '0387409300', 'doangiang665@gmail.com', 'develop.io.vn', 'xxxxx', '2344324', '2343244', '[]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030227_a219e8b45e3cc12378d8.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030230_ffa313e9284e59d34cdf.jpg\"]', '[\"http://assets.giang.test/image/1745030232_e04bed398cc255350886.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030234_7f855fad911edf3ee922.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030254_d9af1ae6c177f1e36141.xls\"]', NULL, NULL, '[]', 1, '2025-04-13 16:14:26', '2025-04-19 02:37:36', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `business_extra_info`
--

CREATE TABLE `business_extra_info` (
  `id` bigint(20) NOT NULL,
  `business_id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Điện thoại & Máy tính bảng', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(2, 'Laptop & Máy tính để bàn', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(3, 'Phụ kiện công nghệ', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(4, 'TV & Thiết bị gia dụng', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(5, 'Thời trang nam', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(6, 'Thời trang nữ', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(7, 'Giày dép & Túi xách', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(8, 'Mẹ & Bé', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(9, 'Sức khoẻ & Làm đẹp', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(10, 'Đồ dùng gia đình', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(11, 'Thể thao & Dã ngoại', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(12, 'Ô tô & Xe máy & Xe đạp', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(13, 'Sách, Văn phòng phẩm & Quà tặng', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(14, 'Đồ chơi & Giải trí', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(15, 'Nhà cửa & Đời sống', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(16, 'Thiết bị điện tử', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(17, 'Thiết bị y tế & Chăm sóc sức khoẻ', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(18, 'Nội thất & Trang trí', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(19, 'Đồng hồ & Trang sức', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(20, 'Dụng cụ & Thiết bị công nghiệp', '2025-04-12 23:49:55', '2025-04-12 23:49:55'),
(21, 'Thiết bị mạng & Camera giám sát', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(22, 'Vật liệu xây dựng & Công cụ', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(23, 'Đồ dùng học tập & Văn phòng', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(24, 'Thực phẩm & Đồ uống', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(25, 'Nhạc cụ & Thiết bị âm thanh', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(26, 'Dịch vụ & Voucher', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(27, 'Vé sự kiện & Giải trí', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(28, 'Phim ảnh & Âm nhạc', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(29, 'Mỹ phẩm & Chăm sóc cá nhân', '2025-04-12 23:50:08', '2025-04-12 23:50:08'),
(30, 'Quà lưu niệm & Thủ công mỹ nghệ', '2025-04-12 23:50:08', '2025-04-12 23:50:08');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `banner` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `user_id`, `name`, `banner`, `location`, `start_time`, `end_time`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'abc', 'http://assets.giang.test/image/1745034978_48fad943a51bce7d7036.png', 'cfs', '2025-04-18 20:55:14', '2025-04-25 20:55:17', 'xxxxxxxxxxxx', '2025-04-19 03:55:21', '2025-04-19 03:55:21');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `key_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'product.view', 'Xem sản phẩm', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(2, 'product.create', 'Tạo sản phẩm', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(3, 'product.update', 'Cập nhật sản phẩm', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(4, 'product.delete', 'Xoá sản phẩm', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(5, 'category.view', 'Xem danh mục', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(6, 'category.create', 'Tạo danh mục', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(7, 'category.update', 'Cập nhật danh mục', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(8, 'category.delete', 'Xoá danh mục', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(9, 'business.view', 'Xem doanh nghiệp', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(10, 'business.create', 'Tạo doanh nghiệp', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(11, 'business.update', 'Cập nhật doanh nghiệp', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(12, 'business.delete', 'Xoá doanh nghiệp', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(13, 'person.view', 'Xem cá nhân', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(14, 'person.create', 'Tạo cá nhân', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(15, 'person.update', 'Cập nhật cá nhân', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(16, 'person.delete', 'Xoá cá nhân', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(17, 'store.view', 'Xem cửa hàng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(18, 'store.create', 'Tạo cửa hàng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(19, 'store.update', 'Cập nhật cửa hàng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(20, 'store.delete', 'Xoá cửa hàng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(21, 'event.view', 'Xem sự kiện', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(22, 'event.create', 'Tạo sự kiện', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(23, 'event.update', 'Cập nhật sự kiện', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(24, 'event.delete', 'Xoá sự kiện', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(25, 'qr.view', 'Xem QR Code', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(26, 'qr.create', 'Tạo QR Code', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(27, 'qr.update', 'Cập nhật QR Code', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(28, 'qr.delete', 'Xoá QR Code', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(29, 'loyalty.view', 'Xem chương trình loyalty', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(30, 'loyalty.create', 'Tạo chương trình loyalty', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(31, 'loyalty.update', 'Cập nhật chương trình loyalty', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(32, 'loyalty.delete', 'Xoá chương trình loyalty', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(33, 'user.view', 'Xem người dùng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(34, 'user.create', 'Tạo người dùng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(35, 'user.update', 'Cập nhật người dùng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(36, 'user.delete', 'Xoá người dùng', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(37, 'setting.view', 'Xem cấu hình', '2025-04-21 00:15:39', '2025-04-21 00:15:39'),
(38, 'setting.update', 'Cập nhật cấu hình', '2025-04-21 00:15:39', '2025-04-21 00:15:39');

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE `persons` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `social_links` text DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `user_id`, `first_name`, `last_name`, `name`, `avatar`, `video_url`, `phone`, `email`, `website`, `country`, `address`, `social_links`, `job_title`, `bio`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 'doan van giang', 'http://assets.giang.test/image/1745033455_7720ded752b051b0556a.jpg', NULL, '0387409300', 'doangiang665@gmail.com', NULL, NULL, NULL, NULL, 'dev web', 'dev web', '2025-04-19 03:23:06', '2025-04-19 03:23:06'),
(2, 1, NULL, NULL, 'chaiel', 'http://assets.giang.test/image/1745033604_a1290dbd357f8d81b784.jpg', NULL, '0387409300', 'chaiel@gmail.com', NULL, NULL, NULL, NULL, 'dev', 'dev', '2025-04-19 03:33:52', '2025-04-19 03:33:52');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) NOT NULL,
  `id_businesses` int(10) UNSIGNED DEFAULT NULL,
  `id_stores` int(10) UNSIGNED DEFAULT NULL,
  `id_surveys` int(10) UNSIGNED DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `price_mode` varchar(20) DEFAULT 'single',
  `price` decimal(15,2) DEFAULT 0.00,
  `price_from` decimal(15,2) DEFAULT 0.00,
  `price_to` decimal(15,2) DEFAULT 0.00,
  `show_contact_price` tinyint(1) DEFAULT 0,
  `avatar` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `certificate_file` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `status` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `display_settings` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `id_businesses`, `id_stores`, `id_surveys`, `sku`, `name`, `category_id`, `price_mode`, `price`, `price_from`, `price_to`, `show_contact_price`, `avatar`, `image`, `video`, `certificate_file`, `description`, `attributes`, `status`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `display_settings`) VALUES
(1, NULL, NULL, NULL, '5424324324kkk', 'demo 1', 1, 'range', 120000.00, 10000.00, 150000.00, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745030161_1629c049dd5304b986df.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030163_2becc0716ebd8871b505.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030164_168ff7d22e43564ad35c.jpg\"]', '[\"http:\\/\\/api.giang.test\\/uploads\\/1744558167_bca4a4605e98ca0c07e5.pdf\"]', NULL, '[{\"id\":\"57\",\"product_id\":\"1\",\"name\":\"XL\",\"value\":\"342424324\",\"created_at\":\"2025-04-24 04:29:54\",\"updated_at\":\"2025-04-24 04:29:54\"}]', 1, '2025-04-12 17:20:19', '2025-04-24 04:34:26', NULL, 0, '{\"selectedTemplate\":\"tpl-3\",\"relatedProducts\":\"all\",\"selectedProducts\":[],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"selected\",\"selectedStores\":[\"1\"],\"enableSurvey\":true,\"selectedSurveys\":[],\"enableOrderButton\":true}'),
(2, NULL, NULL, NULL, '23424244', 'demo sp', 1, 'range', 120000.00, 40000.00, 60000.00, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745030182_9c8ac5def4099a010923.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030183_b10b3ec25f2fcedf2095.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030185_6a907b219d2810ceec89.jpg\"]', '[\"http:\\/\\/api.giang.test\\/uploads\\/1744558212_d3135ea188a37ab7205c.pdf\"]', 'demo demo', '[{\"id\":\"60\",\"product_id\":\"2\",\"name\":\"xl\",\"value\":\"120000\",\"created_at\":\"2025-04-24 04:35:15\",\"updated_at\":\"2025-04-24 04:35:15\"}]', 1, '2025-04-13 14:58:36', '2025-04-24 04:35:21', NULL, 0, '{\"selectedTemplate\":\"tpl-2\",\"relatedProducts\":\"all\",\"selectedProducts\":[],\"company\":\"all\",\"selectedCompanies\":[],\"store\":\"all\",\"selectedStores\":[],\"enableSurvey\":true,\"selectedSurveys\":[],\"enableOrderButton\":true}'),
(3, NULL, NULL, NULL, '43243242', 'demo demo', 1, 'single', 100000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745030199_204f7c732930f2e30a52.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030201_92e108209607bc4142c8.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030203_d86e92994564c22c5735.jpg\"]', '[\"http:\\/\\/api.giang.test\\/uploads\\/1744557413_41644f144bdb597f2bae.pdf\"]', 'demo demo', '[{\"id\": \"24\", \"name\": \"xl \", \"value\": \"12000\", \"created_at\": \"2025-04-20 03:52:02\", \"product_id\": \"3\", \"updated_at\": \"2025-04-20 03:52:02\"}, {\"id\": \"25\", \"name\": \"xxl\", \"value\": \"20000\", \"created_at\": \"2025-04-20 03:52:02\", \"product_id\": \"3\", \"updated_at\": \"2025-04-20 03:52:02\"}]', 1, '2025-04-13 15:17:23', '2025-04-20 04:09:53', NULL, 0, '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"all\",\"company\":\"all\",\"store\":\"all\",\"enableSurvey\":true,\"enableOrderButton\":true}');

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_attributes`
--

INSERT INTO `product_attributes` (`id`, `product_id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(32, 3, 'xl ', '12000', '2025-04-20 04:09:53', '2025-04-20 04:09:53'),
(33, 3, 'xxl', '20000', '2025-04-20 04:09:53', '2025-04-20 04:09:53'),
(58, 1, 'XL', '342424324', '2025-04-24 04:34:26', '2025-04-24 04:34:26'),
(61, 2, 'xl', '120000', '2025-04-24 04:35:21', '2025-04-24 04:35:21');

-- --------------------------------------------------------

--
-- Table structure for table `qr_codes`
--

CREATE TABLE `qr_codes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `target_type` enum('product','store','business','event','person') NOT NULL,
  `target_id` int(11) NOT NULL,
  `qr_name` varchar(255) DEFAULT NULL,
  `qr_url` varchar(255) NOT NULL,
  `scan_count` int(11) DEFAULT 0,
  `settings_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`settings_json`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'super admin', 'Toàn quyền', '2025-04-21 00:06:00', '2025-04-21 00:06:00'),
(2, 'admin', 'Quản trị viên', '2025-04-21 00:06:00', '2025-04-21 00:06:00'),
(3, 'user', 'Người dùng', '2025-04-21 00:06:00', '2025-04-21 00:06:00');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `permission_id`, `created_at`) VALUES
(4, 3, 1, '2025-04-21 00:35:31'),
(5, 3, 2, '2025-04-21 00:35:31'),
(6, 3, 3, '2025-04-21 00:35:31'),
(7, 1, 1, '2025-04-21 21:48:03'),
(8, 1, 2, '2025-04-21 21:48:03'),
(9, 1, 7, '2025-04-21 21:48:03'),
(10, 1, 18, '2025-04-21 21:48:03');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` tinyint(1) DEFAULT 1,
  `product_ids` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `user_id`, `name`, `logo`, `address`, `phone`, `email`, `website`, `description`, `created_at`, `updated_at`, `status`, `product_ids`) VALUES
(1, 1, 'cửa hàng thực phẩm sạch', 'http://assets.giang.test/image/1745041561_cfb1a46ffe8605a53362.png', 'acb xyz', '0387409300', 'doangiang665@gmail.com', NULL, '<p>xxxxxxxxxxxxxxxxxxxxxx zzzzzzzzzzzzzzzzzzz</p>', '2025-04-19 04:05:19', '2025-04-19 06:04:58', 1, '[\"1\",\"2\",\"3\"]');

-- --------------------------------------------------------

--
-- Table structure for table `surveys`
--

CREATE TABLE `surveys` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_answers`
--

CREATE TABLE `survey_answers` (
  `id` bigint(20) NOT NULL,
  `survey_id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `answer_text` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_groups`
--

CREATE TABLE `survey_groups` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_options`
--

CREATE TABLE `survey_options` (
  `id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `option_text` varchar(255) NOT NULL,
  `order_no` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey_questions`
--

CREATE TABLE `survey_questions` (
  `id` bigint(20) NOT NULL,
  `survey_id` bigint(20) NOT NULL,
  `question_text` text NOT NULL,
  `question_type` varchar(50) DEFAULT NULL,
  `required` tinyint(1) DEFAULT 0,
  `order_no` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT 'user',
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `created_at`, `updated_at`, `name`, `phone`, `avatar`, `role`, `role_id`) VALUES
(1, 'demo@example.com', '$2y$10$X0AYs8k7Dw8fbMqF9DzxiuBhQzGzu.ehudtC.2SWOjA4tsTZK0sYG', '2025-04-07 18:49:01', '2025-04-20 23:49:00', 'Demo User', '0123456789', 'avatar.png', 'user', 2),
(3, 'superadmin@example.com', '$2y$10$X0AYs8k7Dw8fbMqF9DzxiuBhQzGzu.ehudtC.2SWOjA4tsTZK0sYG', '2025-04-20 14:02:38', '2025-04-21 00:21:49', 'Super Admin', '0988888888', NULL, 'super admin', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_extra_info`
--
ALTER TABLE `business_extra_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `qr_codes`
--
ALTER TABLE `qr_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `surveys`
--
ALTER TABLE `surveys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey_answers`
--
ALTER TABLE `survey_answers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey_groups`
--
ALTER TABLE `survey_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey_options`
--
ALTER TABLE `survey_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `survey_questions`
--
ALTER TABLE `survey_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `businesses`
--
ALTER TABLE `businesses`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `business_extra_info`
--
ALTER TABLE `business_extra_info`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `qr_codes`
--
ALTER TABLE `qr_codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `surveys`
--
ALTER TABLE `surveys`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_answers`
--
ALTER TABLE `survey_answers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_groups`
--
ALTER TABLE `survey_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_options`
--
ALTER TABLE `survey_options`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey_questions`
--
ALTER TABLE `survey_questions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD CONSTRAINT `product_attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
