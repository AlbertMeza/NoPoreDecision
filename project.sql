-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 03, 2025 at 06:16 PM
-- Server version: 11.4.5-MariaDB
-- PHP Version: 8.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assign3_db`
--
CREATE DATABASE IF NOT EXISTS `assign3_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `assign3_db`;

-- --------------------------------------------------------

--
-- Table structure for table `Product_Logs`
--

CREATE TABLE `Product_Logs` (
  `ProductID` int(11) NOT NULL,
  `Purpose` varchar(128) DEFAULT NULL,
  `ExpDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Product_Logs`
--

INSERT INTO `Product_Logs` (`ProductID`, `Purpose`, `ExpDate`) VALUES
(1, 'Foaming Cleanser', '2026-01-10'),
(2, 'Pore-Minimizing Serum', '2026-06-15'),
(3, 'Retinol Treatment', '2025-12-30'),
(4, 'Hydrating Serum', '2026-02-20'),
(5, 'Fragrance-heavy Moisturizer', '2026-05-10'),
(6, 'Oat-based Cream', '2026-03-15'),
(7, 'Gentle Exfoliant', '2026-07-22'),
(8, 'Chemical Peel', '2025-11-29'),
(9, 'Calming Toner', '2026-04-05'),
(10, 'Alcohol-based Toner', '2026-01-24'),
(11, 'Fragrance-free Routine', '2026-01-31'),
(12, 'Ceramide Cream', '2026-03-03'),
(13, 'Vitamin C Serum', '2025-10-30'),
(14, 'Niacinamide Serum', '2026-06-06'),
(15, 'Clay Mask', '2026-02-02');

-- --------------------------------------------------------

--
-- Table structure for table `Progress_Logs`
--

CREATE TABLE `Progress_Logs` (
  `ProgressID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Progress_Date` date NOT NULL DEFAULT curdate(),
  `Notes` varchar(256) DEFAULT NULL,
  `Rating` decimal(2,1) DEFAULT 0.0
) ;

--
-- Dumping data for table `Progress_Logs`
--

INSERT INTO `Progress_Logs` (`ProgressID`, `UserID`, `ProductID`, `Progress_Date`, `Notes`, `Rating`) VALUES
(1, 1, 1, '2025-01-15', 'Noticed less shine around the T-zone. Skin feels cleaner after switching to a foaming cleanser.', 7.2),
(2, 1, 2, '2025-01-22', 'New serum caused a slight breakout on forehead. Pores looked larger again.', 5.6),
(3, 1, 1, '2025-01-29', 'Switched back to her original routine — oil control is improving again.', 7.8),
(4, 2, 3, '2025-01-17', 'Retinol left skin dry and slightly irritated. Wrinkles unchanged.', 5.2),
(5, 2, 4, '2025-01-24', 'Introduced hydrating serum — skin bounced back, feels smoother.', 7.5),
(6, 2, 4, '2025-01-31', 'Fine lines around mouth are softening, skin feels firmer.', 8.0),
(7, 3, 5, '2025-01-20', 'Tried a fragrance-heavy moisturizer — redness worsened.', 4.9),
(8, 3, 6, '2025-01-27', 'Switched to oat-based cream. Redness and tightness calmed significantly.', 7.9),
(9, 3, 6, '2025-02-03', 'Skin feels calm and hydrated consistently.', 8.7),
(10, 4, 7, '2025-01-22', 'Gentle exfoliant gave slight glow, but flakiness remained.', 6.0),
(11, 4, 8, '2025-01-29', 'Overdid exfoliation with chemical peel — skin was irritated.', 3.8),
(12, 4, 9, '2025-02-05', 'Backed off and used calming toner — skin recovering well.', 7.5),
(13, 5, 10, '2025-01-24', 'Tried a new toner with alcohol — triggered a flare-up.', 4.5),
(14, 5, 11, '2025-01-31', 'Returned to fragrance-free routine — redness began to subside.', 6.9),
(15, 5, 11, '2025-02-07', 'Skin is visibly calmer and feels resilient again.', 8.2);

-- --------------------------------------------------------

--
-- Table structure for table `Routines`
--

CREATE TABLE `Routines` (
  `RoutineID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Cleanser` varchar(128) DEFAULT NULL,
  `Toner` varchar(128) DEFAULT NULL,
  `Serum` varchar(128) DEFAULT NULL,
  `Moisturizer` varchar(128) DEFAULT NULL,
  `Sunscreen` varchar(128) DEFAULT 'SPF 30'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Routines`
--

INSERT INTO `Routines` (`RoutineID`, `UserID`, `Cleanser`, `Toner`, `Serum`, `Moisturizer`, `Sunscreen`) VALUES
(1, 1, 'Foaming Cleanser', 'None', 'Pore-Minimizing Serum', 'Oil-Free Moisturizer', 'SPF 50'),
(2, 2, 'Cream Cleanser', 'Hydrating Toner', 'Retinol Treatment', 'Anti-Aging Cream', 'Tinted SPF 30'),
(3, 3, 'Gentle Wash', 'Rose Water', 'Hydrating Serum', 'Oat-based Cream', 'Mineral SPF 40'),
(4, 4, 'Exfoliating Cleanser', 'Glycolic Toner', 'Vitamin C Serum', 'Lightweight Lotion', 'Chemical SPF 35'),
(5, 5, 'Milky Cleanser', 'Calming Toner', 'None', 'Fragrance-free Moisturizer', 'Physical SPF 50'),
(6, 6, 'Hydrating Cleanser', 'None', 'Hyaluronic Acid Serum', 'Ceramide Cream', 'SPF 30'),
(7, 7, 'Gentle Cleanser', 'Witch Hazel', 'Niacinamide Serum', 'Lightweight Gel', 'SPF 50+'),
(8, 8, 'Clarifying Wash', 'Salicylic Acid Toner', 'Oil-Control Serum', 'Water Gel', 'Matte SPF 30'),
(9, 9, 'Acne Foam Cleanser', 'BHA Toner', 'Spot Treatment', 'Oil-Free Lotion', 'Non-comedogenic SPF 40'),
(10, 10, 'Brightening Cleanser', 'Glow Toner', 'Vitamin C Serum', 'Illuminating Moisturizer', 'Dewy SPF 35');

-- --------------------------------------------------------

--
-- Table structure for table `Skin_Profile`
--

CREATE TABLE `Skin_Profile` (
  `SkinID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `Skin_Concerns` varchar(256) DEFAULT NULL,
  `Sensitivities` varchar(256) DEFAULT NULL,
  `Goals` varchar(256) DEFAULT NULL
) ;

--
-- Dumping data for table `Skin_Profile`
--

INSERT INTO `Skin_Profile` (`SkinID`, `UserID`, `Skin_Concerns`, `Sensitivities`, `Goals`) VALUES
(1, 1, 'Large pores, oily skin', 'Fragrance', 'Smooth and clear skin'),
(2, 2, 'Fine lines, wrinkles', 'None', 'Youthful appearance'),
(3, 3, 'Dryness, redness', 'Essential oils', 'Soothe and hydrate skin'),
(4, 4, 'Dullness, flakiness', 'Alcohol', 'Brighter and even tone'),
(5, 5, 'Rosacea, sensitivity', 'Fragrance, sulfates', 'Calm and even skin'),
(6, 6, 'Dehydration, dry patches', 'None', 'Long-lasting moisture'),
(7, 7, 'Hyperpigmentation, acne scars', 'Strong actives', 'Even skin tone'),
(8, 8, 'Excess oil, breakouts', 'Silicones', 'Balanced complexion'),
(9, 9, 'Cystic acne, oily T-zone', 'Heavy creams', 'Clear and matte skin'),
(10, 10, 'Lack of glow, uneven tone', 'None', 'Radiant and dewy skin');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(36) NOT NULL,
  `Email` varchar(36) NOT NULL,
  `Join_Date` date NOT NULL DEFAULT curdate()
) ;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`UserID`, `Name`, `Email`, `Join_Date`) VALUES
(1, 'Claire Pores', 'pores.claire@example.com', '2025-01-10'),
(2, 'Beau Tox', 'tox.beau@example.com', '2025-01-12'),
(3, 'Aloe Vera', 'vera.aloe@example.com', '2025-01-15'),
(4, 'Peely Maskon', 'maskon.peely@example.com', '2025-01-17'),
(5, 'Rosie Cheeks', 'cheeks.rosie@example.com', '2025-01-20'),
(6, 'Cera Vee', 'vee.cera@example.com', '2025-02-01'),
(7, 'Ben Derma', 'derma.ben@example.com', '2025-02-05'),
(8, 'Lois Shunn', 'shunn.lois@example.com', '2025-02-10'),
(9, 'Zitney Spears', 'spears.zitney@example.com', '2025-03-10'),
(10, 'Luma Essence', 'essence.luma@example.com', '2025-04-13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Product_Logs`
--
ALTER TABLE `Product_Logs`
  ADD PRIMARY KEY (`ProductID`);

--
-- Indexes for table `Progress_Logs`
--
ALTER TABLE `Progress_Logs`
  ADD PRIMARY KEY (`ProgressID`),
  ADD KEY `PROG_USER` (`UserID`),
  ADD KEY `PROG_PROD` (`ProductID`);

--
-- Indexes for table `Routines`
--
ALTER TABLE `Routines`
  ADD PRIMARY KEY (`RoutineID`),
  ADD KEY `ROUTINE_USER` (`UserID`);

--
-- Indexes for table `Skin_Profile`
--
ALTER TABLE `Skin_Profile`
  ADD PRIMARY KEY (`SkinID`),
  ADD KEY `SKIN_USER` (`UserID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`UserID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Progress_Logs`
--
ALTER TABLE `Progress_Logs`
  ADD CONSTRAINT `PROG_PROD` FOREIGN KEY (`ProductID`) REFERENCES `Product_Logs` (`ProductID`) ON DELETE CASCADE,
  ADD CONSTRAINT `PROG_USER` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE;

--
-- Constraints for table `Routines`
--
ALTER TABLE `Routines`
  ADD CONSTRAINT `ROUTINE_USER` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE;

--
-- Constraints for table `Skin_Profile`
--
ALTER TABLE `Skin_Profile`
  ADD CONSTRAINT `SKIN_USER` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE;
