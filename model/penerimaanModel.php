<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/../config/database.php';

class Penerimaan
{
    private $conn;
    private $table = "v_penerimaan";

    public function __construct()
    {
        $db = new Database();
        $this->conn = $db->getConnection();
    }

    // Ambil semua data penerimaan
    public function getAllPenerimaan()
    {
        $sql = "SELECT * FROM {$this->table} WHERE status = 'S' ORDER BY tanggal_penerimaan DESC";
        $result = $this->conn->query($sql);

        $data = [];
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
        }
        return $data;
    }

    // Ambil penerimaan berdasarkan ID
    public function getPenerimaanById($idpenerimaan)
    {
        $stmt = $this->conn->prepare("CALL getPenerimaanById(?)");
        $stmt->bind_param("i", $idpenerimaan);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    // Tambah penerimaan baru
    public function insertDetail($barang, $jumlah, $harga)
    {
        // Query yang benar
        $stmt = $this->conn->prepare("
        INSERT INTO detail_penerimaan(
            barang_idbarang,
            jumlah_terima,
            harga_satuan_terima
        ) VALUES (?, ?, ?)
    ");

        // Bind parameter sesuai tipe data
        $stmt->bind_param("sii", $barang, $jumlah, $harga);

        return $stmt->execute();
    }


    // Update penerimaan
    public function updatePenerimaan($idpenerimaan, $status)
    {
        $stmt = $this->conn->prepare("CALL updatePenerimaan(?, ?)");
        $stmt->bind_param("is", $idpenerimaan, $status);
        return $stmt->execute();
    }

    // Hapus penerimaan
    public function deletePenerimaan($idpenerimaan)
    {
        $stmt = $this->conn->prepare("CALL deletePenerimaan(?)");
        $stmt->bind_param("i", $idpenerimaan);
        return $stmt->execute();
    }

    // Set variable session untuk trigger
    public function prepareTriggerVars($idpengadaan, $iduser)
    {
        $this->conn->query("SET @idpengadaan_selected = {$idpengadaan}");
        $this->conn->query("SET @iduser_login = '{$iduser}'");
    }
}
