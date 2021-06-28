<?php

if(isset($_POST["u"]) && isset($_POST["p"]))
{
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    $mysqli = new mysqli("localhost", $_POST["u"], $_POST["p"], "db_webprog");
    if ($mysqli->connect_error)
        die("Connection failed: " . $mysqli->connect_error);
    
    $sql = "SELECT * FROM `channels` WHERE `status` <> 'e'";
    $result = $mysqli->query($sql);

    if ($result->num_rows > 0)
    {
        $response = [];
        $index = 0;

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

    $mysqli->close();
}

?>