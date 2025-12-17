-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 17, 2025 at 12:05 PM
-- Server version: 12.0.2-MariaDB
-- PHP Version: 8.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ProjekPBD_03`
--
DROP DATABASE IF EXISTS `ProjekPBD_03`;
CREATE DATABASE IF NOT EXISTS `ProjekPBD_03` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `ProjekPBD_03`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `activate_barang`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `activate_barang` (IN `p_idbarang` CHAR(5))   BEGIN
    UPDATE barang SET status = 1 WHERE idbarang = p_idbarang;
END$$

DROP PROCEDURE IF EXISTS `activate_satuan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `activate_satuan` (IN `p_idsatuan` CHAR(3))   BEGIN
    UPDATE satuan
    SET status = 1
    WHERE idsatuan = p_idsatuan;
END$$

DROP PROCEDURE IF EXISTS `deletePengadaan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `deletePengadaan` (IN `pid` CHAR(1))   BEGIN
    UPDATE pengadaan
    SET status = 'T'
    WHERE idpengadaan = pid;
END$$

DROP PROCEDURE IF EXISTS `deleteRole`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `deleteRole` (IN `p_idrole` CHAR(3))   BEGIN
    DELETE FROM role WHERE idrole = p_idrole;
END$$

DROP PROCEDURE IF EXISTS `deleteUser`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `deleteUser` (IN `p_iduser` CHAR(5))   BEGIN
    DELETE FROM user WHERE iduser = p_iduser;
END$$

DROP PROCEDURE IF EXISTS `delete_barang`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `delete_barang` (IN `p_idbarang` CHAR(5))   BEGIN
    UPDATE barang SET status = 0 WHERE idbarang = p_idbarang;
END$$

DROP PROCEDURE IF EXISTS `delete_satuan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `delete_satuan` (IN `p_idsatuan` CHAR(3))   BEGIN
    UPDATE satuan
    SET status = 0
    WHERE idsatuan = p_idsatuan;
END$$

DROP PROCEDURE IF EXISTS `getBarangById`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `getBarangById` (IN `p_idbarang` CHAR(5))   BEGIN
    SELECT * FROM barang WHERE idbarang = p_idbarang;
END$$

DROP PROCEDURE IF EXISTS `getMarginPenjualanById`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `getMarginPenjualanById` (IN `p_id` INT)   BEGIN
    SELECT * FROM v_margin_penjualan_a WHERE idmargin_penjualan = p_id;
END$$

DROP PROCEDURE IF EXISTS `getRoleById`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `getRoleById` (IN `p_idrole` CHAR(3))   BEGIN
    SELECT * FROM v_role WHERE idrole = p_idrole;
END$$

DROP PROCEDURE IF EXISTS `getSatuanById`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `getSatuanById` (IN `p_idsatuan` CHAR(5))   BEGIN
    SELECT * FROM satuan WHERE idsatuan = p_idsatuan;
END$$

DROP PROCEDURE IF EXISTS `getUserById`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `getUserById` (IN `p_iduser` CHAR(5))   BEGIN
    SELECT * FROM user WHERE iduser = p_iduser;
END$$

DROP PROCEDURE IF EXISTS `getVendorById`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `getVendorById` (IN `p_idvendor` CHAR(5))   BEGIN
    SELECT * FROM vendor WHERE idvendor = p_idvendor;
END$$

DROP PROCEDURE IF EXISTS `insertDetailPengadaan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `insertDetailPengadaan` (IN `p_idpengadaan` INT, IN `p_idbarang` CHAR(5), IN `p_jumlah` INT)   BEGIN
    INSERT INTO detail_pengadaan (
        idpengadaan,
        idbarang,
        jumlah
    ) VALUES (
        p_idpengadaan,
        p_idbarang,
        p_jumlah
    );
END$$

DROP PROCEDURE IF EXISTS `insertMarginPenjualan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `insertMarginPenjualan` (IN `p_persen` DECIMAL(5,2), IN `p_iduser` INT)   BEGIN
    DECLARE new_id INT;
    SET new_id = COALESCE((SELECT MAX(idmargin_penjualan) + 1 FROM margin_penjualan), 1);

    INSERT INTO margin_penjualan (idmargin_penjualan, persen, status, iduser)
    VALUES (new_id, p_persen, 1, p_iduser);
END$$

DROP PROCEDURE IF EXISTS `insertRole`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `insertRole` (IN `p_nama_role` VARCHAR(50))   BEGIN
    DECLARE new_id CHAR(3);
    SET new_id = LPAD(COALESCE((SELECT MAX(CAST(idrole AS UNSIGNED)) + 1 FROM role), 1), 3, '0');

    INSERT INTO role (idrole, nama_role)
    VALUES (new_id, p_nama_role);
END$$

DROP PROCEDURE IF EXISTS `insertUser`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `insertUser` (IN `p_username` VARCHAR(45), IN `p_password` VARCHAR(100), IN `p_idrole` CHAR(3))   BEGIN
    DECLARE new_id CHAR(5);
    SET new_id = LPAD(COALESCE((SELECT MAX(CAST(iduser AS UNSIGNED)) + 1 FROM `user`), 1), 5, '0');

    INSERT INTO `user` (iduser, username, password, idrole)
    VALUES (new_id, p_username, p_password, p_idrole);
    COMMIT;
END$$

DROP PROCEDURE IF EXISTS `insertVendor`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `insertVendor` (IN `p_nama` VARCHAR(100), IN `p_badan_hukum` VARCHAR(50))   BEGIN
    DECLARE next_id CHAR(5);
    SELECT LPAD(COALESCE(MAX(CAST(idvendor AS UNSIGNED)) + 1, 1), 5, '0')
    INTO next_id
    FROM vendor;

    INSERT INTO vendor (idvendor, nama_vendor, badan_hukum, status)
    VALUES (next_id, p_nama, p_badan_hukum, 'A');
END$$

DROP PROCEDURE IF EXISTS `insert_barang`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `insert_barang` (IN `p_nama` VARCHAR(100), IN `p_idsatuan` CHAR(5), IN `p_harga` INT)   BEGIN
    DECLARE new_id CHAR(5);

    -- Buat ID otomatis
    SELECT LPAD(COALESCE(MAX(CAST(idbarang AS UNSIGNED)) + 1, 1), 5, '0')
    INTO new_id FROM barang;

    INSERT INTO barang (idbarang, jenis, nama, idsatuan, status, harga)
    VALUES (new_id, 'B', p_nama, p_idsatuan, 1, p_harga);
END$$

DROP PROCEDURE IF EXISTS `insert_satuan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `insert_satuan` (IN `p_nama` VARCHAR(100))   BEGIN
    DECLARE new_id CHAR(3);

    -- Buat ID baru otomatis
    SELECT LPAD(COALESCE(MAX(CAST(idsatuan AS UNSIGNED)) + 1, 1), 3, '0')
    INTO new_id FROM satuan;

    INSERT INTO satuan (idsatuan, nama_satuan, status)
    VALUES (new_id, p_nama, 1);
END$$

DROP PROCEDURE IF EXISTS `setMarginPenjualanStatus`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `setMarginPenjualanStatus` (IN `p_idmargin_penjualan` INT, IN `p_status` TINYINT)   BEGIN
    UPDATE margin_penjualan
    SET status = p_status
    WHERE idmargin_penjualan = p_idmargin_penjualan;
END$$

DROP PROCEDURE IF EXISTS `setVendorStatus`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `setVendorStatus` (IN `p_idvendor` CHAR(5), IN `p_status` CHAR(1))   BEGIN
    UPDATE vendor SET status = p_status WHERE idvendor = p_idvendor;
END$$

DROP PROCEDURE IF EXISTS `updateMarginPenjualan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `updateMarginPenjualan` (IN `p_idmargin_penjualan` INT, IN `p_persen` DECIMAL(5,2))   BEGIN
    UPDATE margin_penjualan
    SET persen = p_persen
    WHERE idmargin_penjualan = p_idmargin_penjualan;
END$$

DROP PROCEDURE IF EXISTS `updatePengadaan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `updatePengadaan` (IN `pid` INT, IN `pstatus` CHAR(1))   BEGIN
    UPDATE pengadaan
    SET status = pstatus
    WHERE idpengadaan = pid;
END$$

DROP PROCEDURE IF EXISTS `updateRole`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `updateRole` (IN `p_idrole` CHAR(3), IN `p_nama_role` VARCHAR(50))   BEGIN
    UPDATE role
    SET nama_role = p_nama_role
    WHERE idrole = p_idrole;
END$$

DROP PROCEDURE IF EXISTS `updateUser`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `updateUser` (IN `p_iduser` CHAR(5), IN `p_username` VARCHAR(45), IN `p_password` VARCHAR(100), IN `p_idrole` CHAR(3))   BEGIN
    IF p_password IS NOT NULL AND p_password <> '' THEN
        UPDATE user
        SET username = p_username, password = p_password, idrole = p_idrole
        WHERE iduser = p_iduser;
    ELSE
        UPDATE user
        SET username = p_username, idrole = p_idrole
        WHERE iduser = p_iduser;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `updateVendor`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `updateVendor` (IN `p_idvendor` CHAR(5), IN `p_nama` VARCHAR(100), IN `p_badan_hukum` VARCHAR(50))   BEGIN
    UPDATE vendor
    SET nama_vendor = p_nama,
        badan_hukum = p_badan_hukum
    WHERE idvendor = p_idvendor;
END$$

DROP PROCEDURE IF EXISTS `update_barang`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `update_barang` (IN `p_idbarang` CHAR(5), IN `p_nama` VARCHAR(100), IN `p_idsatuan` CHAR(5), IN `p_harga` INT)   BEGIN
    UPDATE barang
    SET nama = p_nama,
        idsatuan = p_idsatuan,
        harga = p_harga
    WHERE idbarang = p_idbarang;
END$$

DROP PROCEDURE IF EXISTS `update_satuan`$$
CREATE DEFINER=`admin`@`%` PROCEDURE `update_satuan` (IN `p_idsatuan` CHAR(3), IN `p_nama` VARCHAR(100))   BEGIN
    UPDATE satuan
    SET nama_satuan = p_nama
    WHERE idsatuan = p_idsatuan;
END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `fn_subtotal`$$
CREATE DEFINER=`admin`@`%` FUNCTION `fn_subtotal` (`harga` DECIMAL(15,2), `jumlah` INT) RETURNS DECIMAL(15,2) DETERMINISTIC BEGIN
    RETURN harga * jumlah;
END$$

DROP FUNCTION IF EXISTS `fn_subtotal_nilai`$$
CREATE DEFINER=`admin`@`%` FUNCTION `fn_subtotal_nilai` (`idpengadaan` INT) RETURNS DECIMAL(15,2) DETERMINISTIC BEGIN
    DECLARE subtotal DECIMAL(15,2);
    SELECT SUM(fn_subtotal(harga, jumlah)) INTO subtotal
    FROM detail_pengadaan
    WHERE pengadaan_idpengadaan = idpengadaan;
    RETURN IFNULL(subtotal, 0);
END$$

DROP FUNCTION IF EXISTS `fn_total_nilai`$$
CREATE DEFINER=`admin`@`%` FUNCTION `fn_total_nilai` (`idpengadaan` INT) RETURNS DECIMAL(15,2) DETERMINISTIC BEGIN
    DECLARE subtotal DECIMAL(15,2);
    DECLARE total DECIMAL(15,2);
    SET subtotal = fn_subtotal_nilai(idpengadaan);
    SET total = subtotal + (subtotal * 0.11);
    RETURN total;
END$$

DROP FUNCTION IF EXISTS `hitung_subtotal_penerimaan`$$
CREATE DEFINER=`admin`@`%` FUNCTION `hitung_subtotal_penerimaan` (`p_jumlah` INT, `p_harga` INT) RETURNS INT(11) DETERMINISTIC BEGIN
    RETURN p_jumlah * p_harga;
END$$

DROP FUNCTION IF EXISTS `hitung_total`$$
CREATE DEFINER=`admin`@`%` FUNCTION `hitung_total` (`jumlah` INT, `harga` INT) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE total INT;
    SET total = jumlah * harga;
    RETURN total;
END$$

DROP FUNCTION IF EXISTS `hitung_total_pengadaan`$$
CREATE DEFINER=`admin`@`%` FUNCTION `hitung_total_pengadaan` (`p_id_pengadaan` INT) RETURNS DECIMAL(15,2) DETERMINISTIC BEGIN
    DECLARE v_subtotal DECIMAL(15,2);
    DECLARE v_ppn DECIMAL(15,2);
    DECLARE v_total DECIMAL(15,2);

    SELECT IFNULL(SUM(sub_total),0)
    INTO v_subtotal
    FROM detail_pengadaan
    WHERE idpengadaan = p_id_pengadaan;

    SET v_ppn = v_subtotal * 0.10;
    SET v_total = v_subtotal + v_ppn;

    RETURN v_total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `barang`;
CREATE TABLE `barang` (
  `idbarang` char(5) NOT NULL,
  `jenis` char(1) DEFAULT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `idsatuan` char(3) NOT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `barang`:
--   `idsatuan`
--       `satuan` -> `idsatuan`
--

--
-- Truncate table before insert `barang`
--

TRUNCATE TABLE `barang`;
--
-- Dumping data for table `barang`
--

INSERT DELAYED IGNORE INTO `barang` (`idbarang`, `jenis`, `nama`, `idsatuan`, `status`, `harga`) VALUES
('00001', 'B', 'Beras Premium', '003', 1, 12000),
('00002', 'B', 'Minyak Goreng 1L', '004', 1, 15000),
('00003', 'B', 'Sabun Mandi', '002', 1, 5000),
('00004', 'B', 'Air Mineral 600ml', '001', 1, 3000),
('00005', 'B', 'Minyak', '004', 1, 14000),
('00006', 'B', 'Teh Gelas', '004', 1, 2500);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penerimaan`
--
-- Creation: Nov 27, 2025 at 01:21 AM
--

DROP TABLE IF EXISTS `detail_penerimaan`;
CREATE TABLE `detail_penerimaan` (
  `iddetail_penerimaan` int(11) NOT NULL,
  `idpenerimaan` int(11) DEFAULT NULL,
  `barang_idbarang` char(5) NOT NULL,
  `jumlah_terima` int(11) DEFAULT NULL,
  `harga_satuan_terima` int(11) DEFAULT NULL,
  `sub_total_terima` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `detail_penerimaan`:
--   `barang_idbarang`
--       `barang` -> `idbarang`
--   `idpenerimaan`
--       `penerimaan` -> `idpenerimaan`
--

--
-- Truncate table before insert `detail_penerimaan`
--

TRUNCATE TABLE `detail_penerimaan`;
--
-- Dumping data for table `detail_penerimaan`
--

INSERT DELAYED IGNORE INTO `detail_penerimaan` (`iddetail_penerimaan`, `idpenerimaan`, `barang_idbarang`, `jumlah_terima`, `harga_satuan_terima`, `sub_total_terima`) VALUES
(1, 1, '00001', 5, 3000, 15000),
(2, 2, '00001', 5, 3000, 15000);

--
-- Triggers `detail_penerimaan`
--
DROP TRIGGER IF EXISTS `trg_before_insert_detail_penerimaan`;
DELIMITER $$
CREATE TRIGGER `trg_before_insert_detail_penerimaan` BEFORE INSERT ON `detail_penerimaan` FOR EACH ROW BEGIN
    DECLARE v_last_detail_id INT DEFAULT 0;
    DECLARE v_last_penerimaan_id INT DEFAULT 0;

    -- Generate ID detail penerimaan
    SELECT IFNULL(MAX(iddetail_penerimaan), 0)
    INTO v_last_detail_id
    FROM detail_penerimaan;

    SET NEW.iddetail_penerimaan = v_last_detail_id + 1;

    -- Jika idpenerimaan belum diisi → buat penerimaan baru
    IF NEW.idpenerimaan IS NULL OR NEW.idpenerimaan = 0 THEN
        
        SELECT IFNULL(MAX(idpenerimaan), 0)
        INTO v_last_penerimaan_id
        FROM penerimaan;

        SET NEW.idpenerimaan = v_last_penerimaan_id + 1;

        INSERT INTO penerimaan (idpenerimaan, created_at, status, idpengadaan, iduser)
        VALUES (NEW.idpenerimaan, NOW(), 'S', @idpengadaan_selected, @iduser_login);
    END IF;

    -- Hitung subtotal langsung
    SET NEW.sub_total_terima = NEW.jumlah_terima * NEW.harga_satuan_terima;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_pengadaan`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `detail_pengadaan`;
CREATE TABLE `detail_pengadaan` (
  `iddetail_pengadaan` int(11) NOT NULL,
  `harga_satuan` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `sub_total` int(11) DEFAULT NULL,
  `idbarang` char(5) NOT NULL,
  `idpengadaan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `detail_pengadaan`:
--   `idbarang`
--       `barang` -> `idbarang`
--   `idpengadaan`
--       `pengadaan` -> `idpengadaan`
--

--
-- Truncate table before insert `detail_pengadaan`
--

TRUNCATE TABLE `detail_pengadaan`;
--
-- Dumping data for table `detail_pengadaan`
--

INSERT DELAYED IGNORE INTO `detail_pengadaan` (`iddetail_pengadaan`, `harga_satuan`, `jumlah`, `sub_total`, `idbarang`, `idpengadaan`) VALUES
(1, 12000, 10, 120000, '00001', 1);

--
-- Triggers `detail_pengadaan`
--
DROP TRIGGER IF EXISTS `trg_after_insert_detail_pengadaan`;
DELIMITER $$
CREATE TRIGGER `trg_after_insert_detail_pengadaan` AFTER INSERT ON `detail_pengadaan` FOR EACH ROW BEGIN
    DECLARE v_subtotal DECIMAL(15,2);
    DECLARE v_ppn DECIMAL(15,2);
    DECLARE v_total DECIMAL(15,2);

    -- Hitung ulang subtotal
    SELECT IFNULL(SUM(sub_total),0)
    INTO v_subtotal
    FROM detail_pengadaan
    WHERE idpengadaan = NEW.idpengadaan;

    SET v_ppn = v_subtotal * 0.10;
    SET v_total = v_subtotal + v_ppn;

    -- Update ke tabel pengadaan
    UPDATE pengadaan
    SET subtotal_nilai = v_subtotal,
        ppn = v_ppn,
        total_nilai = v_total
    WHERE idpengadaan = NEW.idpengadaan;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_before_insert_detail_pengadaan`;
DELIMITER $$
CREATE TRIGGER `trg_before_insert_detail_pengadaan` BEFORE INSERT ON `detail_pengadaan` FOR EACH ROW BEGIN
    DECLARE v_last_detail_id INT DEFAULT 0;
    DECLARE v_last_pengadaan_id INT DEFAULT 0;
    DECLARE v_harga INT DEFAULT 0;

    -- Generate ID detail baru
    SELECT IFNULL(MAX(iddetail_pengadaan), 0)
    INTO v_last_detail_id
    FROM detail_pengadaan;

    SET NEW.iddetail_pengadaan = v_last_detail_id + 1;

    -- Ambil harga barang
    SELECT harga
    INTO v_harga
    FROM barang
    WHERE idbarang = NEW.idbarang;

    SET NEW.harga_satuan = v_harga;
    SET NEW.sub_total = NEW.jumlah * NEW.harga_satuan;

    -- Jika idpengadaan belum diisi → buat pengadaan baru
    IF NEW.idpengadaan IS NULL OR NEW.idpengadaan = 0 THEN

        SELECT IFNULL(MAX(idpengadaan), 0)
        INTO v_last_pengadaan_id
        FROM pengadaan;

        SET NEW.idpengadaan = v_last_pengadaan_id + 1;

        INSERT INTO pengadaan
        (idpengadaan, timestamp, user_iduser, status, vendor_idvendor,
         subtotal_nilai, ppn, total_nilai)
        VALUES
        (NEW.idpengadaan, NOW(), @user_login, 'O', @vendor_selected,
         NEW.sub_total, NEW.sub_total * 0.10,
         NEW.sub_total + (NEW.sub_total * 0.10));

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `detail_penjualan`;
CREATE TABLE `detail_penjualan` (
  `iddetail_penjualan` int(11) NOT NULL,
  `harga_satuan` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` int(11) DEFAULT NULL,
  `penjualan_idpenjualan` int(11) NOT NULL,
  `idbarang` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `detail_penjualan`:
--   `idbarang`
--       `barang` -> `idbarang`
--   `penjualan_idpenjualan`
--       `penjualan` -> `idpenjualan`
--

--
-- Truncate table before insert `detail_penjualan`
--

TRUNCATE TABLE `detail_penjualan`;
--
-- Triggers `detail_penjualan`
--
DROP TRIGGER IF EXISTS `trg_after_delete_detail_penjualan`;
DELIMITER $$
CREATE TRIGGER `trg_after_delete_detail_penjualan` AFTER DELETE ON `detail_penjualan` FOR EACH ROW BEGIN
    DECLARE v_last_stock INT DEFAULT 0;
    DECLARE v_new_stock INT DEFAULT 0;

    -- Ambil stok terakhir barang
    SELECT IFNULL(stock, 0)
    INTO v_last_stock
    FROM kartu_stok
    WHERE idbarang = OLD.idbarang
    ORDER BY idkartu_stok DESC
    LIMIT 1;

    -- Hitung stok baru (stok kembali karena penjualan dihapus)
    SET v_new_stock = v_last_stock + OLD.jumlah;

    -- Simpan ke kartu_stok
    INSERT INTO kartu_stok (idbarang, jenis_transaksi, masuk, keluar, stock, created_at, idtransaksi)
    VALUES (OLD.idbarang, 'B', OLD.jumlah, 0, v_new_stock, NOW(), OLD.penjualan_idpenjualan);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_after_insert_detail_penjualan`;
DELIMITER $$
CREATE TRIGGER `trg_after_insert_detail_penjualan` AFTER INSERT ON `detail_penjualan` FOR EACH ROW BEGIN
    DECLARE v_last_stock INT DEFAULT 0;
    DECLARE v_new_stock INT DEFAULT 0;

    -- Ambil stok terakhir dari barang
    SELECT IFNULL(stock, 0)
    INTO v_last_stock
    FROM kartu_stok
    WHERE idbarang = NEW.idbarang
    ORDER BY idkartu_stok DESC
    LIMIT 1;

    -- Hitung stok baru (stok berkurang karena penjualan)
    SET v_new_stock = v_last_stock - NEW.jumlah;

    -- Simpan riwayat ke kartu_stok
    INSERT INTO kartu_stok (idbarang, jenis_transaksi, masuk, keluar, stock, created_at, idtransaksi)
    VALUES (NEW.idbarang, 'K', 0, NEW.jumlah, v_new_stock, NOW(), NEW.penjualan_idpenjualan);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_retur`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `detail_retur`;
CREATE TABLE `detail_retur` (
  `iddetail_retur` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `alasan` varchar(200) DEFAULT NULL,
  `idretur` int(11) NOT NULL,
  `iddetail_penerimaan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `detail_retur`:
--   `iddetail_penerimaan`
--       `detail_penerimaan` -> `iddetail_penerimaan`
--   `idretur`
--       `retur` -> `idretur`
--

--
-- Truncate table before insert `detail_retur`
--

TRUNCATE TABLE `detail_retur`;
-- --------------------------------------------------------

--
-- Table structure for table `kartu_stok`
--
-- Creation: Nov 13, 2025 at 02:05 AM
--

DROP TABLE IF EXISTS `kartu_stok`;
CREATE TABLE `kartu_stok` (
  `idkartu_stok` int(11) NOT NULL,
  `jenis_transaksi` char(1) DEFAULT NULL,
  `masuk` int(11) DEFAULT NULL,
  `keluar` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `idtransaksi` int(11) DEFAULT NULL,
  `idbarang` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `kartu_stok`:
--   `idbarang`
--       `barang` -> `idbarang`
--

--
-- Truncate table before insert `kartu_stok`
--

TRUNCATE TABLE `kartu_stok`;
-- --------------------------------------------------------

--
-- Table structure for table `margin_penjualan`
--
-- Creation: Oct 27, 2025 at 11:06 PM
--

DROP TABLE IF EXISTS `margin_penjualan`;
CREATE TABLE `margin_penjualan` (
  `idmargin_penjualan` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `persen` double DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `iduser` char(5) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `margin_penjualan`:
--   `iduser`
--       `user` -> `iduser`
--

--
-- Truncate table before insert `margin_penjualan`
--

TRUNCATE TABLE `margin_penjualan`;
--
-- Dumping data for table `margin_penjualan`
--

INSERT DELAYED IGNORE INTO `margin_penjualan` (`idmargin_penjualan`, `created_at`, `persen`, `status`, `iduser`, `updated_at`) VALUES
(1, '2025-10-16 05:15:33', 10, 1, '00001', '2025-10-16 05:15:33'),
(2, '2025-10-16 05:15:33', 12.5, 1, '00001', '2025-10-16 05:15:33'),
(3, '2025-10-16 05:15:33', 15, 1, '00001', '2025-10-16 05:15:33'),
(4, '2025-10-16 05:15:33', 8, 0, '00001', '2025-10-16 05:15:33'),
(5, '2025-10-16 05:15:33', 20, 1, '00001', '2025-10-16 05:15:33');

-- --------------------------------------------------------

--
-- Table structure for table `penerimaan`
--
-- Creation: Nov 27, 2025 at 01:20 AM
--

DROP TABLE IF EXISTS `penerimaan`;
CREATE TABLE `penerimaan` (
  `idpenerimaan` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` char(1) DEFAULT NULL,
  `idpengadaan` int(11) NOT NULL,
  `iduser` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `penerimaan`:
--   `idpengadaan`
--       `pengadaan` -> `idpengadaan`
--   `iduser`
--       `user` -> `iduser`
--

--
-- Truncate table before insert `penerimaan`
--

TRUNCATE TABLE `penerimaan`;
--
-- Dumping data for table `penerimaan`
--

INSERT DELAYED IGNORE INTO `penerimaan` (`idpenerimaan`, `created_at`, `status`, `idpengadaan`, `iduser`) VALUES
(1, '2025-11-27 03:01:12', 'S', 1, '00001'),
(2, '2025-11-27 03:01:35', 'S', 1, '00001');

-- --------------------------------------------------------

--
-- Table structure for table `pengadaan`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `pengadaan`;
CREATE TABLE `pengadaan` (
  `idpengadaan` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_iduser` char(5) NOT NULL,
  `status` char(1) DEFAULT NULL,
  `vendor_idvendor` char(5) NOT NULL,
  `subtotal_nilai` int(11) DEFAULT NULL,
  `ppn` int(11) DEFAULT NULL,
  `total_nilai` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `pengadaan`:
--   `user_iduser`
--       `user` -> `iduser`
--   `vendor_idvendor`
--       `vendor` -> `idvendor`
--

--
-- Truncate table before insert `pengadaan`
--

TRUNCATE TABLE `pengadaan`;
--
-- Dumping data for table `pengadaan`
--

INSERT DELAYED IGNORE INTO `pengadaan` (`idpengadaan`, `timestamp`, `user_iduser`, `status`, `vendor_idvendor`, `subtotal_nilai`, `ppn`, `total_nilai`) VALUES
(1, '2025-11-27 02:59:56', '00001', 'O', '00002', 120000, 12000, 132000);

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `penjualan`;
CREATE TABLE `penjualan` (
  `idpenjualan` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `subtotal_nilai` int(11) DEFAULT NULL,
  `ppn` int(11) DEFAULT NULL,
  `total_nilai` int(11) DEFAULT NULL,
  `iduser` char(5) NOT NULL,
  `idmargin_penjualan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `penjualan`:
--   `idmargin_penjualan`
--       `margin_penjualan` -> `idmargin_penjualan`
--   `iduser`
--       `user` -> `iduser`
--

--
-- Truncate table before insert `penjualan`
--

TRUNCATE TABLE `penjualan`;
-- --------------------------------------------------------

--
-- Table structure for table `retur`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `retur`;
CREATE TABLE `retur` (
  `idretur` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `idpenerimaan` int(11) NOT NULL,
  `iduser` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `retur`:
--   `idpenerimaan`
--       `penerimaan` -> `idpenerimaan`
--   `iduser`
--       `user` -> `iduser`
--

--
-- Truncate table before insert `retur`
--

TRUNCATE TABLE `retur`;
-- --------------------------------------------------------

--
-- Table structure for table `role`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `idrole` char(3) NOT NULL,
  `nama_role` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `role`:
--

--
-- Truncate table before insert `role`
--

TRUNCATE TABLE `role`;
--
-- Dumping data for table `role`
--

INSERT DELAYED IGNORE INTO `role` (`idrole`, `nama_role`) VALUES
('001', 'Super Admin'),
('002', 'Admin'),
('003', 'Penjual');

-- --------------------------------------------------------

--
-- Table structure for table `satuan`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `satuan`;
CREATE TABLE `satuan` (
  `idsatuan` char(3) NOT NULL,
  `nama_satuan` varchar(45) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `satuan`:
--

--
-- Truncate table before insert `satuan`
--

TRUNCATE TABLE `satuan`;
--
-- Dumping data for table `satuan`
--

INSERT DELAYED IGNORE INTO `satuan` (`idsatuan`, `nama_satuan`, `status`) VALUES
('001', 'Unit', 1),
('002', 'Box', 1),
('003', 'Kg', 1),
('004', 'Liter', 1),
('005', 'Pack', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--
-- Creation: Oct 28, 2025 at 06:43 AM
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `iduser` char(5) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `idrole` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `user`:
--   `idrole`
--       `role` -> `idrole`
--

--
-- Truncate table before insert `user`
--

TRUNCATE TABLE `user`;
--
-- Dumping data for table `user`
--

INSERT DELAYED IGNORE INTO `user` (`iduser`, `username`, `password`, `idrole`) VALUES
('00001', 'superadmin', 'superadmin123', '001'),
('00002', 'admin', 'adminjual123', '002'),
('00003', 'penjual1', 'admin234', '003'),
('00004', 'penjual2', 'admin345', '003'),
('00005', 'penjual3', 'admin456', '003');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--
-- Creation: Oct 25, 2025 at 10:44 AM
--

DROP TABLE IF EXISTS `vendor`;
CREATE TABLE `vendor` (
  `idvendor` char(5) NOT NULL,
  `nama_vendor` varchar(100) NOT NULL,
  `badan_hukum` char(1) DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- RELATIONSHIPS FOR TABLE `vendor`:
--

--
-- Truncate table before insert `vendor`
--

TRUNCATE TABLE `vendor`;
--
-- Dumping data for table `vendor`
--

INSERT DELAYED IGNORE INTO `vendor` (`idvendor`, `nama_vendor`, `badan_hukum`, `status`) VALUES
('00001', 'PT Sumber Makmur', 'Y', 'A'),
('00002', 'CV Anugerah Jaya', 'Y', 'A'),
('00003', 'UD Sinar Abadi', 'N', 'A'),
('00004', 'PT Berkah Sentosa', 'Y', 'A'),
('00005', 'CV Tunas Harapan', 'Y', 'A');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_barang_a`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_barang_a`;
CREATE TABLE `v_barang_a` (
`idbarang` char(5)
,`nama_barang` varchar(45)
,`nama_satuan` varchar(45)
,`harga` int(11)
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_barang_t`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_barang_t`;
CREATE TABLE `v_barang_t` (
`idbarang` char(5)
,`nama_barang` varchar(45)
,`nama_satuan` varchar(45)
,`harga` int(11)
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_keuntungan_penjualan`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_keuntungan_penjualan`;
CREATE TABLE `v_keuntungan_penjualan` (
`idbarang` char(5)
,`nama_barang` varchar(45)
,`tanggal` date
,`total_penjualan` decimal(32,0)
,`total_modal` decimal(46,4)
,`keuntungan` decimal(47,4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_margin_penjualan_a`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_margin_penjualan_a`;
CREATE TABLE `v_margin_penjualan_a` (
`idmargin_penjualan` int(11)
,`persen` double
,`status` tinyint(4)
,`dibuat_oleh` varchar(45)
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_margin_penjualan_t`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_margin_penjualan_t`;
CREATE TABLE `v_margin_penjualan_t` (
`idmargin_penjualan` int(11)
,`persen` double
,`status` tinyint(4)
,`dibuat_oleh` varchar(45)
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_penerimaan`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_penerimaan`;
CREATE TABLE `v_penerimaan` (
`idpenerimaan` int(11)
,`tanggal_penerimaan` timestamp
,`user_iduser` char(5)
,`nama_user` varchar(45)
,`idpengadaan` int(11)
,`vendor_idvendor` char(5)
,`nama_vendor` varchar(100)
,`total_nilai` int(11)
,`status` char(1)
,`nama_barang` varchar(45)
,`jumlah_terima` int(11)
,`harga_satuan_terima` int(11)
,`sub_total_terima` int(11)
,`keterangan_status` varchar(15)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pengadaan`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_pengadaan`;
CREATE TABLE `v_pengadaan` (
`idpengadaan` int(11)
,`tanggal_pengadaan` timestamp
,`user_iduser` char(5)
,`nama_user` varchar(45)
,`vendor_idvendor` char(5)
,`nama_vendor` varchar(100)
,`harga_satuan` int(11)
,`jumlah` int(11)
,`barang` varchar(45)
,`status` char(1)
,`keterangan_status` varchar(15)
,`subtotal_nilai` int(11)
,`ppn` int(11)
,`total_nilai` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_rekap_keuntungan`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_rekap_keuntungan`;
CREATE TABLE `v_rekap_keuntungan` (
`periode` varchar(12)
,`total_keuntungan` decimal(65,4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_role`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_role`;
CREATE TABLE `v_role` (
`idrole` char(3)
,`nama_role` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_satuan_a`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_satuan_a`;
CREATE TABLE `v_satuan_a` (
`idsatuan` char(3)
,`nama_satuan` varchar(45)
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_satuan_t`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_satuan_t`;
CREATE TABLE `v_satuan_t` (
`idsatuan` char(3)
,`nama_satuan` varchar(45)
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stok_barang`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_stok_barang`;
CREATE TABLE `v_stok_barang` (
`idbarang` char(5)
,`nama_barang` varchar(45)
,`stok_terakhir` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_user`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_user`;
CREATE TABLE `v_user` (
`iduser` char(5)
,`username` varchar(45)
,`password` varchar(100)
,`nama_role` varchar(100)
,`idrole` char(3)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_vendor_a`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_vendor_a`;
CREATE TABLE `v_vendor_a` (
`idvendor` char(5)
,`nama_vendor` varchar(100)
,`badan_hukum` char(1)
,`status` char(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_vendor_t`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_vendor_t`;
CREATE TABLE `v_vendor_t` (
`idvendor` char(5)
,`nama_vendor` varchar(100)
,`badan_hukum` char(1)
,`status` char(1)
);

-- --------------------------------------------------------

--
-- Structure for view `v_barang_a` exported as a table
--
DROP TABLE IF EXISTS `v_barang_a`;
CREATE TABLE`v_barang_a`(
    `idbarang` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_barang` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `nama_satuan` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `harga` int(11) DEFAULT NULL,
    `status` tinyint(4) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_barang_t` exported as a table
--
DROP TABLE IF EXISTS `v_barang_t`;
CREATE TABLE`v_barang_t`(
    `idbarang` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_barang` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `nama_satuan` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `harga` int(11) DEFAULT NULL,
    `status` tinyint(4) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_keuntungan_penjualan` exported as a table
--
DROP TABLE IF EXISTS `v_keuntungan_penjualan`;
CREATE TABLE`v_keuntungan_penjualan`(
    `idbarang` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_barang` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `tanggal` date DEFAULT NULL,
    `total_penjualan` decimal(32,0) DEFAULT NULL,
    `total_modal` decimal(46,4) DEFAULT NULL,
    `keuntungan` decimal(47,4) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_margin_penjualan_a` exported as a table
--
DROP TABLE IF EXISTS `v_margin_penjualan_a`;
CREATE TABLE`v_margin_penjualan_a`(
    `idmargin_penjualan` int(11) NOT NULL,
    `persen` double DEFAULT NULL,
    `status` tinyint(4) DEFAULT NULL,
    `dibuat_oleh` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT 'current_timestamp()',
    `updated_at` timestamp NOT NULL DEFAULT 'current_timestamp()'
);

-- --------------------------------------------------------

--
-- Structure for view `v_margin_penjualan_t` exported as a table
--
DROP TABLE IF EXISTS `v_margin_penjualan_t`;
CREATE TABLE`v_margin_penjualan_t`(
    `idmargin_penjualan` int(11) NOT NULL,
    `persen` double DEFAULT NULL,
    `status` tinyint(4) DEFAULT NULL,
    `dibuat_oleh` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT 'current_timestamp()',
    `updated_at` timestamp NOT NULL DEFAULT 'current_timestamp()'
);

-- --------------------------------------------------------

--
-- Structure for view `v_penerimaan` exported as a table
--
DROP TABLE IF EXISTS `v_penerimaan`;
CREATE TABLE`v_penerimaan`(
    `idpenerimaan` int(11) NOT NULL,
    `tanggal_penerimaan` timestamp NOT NULL DEFAULT 'current_timestamp()',
    `user_iduser` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_user` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
    `idpengadaan` int(11) NOT NULL,
    `vendor_idvendor` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_vendor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
    `total_nilai` int(11) DEFAULT NULL,
    `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `nama_barang` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `jumlah_terima` int(11) DEFAULT NULL,
    `harga_satuan_terima` int(11) DEFAULT NULL,
    `sub_total_terima` int(11) DEFAULT NULL,
    `keterangan_status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_pengadaan` exported as a table
--
DROP TABLE IF EXISTS `v_pengadaan`;
CREATE TABLE`v_pengadaan`(
    `idpengadaan` int(11) NOT NULL,
    `tanggal_pengadaan` timestamp NOT NULL DEFAULT 'current_timestamp()',
    `user_iduser` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_user` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
    `vendor_idvendor` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_vendor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
    `harga_satuan` int(11) DEFAULT NULL,
    `jumlah` int(11) DEFAULT NULL,
    `barang` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `keterangan_status` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `subtotal_nilai` int(11) DEFAULT NULL,
    `ppn` int(11) DEFAULT NULL,
    `total_nilai` int(11) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_rekap_keuntungan` exported as a table
--
DROP TABLE IF EXISTS `v_rekap_keuntungan`;
CREATE TABLE`v_rekap_keuntungan`(
    `periode` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `total_keuntungan` decimal(65,4) NOT NULL DEFAULT '0.0000'
);

-- --------------------------------------------------------

--
-- Structure for view `v_role` exported as a table
--
DROP TABLE IF EXISTS `v_role`;
CREATE TABLE`v_role`(
    `idrole` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_role` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_satuan_a` exported as a table
--
DROP TABLE IF EXISTS `v_satuan_a`;
CREATE TABLE`v_satuan_a`(
    `idsatuan` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_satuan` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` tinyint(4) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_satuan_t` exported as a table
--
DROP TABLE IF EXISTS `v_satuan_t`;
CREATE TABLE`v_satuan_t`(
    `idsatuan` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_satuan` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` tinyint(4) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_stok_barang` exported as a table
--
DROP TABLE IF EXISTS `v_stok_barang`;
CREATE TABLE`v_stok_barang`(
    `idbarang` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_barang` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `stok_terakhir` int(11) NOT NULL DEFAULT '0'
);

-- --------------------------------------------------------

--
-- Structure for view `v_user` exported as a table
--
DROP TABLE IF EXISTS `v_user`;
CREATE TABLE`v_user`(
    `iduser` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `username` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
    `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_role` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
    `idrole` char(3) COLLATE utf8mb4_unicode_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_vendor_a` exported as a table
--
DROP TABLE IF EXISTS `v_vendor_a`;
CREATE TABLE`v_vendor_a`(
    `idvendor` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_vendor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
    `badan_hukum` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure for view `v_vendor_t` exported as a table
--
DROP TABLE IF EXISTS `v_vendor_t`;
CREATE TABLE`v_vendor_t`(
    `idvendor` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
    `nama_vendor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
    `badan_hukum` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`idbarang`),
  ADD KEY `fk_barang_satuan` (`idsatuan`);

--
-- Indexes for table `detail_penerimaan`
--
ALTER TABLE `detail_penerimaan`
  ADD PRIMARY KEY (`iddetail_penerimaan`),
  ADD KEY `fk_detail_penerimaan_penerimaan` (`idpenerimaan`),
  ADD KEY `fk_detail_penerimaan_barang` (`barang_idbarang`);

--
-- Indexes for table `detail_pengadaan`
--
ALTER TABLE `detail_pengadaan`
  ADD PRIMARY KEY (`iddetail_pengadaan`),
  ADD KEY `fk_detail_pengadaan_barang` (`idbarang`),
  ADD KEY `fk_detail_pengadaan_pengadaan` (`idpengadaan`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`iddetail_penjualan`),
  ADD KEY `fk_detail_penjualan_penjualan` (`penjualan_idpenjualan`),
  ADD KEY `fk_detail_penjualan_barang` (`idbarang`);

--
-- Indexes for table `detail_retur`
--
ALTER TABLE `detail_retur`
  ADD PRIMARY KEY (`iddetail_retur`),
  ADD KEY `fk_detail_retur_retur` (`idretur`),
  ADD KEY `fk_detail_retur_penerimaan` (`iddetail_penerimaan`);

--
-- Indexes for table `kartu_stok`
--
ALTER TABLE `kartu_stok`
  ADD PRIMARY KEY (`idkartu_stok`),
  ADD KEY `fk_kartu_stok_barang` (`idbarang`);

--
-- Indexes for table `margin_penjualan`
--
ALTER TABLE `margin_penjualan`
  ADD PRIMARY KEY (`idmargin_penjualan`),
  ADD KEY `fk_margin_penjualan_user` (`iduser`);

--
-- Indexes for table `penerimaan`
--
ALTER TABLE `penerimaan`
  ADD PRIMARY KEY (`idpenerimaan`),
  ADD KEY `fk_penerimaan_pengadaan` (`idpengadaan`),
  ADD KEY `fk_penerimaan_user` (`iduser`);

--
-- Indexes for table `pengadaan`
--
ALTER TABLE `pengadaan`
  ADD PRIMARY KEY (`idpengadaan`),
  ADD KEY `fk_pengadaan_user` (`user_iduser`),
  ADD KEY `fk_pengadaan_vendor` (`vendor_idvendor`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`idpenjualan`),
  ADD KEY `fk_penjualan_user` (`iduser`),
  ADD KEY `fk_penjualan_margin` (`idmargin_penjualan`);

--
-- Indexes for table `retur`
--
ALTER TABLE `retur`
  ADD PRIMARY KEY (`idretur`),
  ADD KEY `fk_retur_penerimaan` (`idpenerimaan`),
  ADD KEY `fk_retur_user` (`iduser`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`idrole`);

--
-- Indexes for table `satuan`
--
ALTER TABLE `satuan`
  ADD PRIMARY KEY (`idsatuan`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `fk_user_role` (`idrole`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`idvendor`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kartu_stok`
--
ALTER TABLE `kartu_stok`
  MODIFY `idkartu_stok` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `fk_barang_satuan` FOREIGN KEY (`idsatuan`) REFERENCES `satuan` (`idsatuan`);

--
-- Constraints for table `detail_penerimaan`
--
ALTER TABLE `detail_penerimaan`
  ADD CONSTRAINT `fk_detail_penerimaan_barang` FOREIGN KEY (`barang_idbarang`) REFERENCES `barang` (`idbarang`),
  ADD CONSTRAINT `fk_detail_penerimaan_penerimaan` FOREIGN KEY (`idpenerimaan`) REFERENCES `penerimaan` (`idpenerimaan`);

--
-- Constraints for table `detail_pengadaan`
--
ALTER TABLE `detail_pengadaan`
  ADD CONSTRAINT `fk_detail_pengadaan_barang` FOREIGN KEY (`idbarang`) REFERENCES `barang` (`idbarang`),
  ADD CONSTRAINT `fk_detail_pengadaan_pengadaan` FOREIGN KEY (`idpengadaan`) REFERENCES `pengadaan` (`idpengadaan`);

--
-- Constraints for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `fk_detail_penjualan_barang` FOREIGN KEY (`idbarang`) REFERENCES `barang` (`idbarang`),
  ADD CONSTRAINT `fk_detail_penjualan_penjualan` FOREIGN KEY (`penjualan_idpenjualan`) REFERENCES `penjualan` (`idpenjualan`);

--
-- Constraints for table `detail_retur`
--
ALTER TABLE `detail_retur`
  ADD CONSTRAINT `fk_detail_retur_penerimaan` FOREIGN KEY (`iddetail_penerimaan`) REFERENCES `detail_penerimaan` (`iddetail_penerimaan`),
  ADD CONSTRAINT `fk_detail_retur_retur` FOREIGN KEY (`idretur`) REFERENCES `retur` (`idretur`);

--
-- Constraints for table `kartu_stok`
--
ALTER TABLE `kartu_stok`
  ADD CONSTRAINT `fk_kartu_stok_barang` FOREIGN KEY (`idbarang`) REFERENCES `barang` (`idbarang`);

--
-- Constraints for table `margin_penjualan`
--
ALTER TABLE `margin_penjualan`
  ADD CONSTRAINT `fk_margin_penjualan_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON UPDATE CASCADE;

--
-- Constraints for table `penerimaan`
--
ALTER TABLE `penerimaan`
  ADD CONSTRAINT `fk_penerimaan_pengadaan` FOREIGN KEY (`idpengadaan`) REFERENCES `pengadaan` (`idpengadaan`),
  ADD CONSTRAINT `fk_penerimaan_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`);

--
-- Constraints for table `pengadaan`
--
ALTER TABLE `pengadaan`
  ADD CONSTRAINT `fk_pengadaan_user` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`),
  ADD CONSTRAINT `fk_pengadaan_vendor` FOREIGN KEY (`vendor_idvendor`) REFERENCES `vendor` (`idvendor`);

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `fk_penjualan_margin` FOREIGN KEY (`idmargin_penjualan`) REFERENCES `margin_penjualan` (`idmargin_penjualan`),
  ADD CONSTRAINT `fk_penjualan_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`);

--
-- Constraints for table `retur`
--
ALTER TABLE `retur`
  ADD CONSTRAINT `fk_retur_penerimaan` FOREIGN KEY (`idpenerimaan`) REFERENCES `penerimaan` (`idpenerimaan`),
  ADD CONSTRAINT `fk_retur_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`idrole`) REFERENCES `role` (`idrole`);


--
-- Metadata
--
USE `phpmyadmin`;

--
-- Metadata for table barang
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table detail_penerimaan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table detail_pengadaan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table detail_penjualan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table detail_retur
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table kartu_stok
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table margin_penjualan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table penerimaan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table pengadaan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table penjualan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table retur
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table role
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table satuan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table user
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table vendor
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_barang_a
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_barang_t
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_keuntungan_penjualan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_margin_penjualan_a
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_margin_penjualan_t
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_penerimaan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_pengadaan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_rekap_keuntungan
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_role
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_satuan_a
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_satuan_t
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_stok_barang
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_user
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_vendor_a
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for table v_vendor_t
--

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
--
-- Metadata for database ProjekPBD_03
--

--
-- Truncate table before insert `pma__bookmark`
--

TRUNCATE TABLE `pma__bookmark`;
--
-- Truncate table before insert `pma__relation`
--

TRUNCATE TABLE `pma__relation`;
--
-- Truncate table before insert `pma__savedsearches`
--

TRUNCATE TABLE `pma__savedsearches`;
--
-- Truncate table before insert `pma__central_columns`
--

TRUNCATE TABLE `pma__central_columns`;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
