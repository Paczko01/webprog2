<?php

//The paramethers - sent by POST method with "send" function - are in a global "array" named $_POST. If they are set, then ...
if (isset($_POST["u"]) &&
	isset($_POST["p"]) &&
	isset($_POST["ch"]) &&
	isset($_POST["player"]))
{
    echo 'Join channel\n'; //This line is for debug

    //Create connection with the database
	$mysqli = new mysqli("localhost", $_POST["u"], $_POST["p"]);
    if ($mysqli->connect_error)
    {
        die("Connection failed: " . $mysqli->connect_error);
    }
    echo 'Connection successfull\n'; //This line is for debug

    //Execute 'JoinChannel' procedure
    //Get the sql query to be ready for execute.
    $sql  = " SET @p0='" . $_POST["ch"] . "';";
    $sql .= " SET @p1='" . $_POST["player"] . "';";
    $sql .= " CALL `JoinChannell`(@p0, @p1);`";
    //Execute the sql query
    $result = $mysqli->query($sql);

    $mysqli->close();
}

?>