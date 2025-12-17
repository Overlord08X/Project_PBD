<?php
require_once __DIR__ . '/../../include/header.php';
require_once __DIR__ . '/../../model/marginPenjualanModel.php';

$marginPenjualan = new MarginPenjualan();
$data = null;

if (isset($_GET['id'])) {
    $data = $marginPenjualan->getMarginPenjualanById($_GET['id']);
}
?>

<div class="container mt-5">
    <h3 class="text-center mb-4">
        <?= !empty($data) ? "Edit Margin Penjualan" : "Tambah Margin Penjualan"; ?>
    </h3>

    <form action="../../controller/marginPenjualanController.php" method="POST" class="card p-4 shadow-sm">
        <?php if (!empty($data)): ?>
            <input type="hidden" name="idmargin_penjualan" value="<?= htmlspecialchars($data['idmargin_penjualan']); ?>">
        <?php endif; ?>

        <div class="mb-3">
            <label for="persen" class="form-label">Persen Margin Penjualan (%)</label>
            <input type="number" step="0.01" min="0" name="persen" id="persen"
                value="<?= !empty($data) ? htmlspecialchars($data['persen']) : ''; ?>"
                class="form-control" required>
        </div>

        <div class="text-end">
            <button type="submit" name="<?= !empty($data) ? 'edit' : 'add'; ?>" class="btn btn-success">
                <?= !empty($data) ? 'Update' : 'Tambah'; ?>
            </button>
            <a href="index.php" class="btn btn-secondary">Batal</a>
        </div>
    </form>
</div>

<?php require_once __DIR__ . '/../../include/footer.php'; ?>