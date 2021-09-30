-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 24, 2021 at 05:44 PM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `my_family`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `family_main` (IN `in_family_name` VARCHAR(50), IN `in_family_desc` VARCHAR(200), IN `in_family_logo` VARCHAR(200), IN `in_family_id` INT(10), IN `query_type` VARCHAR(20))  NO SQL
BEGIN
IF query_type='INSERT' THEN
INSERT INTO family_main(family_name,family_desc,family_logo,family_id) VALUES(in_family_name,in_family_desc,in_family_logo,in_family_id);

ELSEIF  query_type='UPDATE' THEN 
UPDATE family_main SET family_name=in_family_name,family_desc=in_family_desc,family_logo=in_family_logo,family_id=in_family_id WHERE family_id=in_family_id;

ELSEIF query_type='DELETE' THEN
DELETE FROM family_main WHERE family_id=in_family_id;

END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `family_meeting` (IN `in_meeting_id` INT(10), IN `in_meeting_desc` VARCHAR(20), IN `in_location` VARCHAR(50), IN `in_start_time` VARCHAR(6), IN `in_end_time` VARCHAR(6), IN `query_type` VARCHAR(20))  NO SQL
BEGIN
IF query_type='INSERT' THEN
INSERT INTO family_meeting(meeting_id,meeting_desc,location,start_time,end_time) VALUES(in_meeting_id,in_meeting_desc,in_location,in_start_time,in_end_time);

ELSEIF  query_type='UPDATE' THEN 
UPDATE family_meeting SET meeting_id=in_meeting_id,meeting_desc=in_meeting_desc,location=in_location,start_time=in_start_time,end_time=in_end_time WHERE meeting_id=in_meeting_id;

ELSEIF query_type='DELETE' THEN
DELETE FROM family_meeting WHERE meeting_id=in_meeting_id;

END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `family_members` (IN `in_family_id` VARCHAR(20), IN `in_member_id` INT(10), IN `in_fname` VARCHAR(20), IN `in_lname` VARCHAR(20), IN `in_mname` VARCHAR(20), IN `query_type` VARCHAR(50))  NO SQL
BEGIN
IF query_type='INSERT' THEN
INSERT INTO family_members(family_id,member_id,fname,lname,mname) VALUES(in_family_id,in_member_id,in_fname,in_lname,in_mname);

ELSEIF  query_type='UPDATE' THEN 
UPDATE family_members SET family_id=in_family_id,member_id=in_member_id,fname=in_fname,lname=in_lname,mname=in_mname WHERE member_id=in_member_id;

ELSEIF query_type='DELETE' THEN
DELETE FROM family_members WHERE member_id=in_member_id;

END IF; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `posting` (IN `in_member_id` INT(10), IN `in_family_id` VARCHAR(20), IN `in_video` VARCHAR(100), IN `in_picture` VARCHAR(100), IN `in_text` VARCHAR(1000), IN `query_type` VARCHAR(50))  NO SQL
BEGIN
IF query_type='INSERT' THEN
INSERT INTO posting(member_id,family_id,video,picture,text) VALUES(in_member_id,in_family_id,in_video,in_picture,in_text);
                                                                   
ELSEIF  query_type='UPDATE' THEN 
UPDATE posting SET member_id=in_member_id,family_id=in_family_id,video=in_video,picture=in_picture,text=in_text WHERE member_id=in_member_id;

ELSEIF query_type='DELETE' THEN
DELETE FROM posting WHERE member_id=in_member_id;
END IF; 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `family_main`
--

CREATE TABLE `family_main` (
  `family_name` varchar(50) NOT NULL,
  `family_desc` varchar(200) NOT NULL,
  `family_logo` varchar(200) NOT NULL,
  `family_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `family_meeting`
--

CREATE TABLE `family_meeting` (
  `meeting_id` int(10) NOT NULL,
  `meeting_desc` varchar(20) NOT NULL,
  `location` varchar(50) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `family_members`
--

CREATE TABLE `family_members` (
  `family_id` varchar(20) NOT NULL,
  `member_id` int(10) NOT NULL,
  `fname` varchar(20) NOT NULL,
  `lname` varchar(20) NOT NULL,
  `mname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `posting`
--

CREATE TABLE `posting` (
  `member_id` int(10) NOT NULL,
  `family_id` varchar(20) NOT NULL,
  `video` varchar(100) NOT NULL,
  `picture` varchar(100) NOT NULL,
  `text` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `family_main`
--
ALTER TABLE `family_main`
  ADD PRIMARY KEY (`family_id`);

--
-- Indexes for table `family_meeting`
--
ALTER TABLE `family_meeting`
  ADD PRIMARY KEY (`meeting_id`);

--
-- Indexes for table `family_members`
--
ALTER TABLE `family_members`
  ADD PRIMARY KEY (`member_id`);

--
-- Indexes for table `posting`
--
ALTER TABLE `posting`
  ADD PRIMARY KEY (`member_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `family_main`
--
ALTER TABLE `family_main`
  MODIFY `family_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `family_meeting`
--
ALTER TABLE `family_meeting`
  MODIFY `meeting_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `family_members`
--
ALTER TABLE `family_members`
  MODIFY `member_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posting`
--
ALTER TABLE `posting`
  MODIFY `member_id` int(10) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
