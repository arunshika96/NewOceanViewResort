<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New Reservation - Ocean View Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background: #f4f6f9; }
        .reservation-form {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            max-width: 800px;
            margin: 30px auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="reservation-form">
            <h3 class="mb-4"><i class="fas fa-plus-circle text-primary"></i> Book Your Stay</h3>
            
            <form action="${pageContext.request.contextPath}/reservation" method="POST">
                <input type="hidden" name="action" value="create">
                
                <h5 class="mb-3">Guest Details</h5>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label>Full Name *</label>
                        <input type="text" name="fullName" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label>Email *</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                </div>
                
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label>Contact Number *</label>
                        <input type="text" name="contactNumber" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label>Address</label>
                        <input type="text" name="address" class="form-control">
                    </div>
                </div>
                
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label>ID Proof Type</label>
                        <select name="idProofType" class="form-control">
                            <option value="passport">Passport</option>
                            <option value="nic">NIC</option>
                            <option value="driving_license">Driving License</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label>ID Proof Number</label>
                        <input type="text" name="idProofNumber" class="form-control">
                    </div>
                </div>
                
                <h5 class="mb-3 mt-4">Booking Details</h5>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label>Room Type</label>
                        <select name="roomType" class="form-control">
                            <option value="STD">Standard Room - LKR 7,500/night</option>
                            <option value="DLX">Deluxe Room - LKR 12,500/night</option>
                            <option value="STE">Executive Suite - LKR 18,500/night</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label>Check-in Date *</label>
                        <input type="date" name="checkInDate" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label>Check-out Date *</label>
                        <input type="date" name="checkOutDate" class="form-control" required>
                    </div>
                </div>
                
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label>Number of Guests</label>
                        <input type="number" name="numberOfGuests" class="form-control" min="1" max="4" value="2">
                    </div>
                </div>
                
                <div class="mb-3">
                    <label>Special Requests</label>
                    <textarea name="specialRequests" class="form-control" rows="3"></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Create Reservation
                </button>
                <a href="dashboard" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>