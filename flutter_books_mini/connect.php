<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "flutter_books_mini";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
?>