<?php
require_once __DIR__ . '/../config/database.php';

class Satuan
{
    private $conn;
    private $table = "v_satuan_a";

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua data satuan aktif
    public function getAllSatuan1()
    {
        $sql = "SELECT * FROM  v_satuan_a ORDER BY idsatuan";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil semua data satuan tidak aktif
    public function getAllSatuan0()
    {
        $sql = "SELECT * FROM  v_satuan_t ORDER BY idsatuan";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil data satu satuan berdasarkan ID
    public function getSatuanById($idsatuan)
    {
        $stmt = $this->conn->prepare("CALL getSatuanById(?)");
        $stmt->bind_param("s", $idsatuan);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }


    // Tambah satuan baru
    public function insertSatuan($nama)
    {
        $stmt = $this->conn->prepare("CALL insert_satuan(?)");
        $stmt->bind_param("s", $nama);
        return $stmt->execute();
    }

    // Update satuan
    public function updateSatuan($idsatuan, $nama)
    {
        $stmt = $this->conn->prepare("CALL update_satuan(?, ?)");
        $stmt->bind_param("ss", $idsatuan, $nama);
        return $stmt->execute();
    }


    // Hapus satuan (soft delete)
    public function deleteSatuan($idsatuan)
    {
        $stmt = $this->conn->prepare("CALL delete_satuan(?)");
        $stmt->bind_param("s", $idsatuan);
        return $stmt->execute();
    }

    // Aktifkan kembali satuan
    public function activateSatuan($idsatuan)
    {
        $stmt = $this->conn->prepare("CALL activate_satuan(?)");
        $stmt->bind_param("s", $idsatuan);
        return $stmt->execute();
    }
}
