# Restaurant Table Reservation Platform - Table Management Module

This project implements **Component 02: Table Management** for a restaurant reservation platform.

## Features
- Create table records with:
  - Table code
  - Capacity
  - Table type (`INDOOR` / `OUTDOOR`)
  - Availability status (`AVAILABLE`, `RESERVED`, `MAINTENANCE`)
- Read and display all table records with status
- Update existing table details
- Delete table records
- Dashboard with summary cards (total, available, reserved, indoor/outdoor)

## Technologies
- Java 17
- Spring Boot
- Thymeleaf (HTML templates)
- CSS + JavaScript
- MySQL (configured datasource)

## MySQL Setup
1. Create a database in MySQL:
   ```sql
   CREATE DATABASE table_management;
   ```
2. Set environment variables before starting the app:
   ```powershell
   $env:DB_URL="jdbc:mysql://localhost:3306/table_management?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true"
   $env:DB_USERNAME="root"
   $env:DB_PASSWORD="your_password"
   ```
3. Run the app:
   ```bash
   mvn spring-boot:run
   ```

## Storage
Data is persisted only in MySQL table `restaurant_tables`.

## Run
1. Open terminal in project root.
2. Run:
   ```bash
   mvn spring-boot:run
   ```
3. Open browser:
   - `http://localhost:8080/`

## UI Pages
- Dashboard: `/`
- Table List Page: `/tables`
- Add Table Page: `/tables/add`
- Edit Table Page: `/tables/{id}/edit`
