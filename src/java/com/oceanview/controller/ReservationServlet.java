/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Guest;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.model.RoomType;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author marye
 */
@WebServlet("/reservation/*")
public class ReservationServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        switch (path) {
            case "/new" -> request.getRequestDispatcher("/views/newReservation.jsp").forward(request, response);
            case "/list" -> {
                request.setAttribute("reservations", reservationDAO.findAll());
                request.getRequestDispatcher("/views/reservationList.jsp").forward(request, response);
            }
            case "/details" -> {
                String number = request.getParameter("number");
                Reservation reservation = reservationDAO.findByReservationNumber(number);
                if (reservation == null) {
                    response.sendRedirect(request.getContextPath() + "/views/error/404.jsp");
                } else {
                    request.setAttribute("reservation", reservation);
                    request.getRequestDispatcher("/views/reservationDetails.jsp").forward(request, response);
                }
            }
            case "/scan" -> request.getRequestDispatcher("/views/scanQR.jsp").forward(request, response);
            default -> response.sendRedirect(request.getContextPath() + "/");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle reservation creation from public booking form
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            Reservation reservation = buildReservationFromRequest(request);
            Reservation saved = reservationDAO.save(reservation);
            if (saved == null || saved.getReservationNumber() == null) {
                response.sendRedirect(request.getContextPath() + "/views/error/500.jsp");
                return;
            }
            // Redirect to booking success with reservation number
            response.sendRedirect(request.getContextPath()
                    + "/views/bookingSuccess.jsp?number=" + saved.getReservationNumber());
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private Reservation buildReservationFromRequest(HttpServletRequest request) {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");
        String idProofType = request.getParameter("idProofType");
        String idProofNumber = request.getParameter("idProofNumber");
        String roomTypeCode = request.getParameter("roomType");
        String checkInStr = request.getParameter("checkInDate");
        String checkOutStr = request.getParameter("checkOutDate");
        String guestsStr = request.getParameter("numberOfGuests");
        String specialRequests = request.getParameter("specialRequests");

        Guest guest = new Guest(fullName, email, contactNumber);
        guest.setAddress(address);
        guest.setIdProofType(idProofType);
        guest.setIdProofNumber(idProofNumber);

        // Simple room type mapping (STD / DLX / STE)
        RoomType roomType = new RoomType();
        if ("DLX".equals(roomTypeCode)) {
            roomType.setTypeCode("DLX");
            roomType.setTypeName("Deluxe Room");
            roomType.setBaseRate(new BigDecimal("12500"));
        } else if ("STE".equals(roomTypeCode)) {
            roomType.setTypeCode("STE");
            roomType.setTypeName("Executive Suite");
            roomType.setBaseRate(new BigDecimal("18500"));
        } else {
            roomType.setTypeCode("STD");
            roomType.setTypeName("Standard Room");
            roomType.setBaseRate(new BigDecimal("7500"));
        }

        Room room = new Room();
        room.setRoomType(roomType);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate checkIn = LocalDate.parse(checkInStr, formatter);
        LocalDate checkOut = LocalDate.parse(checkOutStr, formatter);
        long nights = Math.max(1, ChronoUnit.DAYS.between(checkIn, checkOut));

        int guests = 1;
        try {
            guests = Integer.parseInt(guestsStr);
        } catch (NumberFormatException ignored) {}

        Reservation reservation = new Reservation();
        reservation.setGuest(guest);
        reservation.setRoom(room);
        reservation.setCheckInDate(checkIn);
        reservation.setCheckOutDate(checkOut);
        reservation.setNumberOfGuests(guests);
        reservation.setTotalNights((int) nights);
        reservation.setRoomRate(roomType.getBaseRate());
        reservation.setSubtotal(roomType.getBaseRate().multiply(BigDecimal.valueOf(nights)));
        reservation.setTaxAmount(BigDecimal.ZERO);
        reservation.setDiscountAmount(BigDecimal.ZERO);
        reservation.setTotalAmount(reservation.getSubtotal());
        reservation.setPaymentStatus("pending");
        reservation.setBookingStatus("confirmed");
        reservation.setSpecialRequests(specialRequests);

        return reservation;
    }
}
 
