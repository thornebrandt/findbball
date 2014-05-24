<?php 

    $url = "https://maps.googleapis.com/maps/api/place/autocomplete/"
            . "json?input=Amoeba&types=establishment&location=37.76999,-122.44696&radius=500&sensor=true"
            . "&key=AIzaSyA4elMMkrN6j24qAKUVl7jeH1y3bS7vRqM"
            . "&callback=?";


    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    //return the transfer as a string
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
    // $output contains the output string
    $output = curl_exec($ch);
    // close curl resource to free up system resources
    curl_close($ch);
    echo $output;
?>


