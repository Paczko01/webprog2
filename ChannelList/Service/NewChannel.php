<?php

if (isset($_POST["u"])      &&
    isset($_POST["p"])      &&
    isset($_POST["player"]) &&
    isset($_POST["chname"]))
{
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    $mysqli = new mysqli("localhost", $_POST["u"], $_POST["p"], "db_webprog");
    if ($mysqli->connect_error)
        die("Connection failed: " . $mysqli->connect_error);

    $sql = "SET @pPlayer  = ". $_POST["player"] .";";
    $mysqli->query($sql);
    
    $sql = "SET @chName  = '". $_POST["chname"] ."';";
    $mysqli->query($sql);

    $mysqli->multi_query("CALL OpenChannel(@pPlayer, @chName)");

    $mysqli->close();
}

?>