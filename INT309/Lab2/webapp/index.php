<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple Front-End App</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        nav { background-color: #333; padding: 10px; }
        nav a { color: white; margin-right: 15px; text-decoration: none; }
        form { margin-top: 20px; }
        label { display: block; margin-top: 10px; }
        input { padding: 5px; width: 200px; }
        button { margin-top: 15px; padding: 8px 16px; }
    </style>
</head>
<body>
    <header>
        <h1>Contact Us</h1>
        <nav>
            <a href="#">Home</a>
            <a href="#">About</a>
            <a href="#">Contact</a>
        </nav>
    </header>

    <form action="process.php" method="POST">
        <label for="firstname">First Name:</label>
        <input type="text" name="firstname" id="firstname" required>

        <label for="lastname">Last Name:</label>
        <input type="text" name="lastname" id="lastname" required>

        <label for="school">School:</label>
        <input type="text" name="school" id="school" required>

        <button type="submit">Submit</button>
    </form>

    <button id="toggleBtn" onclick="toggleText()">Click Me</button>
    <p id="toggleText">This text will change when you click the button.</p>

    <script src="script.js"></script>
</body>
</html>
