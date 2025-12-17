<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

session_start();

require_once __DIR__ . '/../model/penerimaanModel.php';
require_once __DIR__ . '/../config/database.php';

$db = new Database();
$conn = $db->getConnection();
$penerimaan = new Penerimaan();

/*
|--------------------------------------------------------------------------
| INSERT DETAIL PENERIMAAN
|--------------------------------------------------------------------------
*/

if (isset($_POST['insert'])) {  // ← SUDAH DISESUAIKAN DENGAN FORM

    if (!isset($_SESSION['iduser'])) {
        die("ERROR: User belum login.");
    }

    $idpengadaan = $_POST['idpengadaan'];
    $barang = $_POST['barang_idbarang'];
    $jumlah = $_POST['jumlah_terima'];
    $harga = $_POST['harga_satuan_terima'];
    $iduser = $_SESSION['iduser']; 

    // Set variable trigger
    $penerimaan->prepareTriggerVars($idpengadaan, $iduser);

    // Insert detail penerimaan → penerimaan akan dibuat otomatis oleh trigger
    if (!$penerimaan->insertDetail($barang, $jumlah, $harga)) {
        die("Gagal insert: " . $conn->error);
    }

    header("Location: ../master/penerimaan/index.php?success=1");
    exit();
}

/*
|--------------------------------------------------------------------------
| DELETE PENERIMAAN
|--------------------------------------------------------------------------
*/

if (isset($_GET['delete'])) {
    $id = $_GET['delete'];
    $penerimaan->deletePenerimaan($id);

    header("Location: ../master/penerimaan/index.php?deleted=1");
    exit();
}

/*
|--------------------------------------------------------------------------
| DEFAULT
|--------------------------------------------------------------------------
*/

header("Location: ../master/penerimaan/index.php");
exit();
