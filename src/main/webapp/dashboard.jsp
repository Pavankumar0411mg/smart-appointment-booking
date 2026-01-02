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
    <title>Dashboard - Appointment System</title>
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
        <h1>Welcome, <%= session.getAttribute("patientName") %>!</h1>
        
        <div class="doctor-grid">
            <div class="card">
                <h3>Quick Stats</h3>
                <%
                    int totalAppointments = 0;
                    int pendingAppointments = 0;
                    
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT COUNT(*) as total, SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) as pending FROM appointments WHERE patient_id = ?";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, (Integer) session.getAttribute("patientId"));
                        ResultSet rs = stmt.executeQuery();
                        
                        if (rs.next()) {
                            totalAppointments = rs.getInt("total");
                            pendingAppointments = rs.getInt("pending");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
                <p>Total Appointments: <strong><%= totalAppointments %></strong></p>
                <p>Pending Appointments: <strong><%= pendingAppointments %></strong></p>
            </div>
            
            <div class="card">
                <h3>Quick Actions</h3>
                <a href="doctors.jsp" class="btn">Book New Appointment</a>
                <br><br>
                <a href="appointments.jsp" class="btn">View My Appointments</a>
            </div>
        </div>
    </div>
</body>
</html>