<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/barangModel.php';

$barang = new Barang();
$satuanList = $barang->getAllSatuan1();

$idbarang = $_GET['id'] ?? null;
$data = $idbarang ? $barang->getBarangById($idbarang) : null;
$action = $idbarang ? 'edit' : 'add';
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4"><?= $idbarang ? 'Edit Barang' : 'Tambah Barang'; ?></h2>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="../../controller/barangController.php" method="POST">
                    <?php if ($idbarang): ?>
                        <input type="hidden" name="idbarang" value="<?= $data['idbarang']; ?>">
                    <?php endif; ?>

                    <div class="mb-3">
                        <label class="form-label">Nama Barang</label>
                        <input type="text" name="nama_barang" class="form-control"
                            value="<?= $data['nama'] ?? ''; ?>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Satuan</label>
                        <select name="idsatuan" class="form-select" required>
                            <option value="">-- Pilih Satuan --</option>
                            <?php foreach ($satuanList as $satuan): ?>
                                <option value="<?= $satuan['idsatuan']; ?>"
                                    <?= isset($data['idsatuan']) && $data['idsatuan'] === $satuan['idsatuan'] ? 'selected' : ''; ?>>
                                    <?= htmlspecialchars($satuan['nama_satuan']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Harga</label>
                        <input type="number" name="harga" class="form-control"
                            value="<?= $data['harga'] ?? ''; ?>" required>
                    </div>

                    <div class="text-end">
                        <button type="submit" name="<?= $action; ?>" class="btn btn-success">Simpan</button>
                        <a href="index.php" class="btn btn-secondary">Kembali</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>