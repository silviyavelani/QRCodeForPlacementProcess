<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$jsoninput=  file_get_contents("php://input");
$jsonarr=  json_decode($jsoninput,true);

$openid = $jsonarr["cid"];

///connection
$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
$query = "DELETE FROM `opening` WHERE `openid` = $openid";
///query execute
$res = mysqli_query($con, $query);

$msg = "";
if($res > 0)
{
    $msg = "successfully deleted";
    }
 else {
        
 $msg = "try agin "; 
    }

header("Content-Type:application/json");

        echo json_encode(array("response"=>$msg));

?>