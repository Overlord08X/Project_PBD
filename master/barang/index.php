<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/barangModel.php';

$barang = new Barang();

// Cek apakah sedang melihat barang aktif atau tidak aktif
$view = isset($_GET['view']) && $_GET['view'] === 'inactive' ? 'inactive' : 'active';
$dataBarang = $view === 'active' ? $barang->getAllBarang1() : $barang->getAllBarang0();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">
            Daftar Barang <?= $view === 'active' ? 'Aktif' : 'Tidak Aktif'; ?>
        </h2>

        <div class="d-flex justify-content-between mb-3">
            <?php if ($view === 'active'): ?>
                <a href="form.php" class="btn btn-primary btn-sm">+ Tambah Barang</a>
                <a href="?view=inactive" class="btn btn-secondary btn-sm">Lihat Semua</a>
            <?php else: ?>
                <a href="?view=active" class="btn btn-success btn-sm">Lihat Aktif</a>
            <?php endif; ?>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataBarang)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID Barang</th>
                                    <th>Nama Barang</th>
                                    <th>Nama Satuan</th>
                                    <th>Harga</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataBarang as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= htmlspecialchars($row['idbarang']); ?></td>
                                        <td><?= htmlspecialchars($row['nama_barang']); ?></td>
                                        <td><?= htmlspecialchars($row['nama_satuan']); ?></td>
                                        <td class="text-end">Rp <?= number_format($row['harga'], 0, ',', '.'); ?></td>
                                        <td class="text-center">
                                            <?php if ($view === 'active'): ?>
                                                <a href="form.php?id=<?= $row['idbarang']; ?>" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="../../controller/barangController.php?delete=<?= $row['idbarang']; ?>"
                                                    onclick="return confirm('Yakin ingin menonaktifkan barang ini?');"
                                                    class="btn btn-danger btn-sm">Nonaktifkan</a>
                                            <?php else: ?>
                                                <a href="../../controller/barangController.php?activate=<?= $row['idbarang']; ?>"
                                                    onclick="return confirm('Aktifkan kembali barang ini?');"
                                                    class="btn btn-success btn-sm">Aktifkan</a>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <div class="alert alert-warning text-center">
                        Tidak ada data barang aktif <?= $view === 'active' ? 'aktif' : 'tidak aktif'; ?>.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>