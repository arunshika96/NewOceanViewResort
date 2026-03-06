<%-- 
    Document   : reservationDetails
    Created on : Mar 2, 2026, 11:14:11 PM
    Author     : marye
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    com.oceanview.model.Reservation reservation =
            (com.oceanview.model.Reservation) request.getAttribute("reservation");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reservation Details - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container my-4">
        <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-link">&laquo; Back to Reservations</a>

        <% if (reservation == null) { %>
            <div class="alert alert-danger mt-3">
                Reservation not found.
            </div>
        <% } %>

        <% if (reservation != null) { 
            String number = reservation.getReservationNumber();
            String guestName = reservation.getGuest() != null ? reservation.getGuest().getFullName() : "-";
            String guestEmail = reservation.getGuest() != null ? reservation.getGuest().getEmail() : "-";
            String guestContact = reservation.getGuest() != null ? reservation.getGuest().getContactNumber() : "-";
            String guestAddress = reservation.getGuest() != null ? reservation.getGuest().getAddress() : "-";
            String idType = reservation.getGuest() != null ? reservation.getGuest().getIdProofType() : "-";
            String idNo = reservation.getGuest() != null ? reservation.getGuest().getIdProofNumber() : "-";
            String roomType = "-";
            if (reservation.getRoom() != null && reservation.getRoom().getRoomType() != null) {
                roomType = reservation.getRoom().getRoomType().getTypeName();
            }
            String status = reservation.getBookingStatus() != null ? reservation.getBookingStatus() : "-";
            String paymentStatus = reservation.getPaymentStatus() != null ? reservation.getPaymentStatus() : "-";
        %>
            <div class="card shadow-sm">
                <div class="card-header">
                    <h4 class="mb-0">Reservation <%= number %></h4>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <h5>Guest Details</h5>
                            <p class="mb-1"><strong>Name:</strong> <%= guestName %></p>
                            <p class="mb-1"><strong>Email:</strong> <%= guestEmail %></p>
                            <p class="mb-1"><strong>Contact:</strong> <%= guestContact %></p>
                            <p class="mb-1"><strong>Address:</strong> <%= guestAddress %></p>
                            <p class="mb-1"><strong>ID:</strong> <%= idType %> - <%= idNo %></p>
                        </div>
                        <div class="col-md-6">
                            <h5>Stay Details</h5>
                            <p class="mb-1"><strong>Room Type:</strong> <%= roomType %></p>
                            <p class="mb-1"><strong>Check-in:</strong> <%= reservation.getCheckInDate() %></p>
                            <p class="mb-1"><strong>Check-out:</strong> <%= reservation.getCheckOutDate() %></p>
                            <p class="mb-1"><strong>Nights:</strong> <%= reservation.getTotalNights() %></p>
                            <p class="mb-1"><strong>Guests:</strong> <%= reservation.getNumberOfGuests() %></p>
                            <p class="mb-1"><strong>Status:</strong> <%= status %></p>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <h5>Payment</h5>
                            <p class="mb-1"><strong>Room Rate:</strong> LKR <%= reservation.getRoomRate() %></p>
                            <p class="mb-1"><strong>Subtotal:</strong> LKR <%= reservation.getSubtotal() %></p>
                            <p class="mb-1"><strong>Tax:</strong> LKR <%= reservation.getTaxAmount() %></p>
                            <p class="mb-1"><strong>Discount:</strong> LKR <%= reservation.getDiscountAmount() %></p>
                            <p class="mb-1"><strong>Total:</strong> LKR <%= reservation.getTotalAmount() %></p>
                            <p class="mb-1"><strong>Payment Status:</strong> <%= paymentStatus %></p>
                        </div>
                        <div class="col-md-6">
                            <h5>Notes</h5>
                            <p><%= reservation.getSpecialRequests() %></p>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>
