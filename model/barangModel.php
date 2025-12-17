<?php
require_once __DIR__ . '/../config/database.php';

class Barang
{
    private $conn;
    private $table = "v_barang_a";

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua data barang aktif
    public function getAllBarang1()
    {
        $sql = "SELECT * FROM v_barang_a ORDER BY idbarang";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil semua data barang tidak aktif
    public function getAllBarang0()
    {
        $sql = "SELECT * FROM v_barang_t ORDER BY idbarang";
        $result = $this->conn->query($sql);
        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil semua satuan aktif
    public function getAllSatuan1()
    {
        $sql = "SELECT * FROM v_satuan_a ORDER BY nama_satuan";
        $result = $this->conn->query($sql);
        $data = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        return $data;
    }

    // Tambah barang baru
    public function insertBarang($nama, $idsatuan, $harga)
    {
        $stmt = $this->conn->prepare("CALL insert_barang(?, ?, ?)");
        $stmt->bind_param("ssi", $nama, $idsatuan, $harga);
        return $stmt->execute();
    }

    // Ambil data satu barang
    public function getBarangById($idbarang)
    {
        $stmt = $this->conn->prepare("CALL getBarangById(?)");
        $stmt->bind_param("s", $idbarang);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }


    // Update barang
    public function updateBarang($idbarang, $nama, $idsatuan, $harga)
    {
        $stmt = $this->conn->prepare("CALL update_barang(?, ?, ?, ?)");
        $stmt->bind_param("sssi", $idbarang, $nama, $idsatuan, $harga);
        return $stmt->execute();
    }

    // Hapus barang (soft delete)
    public function deleteBarang($idbarang)
    {
        $stmt = $this->conn->prepare("CALL delete_barang(?)");
        $stmt->bind_param("s", $idbarang);
        return $stmt->execute();
    }


    // Aktifkan kembali barang
    public function activateBarang($idbarang)
    {
        $stmt = $this->conn->prepare("CALL activate_barang(?)");
        $stmt->bind_param("s", $idbarang);
        return $stmt->execute();
    }
}
