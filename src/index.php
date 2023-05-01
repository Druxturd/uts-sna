<?php
$host = getenv('DB_HOST');
$user = getenv('DB_USER');
$password = getenv('DB_PASSWORD');
$dbName = getenv('DB_NAME');

$conn = new mysqli($host, $user, $password, $dbName);

if(!$conn->connect_error){
    $q = "SELECT * FROM users";
    $res = $conn->query($q);

    if($res->num_rows > 0){
        echo "<table><tr><th>ID</th><th>Nama</th><th>Alamat</th><th>Jabatan</th></tr>";

        while($row = $res->fetch_assoc()){
            echo "<tr><td>".$row["ID"]."</td><td>".$row["Nama"]."</td><td>".$row["Alamat"]."</td><td>".$row["Jabatan"]."</td></tr>";
        }

        echo "</table>";
    } else {
        echo "no data";
    }

    $conn->close();
}
?>
