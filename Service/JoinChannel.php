<?php

if (isset($_POST["u"]) &&
	isset($_POST["p"]) &&
	isset($_POST["ch"]) &&
	isset($_POST["player"]))
{
    echo 'Join channel\n';

	$conn = new mysqli("localhost", $_POST["u"], $_POST["p"]);
    if ($conn->connect_error)
    {
        die("Connection failed: " . $conn->connect_error);
    }
    echo 'Connection successfull\n';

    //List all non-empty channels
    $sql = "CALL `JoinChannel`(" . $_POST["ch"] . ", " . $_POST["player"] . ");";
    $conn->query($sql);
    
    echo 'Procedure completed\n';

    //Itt m�g lehet, hogy k�rni kell egy jelent�st az elj�r�s sikeress�g�r�l
}

?>