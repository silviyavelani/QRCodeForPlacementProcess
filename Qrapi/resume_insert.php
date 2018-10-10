<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$jsoninput=  file_get_contents("php://input");

$jsonarr=  json_decode($jsoninput,true);


$cid=$jsonarr["cid"];
$lid=$jsonarr["lid"];
$resumeid=$jsonarr["resumeid"];
$filepath=$jsonarr["filepath"];
$examstatus=$jsonarr["examstatus"];
$qrstatus=$jsonarr["qrstatus"];
$marks=$jsonarr["marks"];

$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
$query="INSERT INTO `resume` (`resumeid`, `lid`, `cid`, `filepath`, `examstatus`, `qrstatus`, `marks`) VALUES (NULL, '$lid', '$cid', '$filepath', '$examstatus', '$qrstatus', '$marks')";

$row=mysqli_query($con,$query);
$id =mysqli_insert_id($con);
$msg="";

if($row>0)
{
 $msg="Successfully resume Added";

}else

{

    $msg="Unsucessfull process!";

}

header("Content-Type:application/json");

        echo json_encode(array("response"=>$msg,"id"=>$id));



?>