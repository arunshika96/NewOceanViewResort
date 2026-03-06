package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String number = request.getParameter("number");
        Reservation reservation = reservationDAO.findByReservationNumber(number);
        if (reservation == null) {
            response.sendRedirect(request.getContextPath() + "/views/error/404.jsp");
            return;
        }
        request.setAttribute("reservation", reservation);
        request.getRequestDispatcher("/views/bill.jsp").forward(request, response);
    }
}

