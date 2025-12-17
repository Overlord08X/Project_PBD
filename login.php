<?php
session_start();
require_once __DIR__ . '/config/database.php';

// buat koneksi
$db = new Database();
$conn = $db->getConnection();

$error = "";

if (isset($_POST['username']) && isset($_POST['password'])) {

    $username = $_POST['username'];
    $password = $_POST['password'];

    // Query login
    $stmt = $conn->prepare("SELECT * FROM user WHERE username = ? AND password = ?");
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();

    $result = $stmt->get_result();

    if ($result && $result->num_rows === 1) {
        $data = $result->fetch_assoc();

        // simpan session
        $_SESSION['iduser'] = $data['iduser'];
        $_SESSION['username'] = $data['username'];
        $_SESSION['idrole'] = $data['idrole'];

        header("Location: dashboard.php");
        exit;
    } else {
        $error = "Username atau password salah!";
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial;
            background: #f1f1f1;
        }

        .box {
            width: 300px;
            margin: 140px auto;
            background: #fff;
            padding: 70px;
            border-radius: 10px;
        }

        input,
        button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
        }

        button {
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

    <div class="box">
        <h3 align="center">Login</h3>

        <?php if ($error): ?>
            <div class="error"><?= $error ?></div>
        <?php endif; ?>

        <form method="POST">
            <input type="text" name="username" placeholder="Username" required autocomplete="off">
            <input type="password" name="password" placeholder="Password" required autocomplete="off">
            <button type="submit">Masuk</button>
        </form>
    </div>

</body>

</html>