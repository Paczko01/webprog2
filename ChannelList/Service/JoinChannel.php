<?php

//The paramethers - sent by POST method with "send" function - are in a global "array" named $_POST. If they are set, then ...
if (isset($_POST["u"]) &&
	isset($_POST["p"]) &&
	isset($_POST["ch"]) &&
	isset($_POST["player"]))
{
    echo 'Join channel\n'; //This line is for debug

    //Create connection with the database
	$conn = new mysqli("localhost", $_POST["u"], $_POST["p"]);
    if ($conn->connect_error)
    {
        die("Connection failed: " . $conn->connect_error);
    }
    echo 'Connection successfull\n'; //This line is for debug

    //Execute 'JoinChannel' procedure
    //Get the sql query to be ready for execute.
    $sql = "CALL `JoinChannel`(" . $_POST["ch"] . ", " . $_POST["player"] . ");";
    //Execute the sql query
    $conn->query($sql);
    
    echo 'Procedure completed\n'; //This line is for debug

    //Itt m�g lehet, hogy k�rni kell egy jelent�st az elj�r�s sikeress�g�r�l
}

?>