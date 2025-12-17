<?php
require_once __DIR__ . '/../config/database.php';

class Pengadaan
{
    private $conn;
    private $table = "v_pengadaan";

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua data dari view
    public function getAllPengadaan()
    {
        $sql = "SELECT * FROM v_pengadaan WHERE status = 'O' ORDER BY idpengadaan DESC";
        $result = $this->conn->query($sql);
        $data = [];

        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }

        return $data;
    }

    // Ambil pengadaan tunggal
    public function getPengadaanById($idpengadaan)
    {
        $stmt = $this->conn->prepare("CALL getPengadaanById(?)");
        $stmt->bind_param("i", $idpengadaan);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result ? $result->fetch_assoc() : null;
    }

    // Insert (CALL procedure)
    public function insertDetail($idpengadaan, $idbarang, $jumlah)
    {
        $query = "CALL insertDetailPengadaan(?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("isi", $idpengadaan, $idbarang, $jumlah);

        if (!$stmt->execute()) {
            throw new Exception("Gagal insert detail pengadaan: " . $stmt->error);
        }

        $stmt->close();
    }


    // Update status pengadaan
    public function updatePengadaan($idpengadaan, $status)
    {
        $stmt = $this->conn->prepare("CALL updatePengadaan(?, ?)");
        $stmt->bind_param("is", $idpengadaan, $status);
        return $stmt->execute();
    }

    // Soft delete
    public function deletePengadaan($idpengadaan)
    {
        $stmt = $this->conn->prepare("CALL deletePengadaan(?)");
        $stmt->bind_param("i", $idpengadaan);
        return $stmt->execute();
    }

    public function setContextVariables($user_login, $vendor_selected)
    {
        // pastikan connection ada
        if (!$this->conn) {
            throw new Exception("No DB connection");
        }

        // escape dan bungkus dengan kutip karena iduser/idvendor adalah CHAR
        $u = $this->conn->real_escape_string($user_login);
        $v = $this->conn->real_escape_string($vendor_selected);

        $this->conn->query("SET @user_login = '{$u}'");
        $this->conn->query("SET @vendor_selected = '{$v}'");
    }
}
