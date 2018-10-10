<?php
//INSERT INTO `subqpaper` (`sqid`, `qid`, `question`, `opa`, `opb`, `opc`, `opd`, `correctop`) VALUES (NULL, '7', 'gggg', 'ggg', 'gggg', 'ggg', 'ggg', 'gg');



$jsoninput=  file_get_contents("php://input");
$jsonarr=  json_decode($jsoninput,true);

$qid = $jsonarr["qid"];
$question = $jsonarr["question"];
$opa = $jsonarr["opa"];
$opb = $jsonarr["opb"];
$opc = $jsonarr["opc"];
$opd = $jsonarr["opd"];
$corre = $jsonarr["corre"];


///connection
$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
$query = "INSERT INTO `subqpaper` (`sqid`, `qid`, `question`, `opa`, `opb`, `opc`, `opd`, `correctop`) VALUES (NULL, '$qid', '$question', '$opa', '$opb', '$opc', '$opd', '$corre')";
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