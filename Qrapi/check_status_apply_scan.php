<?php
	// Create connection
	
	
$jsoninput=  file_get_contents("php://input");
$jsonarr=  json_decode($jsoninput,true);
$lid = $jsonarr["lid"];
//$cname = "https://www.qrcodeforplacementprocess.com";
	$con = mysqli_connect("localhost", "id6307319_qr","qr123","id6307319_qr");
	 
	// Check connection
	if (mysqli_connect_errno())
	{
	  echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	 
	// This SQL statement selects ALL from the table 'Category'
	$sql = "SELECT register.firstname, register.lastname, resume.examstatus, resume.applystatus, resume.qrstatus, register.photo FROM login INNER JOIN register ON login.lid = register.lid INNER JOIN resume ON login.lid = resume.lid WHERE login.lid = '$lid'";
	 
	// Check if there are results
	if ($result = mysqli_query($con, $sql))
	{
		// If so, then create a results array and a temporary one
		// to hold the data
		$resultArray = array();
		$tempArray = array();
	 
		// Loop through each row in the result set
		while($row = $result->fetch_object())
		{
			// Add each row into our results array
			$tempArray = $row;
		    array_push($resultArray, $tempArray);
		}
	 
		// Finally, encode the array to JSON and output the results
		echo json_encode($resultArray);
		//echo $resultArray;
	}
	 
	// Close connections
	mysqli_close($con);
?>