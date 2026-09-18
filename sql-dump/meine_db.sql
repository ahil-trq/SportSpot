-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Erstellungszeit: 18. Sep 2026 um 01:09
-- Server-Version: 12.2.2-MariaDB-ubu2404
-- PHP-Version: 8.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `meine_db`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `resource_id` int(10) UNSIGNED NOT NULL,
  `booking_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` enum('confirmed','cancelled') NOT NULL DEFAULT 'confirmed',
  `subtotal` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_price` decimal(10,2) NOT NULL,
  `coupon_code` varchar(40) DEFAULT NULL,
  `booking_slot_active` tinyint(4) GENERATED ALWAYS AS (if(`status` = 'confirmed',1,NULL)) STORED,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `booking_extras`
--

CREATE TABLE `booking_extras` (
  `booking_id` int(10) UNSIGNED NOT NULL,
  `extra_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(40) NOT NULL,
  `discount_type` enum('percent','fixed') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `valid_from` date NOT NULL,
  `valid_until` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Daten für Tabelle `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `discount_type`, `discount_value`, `valid_from`, `valid_until`, `is_active`, `created_at`) VALUES
(1, 'START10', 'percent', 10.00, '2026-01-01', '2030-12-31', 1, '2026-09-18 01:09:26');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `extras`
--

CREATE TABLE `extras` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Daten für Tabelle `extras`
--

INSERT INTO `extras` (`id`, `name`, `description`, `price`, `is_active`, `created_at`) VALUES
(1, 'Leihschlaeger', 'Zwei robuste Schlaeger fuer Tennis.', 4.00, 1, '2026-09-18 01:09:26'),
(2, 'Ballset', 'Passendes Ballset fuer die gewaehlte Sportart.', 3.00, 1, '2026-09-18 01:09:26'),
(3, 'Umkleideschrank', 'Abschliessbarer Schrank fuer den Buchungszeitraum.', 2.00, 1, '2026-09-18 01:09:26'),
(4, 'Trainerstunde', 'Individuelle Betreuung durch einen Trainer.', 25.00, 1, '2026-09-18 01:09:26');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `resources`
--

CREATE TABLE `resources` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `sport_type` varchar(80) NOT NULL,
  `area_type` enum('innen','aussen') NOT NULL,
  `description` text NOT NULL,
  `price_per_slot` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Daten für Tabelle `resources`
--

INSERT INTO `resources` (`id`, `name`, `sport_type`, `area_type`, `description`, `price_per_slot`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Tennisplatz A', 'Tennis', 'aussen', 'Sandplatz mit Netz und Flutlicht.', 18.00, 1, '2026-09-18 01:09:26', '2026-09-18 01:09:26'),
(2, 'Tennisplatz B', 'Tennis', 'aussen', 'Ruhiger Sandplatz fuer Einzel und Doppel.', 18.00, 1, '2026-09-18 01:09:26', '2026-09-18 01:09:26'),
(3, 'Multifunktionshalle', 'Hallenfussball', 'innen', 'Flexible Halle fuer Fussball, Handball und Training.', 35.00, 1, '2026-09-18 01:09:26', '2026-09-18 01:09:26'),
(4, 'Beachvolleyballfeld', 'Beachvolleyball', 'aussen', 'Sandfeld fuer entspannte Matches.', 16.00, 1, '2026-09-18 01:09:26', '2026-09-18 01:09:26'),
(5, 'Kleinfeld', 'Fussball', 'aussen', 'Kompaktes Kunstrasenfeld fuer Teams.', 24.00, 1, '2026-09-18 01:09:26', '2026-09-18 01:09:26');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `street` varchar(160) NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `city` varchar(100) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_booking_slot` (`resource_id`,`booking_date`,`start_time`,`booking_slot_active`),
  ADD KEY `idx_bookings_user` (`user_id`,`booking_date`);

--
-- Indizes für die Tabelle `booking_extras`
--
ALTER TABLE `booking_extras`
  ADD PRIMARY KEY (`booking_id`,`extra_id`),
  ADD KEY `fk_booking_extras_extra` (`extra_id`);

--
-- Indizes für die Tabelle `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indizes für die Tabelle `extras`
--
ALTER TABLE `extras`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_resources_filters` (`sport_type`,`area_type`,`price_per_slot`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `extras`
--
ALTER TABLE `extras`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `fk_bookings_resource` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`),
  ADD CONSTRAINT `fk_bookings_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `booking_extras`
--
ALTER TABLE `booking_extras`
  ADD CONSTRAINT `fk_booking_extras_booking` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_booking_extras_extra` FOREIGN KEY (`extra_id`) REFERENCES `extras` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
