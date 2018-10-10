<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



$json = file_get_contents("php://input");
$jsonArr = json_decode($json,true);

$email = $jsonArr["email"];
$pwd = $jsonArr["pwd"];
$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
$query = "SELECT * FROM `login` WHERE `email` = '$email' AND `pwd` = '$pwd'";

$res = mysqli_query($con,$query);

$outArr = array();

while($row = mysqli_fetch_array($res))

{
    $lid = $row["lid"];

    
    $role = $row["role"];

       

    $outArr = array("lid"=>$lid,"role"=>$role);

  

}




$outResArr = $outArr;

$outJson = json_encode($outResArr);

header("Content-type:application/json");

echo $outJson;

?>

