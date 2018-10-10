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
$firstname = $jsonarr["firstname"];
$middlename = $jsonarr["middlename"];
$lastname = $jsonarr["lastname"];
$no = $jsonarr["no"];
//$photo = $jsonarr["photo"];
//$role = $jsonarr["role"];
$gender = $jsonarr["gender"];

///connection
$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
$query = "INSERT INTO `login` (`lid`, `email`, `pwd`, `role`) VALUES (NULL, '$email', '$pwd', 'user')";
///query execute
$res = mysqli_query($con, $query);

///lastid
$id = mysqli_insert_id($con);
$msg = "";
if($res > 0)
{
    $quer2 = "INSERT INTO `register` (`rid`, `lid`, `firstname`, `middlename`, `lastname`, `no`, `photo`, `gender`) VALUES (NULL, '$id', '$firstname', '$middlename', '$lastname', '$no', 'image', '$gender')";
    
    
    $ex = mysqli_query($con, $quer2);
    if( $ex > 0)
    {
       $quer3 = "INSERT INTO `resume` (`resumeid`, `lid`, `cid`, `filepath`, `examstatus`, `qrstatus`, `applystatus`, `marks`, `schedulestatus`) VALUES (NULL, '$id', '31', '', '0', '0', '0', '0', '0')";
       $ex2 = mysqli_query($con, $quer3);
       if($ex2 >0)
       {
            $msg = "successfully inserted";
       }
        else
        {
            $msg ="try again";
        }
    }
    else
    {
            $msg = "try again";
    }
}

else
{
    $msg = "try again";
}


header("Content-Type:application/json");

        echo json_encode(array("response"=>$msg,"id"=>$id));

?>