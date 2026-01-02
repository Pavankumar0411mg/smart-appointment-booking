# Quick Deployment Guide

## 1. Database Setup
Run this command in MySQL:
```
mysql -u root -p < database.sql
```
Or execute the SQL manually in MySQL Workbench/phpMyAdmin.

## 2. Required JAR Files
Download and place in `lib/` folder:
- mysql-connector-java-8.0.33.jar
- servlet-api.jar

## 3. Build & Deploy
```
build.bat
```
Copy `appointment-system.war` to Tomcat `webapps/` folder.

## 4. Access Application
http://localhost:8080/appointment-system/

## Default Login
- Email: test@example.com  
- Password: 123456

## Database Credentials Updated
- Username: root
- Password: (empty)
- Database: appointment_db