<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Object userObj = session.getAttribute("user");
    if (userObj == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    String role = (String) session.getAttribute("userRole");
    if (role == null && request.getAttribute("userRole") != null) {
        role = (String) request.getAttribute("userRole");
    }
    String dashboardTitle = "Dashboard";
    if (role != null) {
        String r = role.toLowerCase();
        if ("admin".equals(r)) {
            dashboardTitle = "Admin Dashboard";
        } else if ("manager".equals(r)) {
            dashboardTitle = "Manager Dashboard";
        } else if ("reception".equals(r) || "receptionist".equals(r)) {
            dashboardTitle = "Receptionist Dashboard";
        }
    }

    // Load all reservations for dashboard display
    java.util.List<com.oceanview.model.Reservation> allReservations =
            new com.oceanview.dao.ReservationDAO().findAll();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - <%= dashboardTitle %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: #f4f6f9;
        }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 15px 20px;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.1);
            color: white;
            transform: translateX(5px);
        }
        .sidebar .nav-link.active {
            background: rgba(255,255,255,0.2);
            color: white;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
            width: 20px;
        }
        .main-content {
            padding: 20px;
        }
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
        .bg-soft-primary { background: rgba(102,126,234,0.1); color: #667eea; }
        .bg-soft-success { background: rgba(40,167,69,0.1); color: #28a745; }
        .bg-soft-warning { background: rgba(255,193,7,0.1); color: #ffc107; }
        .bg-soft-info { background: rgba(23,162,184,0.1); color: #17a2b8; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 p-0 sidebar">
                <div class="p-3">
                    <div class="text-center mb-4">
                        <i class="fas fa-hotel fa-3x mb-2"></i>
                        <h5>Ocean View Resort</h5>
                    </div>
                    
                    <div class="user-profile bg-white bg-opacity-10 p-3 rounded mb-3">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-user-circle fa-2x me-2"></i>
                            <div>
                                <strong>${sessionScope.user.fullName}</strong><br>
                                <small>${sessionScope.user.role}</small>
                            </div>
                        </div>
                    </div>
                    
                    <!-- FIXED: All links now use ${pageContext.request.contextPath} -->
                    <nav class="nav flex-column">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/views/dashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/reservation/new">
                            <i class="fas fa-plus-circle"></i> New Reservation
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/reservation/list">
                            <i class="fas fa-list"></i> All Reservations
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/reservation/scan">
                            <i class="fas fa-qrcode"></i> Scan QR
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/reports">
                            <i class="fas fa-chart-bar"></i> Reports
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </nav>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-10 main-content">
                <h2 class="mb-4"><%= dashboardTitle %></h2>

                <!-- Common stats for all roles -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stat-card d-flex align-items-center">
                            <div class="stat-icon bg-soft-primary me-3">
                                <i class="fas fa-bed"></i>
                            </div>
                            <div>
                                <h3 class="mb-0">45</h3>
                                <small>Available Rooms</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card d-flex align-items-center">
                            <div class="stat-icon bg-soft-success me-3">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <div>
                                <h3 class="mb-0">28</h3>
                                <small>Checked-in</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card d-flex align-items-center">
                            <div class="stat-icon bg-soft-warning me-3">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div>
                                <h3 class="mb-0">12</h3>
                                <small>Expected Today</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card d-flex align-items-center">
                            <div class="stat-icon bg-soft-info me-3">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div>
                                <h3 class="mb-0">LKR 125K</h3>
                                <small>Today's Revenue</small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Role-specific sections -->
                <%
                    if (role != null) {
                        String r = role.toLowerCase();
                        if ("admin".equals(r)) {
                %>
                        <div class="stat-card mb-4">
                            <h5>Admin Tools</h5>
                            <p>Manage users, roles, and high-level system settings.</p>
                        </div>
                <%
                        } else if ("manager".equals(r)) {
                %>
                        <div class="stat-card mb-4">
                            <h5>Manager Overview</h5>
                            <p>Focus on occupancy, revenue, and daily operational performance.</p>
                        </div>
                <%
                        } else if ("reception".equals(r) || "receptionist".equals(r)) {
                %>
                        <div class="stat-card mb-4">
                            <h5>Reception Shortcuts</h5>
                            <div class="d-flex flex-wrap gap-2">
                                <a href="${pageContext.request.contextPath}/reservation/new" class="btn btn-sm btn-primary">
                                    <i class="fas fa-calendar-plus"></i> New Reservation
                                </a>
                                <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-list"></i> All Reservations
                                </a>
                                <a href="${pageContext.request.contextPath}/reservation/scan" class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-qrcode"></i> Scan QR
                                </a>
                            </div>
                        </div>
                <%
                        }
                    }
                %>

                <!-- All Reservations (common) -->
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h5 class="mb-0">All Reservations</h5>
                        <a class="btn btn-sm btn-outline-primary"
                           href="${pageContext.request.contextPath}/reservation/list">
                            Open full page
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Reservation #</th>
                                    <th>Guest</th>
                                    <th>Room Type</th>
                                    <th>Check-in</th>
                                    <th>Check-out</th>
                                    <th>Status</th>
                                    <th class="text-end">View</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (allReservations == null || allReservations.isEmpty()) {
                                %>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted">No reservations yet.</td>
                                    </tr>
                                <%
                                    } else {
                                        for (com.oceanview.model.Reservation res : allReservations) {
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
                                        <td>
                                            <span class="badge bg-success"><%= status %></span>
                                        </td>
                                        <td class="text-end">
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
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>