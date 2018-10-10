<?php
require 'mail/phpmailer.php';
require 'mail/smtp.php';

$inputJSON = file_get_contents('php://input');
$post_data= $inputJSON;
//echo $post_data;

$json = json_decode($post_data, true);

if(count($json)>0) {
    if (array_key_exists('email', $json) ) {

//      echo "xxx";
        $email = $json['email'];
    //    $message = $json['message'];
       // $subject = $json['subject'];
        $mail = new PHPMailer;

        $mail->IsSMTP(); // telling the class to use SMTP
//$mail->Host       = "smtp.gmail.com"; // SMTP server
        $mail->SMTPDebug  = 0;                     // enables SMTP debug information (for testing)
        // 1 = errors and messages
        // 2 = messages only
        $mail->SMTPAuth   = true;                  // enable SMTP authentication
        $mail->Host       = "smtp.gmail.com"; // sets the SMTP server
        $mail->Port       = 465;                    // set the SMTP port for the GMAIL server
        $mail->Username   = "kalpeshpatel0393@gmail.com"; // SMTP account username
        $mail->Password   = "kalpesh@0393";        // SMTP account password
        $mail->SMTPSecure = 'ssl';


        //$mail->From = 'from@example.com';
        $mail->From = 'hetal.icreate@gmail.com';
        $mail->FromName = 'Mailer';
//$mail->addAddress('arpit.icreate@gmail.com', 'Joe User');     // Add a recipient
        $mail->addAddress($email);               // Name is optional
//        $mail->addReplyTo('info@example.com', 'Information');
//        $mail->addCC('cc@example.com');
//        $mail->addBCC('bcc@example.com');
//print_r($mail->ReplyTo);
//print_r($mail->to);
        $mail->WordWrap = 50;                                 // Set word wrap to 50 characters
//$mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
//$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
        $mail->isHTML(true);                                  // Set email format to HTML

        $min=400;
        $max=1000;
        $otp= rand($min, $max);
        
        $mail->Subject = "OTP number";
        $mail->Body    = "OTP for your login is:$otp";
        $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

        if (!$mail->send()) {

            $msg=  array("result"=>FALSE,"msg"=>"Mail Not Sent");
        } else {

            $msg=  array("result"=>true,"msg"=>"Mail Sent","otp"=>$otp);
        }
    }else{
        $msg=  array("result"=>FALSE,"msg"=>"Invalid Parameter");
    }


}else{
    $msg=  array("result"=>FALSE,"msg"=>"Mail Not Sent");
}


header('Content-type:appliction/json');
echo json_encode($msg);
?>
