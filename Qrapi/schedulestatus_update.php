<?php
//INSERT INTO `subqpaper` (`sqid`, `qid`, `question`, `opa`, `opb`, `opc`, `opd`, `correctop`) VALUES (NULL, '7', 'gggg', 'ggg', 'gggg', 'ggg', 'ggg', 'gg');



$jsoninput=  file_get_contents("php://input");
$jsonarr=  json_decode($jsoninput,true);


$lid = $jsonarr["lid"];

///connection
$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");

	$query = "UPDATE `resume` SET  `schedulestatus` = '1' WHERE `resume`.`lid` = '$lid'";
	 
///query execute
$res = mysqli_query($con, $query);

///lastid
$id = mysqli_insert_id($con);
$msg = "";
if($res > 0)
{
    $msg = "successfully update";
    }
 else {
        
 $msg = "try agin "; 
    }

header("Content-Type:application/json");

        echo json_encode(array("response"=>$msg));

?>