<?php
    if (isset($_POST["u"]) && isset($_POST["p"])){
        $conn = new mysqli('localhost', 'outsider', 'outsider', 'db_webprog');
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        $sql = "CALL ";
        $result = $conn->query($sql)->fetch_assoc()['count'];
        
        echo $result;

        $conn->close();
    }
?>