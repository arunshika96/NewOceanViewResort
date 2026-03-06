<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    com.oceanview.model.Reservation reservation =
            (com.oceanview.model.Reservation) request.getAttribute("reservation");
    if (reservation == null) {
        response.sendRedirect(request.getContextPath() + "/views/error/404.jsp");
        return;
    }

    String number = reservation.getReservationNumber();
    String guestName = reservation.getGuest() != null ? reservation.getGuest().getFullName() : "-";
    String guestEmail = reservation.getGuest() != null ? reservation.getGuest().getEmail() : "-";
    String guestContact = reservation.getGuest() != null ? reservation.getGuest().getContactNumber() : "-";
    String roomType = "-";
    if (reservation.getRoom() != null && reservation.getRoom().getRoomType() != null) {
        roomType = reservation.getRoom().getRoomType().getTypeName();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice <%= number %> - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @media print {
            .no-print { display: none !important; }
            body { background: white !important; }
        }
        .invoice {
            max-width: 900px;
            margin: 24px auto;
        }
        .brand {
            font-weight: 700;
            letter-spacing: .2px;
        }
        .muted { color: #6c757d; }
    </style>
</head>
<body class="bg-light">
    <div class="invoice">
        <div class="card shadow-sm">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                    <div>
                        <div class="brand h4 mb-1">Ocean View Resort</div>
                        <div class="muted">Galle, Sri Lanka</div>
                        <div class="muted">info@oceanview.com</div>
                    </div>
                    <div class="text-end">
                        <div class="h5 mb-1">Invoice</div>
                        <div><strong>#</strong> <%= number %></div>
                        <div class="muted"><strong>Date:</strong> <%= java.time.LocalDate.now() %></div>
                    </div>
                </div>

                <hr class="my-4">

                <div class="row g-3">
                    <div class="col-md-6">
                        <h6 class="mb-2">Billed To</h6>
                        <div><strong><%= guestName %></strong></div>
                        <div class="muted"><%= guestEmail %></div>
                        <div class="muted"><%= guestContact %></div>
                    </div>
                    <div class="col-md-6">
                        <h6 class="mb-2">Stay</h6>
                        <div><strong>Room Type:</strong> <%= roomType %></div>
                        <div><strong>Check-in:</strong> <%= reservation.getCheckInDate() %></div>
                        <div><strong>Check-out:</strong> <%= reservation.getCheckOutDate() %></div>
                        <div><strong>Nights:</strong> <%= reservation.getTotalNights() %></div>
                        <div><strong>Guests:</strong> <%= reservation.getNumberOfGuests() %></div>
                    </div>
                </div>

                <div class="table-responsive mt-4">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Description</th>
                                <th class="text-end">Rate</th>
                                <th class="text-end">Qty</th>
                                <th class="text-end">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Room Charge (<%= roomType %>)</td>
                                <td class="text-end">LKR <%= reservation.getRoomRate() %></td>
                                <td class="text-end"><%= reservation.getTotalNights() %></td>
                                <td class="text-end">LKR <%= reservation.getSubtotal() %></td>
                            </tr>
                            <tr>
                                <td>Tax</td>
                                <td class="text-end">-</td>
                                <td class="text-end">-</td>
                                <td class="text-end">LKR <%= reservation.getTaxAmount() %></td>
                            </tr>
                            <tr>
                                <td>Discount</td>
                                <td class="text-end">-</td>
                                <td class="text-end">-</td>
                                <td class="text-end">LKR <%= reservation.getDiscountAmount() %></td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="3" class="text-end">Total</th>
                                <th class="text-end">LKR <%= reservation.getTotalAmount() %></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mt-3 no-print">
                    <a class="btn btn-outline-secondary" href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
                    <button class="btn btn-primary" onclick="window.print()">Print / Save PDF</button>
                </div>

                <div class="muted small mt-3">
                    Payment status: <strong><%= reservation.getPaymentStatus() %></strong>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

