<?php
require_once __DIR__ . '/../config/database.php';

class User
{
    private $conn;
    private $table = "v_user";

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua user
    public function getAllUser()
    {
        $sql = "SELECT * FROM v_user ORDER BY iduser";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil user by ID
    public function getUserById($iduser)
    {
        $stmt = $this->conn->prepare("CALL getUserById(?)");
        $stmt->bind_param("s", $iduser);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    // Ambil semua role
    public function getAllRole()
    {
        $sql = "SELECT * FROM v_role ORDER BY idrole";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Tambah user
    public function insertUser($username, $password, $idrole)
    {
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $this->conn->prepare("CALL insertUser(?, ?, ?)");
        $stmt->bind_param("sss", $username, $hashedPassword, $idrole);
        return $stmt->execute();
    }

    // Update user
    public function updateUser($iduser, $username, $password, $idrole)
    {
        $hashedPassword = $password ? password_hash($password, PASSWORD_DEFAULT) : null;
        $stmt = $this->conn->prepare("CALL updateUser(?, ?, ?, ?)");
        $stmt->bind_param("ssss", $iduser, $username, $hashedPassword, $idrole);
        return $stmt->execute();
    }

    // Hapus user
    public function deleteUser($iduser)
    {
        $stmt = $this->conn->prepare("CALL deleteUser(?)");
        $stmt->bind_param("s", $iduser);
        return $stmt->execute();
    }
}
