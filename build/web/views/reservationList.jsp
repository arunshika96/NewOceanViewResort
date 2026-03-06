<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    java.util.List<com.oceanview.model.Reservation> reservations =
            (java.util.List<com.oceanview.model.Reservation>) request.getAttribute("reservations");
    if (reservations == null) {
        reservations = java.util.Collections.emptyList();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reservations - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background: #f4f6f9; }
        .content { padding: 20px; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 bg-dark text-white p-0" style="min-height: 100vh;">
                <div class="p-3">
                    <h5>Ocean View Resort</h5>
                    <hr>
                    <nav class="nav flex-column">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/views/dashboard.jsp">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <a class="nav-link text-white active" href="${pageContext.request.contextPath}/reservation/list">
                            <i class="fas fa-list"></i> Reservations
                        </a>
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </nav>
                </div>
            </div>
            <div class="col-md-10 content">
                <h2>All Reservations</h2>
                <table class="table table-bordered bg-white">
                    <thead>
                        <tr>
                            <th>Reservation #</th>
                            <th>Guest Name</th>
                            <th>Room Type</th>
                            <th>Check-in</th>
                            <th>Check-out</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (reservations.isEmpty()) {
                        %>
                            <tr>
                                <td colspan="7" class="text-center text-muted">No reservations found.</td>
                            </tr>
                        <%
                            } else {
                                for (com.oceanview.model.Reservation res : reservations) {
                                    String number = res.getReservationNumber();
                                    String guestName = (res.getGuest() != null) ? res.getGuest().getFullName() : "-";
                                    String roomType = "-";
                                    if (res.getRoom() != null && res.getRoom().getRoomType() != null) {
                                        roomType = res.getRoom().getRoomType().getTypeName();
                                    }
                                    String status = (res.getBookingStatus() != null) ? res.getBookingStatus() : "-";
                        %>
                            <tr>
                                <td><%= number %></td>
                                <td><%= guestName %></td>
                                <td><%= roomType %></td>
                                <td><%= res.getCheckInDate() %></td>
                                <td><%= res.getCheckOutDate() %></td>
                                <td><span class="badge bg-success"><%= status %></span></td>
                                <td>
                                    <a class="btn btn-sm btn-info"
                                       href="<%= request.getContextPath() %>/reservation/details?number=<%= number %>">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>