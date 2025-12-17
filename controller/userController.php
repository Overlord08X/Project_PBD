<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../model/userModel.php';

$user = new User();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'] ?? null;
    $idrole = $_POST['idrole'];
    $iduser = $_POST['iduser'] ?? null;

    if (isset($_POST['add'])) {
        $user->insertUser($username, $password, $idrole);
    } elseif (isset($_POST['edit'])) {
        $user->updateUser($iduser, $username, $password, $idrole);
    }

    header("Location: ../master/user/index.php");
    exit;
}

if (isset($_GET['delete'])) {
    $user->deleteUser($_GET['delete']);
    header("Location: ../master/user/index.php");
    exit;
}
