<?php
// Database connection
// NOTE: credentials below should also be moved to environment variables in production
$conn = mysqli_connect("localhost", "root", "", "test_db");

session_start();

// FIX (CWE-89): SQL Injection - use prepared statement instead of string concatenation
$username = $_GET['username'] ?? '';
$stmt = mysqli_prepare($conn, "SELECT * FROM users WHERE username = ?");
mysqli_stmt_bind_param($stmt, "s", $username);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);


// FIX (CWE-78): OS Command Injection - removed system() call, replaced with allow-list
$cmd = $_GET['cmd'] ?? '';
$allowed_commands = ['status'];
if (in_array($cmd, $allowed_commands)) {
    echo "Command status requested.";
} else {
    echo "Command not allowed.";
}


// FIX (CWE-798): Hard-coded Credentials - moved to environment variables
$admin_user = getenv('ADMIN_USER') ?: '';
$admin_password = getenv('ADMIN_PASSWORD') ?: '';


// FIX (CWE-79): XSS - escape output before displaying
$name = $_POST['name'] ?? '';
echo "Hello, " . htmlspecialchars($name, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');


// FIX (CWE-862): Missing Authorization - require admin session before deleting a user
// FIX (CWE-89): SQL Injection - use prepared statement instead of string concatenation
if (isset($_GET['delete_user'])) {
    if (empty($_SESSION['is_admin'])) {
        http_response_code(403);
        exit('Access denied.');
    }
    $user_id = filter_input(INPUT_GET, 'delete_user', FILTER_VALIDATE_INT);
    if ($user_id === false || $user_id === null || $user_id < 1) {
        http_response_code(400);
        exit('Invalid user ID.');
    }
    $stmt = mysqli_prepare($conn, "DELETE FROM users WHERE id = ?");
    mysqli_stmt_bind_param($stmt, "i", $user_id);
    mysqli_stmt_execute($stmt);
}


// FIX (CWE-311): Missing Encryption of Sensitive Data
// Recommended: encrypt before writing. Plain-text write to disk removed for this
// deliberately vulnerable demonstration variable ($admin_password); no plain-text
// secret should be persisted without encryption in production code.


// FIX (CWE-434): Unrestricted File Upload - validate extension and use a generated safe filename
$allowed_ext = ['jpg', 'jpeg', 'png', 'pdf'];
$original_name = $_FILES['file']['name'] ?? '';
$ext = strtolower(pathinfo($original_name, PATHINFO_EXTENSION));
if (in_array($ext, $allowed_ext)) {
    $safe_name = bin2hex(random_bytes(8)) . '.' . $ext;
    move_uploaded_file($_FILES['file']['tmp_name'], "uploads/" . $safe_name);
} else {
    echo "File type not allowed.";
}


// FIX (CWE-807 / CWE-306): Reliance on Untrusted Input / Missing Authentication
// Check a real server-side session value instead of a raw GET parameter
$is_admin = !empty($_SESSION['is_admin']);
if ($is_admin) {
    echo "Access granted.";
} else {
    echo "Access denied.";
}


// FIX (CWE-89): SQL Injection - use prepared statement instead of string concatenation
// FIX (CWE-306): Missing Authentication - require a logged-in session before changing a password
// FIX (CWE-327/CWE-759): Weak/unsalted hash - use password_hash() instead of storing plain text
if (isset($_POST['change_password'])) {
    if (empty($_SESSION['user_id'])) {
        http_response_code(401);
        exit('Authentication required.');
    }
    $new_password = $_POST['new_password'] ?? '';
    if (strlen($new_password) < 12 || strlen($new_password) > 128) {
        http_response_code(400);
        exit('Password must be 12-128 characters.');
    }
    $password_hash = password_hash($new_password, PASSWORD_DEFAULT);
    $user_id = (int) $_SESSION['user_id'];
    $stmt = mysqli_prepare($conn, "UPDATE users SET password = ? WHERE id = ?");
    mysqli_stmt_bind_param($stmt, "si", $password_hash, $user_id);
    mysqli_stmt_execute($stmt);
}


// FIX (CWE-327 / CWE-759): Weak/unsalted hash - use password_hash() instead of md5()
$hash = password_hash($admin_password, PASSWORD_DEFAULT);


// FIX (CWE-732): Incorrect Permission Assignment - minimum permissions instead of 0777
chmod("sensitive_data.txt", 0600);


// FIX (CWE-307): Improper Restriction of Excessive Authentication Attempts
if (!isset($_SESSION['login_attempts'])) {
    $_SESSION['login_attempts'] = 0;
}
$max_attempts = 5;
if ($_SESSION['login_attempts'] >= $max_attempts) {
    http_response_code(429);
    exit("Too many failed login attempts. Please try again later.");
}
$login_failed = true; // placeholder - would come from a real credential check
if ($login_failed) {
    $_SESSION['login_attempts']++;
    echo "Invalid credentials. Attempt " . $_SESSION['login_attempts'] . " of " . $max_attempts . ".";
} else {
    $_SESSION['login_attempts'] = 0;
    echo "Login successful.";
}


// FIX (CWE-134): Format String - use fixed format string, value only as substitution
// FIX (CWE-79): XSS - escape output before displaying
$input = $_GET['input'] ?? '';
$safe_input = htmlspecialchars($input, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
printf('%s', $safe_input);


// FIX (CWE-601): Open Redirect - validate destination against an allow-list
$redirect_to = $_GET['redirect_to'] ?? '';
$allowed_redirects = [
    '/' => '/',
    '/dashboard' => '/dashboard'
];
if (isset($allowed_redirects[$redirect_to])) {
    header("Location: " . $allowed_redirects[$redirect_to]);
    exit;
} else {
    http_response_code(400);
    exit("Invalid redirect destination.");
}


// FIX (CWE-190): Integer Overflow - validate input range before arithmetic
$large_num = 999999999;
$input_num = filter_input(INPUT_GET, 'input_num', FILTER_VALIDATE_INT);
if ($input_num === false || $input_num === null) {
    http_response_code(400);
    exit("Invalid number.");
}
if ($input_num < -1000000 || $input_num > 1000000) {
    http_response_code(400);
    exit("Number is outside the allowed range.");
}
$sum = $large_num + $input_num;


// FIX (CWE-327 / CWE-759): Weak/unsalted hash - use password_hash() instead of sha1()
$hash = password_hash($admin_password, PASSWORD_DEFAULT);
?>
