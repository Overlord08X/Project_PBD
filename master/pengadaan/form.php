<?php
session_start();

// Jika belum login → tolak
if (!isset($_SESSION['iduser'])) {
  header("Location: login.php");
  exit;
}

$idrole = $_SESSION['idrole'];

require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/pengadaanModel.php';
require_once __DIR__ . '/../../config/database.php';

$iduser = $_SESSION['iduser'];

$db = new Database();
$conn = $db->getConnection();

// vendor untuk pengadaan baru
$q_vendor = $conn->query("SELECT idvendor, nama_vendor FROM vendor ORDER BY nama_vendor ASC");

// barang
$q_barang = $conn->query("SELECT idbarang, nama FROM barang ORDER BY nama ASC");

?>

<div class="container mt-5">
    <h2 class="text-center mb-4">Tambah Detail Pengadaan</h2>

    <div class="card shadow-sm">
        <div class="card-body">
            <form action="../../controller/pengadaanController.php" method="POST">

                <input type="hidden" name="user_login" value="<?= $iduser ?>">

                <div class="mb-3">
                    <label class="form-label">Pilih Vendor</label>
                    <select class="form-select" name="vendor_selected" required>
                        <option value="">-- Pilih Vendor --</option>
                        <?php while ($v = $q_vendor->fetch_assoc()): ?>
                            <option value="<?= $v['idvendor'] ?>"><?= $v['nama_vendor'] ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Pilih Barang</label>
                    <select class="form-select" name="idbarang" required>
                        <option value="">-- Pilih Barang --</option>
                        <?php while ($b = $q_barang->fetch_assoc()): ?>
                            <option value="<?= $b['idbarang'] ?>"><?= $b['nama'] ?></option>
                        <?php endwhile; ?>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Jumlah</label>
                    <input type="number" name="jumlah" class="form-control" required>
                </div>

                <div class="text-end">
                    <button type="submit" name="insert_detail" class="btn btn-primary">Simpan Detail</button>
                    <a href="index.php" class="btn btn-secondary">Kembali</a>
                </div>

            </form>
        </div>
    </div>

</div>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>