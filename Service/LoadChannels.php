<?php

if(isset($_POST["u"]) && isset($_POST["p"]))
{
    $conn = new mysqli("localhost", $_POST["u"], $_POST["p"]);
    if ($conn->connect_error)
    {
        die("Connection failed: " . $conn->connect_error);
    }

    //List all non-empty channels
    $sql = "SELECT *
            FROM `db_webprog`.`channels`
            WHERE `status` <> 'e'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0)
    {
        $response = [];
        $index = 0;
        /*$row = $result->fetch_assoc();
        $response[$index++] = array(
            "Id"          => $row["Id"],
            "name"        => $row["name"],
            "player_1_ID" => $row["player_1_ID"],
            "player_2_ID" => $row["player_2_ID"]);*/

        while($row = $result->fetch_assoc())
        {
            $response[$index++] = array(
                "Id"          => $row["Id"],
                "name"        => $row["name"],
                "player_1_ID" => $row["player_1_ID"],
                "player_2_ID" => $row["player_2_ID"],
                "status"      => $row["status"]);
        }
        echo json_encode($response);
    }
    else
    {
        echo "0 results";
    }

    $conn->close();
}

?>