<?php
require_once 'config.php';

// Get form input
$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$school = $_POST['school'];

// 1. SQL Injection Vulnerability: input concatenated directly into query, no sanitization or prepared statement
$sql = "INSERT INTO users (firstname, lastname, school) VALUES ('$firstname', '$lastname', '$school')";
$conn->query($sql);

// Retrieve all records to demonstrate XSS vulnerability
$result = $conn->query("SELECT * FROM users");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Form Submission Result</title>
</head>
<body>
    <h2>Submitted Data</h2>
    <p>Thank you, <?php echo $firstname; ?>! Here is the data:</p>

    <table border="1">
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>School</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <!-- 2. XSS Vulnerability: Output is not sanitized -->
            <td><?php echo $row['firstname']; ?></td>
            <td><?php echo $row['lastname']; ?></td>
            <td><?php echo $row['school']; ?></td>
        </tr>
        <?php endwhile; ?>
    </table>

    <!-- Sensitive data exposure: Displaying full database contents without restriction -->
    <h2>Database Dump:</h2>
    <?php
    $dumpResult = $conn->query("SELECT * FROM users");
    while ($dumpRow = $dumpResult->fetch_assoc()) {
        echo "User: {$dumpRow['firstname']} {$dumpRow['lastname']}, School: {$dumpRow['school']}<br>";
    }
    ?>

    <a href="index.php">Go Back</a>
</body>
</html>
