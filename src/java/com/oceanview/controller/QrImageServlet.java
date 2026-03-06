package com.oceanview.controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qr-image")
public class QrImageServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String number = request.getParameter("number");
        if (number == null || number.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing reservation number");
            return;
        }

        // Optional: make sure reservation exists
        Reservation reservation = reservationDAO.findByReservationNumber(number);
        if (reservation == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found");
            return;
        }

        String qrText = "Reservation " + number;

        response.setContentType("image/png");
        if (request.getParameter("download") != null) {
            response.setHeader("Content-Disposition",
                    "attachment; filename=\"reservation-" + number + "-qr.png\"");
        }

        try (OutputStream out = response.getOutputStream()) {
            QRCodeWriter writer = new QRCodeWriter();
            BitMatrix matrix = writer.encode(qrText, BarcodeFormat.QR_CODE, 300, 300);
            MatrixToImageWriter.writeToStream(matrix, "PNG", out);
        } catch (WriterException e) {
            throw new ServletException("Failed to generate QR code", e);
        }
    }
}

