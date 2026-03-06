<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmed - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh;">
        <div class="card shadow-lg p-4" style="max-width: 500px; width: 100%;">
            <h3 class="mb-3 text-success">Thank you for your booking!</h3>
            <p>Your reservation request has been received.</p>
            <p class="mb-1"><strong>Reservation Number:</strong> ${param.number}</p>
            <p class="text-muted">Please keep this number for future reference or check-in.</p>
            <div class="d-flex flex-column flex-sm-row gap-2 mt-3">
                <a href="${pageContext.request.contextPath}/bill?number=${param.number}" class="btn btn-primary">
                    View Invoice
                </a>
                <a href="${pageContext.request.contextPath}/views/qr.jsp?number=${param.number}" class="btn btn-outline-secondary">
                    View QR Code
                </a>
            </div>
        </div>
    </div>
</body>
</html>

