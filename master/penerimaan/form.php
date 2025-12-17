<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../config/database.php';

$db = new Database();
$conn = $db->getConnection();

// Ambil barang
$q_barang = $conn->query("SELECT idbarang, nama FROM barang WHERE status = 1 ORDER BY nama ASC");

// Ambil pengadaan
$q_pengadaan = $conn->query("SELECT idpengadaan FROM pengadaan ORDER BY idpengadaan ASC");

// Ambil user login (dari session)
session_start();
$iduser_login = $_SESSION['iduser'];
?>

<div class="container mt-5">
    <h2 class="mb-4">Tambah Penerimaan Barang</h2>

    <form action="../../controller/penerimaanController.php" method="POST">

        <div class="mb-3">
            <label>Barang</label>
            <select name="barang_idbarang" class="form-select" required>
                <option value="">-- Pilih Barang --</option>
                <?php while ($b = $q_barang->fetch_assoc()): ?>
                    <option value="<?= $b['idbarang']; ?>"><?= $b['nama']; ?></option>
                <?php endwhile; ?>
            </select>
        </div>

        <div class="mb-3">
            <label>Jumlah Terima</label>
            <input type="number" name="jumlah_terima" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Harga Satuan</label>
            <input type="number" name="harga_satuan_terima" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>ID Pengadaan</label>
            <select name="idpengadaan" class="form-select" required>
                <option value="">-- Pilih ID Pengadaan --</option>
                <?php while ($p = $q_pengadaan->fetch_assoc()): ?>
                    <option value="<?= $p['idpengadaan']; ?>"><?= $p['idpengadaan']; ?></option>
                <?php endwhile; ?>
            </select>
        </div>

        <input type="hidden" name="iduser" value="<?= $iduser_login ?>">

        <button type="submit" name="insert" class="btn btn-primary">Simpan</button>
        <a href="index.php" class="btn btn-secondary">Kembali</a>
    </form>
</div>
