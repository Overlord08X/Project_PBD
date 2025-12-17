<?php
require_once __DIR__ . '/../config/database.php';

class Vendor
{
    private $conn;
    private $table = "vendor";

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua vendor aktif
    public function getAllVendorA()
    {
        $sql = "SELECT * FROM v_vendor_a ORDER BY idvendor";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil semua vendor tidak aktif
    public function getAllVendorT()
    {
        $sql = "SELECT * FROM v_vendor_t ORDER BY idvendor";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil vendor berdasarkan ID
    public function getVendorById($idvendor)
    {
        $stmt = $this->conn->prepare("SELECT * FROM vendor WHERE idvendor = ?");
        $stmt->bind_param("s", $idvendor);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    // Tambah vendor baru
    public function insertVendor($nama, $badan_hukum)
    {
        $stmt = $this->conn->prepare("CALL insertVendor(?, ?)");
        $stmt->bind_param("ss", $nama, $badan_hukum);
        return $stmt->execute();
    }


    // Update vendor
    public function updateVendor($idvendor, $nama, $badan_hukum)
    {
        $stmt = $this->conn->prepare("CALL updateVendor(?, ?, ?)");
        $stmt->bind_param("sss", $idvendor, $nama, $badan_hukum);
        return $stmt->execute();
    }


    // Hapus vendor (soft delete)
    public function deleteVendor($idvendor)
    {
        $stmt = $this->conn->prepare("CALL setVendorStatus(?, 'T')");
        $stmt->bind_param("s", $idvendor);
        return $stmt->execute();
    }

    // Aktifkan kembali vendor
    public function activateVendor($idvendor)
    {
        $stmt = $this->conn->prepare("CALL setVendorStatus(?, 'A')");
        $stmt->bind_param("s", $idvendor);
        return $stmt->execute();
    }
}
