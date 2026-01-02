-- Create database
CREATE DATABASE IF NOT EXISTS appointment_db;
USE appointment_db;

-- Create patients table
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create doctors table
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create appointments table
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    slot VARCHAR(20) NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    UNIQUE KEY unique_booking (doctor_id, slot)
);

-- Insert sample doctors
INSERT INTO doctors (name, specialization) VALUES
('Dr. John Smith', 'Cardiologist'),
('Dr. Sarah Johnson', 'Dermatologist'),
('Dr. Michael Brown', 'Orthopedic'),
('Dr. Emily Davis', 'Pediatrician'),
('Dr. Robert Wilson', 'Neurologist');

-- Insert sample patient (password: 123456)
INSERT INTO patients (name, email, password) VALUES
('Test Patient', 'test@example.com', '123456');