<?php
	
	$connection = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr") or die ("connection to server failed");
	

	
	$id = $_POST['cid'];
	
	//query
	$QRY="DELETE FROM `category` WHERE `cid` = $id" ;
	if (mysqli_query($connection, $QRY)) {
		$response['error']=false;
		$response['message']="Record Deleted successfully";
	} else {
		$response['error']=true;
		$response['message']="Error: " . $QRY . "<br>" . mysqli_error($connection);
	}
	echo json_encode($response);
	mysqli_close($connection);  
?>