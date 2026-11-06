 # Smart Appointment Booking System. 
        
A complete web application for booking medical appointments built with JSP, Servlets, and MySQL.

## Project Structure

```
appointment-system/
├── src/main/
│   ├── java/com/appointment/
│   │   ├── servlet/
│   │   │   ├── LoginServlet.java
│   │   │   ├── RegisterServlet.java
│   │   │   ├── BookingServlet.java
│   │   │   └── LogoutServlet.java
│   │   └── util/
│   │       └── DBConnection.java
│   └── webapp/
│       ├── WEB-INF/
│       │   └── web.xml
│       ├── css/
│       │   └── style.css
│       ├── index.jsp
│       ├── login.jsp
│       ├── register.jsp
│       ├── dashboard.jsp
│       ├── doctors.jsp
│       └── appointments.jsp
├── database.sql
└── README.md
```

## Features

- **Patient Registration & Login**: Secure authentication with session management
- **Doctor Listings**: View available doctors with specializations
- **Appointment Booking**: Book appointments with 3 time slots per doctor
- **Dashboard**: View appointment statistics and quick actions
- **Appointment Management**: Track appointment status (Pending/Confirmed/Cancelled)
- **Responsive Design**: Mobile-friendly interface

## Setup Instructions

### 1. Database Setup
```sql
-- Run the database.sql file in MySQL
mysql -u root -p < database.sql
```

### 2. Update Database Configuration
Edit `DBConnection.java` and update:
- URL: `jdbc:mysql://localhost:3306/appointment_db`
- USERNAME: Your MySQL username
- PASSWORD: Your MySQL password

### 3. Dependencies Required
Add to your project classpath:
- MySQL Connector/J
- Servlet API
- JSP API

### 4. Deploy
- Deploy the WAR file to Tomcat
- Access at: `http://localhost:8080/appointment-system/`

## Default Login
- Email: test@example.com
- Password: 123456

## Database Schema

### patients
- id (Primary Key)
- name
- email (Unique)
- password

### doctors
- id (Primary Key)
- name
- specialization

### appointments
- id (Primary Key)
- patient_id (Foreign Key)
- doctor_id (Foreign Key)
- slot
- status (Pending/Confirmed/Cancelled)

## Time Slots Available
- 09:00-10:00
- 14:00-15:00
- 16:00-17:00

## Technologies Used
- Frontend: HTML5, CSS3, JavaScript
- Backend: Java (JSP + Servlets)
- Database: MySQL
- Server: Apache Tomcat
