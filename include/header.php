<?php
// include/header.php - Header dengan Bootstrap 5
?>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ProjekPBD - Master Data</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container-fluid">
      <a class="navbar-brand" href="/projekPBD/index.php">ProjekPBD</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item"><a class="nav-link" href="/projekPBD/logout.php">Logout</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/barang/index.php">Barang</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/satuan/index.php">Satuan</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/vendor/index.php">Vendor</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/user/index.php">User</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/role/index.php">Role</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/marginPenjualan/index.php">Margin Penjualan</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/pengadaan/index.php">Pengadaan</a></li>
          <li class="nav-item"><a class="nav-link" href="/projekPBD/master/penerimaan/index.php">Penerimaan</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container">