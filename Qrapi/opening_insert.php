<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$jsoninput=  file_get_contents("php://input");
$jsonarr=  json_decode($jsoninput,true);

$cid = $jsonarr["cid"];
$noofpositions = $jsonarr["noofpositions"];

///connection
$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
$query = "INSERT INTO `opening` (`openid`, `cid`, `noofpositions`) VALUES (NULL,(SELECT cid FROM `category` WHERE cname = '$cid'),'$noofpositions')";
///query execute
$res = mysqli_query($con, $query);

///lastid
$id = mysqli_insert_id($con);
$msg = "";
if($res > 0)
{
    $msg = "successfully inserted";
    }
 else {
        
 $msg = "try agin "; 
    }

header("Content-Type:application/json");

        echo json_encode(array("response"=>$msg,"id"=>$id));

?>