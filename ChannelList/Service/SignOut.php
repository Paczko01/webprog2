<?php

if ( isset($_POST["u"]) ){
    $conn = new mysqli('localhost', 'root', '172321613212331Gz', 'db_webprog');
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $sql = "SET @p_usrName = '".$_POST["u"]."';";
    $conn->query($sql);
    
    $sql = "CALL Logout(@p_usrName);";
    if( ! ($conn->multi_query($sql)))
        die( $conn->error );

    $conn->close();
}

?>