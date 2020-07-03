<?php
error_reporting(0);
include_once("dbconnect.php");

$phone = $_POST['phone'];
$cookerphone = $_POST['cookerphone'];

$sql = "DELETE FROM `order` WHERE `phone` = '$phone' AND `cookerphone` = '$cookerphone'";
$result = $conn->query($sql);

// $respond = array();
// if ($result->num_rows > 0) {
//     array_push($respond, 'success');
//     while ($row = mysqli_fetch_array($result)){
//         array_push($respond, $row['phone']);
//     }
//     echo json_encode($respond);
    
// }else{
//     array_push($respond, 'failed');
//     echo json_encode($respond);
// }

?>