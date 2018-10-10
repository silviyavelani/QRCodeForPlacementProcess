<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$jsoninput=  file_get_contents("php://input");
$jsonarr=  json_decode($jsoninput,true);

$email = $jsonarr["email"];
$pwd = $jsonarr["pwd"];
$msg = "";

$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");

$quer = "UPDATE `login` SET `pwd` = '$pwd' WHERE `email` = '$email'";
$ex = mysqli_query($con, $quer);
    
if( $ex > 0)
{    
    $msg = "successfully updated";
}
 
else 
{
    $msg = "try agin "; 
}

header("Content-Type:application/json");
echo json_encode(array("response"=>$msg));
?>

