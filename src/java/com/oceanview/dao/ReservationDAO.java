package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.model.Guest;
import com.oceanview.model.Room;
import com.oceanview.model.RoomType;
import com.oceanview.pattern.singleton.DatabaseConnection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    private static volatile boolean schemaInitialized = false;

    public ReservationDAO() {
        ensureSchema();
    }

    private Connection getConnection() throws SQLException {
        return DatabaseConnection.getInstance().getConnection();
    }

    private void ensureSchema() {
        if (schemaInitialized) {
            return;
        }
        synchronized (ReservationDAO.class) {
            if (schemaInitialized) {
                return;
            }

            String sql = """
                CREATE TABLE IF NOT EXISTS public_reservations (
                    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
                    reservation_number VARCHAR(20) UNIQUE,
                    full_name VARCHAR(100) NOT NULL,
                    email VARCHAR(150),
                    contact_number VARCHAR(50),
                    address VARCHAR(255),
                    id_proof_type VARCHAR(50),
                    id_proof_number VARCHAR(100),
                    room_type_code VARCHAR(10),
                    room_type_name VARCHAR(100),
                    room_rate DECIMAL(10,2),
                    check_in DATE,
                    check_out DATE,
                    total_nights INT,
                    number_of_guests INT,
                    subtotal DECIMAL(12,2),
                    tax_amount DECIMAL(12,2),
                    discount_amount DECIMAL(12,2),
                    total_amount DECIMAL(12,2),
                    payment_status VARCHAR(20),
                    booking_status VARCHAR(20),
                    special_requests TEXT,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
                """;

            try (Connection con = getConnection(); Statement st = con.createStatement()) {
                st.execute(sql);
                schemaInitialized = true;
            } catch (SQLException e) {
                // If schema init fails, keep schemaInitialized false so we can retry later
                e.printStackTrace();
            }
        }
    }

    public Reservation save(Reservation reservation) {
        String insert = """
            INSERT INTO public_reservations (
                reservation_number,
                full_name, email, contact_number, address,
                id_proof_type, id_proof_number,
                room_type_code, room_type_name, room_rate,
                check_in, check_out, total_nights, number_of_guests,
                subtotal, tax_amount, discount_amount, total_amount,
                payment_status, booking_status, special_requests
            ) VALUES (
                NULL,
                ?, ?, ?, ?,
                ?, ?,
                ?, ?, ?,
                ?, ?, ?, ?,
                ?, ?, ?, ?,
                ?, ?, ?
            )
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {

            Guest g = reservation.getGuest();
            Room room = reservation.getRoom();
            RoomType rt = (room != null) ? room.getRoomType() : null;

            ps.setString(1, g != null ? g.getFullName() : null);
            ps.setString(2, g != null ? g.getEmail() : null);
            ps.setString(3, g != null ? g.getContactNumber() : null);
            ps.setString(4, g != null ? g.getAddress() : null);
            ps.setString(5, g != null ? g.getIdProofType() : null);
            ps.setString(6, g != null ? g.getIdProofNumber() : null);

            ps.setString(7, rt != null ? rt.getTypeCode() : null);
            ps.setString(8, rt != null ? rt.getTypeName() : null);
            ps.setBigDecimal(9, reservation.getRoomRate());

            ps.setDate(10, reservation.getCheckInDate() != null ? Date.valueOf(reservation.getCheckInDate()) : null);
            ps.setDate(11, reservation.getCheckOutDate() != null ? Date.valueOf(reservation.getCheckOutDate()) : null);
            ps.setInt(12, reservation.getTotalNights());
            ps.setInt(13, reservation.getNumberOfGuests());

            ps.setBigDecimal(14, reservation.getSubtotal());
            ps.setBigDecimal(15, reservation.getTaxAmount());
            ps.setBigDecimal(16, reservation.getDiscountAmount());
            ps.setBigDecimal(17, reservation.getTotalAmount());

            ps.setString(18, reservation.getPaymentStatus());
            ps.setString(19, reservation.getBookingStatus());
            ps.setString(20, reservation.getSpecialRequests());

            ps.executeUpdate();

            int id;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (!keys.next()) {
                    throw new SQLException("Failed to get generated reservation_id");
                }
                id = keys.getInt(1);
            }

            String number = String.format("RES%06d", id);
            try (PreparedStatement ups = con.prepareStatement(
                    "UPDATE public_reservations SET reservation_number = ? WHERE reservation_id = ?")) {
                ups.setString(1, number);
                ups.setInt(2, id);
                ups.executeUpdate();
            }

            reservation.setReservationId(id);
            reservation.setReservationNumber(number);
            if (g != null) {
                g.setReservationNumber(number);
            }

            return reservation;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Reservation> findAll() {
        String sql = "SELECT * FROM public_reservations ORDER BY reservation_id DESC";
        List<Reservation> out = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                out.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return out;
    }

    public Reservation findByReservationNumber(String reservationNumber) {
        if (reservationNumber == null || reservationNumber.isBlank()) {
            return null;
        }
        String sql = "SELECT * FROM public_reservations WHERE reservation_number = ? LIMIT 1";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, reservationNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Reservation mapRow(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setReservationId(rs.getInt("reservation_id"));
        reservation.setReservationNumber(rs.getString("reservation_number"));
        reservation.setCheckInDate(rs.getDate("check_in").toLocalDate());
        reservation.setCheckOutDate(rs.getDate("check_out").toLocalDate());
        reservation.setTotalNights(rs.getInt("total_nights"));
        reservation.setNumberOfGuests(rs.getInt("number_of_guests"));
        reservation.setRoomRate(rs.getBigDecimal("room_rate"));
        reservation.setSubtotal(rs.getBigDecimal("subtotal"));
        reservation.setTaxAmount(rs.getBigDecimal("tax_amount"));
        reservation.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        reservation.setTotalAmount(rs.getBigDecimal("total_amount"));
        reservation.setPaymentStatus(rs.getString("payment_status"));
        reservation.setBookingStatus(rs.getString("booking_status"));
        reservation.setSpecialRequests(rs.getString("special_requests"));

        Guest g = new Guest();
        g.setReservationNumber(reservation.getReservationNumber());
        g.setFullName(rs.getString("full_name"));
        g.setEmail(rs.getString("email"));
        g.setContactNumber(rs.getString("contact_number"));
        g.setAddress(rs.getString("address"));
        g.setIdProofType(rs.getString("id_proof_type"));
        g.setIdProofNumber(rs.getString("id_proof_number"));
        reservation.setGuest(g);

        RoomType rt = new RoomType();
        rt.setTypeCode(rs.getString("room_type_code"));
        rt.setTypeName(rs.getString("room_type_name"));
        rt.setBaseRate(rs.getBigDecimal("room_rate"));

        Room room = new Room();
        room.setRoomType(rt);
        reservation.setRoom(room);

        return reservation;
    }
}
