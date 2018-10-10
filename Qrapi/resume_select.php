<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$json = file_get_contents("php://input");
$jsonArr = json_decode($json,true);

$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
$query = "SELECT * FROM `resume` WHERE `lid` = 2 ";

$res = mysqli_query($con,$query);

$outArr = array();

while($row = mysqli_fetch_array($res))

{
    $resumeid = $row["resumeid"];
    $lid = $row["lid"];
    $cid = $row["cid"];
    $filepath = $row["filepath"];
    $examstatus = $row["examstatus"];
    $qrstatus = $row["qrstatus"];
    $marks = $row["marks"];
    
    $outArr[] = array("resumeid"=>$resumeid ,"lid"=>$lid, "cid"=>$cid, "filepath"=>$filepath, "examstatus" =>$examstatus, "qrstatus" => $qrstatus, "marks"=> $marks);

}

$outResArr = array("response"=>$outArr);

$outJson = json_encode($outResArr);

header("Content-type:application/json");

echo $outJson;

?>