<?php
require_once __DIR__ . '/../model/roleModel.php';

$role = new Role();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama_role = $_POST['nama_role'];
    $idrole = $_POST['idrole'];

    if (isset($_POST['add'])) {
        $role->insertRole($nama_role);
    } elseif (isset($_POST['edit'])) {
        $role->updateRole($idrole, $nama_role);
    }

    header("Location: ../master/role/index.php");
    exit;
}

if (isset($_GET['delete'])) {
    $role->deleteRole($_GET['delete']);
    header("Location: ../master/role/index.php");
    exit;
}
