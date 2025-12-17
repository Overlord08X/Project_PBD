<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/vendorModel.php';

$vendor = new Vendor();

// Cek apakah sedang melihat vendor aktif atau tidak aktif
$view = isset($_GET['view']) && $_GET['view'] === 'inactive' ? 'inactive' : 'active';
$dataVendor = $view === 'active' ? $vendor->getAllVendorA() : $vendor->getAllVendorT();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">
            Daftar Vendor <?= $view === 'active' ? 'Aktif' : 'Tidak Aktif'; ?>
        </h2>

        <div class="d-flex justify-content-between mb-3">
            <?php if ($view === 'active'): ?>
                <a href="form.php" class="btn btn-primary btn-sm">+ Tambah Vendor</a>
                <a href="?view=inactive" class="btn btn-secondary btn-sm">Lihat Semua</a>
            <?php else: ?>
                <a href="?view=active" class="btn btn-success btn-sm">Lihat Aktif</a>
            <?php endif; ?>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataVendor)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID Vendor</th>
                                    <th>Nama Vendor</th>
                                    <th>Badan Hukum</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataVendor as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= htmlspecialchars($row['idvendor']); ?></td>
                                        <td><?= htmlspecialchars($row['nama_vendor']); ?></td>
                                        <td><?= htmlspecialchars($row['badan_hukum']); ?></td>
                                        <td class="text-center">
                                            <?php if ($view === 'active'): ?>
                                                <a href="form.php?id=<?= $row['idvendor']; ?>" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="../../controller/vendorController.php?delete=<?= $row['idvendor']; ?>"
                                                    onclick="return confirm('Yakin ingin menonaktifkan vendor ini?');"
                                                    class="btn btn-danger btn-sm">Nonaktifkan</a>
                                            <?php else: ?>
                                                <a href="../../controller/vendorController.php?activate=<?= $row['idvendor']; ?>"
                                                    onclick="return confirm('Aktifkan kembali vendor ini?');"
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
                        Tidak ada data vendor <?= $view === 'active' ? 'aktif' : 'tidak aktif'; ?>.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>