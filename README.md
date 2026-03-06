# 🍽️ Restaurant Table Reservation System

Spring Boot + MySQL + Thymeleaf group project.

---

## 👥 Team Members

| Name     | Role                       | Module                             | GitHub |
|----------|----------------------------|------------------------------------|--------|
| sahan    | Backend Architect          | Project Setup,Notification  Auth   | @username |
| Thirshe  | QA & Integration, Frondend | Admin Dashboard & Special requests | @username |
| Swetha   | Developer 1                | User Management                    | @username |
| Kowshika | Developer 2                | Table Management                   | @username |
| Binuth   | Developer 3                | Reservation Management             | @username |
| Hashini  | Developer 4                | Notification & Feedback            | @username |

---

## ⚙️ Technologies Used

- Java 21
- Spring Boot 3.2.x
- MySQL 8.0
- Spring Data JPA
- Thymeleaf
- Bootstrap 5
- Maven

---

## 🖥️ How to Run the Project

### Step 1 — Requirements
Make sure you have installed:
- Java r 21
- MySQL 8.0
- Maven
- IntelliJ IDEA 

### Step 2 — Clone the Repository
git clone https://github.com/IT25102074/restaurant-table-reservation-system.git
cd restaurant-table-reservation-system

### Step 3 — Create the Database
Open MySQL Workbench and run:
CREATE DATABASE restaurant_db;

### Step 4 — Configure application.properties
Open src/main/resources/application.properties
Change the password to YOUR MySQL root password:
spring.datasource.password=your_password

### Step 5 — Run the Project
mvn spring-boot:run
OR open in IntelliJ and click the Run button.

### Step 6 — Open in Browser
http://localhost:8080

---

## 🌳 Branch Strategy

| Branch | Purpose |
|--------|---------|
| main | Final working code only |
| develop | All features combine here |
| feature/* | Each developer's work |

---

## 📁 Project Structure

src/main/java/com/restaurant/reservation/
│
├── controller/        → handles web requests
├── service/           → business logic
├── model/             → database entity classes
└── repository/        → database operations

---

[//]: # (## 🔐 System Modules)

[//]: # ()
[//]: # (| Module | Developer | Status |)

[//]: # (|--------|-----------|--------|)

[//]: # (| User Management | Dev 1 | 🔄 In Progress |)

[//]: # (| Table Management | Dev 2 | 🔄 In Progress |)

[//]: # (| Reservation Management | Dev 3 | 🔄 In Progress |)

[//]: # (| Notification & Feedback | Dev 4 | 🔄 In Progress |)

[//]: # (| Admin Dashboard | Lead 2 | 🔄 In Progress |)

[//]: # (| Auth & Security | Lead 1 | 🔄 In Progress |)