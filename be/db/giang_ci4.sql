-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2025 at 11:37 AM
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
  `other_links` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `library_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `video_intro` varchar(255) DEFAULT NULL,
  `certificate_file` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `extra_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `display_settings` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `businesses`
--

INSERT INTO `businesses` (`id`, `name`, `tax_code`, `country`, `city`, `district`, `ward`, `address`, `phone`, `email`, `website`, `description`, `career`, `facebook_link`, `other_links`, `logo`, `cover_image`, `library_images`, `video_intro`, `certificate_file`, `lat`, `lng`, `extra_info`, `status`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `display_settings`) VALUES
(1, 'xxx', '32423234', 'việt nam', 'ha noi', 'ba đình', 'cống vị ba đình', 'xóm liều', '0387409300', 'doangiang665@gmail.com', 'develop.io.vn', 'xxxxx', '2344324', '2343244', '[]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030227_a219e8b45e3cc12378d8.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030230_ffa313e9284e59d34cdf.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030232_e04bed398cc255350886.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030234_7f855fad911edf3ee922.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030254_d9af1ae6c177f1e36141.xls\"]', NULL, NULL, '[]', 1, '2025-04-13 16:14:26', '2025-05-03 07:32:54', NULL, 1, '{\"selectedTemplate\":\"tpl-3\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"company\":\"selected\",\"selectedCompanies\":[],\"store\":\"selected\",\"selectedStores\":[\"1\"]}'),
(2, 'Xiaomi', 'xxxxxxxxxxxiiiiiiiiiiiiiiiiiii', 'Trung quốc', 'Thượng hải', 'Thượng hải', 'Thượng hải', 'Thượng hải', '0387409300', 'doangiang665@gmail.com', 'https://shopee.vn/', '★ Kệ máy tính để bàn còn giúp sắp xếp tài liệu, đồ dùng gọn gàng, tiện ích, khoa học\n\n★ Sử dụng chiếc kệ màn hình này giúp bạn không phải cúi người trong khi làm việc, cải thiện tư thế cổ vai gáy, bảo vệ vóc dáng\n\n★ Đáy kệ đồng thời làm hộc để đồ, bàn phím, chuột ngăn nắp tạo không làm việc gọn gàng\n\n★ TopV sở hữu công nghệ sản xuất CNC tiên tiến bậc nhất hiện nay, giúp cho sản phẩm được gia công chính xác tới 0.1mm\n\n★ Kệ màn hình TOPV được thiết kế thông minh để dấu đinh vít do đó sản phẩm nhìn rất đẹp và sang trọng\n\n★ Chất liệu: Gỗ công nghiệp MDF nhập khẩu Malaisia phủ melamine, chống ẩm mối mọt\n\n★ Gỗ dày tới 1.6cm, không mỏng như những sản phẩm khác trên thị trường (thường dày 1-1.2cm)', 'dev', 'facebook.com', '[\"facebook.com\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745505449_599f8a45b9ee7e1d9229.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745505455_b7981d8de74f5078971c.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745505458_cc3a1c933382d26b775d.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745505462_eda4879f1a14188a33a3.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745505471_4c70ac8ebced86736d2e.txt\"]', NULL, NULL, '[]', 1, '2025-04-24 14:40:00', '2025-04-24 14:40:00', NULL, 3, NULL),
(3, 'abc', '435344353', 'Viet nam', 'ha noi', 'Tay mo', 'vin home', 'vin smart', '0387409300', 'doangiang665@gmail.com', 'vnexpress.vn', 'công ty truyền thông', 'dev code', '', '[\"demo demo\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745514075_a14af045326518955620.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745514083_5ae77b2ff50d5681708a.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745514085_0f0cb594530b70223389.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745514088_63d54e4f02a4df3d4541.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745514094_a682714304111395c58a.xlsx\"]', NULL, NULL, '[]', 1, '2025-04-24 17:02:42', '2025-04-24 17:02:42', NULL, 3, NULL),
(4, 'xxxxxxxx', '3424324', 'viet nam', 'ha noi', 'ba dinh', 'cong vi', 'ngoc khanh ba dinh ha noi', '0387409300', 'doangiang@gmail.com', '', '', '', '', '[]', '[\"http:\\/\\/assets.giang.test\\/image\\/1746257908_44365af29a30d1cb69e3.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1746257913_e9957ca23bd689ae3c96.png\"]', '[]', '[]', '[]', NULL, NULL, '[]', 1, '2025-05-03 07:33:03', '2025-05-03 07:45:58', NULL, 1, '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"1\",\"3\"],\"company\":\"selected\",\"selectedCompanies\":[\"4\",\"1\"],\"store\":\"selected\",\"selectedStores\":[\"1\",\"6\"]}');

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
-- Table structure for table `entity_images`
--

CREATE TABLE `entity_images` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(10) UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_cover` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `banner` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `event_mode` varchar(20) DEFAULT 'online',
  `is_enabled` tinyint(1) DEFAULT 1,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `contact_first_name` varchar(100) DEFAULT NULL,
  `contact_last_name` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `ticket_options` text DEFAULT NULL,
  `social_links` text DEFAULT NULL,
  `images` text DEFAULT NULL,
  `video` text DEFAULT NULL,
  `format_type` enum('online','offline') DEFAULT 'offline',
  `display_settings` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `user_id`, `name`, `banner`, `location`, `event_mode`, `is_enabled`, `start_time`, `end_time`, `description`, `created_at`, `updated_at`, `country`, `city`, `district`, `contact_first_name`, `contact_last_name`, `contact_phone`, `contact_email`, `ticket_options`, `social_links`, `images`, `video`, `format_type`, `display_settings`) VALUES
(1, 1, 'abc', 'http://assets.giang.test/image/1746037955_5db3c563bd96591ec624.jpg', 'ty mo nam tu liem', 'online', 1, '2025-04-02 19:55:14', '2025-04-09 19:55:17', '[{\"title\":\"ewqeqwqeqwe\",\"content\":\"<p>dsadsadda<\\/p>\"},{\"title\":\"57567567657\",\"content\":\"<p>fsdfdsfsfsf<\\/p>\"},{\"title\":\"mmmmmmmmmmmmmm\",\"content\":\"<p>nnnnnnnnnnnnnnnnnn<\\/p>\"}]', '2025-04-19 03:55:21', '2025-05-02 16:08:03', 'viet nam', 'ha noi', 'nam tu liem', 'doan', 'giang', '0387409300', 'doangiang665@gmail.com', '\"[{\\\"title\\\":\\\"111111111\\\",\\\"description\\\":\\\"\\\",\\\"price\\\":10000000000},{\\\"title\\\":\\\"33333333333\\\",\\\"description\\\":\\\"\\\",\\\"price\\\":6666666666666666}]\"', '\"[{\\\"type\\\":\\\"facebook\\\",\\\"url\\\":\\\"https:\\/\\/dantri.com.vn\\/giao-duc\\/top-9-truong-dai-hoc-tot-nhat-nhat-ban-nam-2025-20250501202923859.htm\\\",\\\"icon\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746201737_6b8aef50c620203911ef.jpg\\\"},{\\\"type\\\":\\\"linkedin\\\",\\\"url\\\":\\\"https:\\/\\/cdnphoto.dantri.com.vn\\/7SRYiJD05ukrmyoV6TZx1k3sAZM=\\/thumb_w\\/1020\\/2025\\/05\\/02\\/tbt-1746158118574.jpg\\\",\\\"icon\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746201920_c5131d2c0c5858f4bedb.jpg\\\"}]\"', '\"[{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746029417_20453b5636ecffe9887d.jpg\\\",\\\"is_main\\\":true},{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746030360_c16844c25c41255be6e4.jpg\\\",\\\"is_main\\\":false},{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746032537_8307b0403fe457e20580.jpg\\\",\\\"is_main\\\":false},{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746032541_35aea3dbeaa439d9cedd.jpg\\\",\\\"is_main\\\":false},{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746032548_88a4a4a19cbe5408828d.jpg\\\",\\\"is_main\\\":false},{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746037959_aff78cc90d81287f74e4.jpg\\\",\\\"is_main\\\":false},{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746037963_57a3d4cbb59f554357b3.jpg\\\",\\\"is_main\\\":false}]\"', '\"[{\\\"uid\\\":\\\"1746037845545\\\",\\\"url\\\":\\\"https:\\/\\/www.youtube.com\\/watch?v=R3GfuzLMPkA\\\",\\\"preview\\\":\\\"https:\\/\\/img.youtube.com\\/vi\\/R3GfuzLMPkA\\/hqdefault.jpg\\\",\\\"isCover\\\":false,\\\"isYoutube\\\":true},{\\\"uid\\\":\\\"1746037969377\\\",\\\"url\\\":\\\"https:\\/\\/www.youtube.com\\/watch?v=G5RpJwCJDqc\\\",\\\"preview\\\":\\\"https:\\/\\/img.youtube.com\\/vi\\/G5RpJwCJDqc\\/hqdefault.jpg\\\",\\\"isCover\\\":false,\\\"isYoutube\\\":true}]\"', 'offline', NULL),
(2, 1, 'xxxxxxx', 'http://assets.giang.test/image/1746202553_13787ae765a78b8865a6.jpg', 'gdfgdfgdfg', 'online', 1, '2025-05-02 16:16:56', '2025-05-15 16:17:01', '[{\"title\":\"6546546546\",\"content\":\"<p>t\\u1ebbtretete<\\/p>\"},{\"title\":\"rtetretet\",\"content\":\"<p>\\u1ec3trtret<\\/p>\"}]', '2025-05-02 16:15:40', '2025-05-02 16:17:24', 'vvvvvvvvvv', 'bbbbbbbbbb', 'ruiyiuyii', 'rewrewr', '56757567', '0387409300', 'doangiang665@gmail.com', '\"[{\\\"title\\\":\\\"\\\",\\\"description\\\":\\\"\\\",\\\"price\\\":0}]\"', '\"[{\\\"type\\\":\\\"instagram\\\",\\\"url\\\":\\\"https:\\/\\/antdv.com\\/components\\/upload\\/#Upload\\\",\\\"icon\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746202636_55513f183c5978bf4488.jpg\\\"}]\"', '\"[{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746202521_8a81f574aeeac142dd3c.jpg\\\",\\\"is_main\\\":true}]\"', '\"[{\\\"uid\\\":\\\"1746202578711\\\",\\\"url\\\":\\\"https:\\/\\/www.youtube.com\\/watch?v=gTkV0z3NTcA\\\",\\\"preview\\\":\\\"https:\\/\\/img.youtube.com\\/vi\\/gTkV0z3NTcA\\/hqdefault.jpg\\\",\\\"isCover\\\":false,\\\"isYoutube\\\":true}]\"', 'offline', NULL),
(3, 1, '33333', 'http://assets.giang.test/image/1746258612_4f4625f74cb3d27de0e4.png', 'gggggggg', 'online', 1, '2025-05-03 00:50:24', '2025-05-30 00:50:27', '[{\"title\":\"\",\"content\":\"<p><br><\\/p>\"}]', '2025-05-03 06:19:35', '2025-05-03 08:07:40', NULL, NULL, NULL, '', '', '', '', '\"[{\\\"title\\\":\\\"\\\",\\\"description\\\":\\\"\\\",\\\"price\\\":0}]\"', '\"[]\"', '\"[{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746258610_ada5434eb10a8d6fd757.png\\\",\\\"is_main\\\":false}]\"', '\"[]\"', 'offline', '[]'),
(4, 1, 'ccccccccccccccc', 'http://assets.giang.test/image/1746256539_dc524834f2899997e8c9.jpg', 'xxxxxxxxxxxxxxxx', 'online', 1, '2025-05-02 10:16:00', '2025-05-20 10:16:04', '[{\"title\":\"\",\"content\":\"<p><br><\\/p>\"}]', '2025-05-03 06:25:47', '2025-05-03 07:18:17', NULL, NULL, NULL, '', '', '', '', '\"[{\\\"title\\\":\\\"\\\",\\\"description\\\":\\\"\\\",\\\"price\\\":0}]\"', '\"[]\"', '\"[{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746256530_959ce70527ba750584b2.jpg\\\",\\\"is_main\\\":false}]\"', '\"[]\"', 'offline', '[]'),
(5, 1, 'xxxxxxxxxx', 'http://assets.giang.test/image/1746253818_9096dad87a5b81cf36b5.jpg', 'vvvvvvvvvvvvvv', 'online', 1, '2025-04-28 00:33:53', '2025-05-26 00:33:56', '[{\"title\":\"xxxxxxx\",\"content\":\"<p>vvvvvvvv<\\/p>\"},{\"title\":\"bbbbbbbbbb\",\"content\":\"<p>vvvvvvvvvvvv<\\/p>\"}]', '2025-05-03 06:30:22', '2025-05-03 09:06:11', NULL, NULL, NULL, '', '', '', '', '\"[{\\\"title\\\":\\\"\\\",\\\"description\\\":\\\"\\\",\\\"price\\\":0}]\"', '\"[{\\\"type\\\":\\\"facebook\\\",\\\"url\\\":\\\"https:\\/\\/www.youtube.com\\/watch?v=QEjB71pQDf8\\\",\\\"icon\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746261130_c74cd26ffad1ebd88c80.png\\\"}]\"', '\"[{\\\"url\\\":\\\"http:\\/\\/assets.giang.test\\/image\\/1746253811_07015ce4da9066ba0b45.jpg\\\",\\\"is_main\\\":false}]\"', '\"[]\"', 'offline', '\"{\\\"selectedTemplate\\\":\\\"tpl-1\\\",\\\"relatedProducts\\\":\\\"all\\\",\\\"selectedProducts\\\":[],\\\"company\\\":\\\"selected\\\",\\\"selectedCompanies\\\":[\\\"1\\\"],\\\"store\\\":\\\"all\\\",\\\"selectedStores\\\":[],\\\"enableSurvey\\\":false,\\\"selectedSurveys\\\":[],\\\"enableOrderButton\\\":true,\\\"topProductsMode\\\":\\\"all\\\",\\\"topProducts\\\":[],\\\"productLinks\\\":[]}\"');

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
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `display_settings` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `user_id`, `first_name`, `last_name`, `name`, `avatar`, `video_url`, `phone`, `email`, `website`, `country`, `address`, `social_links`, `job_title`, `bio`, `created_at`, `updated_at`, `display_settings`) VALUES
(1, 1, NULL, NULL, 'demo 1', 'http://assets.giang.test/image/1745030161_1629c049dd5304b986df.jpg', NULL, '0387409300', 'doangiang665@gmail.com', NULL, NULL, 'acb xyz', NULL, 'dev web', 'dev web', '2025-04-12 17:20:19', '2025-04-25 04:05:50', '{\"selectedTemplate\":\"tpl-3\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"1\",\"2\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"selected\",\"selectedStores\":[\"1\"],\"enableSurvey\":true,\"selectedSurveys\":[],\"enableOrderButton\":true,\"topProductsMode\":\"selected\",\"topProducts\":[\"2\",\"9\",\"5\"],\"productLinks\":[{\"platform\":\"Shopee\",\"url\":\"https://shopee.vn/\"},{\"platform\":\"Lazada\",\"url\":\"https://tiki.vn/\"},{\"platform\":\"Tiki\",\"url\":\"https://www.lazada.vn/\"}]}'),
(2, 1, NULL, NULL, 'chaiel', 'http://assets.giang.test/image/1745033604_a1290dbd357f8d81b784.jpg', NULL, '0387409300', 'chaiel@gmail.com', NULL, NULL, NULL, NULL, 'dev', 'dev', '2025-04-19 03:33:52', '2025-04-19 03:33:52', '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"2\",\"3\",\"4\",\"5\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"selected\",\"selectedStores\":[\"1\"]}'),
(3, 1, NULL, NULL, 'xxxxxxxxx', 'http://assets.giang.test/image/1746256163_85b41370090178cdcc1d.jpg', NULL, '0387409300', 'giang@gmail.com', NULL, NULL, NULL, NULL, 'dev', '', '2025-05-03 07:05:38', '2025-05-03 07:05:38', '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"1\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"selected\",\"selectedStores\":[\"6\"]}');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) NOT NULL,
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
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `display_settings` text DEFAULT NULL,
  `product_links` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `name`, `category_id`, `price_mode`, `price`, `price_from`, `price_to`, `show_contact_price`, `avatar`, `image`, `video`, `certificate_file`, `description`, `attributes`, `status`, `created_at`, `updated_at`, `deleted_at`, `user_id`, `display_settings`, `product_links`) VALUES
(1, '5424324324kkk', 'demo 1', 1, 'range', 120000.00, 10000.00, 150000.00, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745030161_1629c049dd5304b986df.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030163_2becc0716ebd8871b505.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030164_168ff7d22e43564ad35c.jpg\"]', '[\"http:\\/\\/api.giang.test\\/uploads\\/1744558167_bca4a4605e98ca0c07e5.pdf\"]', '<p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">- Xuất xứ : Trung Quốc</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Thiết kế nhỏ gọn, vừa tầm tay.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Các phím to, rõ, dễ nhìn, không bị phai mờ theo thời gian.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Sử dụng 2 pin AAA, không cần thiết lập cài đặt.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Khoảng cách khiển lên đến 8m.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-An toàn cho người sử dụng.</span></p><p><br></p>', '[{\"id\":\"96\",\"product_id\":\"1\",\"name\":\"XL\",\"value\":\"342424324\",\"created_at\":\"2025-04-24 16:18:16\",\"updated_at\":\"2025-04-24 16:18:16\"}]', 1, '2025-04-12 17:20:19', '2025-04-25 04:05:50', NULL, 1, '{\"selectedTemplate\":\"tpl-3\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"1\",\"2\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"selected\",\"selectedStores\":[\"1\"],\"enableSurvey\":true,\"selectedSurveys\":[],\"enableOrderButton\":true,\"productLinks\":[{\"platform\":\"Shopee\",\"url\":\"https://shopee.vn/\"},{\"platform\":\"Lazada\",\"url\":\"https://tiki.vn/\"},{\"platform\":\"Tiki\",\"url\":\"https://www.lazada.vn/\"}]}', NULL),
(2, '23424244', 'demo sp', 1, 'range', 120000.00, 40000.00, 60000.00, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745030182_9c8ac5def4099a010923.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030183_b10b3ec25f2fcedf2095.jpg\",\"http:\\/\\/assets.giang.test\\/image\\/1745552471_508fb17cc865c1cd3bea.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030185_6a907b219d2810ceec89.jpg\"]', '[\"http:\\/\\/api.giang.test\\/uploads\\/1744558212_d3135ea188a37ab7205c.pdf\"]', '<p>demo demo</p>', '[{\"id\":\"115\",\"product_id\":\"2\",\"name\":\"xl\",\"value\":\"120000\",\"created_at\":\"2025-04-25 04:05:58\",\"updated_at\":\"2025-04-25 04:05:58\"}]', 1, '2025-04-13 14:58:36', '2025-04-25 04:06:04', NULL, 1, '{\"selectedTemplate\":\"tpl-2\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"5\",\"4\",\"6\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"selected\",\"selectedStores\":[\"1\"],\"enableSurvey\":true,\"selectedSurveys\":[],\"enableOrderButton\":true,\"productLinks\":[{\"platform\":\"Shopee\",\"url\":\"\"},{\"platform\":\"Lazada\",\"url\":\"\"},{\"platform\":\"Tiki\",\"url\":\"\"}]}', NULL),
(3, '43243242', 'demo demo', 1, 'single', 100000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745030199_204f7c732930f2e30a52.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030201_92e108209607bc4142c8.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745030203_d86e92994564c22c5735.jpg\"]', '[\"http:\\/\\/api.giang.test\\/uploads\\/1744557413_41644f144bdb597f2bae.pdf\"]', 'demo demo', '[{\"id\": \"24\", \"name\": \"xl \", \"value\": \"12000\", \"created_at\": \"2025-04-20 03:52:02\", \"product_id\": \"3\", \"updated_at\": \"2025-04-20 03:52:02\"}, {\"id\": \"25\", \"name\": \"xxl\", \"value\": \"20000\", \"created_at\": \"2025-04-20 03:52:02\", \"product_id\": \"3\", \"updated_at\": \"2025-04-20 03:52:02\"}]', 0, '2025-04-13 15:17:23', '2025-04-24 14:48:15', NULL, 1, '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"all\",\"company\":\"all\",\"store\":\"all\",\"enableSurvey\":true,\"enableOrderButton\":true}', NULL),
(4, '435435436787AAAAAAAAAA', 'Nước rau má', NULL, 'single', 25000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745479571_e32d4ad88fe5e94a4246.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745479579_fc31d80c0b144d95d3a9.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745479581_77d80ba9c15350d71ce9.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745479589_c8a7153f6047d2b56181.html\"]', '<p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">- Xuất xứ : Trung Quốc</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Thiết kế nhỏ gọn, vừa tầm tay.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Các phím to, rõ, dễ nhìn, không bị phai mờ theo thời gian.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Sử dụng 2 pin AAA, không cần thiết lập cài đặt.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Khoảng cách khiển lên đến 8m.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-An toàn cho người sử dụng.</span></p><p><br></p>', '[{\"id\":\"69\",\"product_id\":\"4\",\"name\":\"L\",\"value\":\"25000\",\"created_at\":\"2025-04-24 07:27:16\",\"updated_at\":\"2025-04-24 07:27:16\"},{\"id\":\"70\",\"product_id\":\"4\",\"name\":\"M\",\"value\":\"20000\",\"created_at\":\"2025-04-24 07:27:16\",\"updated_at\":\"2025-04-24 07:27:16\"}]', 1, '2025-04-24 07:27:16', '2025-04-24 08:49:28', NULL, 1, '{\"0\":\"{\",\"1\":\"\\\"\",\"2\":\"s\",\"3\":\"e\",\"4\":\"l\",\"5\":\"e\",\"6\":\"c\",\"7\":\"t\",\"8\":\"e\",\"9\":\"d\",\"10\":\"T\",\"11\":\"e\",\"12\":\"m\",\"13\":\"p\",\"14\":\"l\",\"15\":\"a\",\"16\":\"t\",\"17\":\"e\",\"18\":\"\\\"\",\"19\":\":\",\"20\":\"\\\"\",\"21\":\"t\",\"22\":\"p\",\"23\":\"l\",\"24\":\"-\",\"25\":\"1\",\"26\":\"\\\"\",\"27\":\",\",\"28\":\"\\\"\",\"29\":\"r\",\"30\":\"e\",\"31\":\"l\",\"32\":\"a\",\"33\":\"t\",\"34\":\"e\",\"35\":\"d\",\"36\":\"P\",\"37\":\"r\",\"38\":\"o\",\"39\":\"d\",\"40\":\"u\",\"41\":\"c\",\"42\":\"t\",\"43\":\"s\",\"44\":\"\\\"\",\"45\":\":\",\"46\":\"\\\"\",\"47\":\"a\",\"48\":\"l\",\"49\":\"l\",\"50\":\"\\\"\",\"51\":\",\",\"52\":\"\\\"\",\"53\":\"s\",\"54\":\"e\",\"55\":\"l\",\"56\":\"e\",\"57\":\"c\",\"58\":\"t\",\"59\":\"e\",\"60\":\"d\",\"61\":\"P\",\"62\":\"r\",\"63\":\"o\",\"64\":\"d\",\"65\":\"u\",\"66\":\"c\",\"67\":\"t\",\"68\":\"s\",\"69\":\"\\\"\",\"70\":\":\",\"71\":\"[\",\"72\":\"]\",\"73\":\",\",\"74\":\"\\\"\",\"75\":\"c\",\"76\":\"o\",\"77\":\"m\",\"78\":\"p\",\"79\":\"a\",\"80\":\"n\",\"81\":\"y\",\"82\":\"\\\"\",\"83\":\":\",\"84\":\"\\\"\",\"85\":\"a\",\"86\":\"l\",\"87\":\"l\",\"88\":\"\\\"\",\"89\":\",\",\"90\":\"\\\"\",\"91\":\"s\",\"92\":\"e\",\"93\":\"l\",\"94\":\"e\",\"95\":\"c\",\"96\":\"t\",\"97\":\"e\",\"98\":\"d\",\"99\":\"C\",\"100\":\"o\",\"101\":\"m\",\"102\":\"p\",\"103\":\"a\",\"104\":\"n\",\"105\":\"i\",\"106\":\"e\",\"107\":\"s\",\"108\":\"\\\"\",\"109\":\":\",\"110\":\"[\",\"111\":\"]\",\"112\":\",\",\"113\":\"\\\"\",\"114\":\"s\",\"115\":\"t\",\"116\":\"o\",\"117\":\"r\",\"118\":\"e\",\"119\":\"\\\"\",\"120\":\":\",\"121\":\"\\\"\",\"122\":\"a\",\"123\":\"l\",\"124\":\"l\",\"125\":\"\\\"\",\"126\":\",\",\"127\":\"\\\"\",\"128\":\"s\",\"129\":\"e\",\"130\":\"l\",\"131\":\"e\",\"132\":\"c\",\"133\":\"t\",\"134\":\"e\",\"135\":\"d\",\"136\":\"S\",\"137\":\"t\",\"138\":\"o\",\"139\":\"r\",\"140\":\"e\",\"141\":\"s\",\"142\":\"\\\"\",\"143\":\":\",\"144\":\"[\",\"145\":\"]\",\"146\":\",\",\"147\":\"\\\"\",\"148\":\"e\",\"149\":\"n\",\"150\":\"a\",\"151\":\"b\",\"152\":\"l\",\"153\":\"e\",\"154\":\"S\",\"155\":\"u\",\"156\":\"r\",\"157\":\"v\",\"158\":\"e\",\"159\":\"y\",\"160\":\"\\\"\",\"161\":\":\",\"162\":\"f\",\"163\":\"a\",\"164\":\"l\",\"165\":\"s\",\"166\":\"e\",\"167\":\",\",\"168\":\"\\\"\",\"169\":\"s\",\"170\":\"e\",\"171\":\"l\",\"172\":\"e\",\"173\":\"c\",\"174\":\"t\",\"175\":\"e\",\"176\":\"d\",\"177\":\"S\",\"178\":\"u\",\"179\":\"r\",\"180\":\"v\",\"181\":\"e\",\"182\":\"y\",\"183\":\"s\",\"184\":\"\\\"\",\"185\":\":\",\"186\":\"[\",\"187\":\"]\",\"188\":\",\",\"189\":\"\\\"\",\"190\":\"e\",\"191\":\"n\",\"192\":\"a\",\"193\":\"b\",\"194\":\"l\",\"195\":\"e\",\"196\":\"O\",\"197\":\"r\",\"198\":\"d\",\"199\":\"e\",\"200\":\"r\",\"201\":\"B\",\"202\":\"u\",\"203\":\"t\",\"204\":\"t\",\"205\":\"o\",\"206\":\"n\",\"207\":\"\\\"\",\"208\":\":\",\"209\":\"t\",\"210\":\"r\",\"211\":\"u\",\"212\":\"e\",\"213\":\",\",\"214\":\"\\\"\",\"215\":\"p\",\"216\":\"r\",\"217\":\"o\",\"218\":\"d\",\"219\":\"u\",\"220\":\"c\",\"221\":\"t\",\"222\":\"L\",\"223\":\"i\",\"224\":\"n\",\"225\":\"k\",\"226\":\"s\",\"227\":\"\\\"\",\"228\":\":\",\"229\":\"[\",\"230\":\"{\",\"231\":\"\\\"\",\"232\":\"p\",\"233\":\"l\",\"234\":\"a\",\"235\":\"t\",\"236\":\"f\",\"237\":\"o\",\"238\":\"r\",\"239\":\"m\",\"240\":\"\\\"\",\"241\":\":\",\"242\":\"\\\"\",\"243\":\"S\",\"244\":\"h\",\"245\":\"o\",\"246\":\"p\",\"247\":\"e\",\"248\":\"e\",\"249\":\"\\\"\",\"250\":\",\",\"251\":\"\\\"\",\"252\":\"u\",\"253\":\"r\",\"254\":\"l\",\"255\":\"\\\"\",\"256\":\":\",\"257\":\"\\\"\",\"258\":\"\\\"\",\"259\":\"}\",\"260\":\",\",\"261\":\"{\",\"262\":\"\\\"\",\"263\":\"p\",\"264\":\"l\",\"265\":\"a\",\"266\":\"t\",\"267\":\"f\",\"268\":\"o\",\"269\":\"r\",\"270\":\"m\",\"271\":\"\\\"\",\"272\":\":\",\"273\":\"\\\"\",\"274\":\"L\",\"275\":\"a\",\"276\":\"z\",\"277\":\"a\",\"278\":\"d\",\"279\":\"a\",\"280\":\"\\\"\",\"281\":\",\",\"282\":\"\\\"\",\"283\":\"u\",\"284\":\"r\",\"285\":\"l\",\"286\":\"\\\"\",\"287\":\":\",\"288\":\"\\\"\",\"289\":\"\\\"\",\"290\":\"}\",\"291\":\",\",\"292\":\"{\",\"293\":\"\\\"\",\"294\":\"p\",\"295\":\"l\",\"296\":\"a\",\"297\":\"t\",\"298\":\"f\",\"299\":\"o\",\"300\":\"r\",\"301\":\"m\",\"302\":\"\\\"\",\"303\":\":\",\"304\":\"\\\"\",\"305\":\"T\",\"306\":\"i\",\"307\":\"k\",\"308\":\"i\",\"309\":\"\\\"\",\"310\":\",\",\"311\":\"\\\"\",\"312\":\"u\",\"313\":\"r\",\"314\":\"l\",\"315\":\"\\\"\",\"316\":\":\",\"317\":\"\\\"\",\"318\":\"\\\"\",\"319\":\"}\",\"320\":\"]\",\"321\":\"}\",\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"all\",\"selectedProducts\":[],\"company\":\"all\",\"selectedCompanies\":[],\"store\":\"all\",\"selectedStores\":[],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"productLinks\":[{\"platform\":\"Shopee\",\"url\":\"\"},{\"platform\":\"Lazada\",\"url\":\"\"},{\"platform\":\"Tiki\",\"url\":\"\"}]}', NULL),
(5, '454657AADĐGGG', 'rau má', NULL, 'single', 10000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745480303_0186821d966918c4db65.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480305_272f716996ccae559ffb.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480307_565b58fd280481cf7755.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480311_58487ae57951309fd294.html\"]', '', '[{\"name\":\"L\",\"value\":\"10000\"}]', 1, '2025-04-24 07:39:06', '2025-04-24 14:48:15', NULL, 1, '\"{\\\"selectedTemplate\\\":\\\"tpl-1\\\",\\\"relatedProducts\\\":\\\"all\\\",\\\"selectedProducts\\\":[],\\\"company\\\":\\\"all\\\",\\\"selectedCompanies\\\":[],\\\"store\\\":\\\"all\\\",\\\"selectedStores\\\":[],\\\"enableSurvey\\\":false,\\\"selectedSurveys\\\":[],\\\"enableOrderButton\\\":true,\\\"productLinks\\\":[{\\\"platform\\\":\\\"Shopee\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Lazada\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Tiki\\\",\\\"url\\\":\\\"\\\"}]}\"', NULL),
(6, '4535353hhhhhhhh', 'Sữa đậu fami', NULL, 'single', 20000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745480582_a58f7b1a82ccf75e9bd6.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480585_6055a70269e35cd3a466.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480592_4835d8dc072c7b31ad5b.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480596_fc8f6d8c4503d8e6feff.txt\"]', '<p><br></p>', '[{\"id\":\"72\",\"product_id\":\"6\",\"name\":\"xl\",\"value\":\"10000\",\"created_at\":\"2025-04-24 07:43:52\",\"updated_at\":\"2025-04-24 07:43:52\"}]', 1, '2025-04-24 07:43:52', '2025-04-28 16:48:44', NULL, 1, '{\"0\":\"{\",\"1\":\"\\\"\",\"2\":\"s\",\"3\":\"e\",\"4\":\"l\",\"5\":\"e\",\"6\":\"c\",\"7\":\"t\",\"8\":\"e\",\"9\":\"d\",\"10\":\"T\",\"11\":\"e\",\"12\":\"m\",\"13\":\"p\",\"14\":\"l\",\"15\":\"a\",\"16\":\"t\",\"17\":\"e\",\"18\":\"\\\"\",\"19\":\":\",\"20\":\"\\\"\",\"21\":\"t\",\"22\":\"p\",\"23\":\"l\",\"24\":\"-\",\"25\":\"1\",\"26\":\"\\\"\",\"27\":\",\",\"28\":\"\\\"\",\"29\":\"r\",\"30\":\"e\",\"31\":\"l\",\"32\":\"a\",\"33\":\"t\",\"34\":\"e\",\"35\":\"d\",\"36\":\"P\",\"37\":\"r\",\"38\":\"o\",\"39\":\"d\",\"40\":\"u\",\"41\":\"c\",\"42\":\"t\",\"43\":\"s\",\"44\":\"\\\"\",\"45\":\":\",\"46\":\"\\\"\",\"47\":\"a\",\"48\":\"l\",\"49\":\"l\",\"50\":\"\\\"\",\"51\":\",\",\"52\":\"\\\"\",\"53\":\"s\",\"54\":\"e\",\"55\":\"l\",\"56\":\"e\",\"57\":\"c\",\"58\":\"t\",\"59\":\"e\",\"60\":\"d\",\"61\":\"P\",\"62\":\"r\",\"63\":\"o\",\"64\":\"d\",\"65\":\"u\",\"66\":\"c\",\"67\":\"t\",\"68\":\"s\",\"69\":\"\\\"\",\"70\":\":\",\"71\":\"[\",\"72\":\"]\",\"73\":\",\",\"74\":\"\\\"\",\"75\":\"c\",\"76\":\"o\",\"77\":\"m\",\"78\":\"p\",\"79\":\"a\",\"80\":\"n\",\"81\":\"y\",\"82\":\"\\\"\",\"83\":\":\",\"84\":\"\\\"\",\"85\":\"a\",\"86\":\"l\",\"87\":\"l\",\"88\":\"\\\"\",\"89\":\",\",\"90\":\"\\\"\",\"91\":\"s\",\"92\":\"e\",\"93\":\"l\",\"94\":\"e\",\"95\":\"c\",\"96\":\"t\",\"97\":\"e\",\"98\":\"d\",\"99\":\"C\",\"100\":\"o\",\"101\":\"m\",\"102\":\"p\",\"103\":\"a\",\"104\":\"n\",\"105\":\"i\",\"106\":\"e\",\"107\":\"s\",\"108\":\"\\\"\",\"109\":\":\",\"110\":\"[\",\"111\":\"]\",\"112\":\",\",\"113\":\"\\\"\",\"114\":\"s\",\"115\":\"t\",\"116\":\"o\",\"117\":\"r\",\"118\":\"e\",\"119\":\"\\\"\",\"120\":\":\",\"121\":\"\\\"\",\"122\":\"a\",\"123\":\"l\",\"124\":\"l\",\"125\":\"\\\"\",\"126\":\",\",\"127\":\"\\\"\",\"128\":\"s\",\"129\":\"e\",\"130\":\"l\",\"131\":\"e\",\"132\":\"c\",\"133\":\"t\",\"134\":\"e\",\"135\":\"d\",\"136\":\"S\",\"137\":\"t\",\"138\":\"o\",\"139\":\"r\",\"140\":\"e\",\"141\":\"s\",\"142\":\"\\\"\",\"143\":\":\",\"144\":\"[\",\"145\":\"]\",\"146\":\",\",\"147\":\"\\\"\",\"148\":\"e\",\"149\":\"n\",\"150\":\"a\",\"151\":\"b\",\"152\":\"l\",\"153\":\"e\",\"154\":\"S\",\"155\":\"u\",\"156\":\"r\",\"157\":\"v\",\"158\":\"e\",\"159\":\"y\",\"160\":\"\\\"\",\"161\":\":\",\"162\":\"f\",\"163\":\"a\",\"164\":\"l\",\"165\":\"s\",\"166\":\"e\",\"167\":\",\",\"168\":\"\\\"\",\"169\":\"s\",\"170\":\"e\",\"171\":\"l\",\"172\":\"e\",\"173\":\"c\",\"174\":\"t\",\"175\":\"e\",\"176\":\"d\",\"177\":\"S\",\"178\":\"u\",\"179\":\"r\",\"180\":\"v\",\"181\":\"e\",\"182\":\"y\",\"183\":\"s\",\"184\":\"\\\"\",\"185\":\":\",\"186\":\"[\",\"187\":\"]\",\"188\":\",\",\"189\":\"\\\"\",\"190\":\"e\",\"191\":\"n\",\"192\":\"a\",\"193\":\"b\",\"194\":\"l\",\"195\":\"e\",\"196\":\"O\",\"197\":\"r\",\"198\":\"d\",\"199\":\"e\",\"200\":\"r\",\"201\":\"B\",\"202\":\"u\",\"203\":\"t\",\"204\":\"t\",\"205\":\"o\",\"206\":\"n\",\"207\":\"\\\"\",\"208\":\":\",\"209\":\"t\",\"210\":\"r\",\"211\":\"u\",\"212\":\"e\",\"213\":\",\",\"214\":\"\\\"\",\"215\":\"p\",\"216\":\"r\",\"217\":\"o\",\"218\":\"d\",\"219\":\"u\",\"220\":\"c\",\"221\":\"t\",\"222\":\"L\",\"223\":\"i\",\"224\":\"n\",\"225\":\"k\",\"226\":\"s\",\"227\":\"\\\"\",\"228\":\":\",\"229\":\"[\",\"230\":\"{\",\"231\":\"\\\"\",\"232\":\"p\",\"233\":\"l\",\"234\":\"a\",\"235\":\"t\",\"236\":\"f\",\"237\":\"o\",\"238\":\"r\",\"239\":\"m\",\"240\":\"\\\"\",\"241\":\":\",\"242\":\"\\\"\",\"243\":\"S\",\"244\":\"h\",\"245\":\"o\",\"246\":\"p\",\"247\":\"e\",\"248\":\"e\",\"249\":\"\\\"\",\"250\":\",\",\"251\":\"\\\"\",\"252\":\"u\",\"253\":\"r\",\"254\":\"l\",\"255\":\"\\\"\",\"256\":\":\",\"257\":\"\\\"\",\"258\":\"\\\"\",\"259\":\"}\",\"260\":\",\",\"261\":\"{\",\"262\":\"\\\"\",\"263\":\"p\",\"264\":\"l\",\"265\":\"a\",\"266\":\"t\",\"267\":\"f\",\"268\":\"o\",\"269\":\"r\",\"270\":\"m\",\"271\":\"\\\"\",\"272\":\":\",\"273\":\"\\\"\",\"274\":\"L\",\"275\":\"a\",\"276\":\"z\",\"277\":\"a\",\"278\":\"d\",\"279\":\"a\",\"280\":\"\\\"\",\"281\":\",\",\"282\":\"\\\"\",\"283\":\"u\",\"284\":\"r\",\"285\":\"l\",\"286\":\"\\\"\",\"287\":\":\",\"288\":\"\\\"\",\"289\":\"\\\"\",\"290\":\"}\",\"291\":\",\",\"292\":\"{\",\"293\":\"\\\"\",\"294\":\"p\",\"295\":\"l\",\"296\":\"a\",\"297\":\"t\",\"298\":\"f\",\"299\":\"o\",\"300\":\"r\",\"301\":\"m\",\"302\":\"\\\"\",\"303\":\":\",\"304\":\"\\\"\",\"305\":\"T\",\"306\":\"i\",\"307\":\"k\",\"308\":\"i\",\"309\":\"\\\"\",\"310\":\",\",\"311\":\"\\\"\",\"312\":\"u\",\"313\":\"r\",\"314\":\"l\",\"315\":\"\\\"\",\"316\":\":\",\"317\":\"\\\"\",\"318\":\"\\\"\",\"319\":\"}\",\"320\":\"]\",\"321\":\"}\",\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"3\",\"4\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"selected\",\"selectedStores\":[\"1\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"productLinks\":[{\"platform\":\"Shopee\",\"url\":\"\"},{\"platform\":\"Lazada\",\"url\":\"\"},{\"platform\":\"Tiki\",\"url\":\"\"}]}', NULL),
(7, '3453454353', 'bún đậu', NULL, 'single', 140000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745480966_68d7c266dac1fcb14dde.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480970_347dc3ef1b43bf24cf4c.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480975_9de1474121f7e51f1e7e.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745480986_6bbf44cd4056913f2f8d.png\"]', '', '[{\"name\":\"L\",\"value\":\"10000\"}]', 1, '2025-04-24 07:50:14', '2025-04-24 07:50:14', NULL, 0, '\"{\\\"selectedTemplate\\\":\\\"tpl-1\\\",\\\"relatedProducts\\\":\\\"all\\\",\\\"selectedProducts\\\":[],\\\"company\\\":\\\"all\\\",\\\"selectedCompanies\\\":[],\\\"store\\\":\\\"all\\\",\\\"selectedStores\\\":[],\\\"enableSurvey\\\":false,\\\"selectedSurveys\\\":[],\\\"enableOrderButton\\\":true,\\\"productLinks\\\":[{\\\"platform\\\":\\\"Shopee\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Lazada\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Tiki\\\",\\\"url\\\":\\\"\\\"}]}\"', NULL),
(8, '34234242', 'nem nuong nha trang', NULL, 'single', 23000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745481478_689e4fb81f3be539c086.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481481_adca135c4dae226d93bb.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481484_67d6fc9c4e13a0d0e694.png\"]', '[]', '', '[{\"name\":\"X\",\"value\":\"23000\"}]', 1, '2025-04-24 07:58:36', '2025-04-24 07:58:36', NULL, 0, '\"{\\\"selectedTemplate\\\":\\\"tpl-1\\\",\\\"relatedProducts\\\":\\\"all\\\",\\\"selectedProducts\\\":[],\\\"company\\\":\\\"all\\\",\\\"selectedCompanies\\\":[],\\\"store\\\":\\\"all\\\",\\\"selectedStores\\\":[],\\\"enableSurvey\\\":false,\\\"selectedSurveys\\\":[],\\\"enableOrderButton\\\":true,\\\"productLinks\\\":[{\\\"platform\\\":\\\"Shopee\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Lazada\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Tiki\\\",\\\"url\\\":\\\"\\\"}]}\"', NULL),
(9, '4353543535435', 'Vịt om sấu', NULL, 'single', 124000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745481673_f32d9704acbad7840e4a.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481676_87560cd3f7f9b0d639c3.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481679_875e9a818fe1dbb531ea.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481689_ca1989e0b3c6e8d7adaf.txt\"]', '', '[{\"name\":\"L\",\"value\":\"120000\"}]', 1, '2025-04-24 08:02:04', '2025-04-24 08:02:04', NULL, 1, '\"{\\\"selectedTemplate\\\":\\\"tpl-1\\\",\\\"relatedProducts\\\":\\\"all\\\",\\\"selectedProducts\\\":[],\\\"company\\\":\\\"all\\\",\\\"selectedCompanies\\\":[],\\\"store\\\":\\\"all\\\",\\\"selectedStores\\\":[],\\\"enableSurvey\\\":false,\\\"selectedSurveys\\\":[],\\\"enableOrderButton\\\":true,\\\"productLinks\\\":[{\\\"platform\\\":\\\"Shopee\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Lazada\\\",\\\"url\\\":\\\"\\\"},{\\\"platform\\\":\\\"Tiki\\\",\\\"url\\\":\\\"\\\"}]}\"', NULL),
(10, '54356465464', 'Giường gấp văn phòng cao cấp gấp gọn 4 khúc H2Home khung hợp kim sơn tĩnh điện chắc chắn bảo hành 12 tháng', 1, 'single', 1500000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745506841_4fab5f44fa54d974ba11.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481785_7e1b5ecc5e060c8a96fe.png\",\"http:\\/\\/assets.giang.test\\/image\\/1745506019_855fbb66bf4f40091f09.jpg\",\"http:\\/\\/assets.giang.test\\/image\\/1745507157_375fc75b50de8a6ad20b.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481788_49c58f5b697b0823f8ee.png\",\"http:\\/\\/assets.giang.test\\/image\\/1745507161_67fd47f8896136598fdf.jpg\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745481795_526baab6a0b8fa0aca46.html\"]', '<p>Các trường hợp bảo hành cụ thể\n\n- Sản phẩm bị hư hỏng/ bể vỡ trong quá trình vận chuyển \n\n- Sản phẩm bị lỗi do lỗi từ nhà sản xuất \n\n- Sản phẩm giao đến không đúng với đơn hàng đã đặt \n\n- Sản phẩm được giao không đủ số lượng theo đơn hàng đã đặt \n\n- Những lỗi khác do kỹ thuật, chất liệu của sản phẩm </p>', '[{\"id\":\"99\",\"product_id\":\"10\",\"name\":\"XL\",\"value\":\"2000000\",\"created_at\":\"2025-04-24 16:32:03\",\"updated_at\":\"2025-04-24 16:32:03\"}]', 1, '2025-04-24 08:05:05', '2025-04-24 17:04:00', NULL, 3, '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"10\",\"11\"],\"company\":\"selected\",\"selectedCompanies\":[\"2\",\"3\"],\"store\":\"selected\",\"selectedStores\":[\"2\",\"3\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"productLinks\":[{\"platform\":\"Shopee\",\"url\":\"https://shopee.vn/\"},{\"platform\":\"Lazada\",\"url\":\"https://www.lazada.vn/\"},{\"platform\":\"Tiki\",\"url\":\"https://tiki.vn/\"}]}', NULL),
(11, '54353453535', 'Điều khiển điều hòa NAGAKAWA - Remote máy lạnh Nagakawa hàng loại 1 bảo hành đổi trả 30 ngày', 5, 'single', 120000.00, NULL, NULL, 0, '[\"http:\\/\\/assets.giang.test\\/image\\/1745506496_b61218fe994ad5b2abe5.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745482473_c82e19525025ad5852fe.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745482475_16c60515a6f0f2b4dcab.png\"]', '[\"http:\\/\\/assets.giang.test\\/image\\/1745482482_b672aeeef7a3fc2c57d9.html\"]', '<p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">- Xuất xứ : Trung Quốc</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Thiết kế nhỏ gọn, vừa tầm tay.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Các phím to, rõ, dễ nhìn, không bị phai mờ theo thời gian.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Sử dụng 2 pin AAA, không cần thiết lập cài đặt.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Khoảng cách khiển lên đến 8m.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-An toàn cho người sử dụng.</span></p><p><br></p>', '[{\"id\":\"88\",\"product_id\":\"11\",\"name\":\"XL\",\"value\":\"230000\",\"created_at\":\"2025-04-24 15:16:05\",\"updated_at\":\"2025-04-24 15:16:05\"}]', 1, '2025-04-24 08:15:54', '2025-04-24 16:33:08', NULL, 3, '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"10\",\"11\"],\"company\":\"selected\",\"selectedCompanies\":[\"2\"],\"store\":\"selected\",\"selectedStores\":[\"2\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"productLinks\":[{\"platform\":\"Shopee\",\"url\":\"\"},{\"platform\":\"Lazada\",\"url\":\"\"},{\"platform\":\"Tiki\",\"url\":\"\"}]}', NULL);

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
(71, 5, 'L', '10000', '2025-04-24 07:39:06', '2025-04-24 07:39:06'),
(73, 7, 'L', '10000', '2025-04-24 07:50:14', '2025-04-24 07:50:14'),
(74, 8, 'X', '23000', '2025-04-24 07:58:36', '2025-04-24 07:58:36'),
(75, 9, 'L', '120000', '2025-04-24 08:02:04', '2025-04-24 08:02:04'),
(78, 4, 'L', '25000', '2025-04-24 08:49:28', '2025-04-24 08:49:28'),
(79, 4, 'M', '20000', '2025-04-24 08:49:28', '2025-04-24 08:49:28'),
(100, 11, 'XL', '230000', '2025-04-24 16:33:08', '2025-04-24 16:33:08'),
(101, 10, 'XL', '2000000', '2025-04-24 17:04:00', '2025-04-24 17:04:00'),
(114, 1, 'XL', '342424324', '2025-04-25 04:05:50', '2025-04-25 04:05:50'),
(116, 2, 'xl', '120000', '2025-04-25 04:06:04', '2025-04-25 04:06:04'),
(117, 6, 'xl', '10000', '2025-04-28 16:48:44', '2025-04-28 16:48:44');

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
  `settings_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
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
  `display_settings` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `product_ids` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `user_id`, `name`, `logo`, `address`, `phone`, `email`, `website`, `description`, `created_at`, `updated_at`, `display_settings`, `status`, `product_ids`) VALUES
(1, 1, 'demo 1', 'http://assets.giang.test/image/1745041561_cfb1a46ffe8605a53362.png', 'acb xyz', '0387409300', 'doangiang665@gmail.com', NULL, '<p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">- Xuất xứ : Trung Quốc</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Thiết kế nhỏ gọn, vừa tầm tay.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Các phím to, rõ, dễ nhìn, không bị phai mờ theo thời gian.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Sử dụng 2 pin AAA, không cần thiết lập cài đặt.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-Khoảng cách khiển lên đến 8m.</span></p><p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">-An toàn cho người sử dụng.</span></p><p><br></p>', '2025-04-19 04:05:19', '2025-04-29 04:38:18', '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"3\",\"4\",\"5\",\"6\",\"9\",\"2\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"all\",\"selectedStores\":[\"1\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"topProductsMode\":\"selected\",\"topProducts\":[\"2\",\"3\",\"5\"]}', 1, '[\"3\",\"4\",\"5\",\"6\",\"9\",\"2\"]'),
(2, 3, 'Cửa hàng demo 2', 'http://assets.giang.test/image/1745508366_fbe589f048b5b352163e.png', 'tây mỗ, nam từ liêm', '0387409300', 'doangiang665@gmail.com', NULL, '<p><span style=\"background-color: rgb(255, 255, 255); color: rgba(0, 0, 0, 0.8);\">Kệ để màn hình máy tính Homeline kệ để PC decor bàn làm việc, bàn học chất liệu gỗ MDF cao cấp chống xước - D48</span></p>', '2025-04-24 15:26:22', '2025-04-24 15:26:22', NULL, 1, '[\"10\",\"11\"]'),
(3, 3, 'Cửa hàng tạp hóa pew pew', 'http://assets.giang.test/image/1745514221_cc7f4778e22f25f9e86b.jpg', 'nam từ liêm, hà nội', '0387409300', 'doangiang665@gmail.com', NULL, '<p>cửa hàng tạp hóa 10k</p>', '2025-04-24 17:03:43', '2025-04-24 17:03:43', NULL, 1, '[]'),
(4, 1, 'cửa hàng 2', 'http://assets.giang.test/image/1745902592_23ccb866515a39eacc0f.jpg', 'tay mo nam tu liem', '0387409300', 'giang@gmail.com', NULL, '', '2025-04-29 04:56:33', '2025-04-29 04:56:51', '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"4\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"all\",\"selectedStores\":[\"1\",\"4\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"topProductsMode\":\"selected\",\"topProducts\":[\"2\"]}', 1, '[\"4\"]'),
(5, 1, 'gggggggg', 'http://assets.giang.test/image/1746258587_08836e9fa786a9d22f76.png', 'xuan thuy, cau giay', '0387409300', 'qe@gmail.com', NULL, '<p><br></p>', '2025-05-03 06:23:25', '2025-05-03 07:50:00', '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"3\",\"4\",\"6\"],\"company\":\"selected\",\"selectedCompanies\":[\"4\",\"1\"],\"store\":\"all\",\"selectedStores\":[\"1\",\"4\",\"5\",\"6\",\"7\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"topProductsMode\":\"selected\",\"topProducts\":[\"1\",\"2\",\"4\"]}', 1, '[\"3\",\"4\",\"6\"]'),
(6, 1, 'xxxxx', 'http://assets.giang.test/image/1746254862_8f14809456d38f343fe2.jpg', 'le duc tho nam tu liem ha noi', '0387409300', 'xxx@gmail.com', NULL, '<p><br></p>', '2025-05-03 06:34:23', '2025-05-03 06:51:14', '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"selected\",\"selectedProducts\":[\"3\"],\"company\":\"selected\",\"selectedCompanies\":[\"1\"],\"store\":\"all\",\"selectedStores\":[\"1\",\"4\",\"5\",\"6\",\"7\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"topProductsMode\":\"selected\",\"topProducts\":[\"2\"]}', 1, '[\"3\"]'),
(7, 1, 'xxxxxxxxxx', 'http://assets.giang.test/image/1746254261_fc9580dbd75aa45ed9b1.jpg', 'tay mo', '0387409300', 'giang@gmail.com', NULL, '<p><br></p>', '2025-05-03 06:37:42', '2025-05-03 08:56:19', '{\"selectedTemplate\":\"tpl-1\",\"relatedProducts\":\"all\",\"selectedProducts\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"9\"],\"company\":\"all\",\"selectedCompanies\":[\"1\",\"4\"],\"store\":\"all\",\"selectedStores\":[\"1\",\"4\",\"5\",\"6\",\"7\"],\"enableSurvey\":false,\"selectedSurveys\":[],\"enableOrderButton\":true,\"topProductsMode\":\"all\",\"topProducts\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"9\"]}', 1, '[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"9\"]');

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
-- Indexes for table `entity_images`
--
ALTER TABLE `entity_images`
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
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `businesses`
--
ALTER TABLE `businesses`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- AUTO_INCREMENT for table `entity_images`
--
ALTER TABLE `entity_images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `surveys`
--
ALTER TABLE `surveys`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
