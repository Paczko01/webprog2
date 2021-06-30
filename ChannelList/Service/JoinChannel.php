<?php

if (isset($_POST["u"]) &&
    isset($_POST["p"]) &&
    isset($_POST["ch"]) &&
    isset($_POST["player"]))
{
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    $mysqli = new mysqli("localhost", $_POST["u"], $_POST["p"], "db_webprog");
    if ($mysqli->connect_error)
        die("Connection failed: " . $mysqli->connect_error);

    $sql = "SET @pChannel = ". $_POST["ch"]     .";";
    $mysqli->query($sql);

    $sql = "SET @pPlayer  = ". $_POST["player"] .";";
    $mysqli->query($sql);

    $mysqli->multi_query("CALL JoinChannel(@pChannel, @pPlayer)");

    $mysqli->close();
}

?>