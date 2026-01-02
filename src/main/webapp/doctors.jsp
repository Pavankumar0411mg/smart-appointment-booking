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
    <title>Doctors - Appointment System</title>
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
        <h1>Available Doctors</h1>
        
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <div class="doctor-grid">
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT * FROM doctors";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();
                    
                    while (rs.next()) {
                        int doctorId = rs.getInt("id");
                        String doctorName = rs.getString("name");
                        String specialization = rs.getString("specialization");
            %>
            <div class="doctor-card">
                <h3><%= doctorName %></h3>
                <p class="specialization"><%= specialization %></p>
                
                <form action="book" method="post">
                    <input type="hidden" name="doctorId" value="<%= doctorId %>">
                    
                    <div class="form-group">
                        <label>Select Time Slot:</label>
                        <div class="time-slots">
                            <label>
                                <input type="radio" name="slot" value="09:00-10:00" required>
                                <span class="time-slot">09:00-10:00</span>
                            </label>
                            <label>
                                <input type="radio" name="slot" value="14:00-15:00" required>
                                <span class="time-slot">14:00-15:00</span>
                            </label>
                            <label>
                                <input type="radio" name="slot" value="16:00-17:00" required>
                                <span class="time-slot">16:00-17:00</span>
                            </label>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-success">Book Appointment</button>
                </form>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>

    <script>
        document.querySelectorAll('input[type="radio"]').forEach(radio => {
            radio.addEventListener('change', function() {
                this.closest('.time-slots').querySelectorAll('.time-slot').forEach(slot => {
                    slot.classList.remove('selected');
                });
                this.nextElementSibling.classList.add('selected');
            });
        });
    </script>
</body>
</html>