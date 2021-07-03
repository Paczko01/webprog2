<?php

if ( isset( $_POST["n"] ) &&
     isset( $_POST["e"] ) &&
     isset( $_POST["u"] ) &&
     isset( $_POST["p"] ) )
{
    echo $_POST["u"];

    $mysqli = new mysqli('localhost', 'root', '172321613212331Gz', 'db_webprog');
    if ($mysqli->connect_error) {
        die("connection failed: " . $mysqli->connect_error);
    }

    $sql = "SET @p_result = '';\n";
    $mysqli->query($sql);

    $sql = "CALL Register('".$_POST["e"]."', '
                           ".$_POST["n"]."', '
                           ".$_POST["u"]."', '
                           ".$_POST["p"]."', @p_result)";
    if( ! ($result = $mysqli->multi_query($sql)) )
        die( $mysqli->error );

    $sql = "SELECT @p_result;";
    $result = $mysqli->query($sql);

    $response = '';
    $row = $result->fetch_assoc();
    if( $row != NULL )
    {
        if( isset($row['Email']) )
            $response += 'Email';
        
        if( isset($row['username']) )
            $response += 'username';
    }

    echo $response;

    $mysqli->close();
}

?>