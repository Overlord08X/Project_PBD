<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/satuanModel.php';

$satuan = new Satuan();

// Cek apakah sedang melihat satuan aktif atau tidak aktif
$view = isset($_GET['view']) && $_GET['view'] === 'inactive' ? 'inactive' : 'active';
$dataSatuan = $view === 'active' ? $satuan->getAllSatuan1() : $satuan->getAllSatuan0();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">
            Daftar Satuan <?= $view === 'active' ? 'Aktif' : 'Tidak Aktif'; ?>
        </h2>

        <div class="d-flex justify-content-between mb-3">
            <?php if ($view === 'active'): ?>
                <a href="form.php" class="btn btn-primary btn-sm">+ Tambah Satuan</a>
                <a href="?view=inactive" class="btn btn-secondary btn-sm">Lihat Semua</a>
            <?php else: ?>
                <a href="?view=active" class="btn btn-success btn-sm">Lihat Aktif</a>
            <?php endif; ?>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataSatuan)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID Satuan</th>
                                    <th>Nama Satuan</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataSatuan as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= htmlspecialchars($row['idsatuan']); ?></td>
                                        <td><?= htmlspecialchars($row['nama_satuan']); ?></td>
                                        <td class="text-center">
                                            <?php if ($view === 'active'): ?>
                                                <a href="form.php?id=<?= $row['idvendor']; ?>" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="../../controller/satuanController.php?delete=<?= $row['idsatuan']; ?>"
                                                    onclick="return confirm('Yakin ingin menonaktifkan satuan ini?');"
                                                    class="btn btn-danger btn-sm">Nonaktifkan</a>
                                            <?php else: ?>
                                                <a href="../../controller/satuanController.php?activate=<?= $row['idsatuan']; ?>"
                                                    onclick="return confirm('Aktifkan kembali satuan ini?');"
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
                        Tidak ada data satuan <?= $view === 'active' ? 'aktif' : 'tidak aktif'; ?>.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>