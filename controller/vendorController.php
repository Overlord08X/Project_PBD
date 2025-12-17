<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../model/vendorModel.php';

$vendor = new Vendor();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = $_POST['nama_vendor'];
    $badan_hukum = $_POST['badan_hukum'];
    $idvendor = $_POST['idvendor'] ?? null;

    if (isset($_POST['add'])) {
        $vendor->insertVendor($nama, $badan_hukum);
    } elseif (isset($_POST['edit'])) {
        $vendor->updateVendor($idvendor, $nama, $badan_hukum);
    }

    header("Location: ../master/vendor/index.php");
    exit;
}

if (isset($_GET['delete'])) {
    $vendor->deleteVendor($_GET['delete']);
    header("Location: ../master/vendor/index.php");
    exit;
}

if (isset($_GET['activate'])) {
    $vendor->activateVendor($_GET['activate']);
    header("Location: ../master/vendor/index.php?view=inactive");
    exit;
}
