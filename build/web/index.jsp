<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #667eea;
            --secondary: #764ba2;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }
        
        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 100px 0;
            position: relative;
            overflow: hidden;
        }
        
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3') center/cover;
            opacity: 0.1;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        /* Navigation */
        .navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 15px 0;
        }
        
        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary) !important;
        }
        
        .btn-login-nav {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 10px 30px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            transition: transform 0.3s;
        }
        
        .btn-login-nav:hover {
            transform: translateY(-2px);
            color: white;
        }
        
        /* Features Section */
        .features {
            padding: 80px 0;
            background: #f8f9fa;
        }
        
        .feature-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: transform 0.3s;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
        }
        
        .feature-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 20px;
        }
        
        /* Room Cards */
        .rooms {
            padding: 80px 0;
        }
        
        .room-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        
        .room-image {
            height: 250px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
        }
        
        .room-details {
            padding: 20px;
        }
        
        .room-price {
            color: var(--primary);
            font-size: 1.5rem;
            font-weight: 700;
        }
        
        .btn-book {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            width: 100%;
            font-weight: 600;
            transition: transform 0.3s;
        }
        
        .btn-book:hover {
            transform: translateY(-2px);
            color: white;
        }
        
        /* Login Modal */
        .modal-content {
            border-radius: 15px;
            border: none;
        }
        
        .modal-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border-radius: 15px 15px 0 0;
        }
        
        .modal-title {
            font-weight: 600;
        }
        
        .btn-close {
            filter: brightness(0) invert(1);
        }
        
        /* Footer */
        .footer {
            background: #2d3748;
            color: white;
            padding: 50px 0 20px;
        }
        
        .footer a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .footer a:hover {
            color: white;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#home">
                <i class="fas fa-hotel"></i> Ocean View Resort
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="mainNav">
                <ul class="navbar-nav me-3">
                    <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="#rooms">Rooms</a></li>
                    <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/reservation/new">Book</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
                </ul>
                <!-- Login Button (opens modal) -->
                <button class="btn-login-nav" data-bs-toggle="modal" data-bs-target="#loginModal">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>
            </div>
        </div>
    </nav>

    <!-- Home / Hero Section -->
    <section id="home" class="hero">
        <div class="container hero-content text-center">
            <h1>Welcome to Paradise</h1>
            <p class="lead mb-4">Experience luxury living at Ocean View Resort, Galle</p>
            <a href="#rooms" class="btn btn-light btn-lg">View Our Rooms</a>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="features">
        <div class="container">
            <h2 class="text-center mb-4">About Ocean View Resort</h2>
            <div class="row align-items-center mb-5">
                <div class="col-md-6">
                    <p class="lead">
                        Nestled on the golden shores of Galle, Ocean View Resort combines Sri Lankan hospitality
                        with modern luxury. Whether you are here for a family vacation, honeymoon, or business trip,
                        we offer the perfect blend of comfort and elegance.
                    </p>
                    <p>
                        Enjoy breathtaking sunsets, world‑class dining, and personalized service designed to make
                        your stay unforgettable.
                    </p>
                </div>
                <div class="col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-umbrella-beach"></i>
                        </div>
                        <h4>Beachfront Escape</h4>
                        <p>
                            Step outside your room and you are just a few meters away from the warm waters of the
                            Indian Ocean.
                        </p>
                    </div>
                </div>
            </div>

            <h3 class="text-center mb-4">Why Choose Us?</h3>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-sea"></i>
                        </div>
                        <h4>Ocean View</h4>
                        <p>All rooms offer stunning views of the Indian Ocean</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-utensils"></i>
                        </div>
                        <h4>Fine Dining</h4>
                        <p>World-class restaurants serving local and international cuisine</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-spa"></i>
                        </div>
                        <h4>Luxury Spa</h4>
                        <p>Rejuvenate with our traditional Ayurvedic treatments</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="rooms">
        <div class="container">
            <h2 class="text-center mb-5">Our Services</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="room-card">
                        <div class="room-image">
                            <i class="fas fa-concierge-bell"></i>
                        </div>
                        <div class="room-details">
                            <h4>24/7 Concierge</h4>
                            <p>Our team is always available to assist with your travel plans, tours, and special requests.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="room-card">
                        <div class="room-image">
                            <i class="fas fa-shuttle-van"></i>
                        </div>
                        <div class="room-details">
                            <h4>Airport Transfers</h4>
                            <p>Comfortable pick‑up and drop‑off services from Colombo and nearby airports.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="room-card">
                        <div class="room-image">
                            <i class="fas fa-swimmer"></i>
                        </div>
                        <div class="room-details">
                            <h4>Recreation & Spa</h4>
                            <p>Infinity pool, spa, and fitness center to help you relax and recharge.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Rooms Section -->
    <section id="rooms" class="rooms">
        <div class="container">
            <h2 class="text-center mb-5">Our Rooms</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="room-card">
                        <div class="room-image">
                            <i class="fas fa-bed"></i>
                        </div>
                        <div class="room-details">
                            <h4>Standard Room</h4>
                            <p class="room-price">LKR 7,500/night</p>
                            <p>Comfortable room with garden view, perfect for couples</p>
                            <a class="btn-book text-center d-block text-decoration-none"
                               href="${pageContext.request.contextPath}/reservation/new">
                                <i class="fas fa-calendar-check"></i> Book Now
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="room-card">
                        <div class="room-image">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="room-details">
                            <h4>Deluxe Room</h4>
                            <p class="room-price">LKR 12,500/night</p>
                            <p>Spacious room with partial sea view and private balcony</p>
                            <a class="btn-book text-center d-block text-decoration-none"
                               href="${pageContext.request.contextPath}/reservation/new">
                                <i class="fas fa-calendar-check"></i> Book Now
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="room-card">
                        <div class="room-image">
                            <i class="fas fa-crown"></i>
                        </div>
                        <div class="room-details">
                            <h4>Executive Suite</h4>
                            <p class="room-price">LKR 18,500/night</p>
                            <p>Luxury suite with panoramic ocean view and Jacuzzi</p>
                            <a class="btn-book text-center d-block text-decoration-none"
                               href="${pageContext.request.contextPath}/reservation/new">
                                <i class="fas fa-calendar-check"></i> Book Now
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Booking Section -->
    <section id="book" class="features">
        <div class="container">
            <h2 class="text-center mb-4">Book Your Stay</h2>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="feature-card">
                        <form action="${pageContext.request.contextPath}/reservation/new" method="GET">
                            <div class="row mb-3">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <label class="form-label">Check‑in</label>
                                    <input type="date" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Check‑out</label>
                                    <input type="date" class="form-control" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4 mb-3 mb-md-0">
                                    <label class="form-label">Guests</label>
                                    <input type="number" min="1" value="2" class="form-control" required>
                                </div>
                                <div class="col-md-8">
                                    <label class="form-label">Room Type</label>
                                    <select class="form-select" required>
                                        <option value="">Select room type</option>
                                        <option>Standard Room</option>
                                        <option>Deluxe Room</option>
                                        <option>Executive Suite</option>
                                    </select>
                                </div>
                            </div>
                            <button type="submit" class="btn-book">
                                <i class="fas fa-calendar-check"></i> Check Availability
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-lock"></i> Staff Login
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                    
                    <form action="${pageContext.request.contextPath}/login" method="POST">
                        <input type="hidden" name="action" value="login">
                        
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </button>
                    </form>
                </div>
                <div class="modal-footer">
                    <small class="text-muted">Demo: admin / 123</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Contact Section -->
    <section id="contact" class="rooms" style="background:#f8f9fa;">
        <div class="container">
            <h2 class="text-center mb-4">Contact Us</h2>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <h5>Visit Us</h5>
                    <p><i class="fas fa-map-marker-alt"></i> Galle, Southern Province, Sri Lanka</p>
                    <p><i class="fas fa-phone"></i> +94 77 123 4567</p>
                    <p><i class="fas fa-envelope"></i> info@oceanview.com</p>
                    <p>We are happy to assist you with reservations, events, and any special requests.</p>
                </div>
                <div class="col-md-6 mb-4">
                    <h5>Send a Message</h5>
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Message</label>
                            <textarea class="form-control" rows="4" required></textarea>
                        </div>
                        <button type="button" class="btn-book">
                            <i class="fas fa-paper-plane"></i> Send Message
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5><i class="fas fa-hotel"></i> Ocean View Resort</h5>
                    <p>Experience luxury living in the heart of Galle.</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Contact Info</h5>
                    <p><i class="fas fa-map-marker-alt"></i> Galle, Sri Lanka</p>
                    <p><i class="fas fa-phone"></i> +94 77 123 4567</p>
                    <p><i class="fas fa-envelope"></i> info@oceanview.com</p>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Follow Us</h5>
                    <div class="social-links">
                        <a href="#" class="me-3"><i class="fab fa-facebook fa-2x"></i></a>
                        <a href="#" class="me-3"><i class="fab fa-instagram fa-2x"></i></a>
                        <a href="#" class="me-3"><i class="fab fa-twitter fa-2x"></i></a>
                    </div>
                </div>
            </div>
            <hr class="bg-light">
            <div class="text-center mt-3">
                <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Show error message in modal if login fails -->
    <script>
        <% if (request.getAttribute("error") != null) { %>
            var loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
            loginModal.show();
        <% } %>
    </script>
</body>
</html>