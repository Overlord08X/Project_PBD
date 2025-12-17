<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/roleModel.php';

$role = new Role();
$dataRole = $role->getAllRole();
?>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Daftar Role</h2>

        <div class="text-end mb-3">
            <a href="form.php" class="btn btn-primary btn-sm">+ Tambah Role</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <?php if (!empty($dataRole)): ?>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead class="table-primary">
                                <tr class="text-center">
                                    <th>ID Role</th>
                                    <th>Nama Role</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($dataRole as $row): ?>
                                    <tr>
                                        <td class="text-center"><?= htmlspecialchars($row['idrole']); ?></td>
                                        <td><?= htmlspecialchars($row['nama_role']); ?></td>
                                        <td class="text-center">
                                            <a href="form.php?id=<?= $row['idrole']; ?>" class="btn btn-warning btn-sm">Edit</a>
                                            <a href="../../controller/roleController.php?delete=<?= $row['idrole']; ?>"
                                                onclick="return confirm('Yakin ingin menghapus role ini?');"
                                                class="btn btn-danger btn-sm">Hapus</a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                <?php else: ?>
                    <div class="alert alert-warning text-center">
                        Tidak ada data role.
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</body>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>