<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.appointment.util.DBConnection" %>
<%
    if (session.getAttribute("patientId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - Appointment System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">AppointmentBook</div>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="doctors.jsp">Doctors</a></li>
                <li><a href="appointments.jsp">My Appointments</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h1>My Appointments</h1>
        
        <div class="appointments-grid">
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT a.id, a.slot, a.status, d.name as doctor_name, d.specialization " +
                                "FROM appointments a JOIN doctors d ON a.doctor_id = d.id " +
                                "WHERE a.patient_id = ? ORDER BY a.id DESC";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, (Integer) session.getAttribute("patientId"));
                    ResultSet rs = stmt.executeQuery();
                    
                    boolean hasAppointments = false;
                    while (rs.next()) {
                        hasAppointments = true;
                        String status = rs.getString("status");
                        String statusClass = status.toLowerCase();
            %>
            <div class="appointment-card">
                <div>
                    <h3>Dr. <%= rs.getString("doctor_name") %></h3>
                    <p><%= rs.getString("specialization") %></p>
                    <p><strong>Time:</strong> <%= rs.getString("slot") %></p>
                </div>
                <div>
                    <span class="status <%= statusClass %>"><%= status %></span>
                </div>
            </div>
            <%
                    }
                    
                    if (!hasAppointments) {
            %>
            <div class="card">
                <p>No appointments found. <a href="doctors.jsp">Book your first appointment</a></p>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
            %>
            <div class="alert alert-error">
                Error loading appointments. Please try again later.
            </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>