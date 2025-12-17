<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/userModel.php';

$user = new User();

$dataRole = $user->getAllRole();
$iduser = $_GET['id'] ?? null;
$data = $iduser ? $user->getUserById($iduser) : null;
$action = $iduser ? 'edit' : 'add';
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4"><?= $iduser ? 'Edit User' : 'Tambah User'; ?></h2>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="../../controller/userController.php" method="POST">
                    <?php if ($iduser): ?>
                        <input type="hidden" name="iduser" value="<?= htmlspecialchars($data['iduser']); ?>">
                    <?php endif; ?>

                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control"
                            value="<?= htmlspecialchars($data['username'] ?? ''); ?>" maxlength="50" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><?= $iduser ? 'Password Baru (Kosongkan jika tidak diubah)' : 'Password'; ?></label>
                        <input type="password" name="password" class="form-control" <?= $iduser ? '' : 'required'; ?> maxlength="50">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Role</label>
                        <select name="idrole" class="form-select" required>
                            <option value="">-- Pilih Role --</option>
                            <?php foreach ($dataRole as $role): ?>
                                <option value="<?= $role['idrole']; ?>" <?= isset($data['idrole']) && $data['idrole'] === $role['idrole'] ? 'selected' : ''; ?>>
                                    <?= htmlspecialchars($role['nama_role']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
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