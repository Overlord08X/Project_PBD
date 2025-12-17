<?php
session_start();

// Jika belum login → tolak
if (!isset($_SESSION['iduser'])) {
  header("Location: login.php");
  exit;
}

$idrole = $_SESSION['idrole'];

require_once __DIR__ . '/include/header.php';
require_once __DIR__ . '/config/database.php';

// Inisialisasi koneksi
$db = new Database();
$conn = $db->getConnection();

// Query ambil stok barang
$q_stok = $conn->query("SELECT * FROM v_stok_barang ORDER BY nama_barang ASC");

// Query ambil rekap keuntungan
$q_rekap = $conn->query("SELECT * FROM v_rekap_keuntungan");
?>

<div class="card mb-4">
  <div class="card-body">
    <h3 class="mb-3">📊 Dashboard - Data Master</h3>
    <p>Pilih menu di navigasi untuk mengelola data master.</p>

    <h4 class="mt-4">📦 Stok Barang</h4>
    <div class="table-responsive">
      <table class="table table-bordered table-striped align-middle mt-2">
        <thead class="table-primary">
          <tr>
            <th>ID Barang</th>
            <th>Nama Barang</th>
            <th>Stok Terakhir</th>
          </tr>
        </thead>
        <tbody>
          <?php while ($row = $q_stok->fetch_assoc()) { ?>
            <tr>
              <td><?= htmlspecialchars($row['idbarang']) ?></td>
              <td><?= htmlspecialchars($row['nama_barang']) ?></td>
              <td><?= htmlspecialchars($row['stok_terakhir']) ?></td>
            </tr>
          <?php } ?>
        </tbody>
      </table>
    </div>

    <h4 class="mt-5">💰 Rekap Keuntungan</h4>
    <div class="table-responsive">
      <table class="table table-bordered table-striped align-middle mt-2">
        <thead class="table-success">
          <tr>
            <th>Periode</th>
            <th>Total Keuntungan</th>
          </tr>
        </thead>
        <tbody>
          <?php while ($rekap = $q_rekap->fetch_assoc()) { ?>
            <tr>
              <td><?= htmlspecialchars($rekap['periode']) ?></td>
              <td><?= number_format($rekap['total_keuntungan'], 0, ',', '.') ?></td>
            </tr>
          <?php } ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<?php require_once __DIR__ . '/include/footer.php'; ?>