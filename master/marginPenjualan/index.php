<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/marginPenjualanModel.php';

$marginPenjualan = new MarginPenjualan();

// Cek apakah sedang melihat data aktif atau tidak aktif
$view = isset($_GET['view']) && $_GET['view'] === 'inactive' ? 'inactive' : 'active';
$dataMarginPenjualan = $view === 'active'
    ? $marginPenjualan->getAllMarginPenjualan1()
    : $marginPenjualan->getAllMarginPenjualan0();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">
            Daftar Margin Penjualan <?= $view === 'active' ? 'Aktif' : 'Tidak Aktif'; ?>
        </h2>

        <div class="d-flex justify-content-between mb-3">
            <?php if ($view === 'active'): ?>
                <a href="form.php" class="btn btn-primary btn-sm">+ Tambah Margin Penjualan</a>
                <a href="?view=inactive" class="btn btn-secondary btn-sm">Lihat Semua</a>
            <?php else: ?>
                <a href="?view=active" class="btn btn-success btn-sm">Lihat Aktif</a>
            <?php endif; ?>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataMarginPenjualan)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID Margin Penjualan</th>
                                    <th>Persen Margin Penjualan (%)</th>
                                    <th>Dibuat Oleh</th>
                                    <th>Created At</th>
                                    <th>Updated At</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataMarginPenjualan as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= htmlspecialchars($row['idmargin_penjualan']); ?></td>
                                        <td class="text-center"><?= htmlspecialchars($row['persen']); ?>%</td>
                                        <td class="text-center"><?= htmlspecialchars($row['dibuat_oleh']); ?></td>
                                        <td class="text-center"><?= htmlspecialchars($row['created_at']); ?></td>
                                        <td class="text-center"><?= htmlspecialchars($row['updated_at']); ?></td>
                                        <td class="text-center">
                                            <?php if ($view === 'active'): ?>
                                                <a href="form.php?id=<?= $row['idmargin_penjualan']; ?>" class="btn btn-warning btn-sm">
                                                    Edit
                                                </a>
                                                <a href="../../controller/marginPenjualanController.php?delete=<?= $row['idmargin_penjualan']; ?>"
                                                    onclick="return confirm('Yakin ingin menonaktifkan margin penjualan ini?');"
                                                    class="btn btn-danger btn-sm">
                                                    Nonaktifkan
                                                </a>
                                            <?php else: ?>
                                                <a href="../../controller/marginPenjualanController.php?activate=<?= $row['idmargin_penjualan']; ?>"
                                                    onclick="return confirm('Aktifkan kembali margin penjualan ini?');"
                                                    class="btn btn-success btn-sm">
                                                    Aktifkan
                                                </a>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <div class="alert alert-warning text-center">
                        Tidak ada data margin penjualan <?= $view === 'active' ? 'aktif' : 'tidak aktif'; ?>.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>