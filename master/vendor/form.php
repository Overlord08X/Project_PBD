<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/vendorModel.php';

$vendor = new Vendor();

$idvendor = $_GET['id'] ?? null;
$data = $idvendor ? $vendor->getVendorById($idvendor) : null;
$action = $idvendor ? 'edit' : 'add';
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4"><?= $idvendor ? 'Edit Vendor' : 'Tambah Vendor'; ?></h2>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="../../controller/vendorController.php" method="POST">
                    <?php if ($idvendor): ?>
                        <input type="hidden" name="idvendor" value="<?= $data['idvendor']; ?>">
                    <?php endif; ?>

                    <div class="mb-3">
                        <label class="form-label">Nama Vendor</label>
                        <input type="text" name="nama_vendor" class="form-control"
                            value="<?= $data['nama_vendor'] ?? ''; ?>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Badan Hukum</label>
                        <input type="text" name="badan_hukum" class="form-control"
                            value="<?= $data['badan_hukum'] ?? ''; ?>" required>
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