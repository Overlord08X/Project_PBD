<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../model/satuanModel.php';

$satuan = new Satuan();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = $_POST['nama_satuan'];
    $idsatuan = $_POST['idsatuan'] ?? null;

    if (isset($_POST['add'])) {
        $satuan->insertSatuan($nama);
    } elseif (isset($_POST['edit'])) {
        $satuan->updateSatuan($idsatuan, $nama);
    }

    header("Location: ../master/satuan/index.php");
    exit;
}

if (isset($_GET['delete'])) {
    $satuan->deleteSatuan($_GET['delete']);
    header("Location: ../master/satuan/index.php");
    exit;
}

if (isset($_GET['activate'])) {
    $satuan->activateSatuan($_GET['activate']);
    header("Location: ../master/satuan/index.php?view=inactive");
    exit;
}
