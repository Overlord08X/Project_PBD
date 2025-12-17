<?php
require_once __DIR__ . '/../config/database.php';

class MarginPenjualan
{
    private $conn;

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua margin penjualan aktif
    public function getAllMarginPenjualan1()
    {
        $sql = "SELECT * FROM v_margin_penjualan_a ORDER BY idmargin_penjualan";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            $result->free_result();
        }
        return $data;
    }

    // Ambil semua margin penjualan tidak aktif
    public function getAllMarginPenjualan0()
    {
        $sql = "SELECT * FROM v_margin_penjualan_t ORDER BY idmargin_penjualan";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            $result->free_result();
        }
        return $data;
    }

    // Ambil satu margin penjualan
    public function getMarginPenjualanById($id)
    {
        $stmt = $this->conn->prepare("CALL getMarginPenjualanById(?)");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_assoc();
        $stmt->close();
        $this->conn->next_result(); // penting!
        return $data;
    }

    // Insert margin penjualan baru
    public function insertMarginPenjualan($persen, $iduser)
    {
        $stmt = $this->conn->prepare("CALL insertMarginPenjualan(?, ?)");
        // ganti 'i' jadi 's' jika iduser VARCHAR
        $stmt->bind_param("ds", $persen, $iduser);
        $success = $stmt->execute();
        $stmt->close();
        $this->conn->next_result();
        return $success;
    }

    // Update margin penjualan
    public function updateMarginPenjualan($idmargin_penjualan, $persen)
    {
        $stmt = $this->conn->prepare("CALL updateMarginPenjualan(?, ?)");
        $stmt->bind_param("id", $idmargin_penjualan, $persen);
        $success = $stmt->execute();
        $stmt->close();
        $this->conn->next_result();
        return $success;
    }

    // Ubah status aktif/tidak aktif (soft delete)
    public function setMarginPenjualanStatus($idmargin_penjualan, $status)
    {
        $stmt = $this->conn->prepare("CALL setMarginPenjualanStatus(?, ?)");
        $stmt->bind_param("ii", $idmargin_penjualan, $status);
        $success = $stmt->execute();
        $stmt->close();
        $this->conn->next_result();
        return $success;
    }

    // Shortcut
    public function deleteMarginPenjualan($id)
    {
        return $this->setMarginPenjualanStatus($id, 0);
    }

    public function activateMarginPenjualan($id)
    {
        return $this->setMarginPenjualanStatus($id, 1);
    }
}
