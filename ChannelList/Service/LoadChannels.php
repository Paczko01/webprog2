<?php

//The paramethers - sent by POST method with "send" function - are in a global "array" named $_POST. If they are set, then ...
if(isset($_POST["u"]) && isset($_POST["p"]))
{
    //Create connection with the database
    $conn = new mysqli("localhost", $_POST["u"], $_POST["p"]);
    if ($conn->connect_error)
    {
        die("Connection failed: " . $conn->connect_error);
    }

    //List all non-empty channels
    //Get the sql query to be ready for execute.
    $sql = "SELECT * FROM `db_webprog`.`channels` WHERE `status` <> 'e'";
    
    //Execute the sql query and store the result in the "$result" object
    $result = $conn->query($sql);

    if ($result->num_rows > 0) //If the result of the sql query is NOT empty
    {
        $response = [];
        $index = 0;

        //Get the "$response" object to be ready for send back the ansver for the client
        while($row = $result->fetch_assoc())
        {
            $response[$index++] = array(
                "Id"          => $row["Id"],
                "name"        => $row["name"],
                "player_1_ID" => $row["player_1_ID"],
                "player_2_ID" => $row["player_2_ID"],
                "status"      => $row["status"]);
        }
        //Send the ansver ($response) back to the client
        echo json_encode($response);
    }
    else //If the result of the sql query is EMPTY
    {
        echo "0 results";
    }

    //Close the database connection
    $conn->close();
}

?>