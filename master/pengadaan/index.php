<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/pengadaanModel.php';

$pengadaan = new Pengadaan();
$dataPengadaan = $pengadaan->getAllPengadaan();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Daftar Pengadaan</h2>

        <div class="text-end mb-3">
            <a href="form.php" class="btn btn-primary btn-sm">+ Tambah Pengadaan</a>
        </div>

        <?php if (isset($_GET['success'])): ?>
            <div class="alert alert-success text-center">
                Data berhasil <?= htmlspecialchars($_GET['success']); ?>.
            </div>
        <?php elseif (isset($_GET['error'])): ?>
            <div class="alert alert-danger text-center">
                Terjadi kesalahan saat <?= htmlspecialchars($_GET['error']); ?> data.
            </div>
        <?php endif; ?>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataPengadaan)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>Tanggal</th>
                                    <th>User</th>
                                    <th>Vendor</th>
                                    <th>Barang</th>
                                    <th>Harga Satuan</th>
                                    <th>Jumlah</th>
                                    <th>Subtotal</th>
                                    <th>PPN</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataPengadaan as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= $row['idpengadaan']; ?></td>
                                        <td><?= $row['tanggal_pengadaan']; ?></td>
                                        <td><?= $row['nama_user']; ?></td>
                                        <td><?= $row['nama_vendor']; ?></td>
                                        <td><?= $row['barang']; ?></td>
                                        <td class="text-end"><?= number_format($row['harga_satuan'], 0, ',', '.'); ?></td>
                                        <td class="text-center"><?= $row['jumlah']; ?></td>
                                        <td class="text-end"><?= number_format($row['subtotal_nilai'], 0, ',', '.'); ?></td>
                                        <td class="text-end"><?= number_format($row['ppn'], 0, ',', '.'); ?></td>
                                        <td class="text-end"><?= number_format($row['total_nilai'], 0, ',', '.'); ?></td>
                                        <td class="text-center">
                                            <span class="badge bg-<?= $row['status'] == 'F' ? 'success' : ($row['status'] == 'O' ? 'warning' : 'secondary'); ?>">
                                                <?= $row['keterangan_status']; ?>
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <a href="form.php?id=<?= $row['idpengadaan']; ?>" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="../../controller/pengadaanController.php?delete=<?= $row['idpengadaan']; ?>"
                                                onclick="return confirm('Yakin ingin menghapus pengadaan ini?');"
                                                class="btn btn-danger btn-sm">Hapus</a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <div class="alert alert-warning text-center">
                        Tidak ada data pengadaan.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>