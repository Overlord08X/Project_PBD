<?php
require_once __DIR__ . '/../config/database.php';

class Role
{
    private $conn;
    private $table = "v_role";

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua data role
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

    // Ambil role berdasarkan ID
    public function getRoleById($idrole)
    {
        $stmt = $this->conn->prepare("CALL getRoleById(?)");
        $stmt->bind_param("s", $idrole);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    // Tambah role baru
    public function insertRole($nama_role)
    {
        $stmt = $this->conn->prepare("CALL insertRole(?)");
        $stmt->bind_param("s", $nama_role);
        return $stmt->execute();
    }

    // Update role
    public function updateRole($idrole, $nama_role)
    {
        $stmt = $this->conn->prepare("CALL updateRole(?, ?)");
        $stmt->bind_param("ss", $idrole, $nama_role);
        return $stmt->execute();
    }

    // Hapus role (hard delete)
    public function deleteRole($idrole)
    {
        $stmt = $this->conn->prepare("CALL deleteRole(?)");
        $stmt->bind_param("s", $idrole);
        return $stmt->execute();
    }
}
