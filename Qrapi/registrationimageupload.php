<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//servicesimages




//$jsoninput=  file_get_contents('php://input');
//$jsonarr=  json_decode($jsoninput,TRUE);
$id=$_GET["id"];

$con = @mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
    
//foldername
$target_dir="profile/";
$target_file=$target_dir.basename($_FILES["fileUpload"]["name"]);
$msg="";

if(move_uploaded_file($_FILES["fileUpload"]["tmp_name"],$target_file))
{
     $path=$target_file;
     $q="UPDATE `register` SET  `photo` = '$path' WHERE `register`.`lid` = '$id'";
     //UPDATE `register` SET  `photo` = '5jjjjjnnnn' WHERE `register`.`lid` = '10'
     $res=  mysqli_query($con,$q);
     
     if($res>0)
     {
   $msg= "success";
     }
    
}
 else {
$path="fail";  
$msg= "fail";    
}
header("Content-Type:application/json");
echo json_encode(array("msg"=>$msg,"path"=>$path));
