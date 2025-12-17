<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/penerimaanModel.php';

$penerimaan = new Penerimaan();
$dataPenerimaan = $penerimaan->getAllPenerimaan();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Daftar Penerimaan</h2>

        <div class="text-end mb-3">
            <a href="form.php" class="btn btn-primary btn-sm">+ Tambah Penerimaan</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataPenerimaan)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary text-center">
                                <tr>
                                    <th>ID</th>
                                    <th>Tanggal</th>
                                    <th>Pengadaan</th>
                                    <th>Vendor</th>
                                    <th>Barang</th>
                                    <th>Jumlah</th>
                                    <th>Harga</th>
                                    <th>Subtotal</th>
                                    <th>User</th>
                                    <th>Total Nilai</th>
                                    <th>Status</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataPenerimaan as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= htmlspecialchars($row['idpenerimaan']); ?></td>
                                        <td><?= htmlspecialchars($row['tanggal_penerimaan']); ?></td>
                                        <td class="text-center"><?= htmlspecialchars($row['idpengadaan']); ?></td>
                                        <td><?= htmlspecialchars($row['nama_vendor']); ?></td>
                                        <td><?= $row['nama_barang']; ?></td>
                                        <td class="text-center"><?= $row['jumlah_terima']; ?></td>
                                        <td class="text-end"><?= $row['harga_satuan_terima']; ?></td>
                                        <td class="text-end"><?= $row['sub_total_terima']; ?></td>
                                        <td><?= htmlspecialchars($row['nama_user']); ?></td>
                                        <td class="text-end"><?= number_format($row['total_nilai'], 0, ',', '.'); ?></td>
                                        <td class="text-center">
                                            <span class="badge 
                                                <?= $row['status'] == 'S' ? 'bg-secondary' : ($row['status'] == 'D' ? 'bg-warning' : 'bg-success'); ?>">
                                                <?= $row['keterangan_status']; ?>
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <a href="form.php?id=<?= $row['idpenerimaan']; ?>" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="../../controller/penerimaanController.php?delete=<?= $row['idpenerimaan']; ?>"
                                                onclick="return confirm('Yakin ingin menghapus data ini?');"
                                                class="btn btn-danger btn-sm">Hapus</a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <div class="alert alert-warning text-center">
                        Tidak ada data penerimaan.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>