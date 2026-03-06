<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Server Error</title>
</head>
<body>
    <h2>500 - Internal Server Error</h2>
    <p><strong>Message:</strong> <%= exception != null ? exception.getMessage() : "N/A" %></p>
</body>
</html>

