<?php

if ( isset( $_POST["n"] ) &&
     isset( $_POST["e"] ) &&
     isset( $_POST["u"] ) &&
     isset( $_POST["p"] ) )
{
    $mysqli = new mysqli('localhost', 'root', '172321613212331Gz', 'db_webprog');
    if ($mysqli->connect_error) {
        die("connection failed: " . $mysqli->connect_error);
    }

    $sql = "SET @`p_email`   = '".$_POST["e"]."';";
    $mysqli->query($sql);

    $sql = "SET @`p_name`    = '".$_POST["n"]."';";
    $mysqli->query($sql);

    $sql = "SET @`p_usrName` = '".$_POST["u"]."';";
    $mysqli->query($sql);

    $sql = "SET @`p_pwd`     = '".$_POST["p"]."';";
    $mysqli->query($sql);

    $sql = "SET @`p_result`  = '';";
    $mysqli->query($sql);

    $sql = "CALL Register(@`p_email`, @`p_name`, @`p_usrName`, @`p_pwd`, @`p_result`)";
    if( ! ($result = $mysqli->multi_query($sql)) )
        die( $mysqli->error );

    $sql = "SELECT @`p_result`;";
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

    if( $response == '' )
    {
        $to      = $_POST["e"];
        $subject = 'Sikeres regisztráció';
        $message = '
        <html>
            <body>
                <h2>Kedves'.$_POST["n"].'</h2>
                <p>Köszönjük, hogy regisztráltál a torpedó-játékunkra!</p>
                <p>E-mail cím: '.$_POST["e"].'</p>
                <p>Felhasználónév: '.$_POST["u"].'</p>
                <p><a href="http://localhost/webprog2/login/login.html">Ide</a> kattintva be tudsz jelentkezni.</p>
                <p>Jó játékot kívánunk! :-)</p>
            </body>
        </html>';
        
        mail($to, $subject, $message);

        echo 'E-mail has just been sent.';
    }

    $mysqli->close();
}

?>