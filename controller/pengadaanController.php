<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

session_start();
require_once __DIR__ . '/../model/pengadaanModel.php';

$pengadaan = new Pengadaan();

// =============== INSERT DETAIL PENGADAAN ===============
if (isset($_POST['insert_detail'])) {

    $idpengadaan     = 0; // biarkan 0 → biar trigger buat pengadaan baru
    $idbarang        = $_POST['idbarang'];
    $jumlah          = $_POST['jumlah'];

    // Variabel untuk trigger
    $user_login      = $_POST['user_login'];
    $vendor_selected = $_POST['vendor_selected'];

    try {

        // --- Set variabel trigger ---
        $pengadaan->setContextVariables($user_login, $vendor_selected);

        // --- Jalankan insert detail (trigger akan hitung subtotal, ppn, total) ---
        $pengadaan->insertDetail($idpengadaan, $idbarang, $jumlah);

        header("Location: ../master/pengadaan/index.php?success=ditambah");
        exit;

    } catch (Exception $e) {
        header("Location: ../master/pengadaan/index.php?error=" . urlencode($e->getMessage()));
        exit;
    }
}



// =============== HAPUS (SOFT DELETE) ===============
if (isset($_GET['delete'])) {

    $idpengadaan = $_GET['delete'];

    if ($pengadaan->deletePengadaan($idpengadaan)) {
        header("Location: ../master/pengadaan/index.php?success=dihapus");
        exit;
    } else {
        header("Location: ../master/pengadaan/index.php?error=gagal hapus");
        exit;
    }
}



// =============== UPDATE STATUS ===============
if (isset($_POST['update_status'])) {

    $idpengadaan = $_POST['idpengadaan'];
    $status      = $_POST['status'];  // contoh: '1' = selesai, '2' = pending

    if ($pengadaan->updatePengadaan($idpengadaan, $status)) {
        header("Location: ../master/pengadaan/index.php?success=status diupdate");
        exit;
    } else {
        header("Location: ../master/pengadaan/index.php?error=gagal update status");
        exit;
    }
}

?>
