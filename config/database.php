<?php
class Database
{
    private $host = "192.168.56.102";
    private $user = "admin";
    private $pass = "1234";
    private $dbname = "ProjekPBD_03";
    protected $conn;

    public function __construct()
    {
        $this->connect();
    }

    private function connect()
    {
        $this->conn = new mysqli($this->host, $this->user, $this->pass, $this->dbname);
        if ($this->conn->connect_error) {
            die("Koneksi gagal: " . $this->conn->connect_error);
        }
    }

    public function getConnection()
    {
        return $this->conn;
    }
}
