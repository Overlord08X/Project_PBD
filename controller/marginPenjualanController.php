<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../model/marginPenjualanModel.php';

$marginPenjualan = new MarginPenjualan();

// 🟢 sementara: tanpa login, iduser diisi default (misal: 001)
$iduser = '00001';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $persen = $_POST['persen'] ?? null;
    $idmargin_penjualan = $_POST['idmargin_penjualan'] ?? null;

    if (isset($_POST['add'])) {
        $marginPenjualan->insertMarginPenjualan($persen, $iduser);
    } elseif (isset($_POST['edit'])) {
        $marginPenjualan->updateMarginPenjualan($idmargin_penjualan, $persen);
    }

    header("Location: ../master/margin_penjualan/index.php");
    exit;
}

if (isset($_GET['delete'])) {
    $marginPenjualan->deleteMarginPenjualan($_GET['delete']);
    header("Location: ../master/margin_penjualan/index.php");
    exit;
}

if (isset($_GET['activate'])) {
    $marginPenjualan->activateMarginPenjualan($_GET['activate']);
    header("Location: ../master/margin_penjualan/index.php?view=inactive");
    exit;
}
