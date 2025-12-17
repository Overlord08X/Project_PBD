<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/satuanModel.php';

$satuan = new Satuan();

$idsatuan = $_GET['id'] ?? null;
$data = $idsatuan ? $satuan->getSatuanById($idsatuan) : null;
$action = $idsatuan ? 'edit' : 'add';
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4"><?= $idsatuan ? 'Edit Satuan' : 'Tambah Satuan'; ?></h2>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="../../controller/satuanController.php" method="POST">
                    <?php if ($idsatuan): ?>
                        <input type="hidden" name="idsatuan" value="<?= $data['idsatuan']; ?>">
                    <?php endif; ?>

                    <div class="mb-3">
                        <label class="form-label">Nama Satuan</label>
                        <input type="text" name="nama_satuan" class="form-control"
                            value="<?= $data['nama_satuan'] ?? ''; ?>" required>
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