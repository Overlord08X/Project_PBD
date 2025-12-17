<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/roleModel.php';

$role = new Role();

$idrole = $_GET['id'] ?? null;
$data = $idrole ? $role->getRoleById($idrole) : null;
$action = $idrole ? 'edit' : 'add';
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4"><?= $idrole ? 'Edit Role' : 'Tambah Role'; ?></h2>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="../../controller/roleController.php" method="POST">
                    <?php if ($idrole): ?>
                        <input type="hidden" name="idrole" value="<?= $data['idrole']; ?>">
                    <?php endif; ?>

                    <div class="mb-3">
                        <label class="form-label">Nama Role</label>
                        <input type="text" name="nama_role" class="form-control"
                            value="<?= $data['nama_role'] ?? ''; ?>" required>
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