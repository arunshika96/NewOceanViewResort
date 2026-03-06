<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String number = request.getParameter("number");
    if (number == null || number.isBlank()) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reservation QR - <%= number %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="min-height: 100vh;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm text-center p-4">
                    <h4 class="mb-2">Your Check‑in QR Code</h4>
                    <p class="text-muted mb-3">
                        Reservation <strong><%= number %></strong>
                    </p>
                    <img
                        src="<%= request.getContextPath() %>/qr-image?number=<%= number %>"
                        alt="Reservation QR Code"
                        class="img-fluid mb-3"
                        style="max-width: 260px;"
                    />
                    <div class="d-flex flex-column flex-sm-row gap-2 justify-content-center">
                        <a class="btn btn-outline-primary"
                           href="<%= request.getContextPath() %>/qr-image?number=<%= number %>&download=1"
                           download="reservation-<%= number %>-qr.png">
                            Download QR
                        </a>
                        <a class="btn btn-secondary" href="<%= request.getContextPath() %>/index.jsp">
                            Back to Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

