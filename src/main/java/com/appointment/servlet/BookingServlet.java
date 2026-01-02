package com.appointment.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.appointment.util.DBConnection;

public class BookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String slot = request.getParameter("slot");
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO appointments (patient_id, doctor_id, slot, status) VALUES (?, ?, ?, 'Pending')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, patientId);
            stmt.setInt(2, doctorId);
            stmt.setString(3, slot);
            
            int result = stmt.executeUpdate();
            
            if (result > 0) {
                request.setAttribute("success", "Appointment booked successfully!");
            } else {
                request.setAttribute("error", "Booking failed");
            }
            request.getRequestDispatcher("doctors.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error or slot already booked");
            request.getRequestDispatcher("doctors.jsp").forward(request, response);
        }
    }
}