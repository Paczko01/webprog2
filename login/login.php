<?php
    if (isset($_POST["u"]) && isset($_POST["p"])){
        $conn = new mysqli('localhost', 'root', '172321613212331Gz', 'db_webprog');
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        $sql = "SET @p_usrName = '".$_POST["u"]."';";
        $conn->query($sql);
        
        $sql = "SET @p_pwd = '".$_POST["p"]."';";
        $conn->query($sql);
        
        $sql = "SET @p_result = '';";
        $conn->query($sql);
        
        $sql = "CALL Login(@p_usrName, @p_pwd, @p_result);";
        if( ! ($conn->multi_query($sql)))
            die( $conn->error );
        
        $sql = "SELECT @p_result;";
        $result = $conn->query($sql);
        echo $result->fetch_assoc()['@p_result'];

        $conn->close();
    }
?>