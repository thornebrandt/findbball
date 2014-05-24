<?php
	if (!$_POST["em"] || $_POST["address"]){ 
		//kill the page if it isn't accessed via post
		//address is a fake form to prevent bots
		die ("You're not supposed to be here."); 
	}
		
	$to .= "thornebrandt@gmail.com"; 
	$to .= ", info@findbball.com";
	
	$subject = $_POST['em'] . " subscribed to the Findbball.com mailing list";
	
	
	$body = "New mailing list subscription for Findbball.com\n"; 
	$body .=  $_POST['em'] . "\n"; 
	
	$headers = "From: newsubscriber@findbball.com" . "\r\n" . 
				"Reply-To: noreply@findbball.com" . "\r\n" . 
				"X-Mailer: PHP/" . phpversion(); 
				
 if (mail($to, $subject, $body, $headers)) {
 	echo "<p>Thank you</p>";
  } else {
   	error_log("<p>Message delivery failed...</p>");
  }
?>