<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../model/barangModel.php';

$barang = new Barang();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = $_POST['nama_barang'];
    $idsatuan = $_POST['idsatuan'];
    $harga = $_POST['harga'];
    $idbarang = $_POST['idbarang'] ?? null;

    if (isset($_POST['add'])) {
        $barang->insertBarang($nama, $idsatuan, $harga);
    } elseif (isset($_POST['edit'])) {
        $barang->updateBarang($idbarang, $nama, $idsatuan, $harga);
    }

    header("Location: ../master/barang/index.php");
    exit;
}

if (isset($_GET['delete'])) {
    $barang->deleteBarang($_GET['delete']);
    header("Location: ../master/barang/index.php");
    exit;
}

if (isset($_GET['activate'])) {
    $barang->activateBarang($_GET['activate']);
    header("Location: ../master/barang/index.php?view=inactive");
    exit;
}
