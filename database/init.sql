-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2025 at 04:30 PM
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
-- Database: `cyberproject`
--
CREATE DATABASE IF NOT EXISTS `cyberproject` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cyberproject`;

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `asset_name` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`id`, `asset_name`, `owner`, `description`, `department`, `time_created`) VALUES
(1, 'komputer', 'bobby123', 'komputer bermasalah di motherboard yg digunakan', 'it', '2025-01-29 19:59:29'),
(3, 'laptop', 'jeremiah', 'baterai kembung', 'it', '2025-01-30 14:49:15'),
(5, 'komputer', 'maya anna', 'monitor rusak', 'engineer', '2025-01-30 18:20:25'),
(6, 'laptop', 'budi', 'monitor issue', 'human resources', '2025-06-30 23:10:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--
-- Error reading structure for table phpmyadmin.pma__bookmark: #1932 - Table &#039;phpmyadmin.pma__bookmark&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__bookmark: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__bookmark`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--
-- Error reading structure for table phpmyadmin.pma__central_columns: #1932 - Table &#039;phpmyadmin.pma__central_columns&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__central_columns: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__central_columns`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--
-- Error reading structure for table phpmyadmin.pma__column_info: #1932 - Table &#039;phpmyadmin.pma__column_info&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__column_info: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__column_info`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--
-- Error reading structure for table phpmyadmin.pma__designer_settings: #1932 - Table &#039;phpmyadmin.pma__designer_settings&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__designer_settings: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__designer_settings`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--
-- Error reading structure for table phpmyadmin.pma__export_templates: #1932 - Table &#039;phpmyadmin.pma__export_templates&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__export_templates: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__export_templates`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--
-- Error reading structure for table phpmyadmin.pma__favorite: #1932 - Table &#039;phpmyadmin.pma__favorite&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__favorite: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__favorite`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--
-- Error reading structure for table phpmyadmin.pma__history: #1932 - Table &#039;phpmyadmin.pma__history&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__history: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__history`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--
-- Error reading structure for table phpmyadmin.pma__navigationhiding: #1932 - Table &#039;phpmyadmin.pma__navigationhiding&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__navigationhiding: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__navigationhiding`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--
-- Error reading structure for table phpmyadmin.pma__pdf_pages: #1932 - Table &#039;phpmyadmin.pma__pdf_pages&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__pdf_pages: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__pdf_pages`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--
-- Error reading structure for table phpmyadmin.pma__recent: #1932 - Table &#039;phpmyadmin.pma__recent&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__recent: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__recent`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--
-- Error reading structure for table phpmyadmin.pma__relation: #1932 - Table &#039;phpmyadmin.pma__relation&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__relation: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__relation`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--
-- Error reading structure for table phpmyadmin.pma__savedsearches: #1932 - Table &#039;phpmyadmin.pma__savedsearches&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__savedsearches: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__savedsearches`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--
-- Error reading structure for table phpmyadmin.pma__table_coords: #1932 - Table &#039;phpmyadmin.pma__table_coords&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__table_coords: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__table_coords`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--
-- Error reading structure for table phpmyadmin.pma__table_info: #1932 - Table &#039;phpmyadmin.pma__table_info&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__table_info: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__table_info`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--
-- Error reading structure for table phpmyadmin.pma__table_uiprefs: #1932 - Table &#039;phpmyadmin.pma__table_uiprefs&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__table_uiprefs: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__table_uiprefs`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--
-- Error reading structure for table phpmyadmin.pma__tracking: #1932 - Table &#039;phpmyadmin.pma__tracking&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__tracking: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__tracking`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--
-- Error reading structure for table phpmyadmin.pma__userconfig: #1932 - Table &#039;phpmyadmin.pma__userconfig&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__userconfig: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__userconfig`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--
-- Error reading structure for table phpmyadmin.pma__usergroups: #1932 - Table &#039;phpmyadmin.pma__usergroups&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__usergroups: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__usergroups`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--
-- Error reading structure for table phpmyadmin.pma__users: #1932 - Table &#039;phpmyadmin.pma__users&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__users: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__users`&#039; at line 1
--
-- Database: `portfolio_db`
--
CREATE DATABASE IF NOT EXISTS `portfolio_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `portfolio_db`;

-- --------------------------------------------------------

--
-- Table structure for table `competencies`
--

CREATE TABLE `competencies` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `img` varchar(255) NOT NULL,
  `alt` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `competencies`
--

INSERT INTO `competencies` (`id`, `title`, `description`, `img`, `alt`, `created_at`) VALUES
(1, 'Quality Focus', 'Delivering high-quality results while maintaining attention to every detail.', 'images/icons/quality.png', 'quality', '2025-06-29 10:38:32'),
(2, 'Team Collaboration', 'Working seamlessly with others to achieve common goals.', 'images/icons/communication.png', 'teamwork', '2025-06-29 10:38:32'),
(3, 'Creative Thinking', 'Innovating solutions through out-of-the-box thinking.', 'images/icons/time.png', 'creativity', '2025-06-29 10:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `subject`, `message`, `created_at`, `status`) VALUES
(1, 'budi', 'budi@gmail.com', 'Web Project', 'Make me a design for restaurant theme', '2025-07-01 13:33:21', 1),
(2, 'testcap', 'tescap@gmail.com', 'cap', 'tcha', '2025-07-01 22:36:54', 1),
(3, 'testcap', 'tescap@gmail.com', 'cap', 'tcha', '2025-07-01 22:37:01', 0),
(4, 'tescaptcha2', 'captcha2@gmail.com', 'captcha2', 'tes untuk kedua kalinya', '2025-07-01 22:43:00', 0),
(5, 'tescaptcha2', 'captcha2@gmail.com', 'captcha2', 'tes untuk kedua kalinya', '2025-07-01 22:43:21', 0),
(6, 'qwercapt3', 'qewr@gmail.com', 'qwer', 'qwer', '2025-07-01 22:47:57', 0),
(7, 'qwercapt3', 'qewr@gmail.com', 'qwer', 'qwer', '2025-07-01 22:48:09', 0),
(8, 'test4', 'test4@gmail.com', 'test4', 'test4', '2025-07-01 22:50:25', 0),
(9, 'wayan', 'wayan@gmail.com', 'wayan ingin captcha', 'test captcha terakhir', '2025-07-01 22:55:22', 0),
(10, 'qwer', 'qsdffg@gmail.com', 'ertyerty', 'ertudfghdfgn', '2025-07-01 22:55:43', 0),
(11, 'tenten', 'tenten@gmail.com', 'web', 'tolonkkk!', '2025-07-06 14:19:11', 1);

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `education`
--

INSERT INTO `education` (`id`, `title`, `description`, `image_path`, `created_at`) VALUES
(1, 'Vocational High School', 'Majoring in multimedia with Adobe Creative Suite skills', 'images/icons/hat-y.png', '2025-06-29 10:38:32'),
(2, 'President University', 'Undergraduate student of computer science focused in cyber security', 'images/icons/hat-y.png', '2025-06-29 10:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `experience`
--

CREATE TABLE `experience` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `date_range` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `experience`
--

INSERT INTO `experience` (`id`, `title`, `date_range`, `created_at`) VALUES
(1, 'Internship in CV. Leo Printing', '📆 June 2021 - November 2021', '2025-06-29 10:38:32'),
(2, 'BEM Faculty: PUFA Computing', '📆 October 2023 - September 2024', '2025-06-29 10:38:32'),
(3, 'Religion Club: KMHD', '📆 November 2023 - September 2024', '2025-06-29 10:38:32'),
(4, 'Developer Club: PUDC', '📆 October 2024 - Present', '2025-06-29 10:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `experience_details`
--

CREATE TABLE `experience_details` (
  `id` int(11) NOT NULL,
  `experience_id` int(11) NOT NULL,
  `detail` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `experience_details`
--

INSERT INTO `experience_details` (`id`, `experience_id`, `detail`) VALUES
(1, 1, 'Handling 2D design process making'),
(2, 1, 'Helping with printing process'),
(3, 2, 'Part of MTDD division of the organization'),
(4, 2, 'PIC MTDD of the biggest event in Computing Faculty'),
(5, 3, 'Part of MTDD division of the club'),
(6, 4, 'Head of Division for MTDD Division'),
(7, 4, 'Creating logo for the club');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `count` varchar(10) NOT NULL,
  `label` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `count`, `label`, `created_at`) VALUES
(1, '5+', 'Cyber Project', '2025-06-29 10:38:32'),
(2, '7+', 'Web Design', '2025-06-29 10:38:32'),
(3, '3+', 'Mobile App', '2025-06-29 10:38:32'),
(4, '27+', 'Design Project', '2025-06-29 10:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `alt` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT 'all',
  `logo_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `alt`, `category`, `logo_path`, `created_at`) VALUES
(1, 'Kali Linux', 'cyber', 'images/logo-skills/kali_linux.png', '2025-06-29 10:38:32'),
(2, 'Burp Suite', 'cyber', 'images/logo-skills/burpsuite.png', '2025-06-29 10:38:32'),
(3, 'Autopsy', 'cyber', 'images/logo-skills/autopsy.png', '2025-06-29 10:38:32'),
(4, 'VS Code', 'code', 'images/logo-skills/vs_code.png', '2025-06-29 10:38:32'),
(5, 'Javascript', 'code', 'images/logo-skills/javascript.png', '2025-06-29 10:38:32'),
(6, 'Tailwind', 'code', 'images/logo-skills/tailwind.png', '2025-06-29 10:38:32'),
(7, 'Python', 'code', 'images/logo-skills/python.png', '2025-06-29 10:38:32'),
(9, 'Network Miner', 'cyber', 'images/logo-skills/network_miner.png', '2025-06-29 03:38:32'),
(10, 'Wireshark', 'cyber', 'images/logo-skills/wireshark.png', '2025-06-29 03:38:32'),
(11, 'Figma', 'design', 'images/logo-skills/figma.png', '2025-06-29 03:38:32'),
(12, 'HTML', 'code', 'images/logo-skills/html.png', '2025-06-29 03:38:32'),
(13, 'CSS', 'code', 'images/logo-skills/css.png', '2025-06-29 03:38:32'),
(14, 'Photoshop', 'design', 'images/logo-skills/photoshop.png', '2025-06-29 03:38:32'),
(15, 'Illustrator', 'design', 'images/logo-skills/illustrator.png', '2025-06-29 03:38:32'),
(16, 'After Effects', 'design', 'images/logo-skills/after_effects.png', '2025-06-29 03:38:32'),
(17, 'Premiere Pro', 'design', 'images/logo-skills/premiere_pro.png', '2025-06-29 03:38:32'),
(18, 'Firebase', 'code', 'images/logo-skills/firebase.png', '2025-06-29 03:38:32'),
(19, 'phpMyAdmin', 'code', 'images/logo-skills/phpmyadmin.png', '2025-06-29 03:38:32'),
(20, 'Git', 'code', 'images/logo-skills/git.png', '2025-06-29 03:38:32'),
(22, 'Blender', 'design', 'images/logo-skills/blender.png', '2025-06-29 03:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `social_media`
--

CREATE TABLE `social_media` (
  `id` int(11) NOT NULL,
  `platform` varchar(50) NOT NULL,
  `logo_path` varchar(255) NOT NULL,
  `url` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `social_media`
--

INSERT INTO `social_media` (`id`, `platform`, `logo_path`, `url`, `created_at`) VALUES
(1, 'instagram', 'images/icons/instagram.png', 'https://instagram.com/jayadeva.21', '2025-06-29 10:38:32'),
(2, 'linkedin', 'images/icons/linkedin.png', 'https://linkedin.com/in/ngurah-jaya-deva-5b401528b/', '2025-06-29 10:38:32'),
(3, 'github', 'images/icons/github.png', 'https://github.com/rahjade21', '2025-06-29 10:38:32'),
(4, 'line', 'images/icons/line.png', 'https://line.me/ti/p/ngurahjayadeva2112', '2025-06-29 10:38:32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `competencies`
--
ALTER TABLE `competencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `experience`
--
ALTER TABLE `experience`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `experience_details`
--
ALTER TABLE `experience_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `experience_id` (`experience_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media`
--
ALTER TABLE `social_media`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `competencies`
--
ALTER TABLE `competencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `experience`
--
ALTER TABLE `experience`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `experience_details`
--
ALTER TABLE `experience_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `social_media`
--
ALTER TABLE `social_media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `experience_details`
--
ALTER TABLE `experience_details`
  ADD CONSTRAINT `experience_details_ibfk_1` FOREIGN KEY (`experience_id`) REFERENCES `experience` (`id`) ON DELETE CASCADE;
--
-- Database: `risk_management`
--
CREATE DATABASE IF NOT EXISTS `risk_management` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `risk_management`;

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `asset_name` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `security_requirement` varchar(255) DEFAULT NULL,
  `concern` varchar(255) DEFAULT NULL,
  `actor` varchar(255) DEFAULT NULL,
  `objective` varchar(255) DEFAULT NULL,
  `motive` varchar(255) DEFAULT NULL,
  `result` text DEFAULT NULL,
  `security` varchar(255) DEFAULT NULL,
  `likelihood` varchar(50) DEFAULT NULL,
  `risk_description` text DEFAULT NULL,
  `risk_response` varchar(255) DEFAULT NULL,
  `confidentiality` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`id`, `asset_name`, `owner`, `description`, `department`, `time_created`, `security_requirement`, `concern`, `actor`, `objective`, `motive`, `result`, `security`, `likelihood`, `risk_description`, `risk_response`, `confidentiality`) VALUES
(3, 'asdf', 'adfasdf', 'asdf', 'adsf', '2025-01-30 22:34:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'asdf', 'asdf', 'asdf', 'asdf', '2025-01-30 23:05:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'laptop', 'jere123', 'monitor problem', 'it', '2025-01-30 23:06:37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'asdf', 'asdf', 'adsf', 'asdf', '2025-01-30 23:59:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roles` varchar(50) DEFAULT 'user',
  `department` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `roles`, `department`) VALUES
(1, 'bobo', 'scrypt:32768:8:1$qlp8BZ5WFop369qd$374f8a7b10ed97506b4f082aa5884583dfca70800390d6ed7a98063f26674f88a09b8094cbdb899145341cce25207717107c62c38117fced0795a0cf2bb15738', 'admin', 'Computer Science'),
(2, 'jojo', 'scrypt:32768:8:1$fa6zKr9lFUs73DmN$18b5f03210e4d6f22fa698c109e1d856699e1ad1cd113e3e889585d3ff875d44dd84bb2fb47cdea018dd9c6192653c6dbeb0cb78b2edbcb03597da6ff07a0c43', 'user', 'Humanities');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Database: `sales_order_db`
--
CREATE DATABASE IF NOT EXISTS `sales_order_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sales_order_db`;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_number` varchar(50) DEFAULT NULL,
  `customer_ref` varchar(100) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `customer_ref`, `order_date`, `total`) VALUES
(1, '', '', '0000-00-00', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`) VALUES
(1, 'Charger', 15000.00),
(2, 'Battery', 100000.00),
(3, 'Casing', 25000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
--
-- Database: `tax_rates`
--
CREATE DATABASE IF NOT EXISTS `tax_rates` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tax_rates`;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE `rates` (
  `income_from` int(11) NOT NULL,
  `income_to` int(11) NOT NULL,
  `percentage` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rates`
--

INSERT INTO `rates` (`income_from`, `income_to`, `percentage`) VALUES
(0, 5400000, 0.00),
(5400000, 5650000, 0.25),
(5650000, 5950000, 0.50),
(5950000, 6300000, 0.75),
(6300000, 6750000, 1.00),
(6750000, 7500000, 1.25),
(7500000, 8550000, 1.50),
(8550000, 9650000, 1.75),
(9650000, 10050000, 2.00),
(10050000, 10350000, 2.25),
(10350000, 10700000, 2.50),
(10700000, 11050000, 3.00),
(11050000, 11600000, 3.50),
(11600000, 12500000, 4.00),
(12500000, 13750000, 5.00),
(13750000, 15100000, 6.00),
(15100000, 16950000, 7.00),
(16950000, 19750000, 8.00),
(19750000, 24150000, 9.00),
(24150000, 2147483647, 30.00);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('3TFq0ETC3W4ekMtZmZdlqJjIIHQtzJaKA0Ny5QWL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMXBvandENVBaR01CTTNNT21KN2gwSFNRcUNNSVZKQ0pBRDB6ZzZLUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jYWxjdWxhdGUiO319', 1715661775);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
