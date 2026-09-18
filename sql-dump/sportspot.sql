CREATE DATABASE IF NOT EXISTS `meine_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `meine_db`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS booking_extras, bookings, coupons, extras, resources, users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    street VARCHAR(160) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE resources (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    sport_type VARCHAR(80) NOT NULL,
    area_type ENUM('innen', 'aussen') NOT NULL,
    description TEXT NOT NULL,
    price_per_slot DECIMAL(10,2) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_resources_filters (sport_type, area_type, price_per_slot)
) ENGINE=InnoDB;

CREATE TABLE extras (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    description VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE coupons (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(40) NOT NULL UNIQUE,
    discount_type ENUM('percent', 'fixed') NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    valid_from DATE NOT NULL,
    valid_until DATE NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE bookings (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    resource_id INT UNSIGNED NOT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status ENUM('confirmed', 'cancelled') NOT NULL DEFAULT 'confirmed',
    subtotal DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    total_price DECIMAL(10,2) NOT NULL,
    coupon_code VARCHAR(40) NULL,
    booking_slot_active TINYINT AS (IF(status = 'confirmed', 1, NULL)) PERSISTENT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_booking_slot (resource_id, booking_date, start_time, booking_slot_active),
    INDEX idx_bookings_user (user_id, booking_date),
    CONSTRAINT fk_bookings_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_bookings_resource FOREIGN KEY (resource_id) REFERENCES resources(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE booking_extras (
    booking_id INT UNSIGNED NOT NULL,
    extra_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (booking_id, extra_id),
    CONSTRAINT fk_booking_extras_booking FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_extras_extra FOREIGN KEY (extra_id) REFERENCES extras(id) ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO resources (name, sport_type, area_type, description, price_per_slot) VALUES
('Tennisplatz A', 'Tennis', 'aussen', 'Sandplatz mit Netz und Flutlicht.', 18.00),
('Tennisplatz B', 'Tennis', 'aussen', 'Ruhiger Sandplatz fuer Einzel und Doppel.', 18.00),
('Multifunktionshalle', 'Hallenfussball', 'innen', 'Flexible Halle fuer Fussball, Handball und Training.', 35.00),
('Beachvolleyballfeld', 'Beachvolleyball', 'aussen', 'Sandfeld fuer entspannte Matches.', 16.00),
('Kleinfeld', 'Fussball', 'aussen', 'Kompaktes Kunstrasenfeld fuer Teams.', 24.00);

INSERT INTO extras (name, description, price) VALUES
('Leihschlaeger', 'Zwei robuste Schlaeger fuer Tennis.', 4.00),
('Ballset', 'Passendes Ballset fuer die gewaehlte Sportart.', 3.00),
('Umkleideschrank', 'Abschliessbarer Schrank fuer den Buchungszeitraum.', 2.00),
('Trainerstunde', 'Individuelle Betreuung durch einen Trainer.', 25.00);

INSERT INTO coupons (code, discount_type, discount_value, valid_from, valid_until) VALUES
('START10', 'percent', 10.00, '2026-01-01', '2030-12-31');