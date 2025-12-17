<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/userModel.php';

$user = new User();
$dataUser = $user->getAllUser();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Daftar User</h2>

        <div class="text-end mb-3">
            <a href="form.php" class="btn btn-primary btn-sm">+ Tambah User</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataUser)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID User</th>
                                    <th>Username</th>
                                    <th>Nama Role</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataUser as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= htmlspecialchars($row['iduser']); ?></td>
                                        <td><?= htmlspecialchars($row['username']); ?></td>
                                        <td><?= htmlspecialchars($row['nama_role']); ?></td>
                                        <td class="text-center">
                                            <a href="form.php?id=<?= $row['iduser']; ?>" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="../../controller/userController.php?delete=<?= $row['iduser']; ?>"
                                                onclick="return confirm('Yakin ingin menghapus user ini?');"
                                                class="btn btn-danger btn-sm">Hapus</a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <div class="alert alert-warning text-center">
                        Tidak ada data user aktif.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>