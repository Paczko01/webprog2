<?php

    if (isset($_POST["u"]) &&
    	isset($_POST["p"]) &&
    	isset($_POST["ch"]) &&
    	isset($_POST["player"]))
    {
        $conn = new mysqli('localhost', $_POST["u"], $_POST["p"], 'db_webprog');
        if ($conn->connect_error){
            die("Connection failed: " . $conn->connect_error);
        }

        $sql = "DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;";
        $conn->query($sql);
        $sql = "START TRANSACTION;";
        $conn->query($sql);
        $sql = "UPDATE `channels`
        SET `player_2_ID` = pl_Id,
            `status` = 's'
        WHERE `Id` = ch_Id;";
        $conn->query($sql);
        $sql = "COMMIT;";
        $conn->query($sql);

        $conn->close();
    }

?>