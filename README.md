# 🍽️ ReserveSmart — Restaurant Table Reservation System

A web-based **Restaurant Table Reservation System** built using **Spring Boot, MySQL, and JSP (JavaServer Pages)**.

This system allows customers to reserve tables online and enables administrators to efficiently manage tables, reservations, users, feedback, and notifications.

📌 Developed as a **group project for the Object-Oriented Programming (OOP) module — SE1020**

---

## 🚀 Features

- 👤 User registration and login (session-based auth)
- 📅 Online table reservation with conflict detection
- 🪑 Table availability management with recommendation engine
- 📋 Reservation management (create, update, cancel, confirm)
- 🧑‍💼 Admin dashboard with live analytics
- 🔔 Notification system (System + Gmail Email + SMS)
- ⭐ Customer feedback system with star ratings
- 🔍 Search and filter across all modules
- 🛡️ Role-based access control (CUSTOMER / ADMIN)
- ✅ Strong validation (capacity, conflict, date/time)

---

## 👥 Team Members

| Name     | Role                      | Module                                          | GitHub |
|----------|---------------------------|-------------------------------------------------|--------|
| Sahan    | Backend Architect & Lead  | Project Setup, Auth, Notifications, Integration | https://github.com/IT25102074 |
| Thirshe  | QA & Frontend Lead        | Admin Dashboard, UI Polish, Testing             | https://github.com/ArsenicV |
| Swetha   | Developer                 | User Management                                 | — |
| Kowshika | Developer                 | Table Management                                | — |
| Binuth   | Developer                 | Reservation Management                          | — |
| Hashini  | Developer                 | Feedback Management                             | — |

---

## ⚙️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 21 |
| Backend | Spring Boot 3.2.x |
| Frontend | JSP (JavaServer Pages) + JSTL |
| Styling | Tailwind CSS (CDN) |
| Database | MySQL 8.0 |
| ORM | Spring Data JPA / Hibernate |
| Email | Spring Mail + Gmail SMTP |
| SMS | Twilio (mock mode by default) |
| Build | Maven |
| Version Control | Git & GitHub |
| IDE | IntelliJ IDEA |

---

## 🗂️ Project Structure

```
src/main/java/com/reservesmart/
├── controller/        ← Spring MVC Controllers
├── model/             ← JPA Entity classes (OOP hierarchy)
├── repository/        ← Spring Data JPA Repositories
├── service/           ← Business logic + Validators
└── ReserveSmartApplication.java

src/main/webapp/WEB-INF/views/
├── auth/              ← login.jsp, register.jsp
├── customer/          ← dashboard, tables, reservations, feedback, notifications, profile
├── admin/             ← dashboard, users, tables, reservations, feedback
└── common/            ← header.jsp, footer.jsp
```

---

## 🖥️ Getting Started

### 1️⃣ Prerequisites

Make sure you have installed:

- Java JDK 21
- MySQL Server 8.0
- Maven
- IntelliJ IDEA (recommended)
- Git

---

### 2️⃣ Clone Repository

```bash
git clone https://github.com/IT25102074/restaurant-table-reservation-system.git
cd restaurant-table-reservation-system
```

---

### 3️⃣ Create the Database

Open **MySQL Workbench** and run:

```sql
CREATE DATABASE reservesmart_db;
```

---

### 4️⃣ Configure application.properties

Open `src/main/resources/application.properties` and update:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/reservesmart_db?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=YOUR_MYSQL_PASSWORD

# Gmail (optional — leave blank to use mock mode)
spring.mail.username=your_gmail@gmail.com
spring.mail.password=your_gmail_app_password
```

> ⚠️ Never commit your real password. Use `your_password` as a placeholder before pushing.

---

### 5️⃣ Run the Project

Click **Run** in IntelliJ, then open:

```
http://localhost:8080
```

---

### 6️⃣ Seed the Admin Account

Run this SQL in MySQL Workbench after the app starts:

```sql
USE reservesmart_db;

INSERT INTO users (dtype, full_name, email, password, phone, role, created_at)
VALUES ('ADMIN', 'Super Admin', 'admin@reservesmart.com', 'admin123', '0771234567', 'ADMIN', NOW());
```

Login with:
- **Email:** `admin@reservesmart.com`
- **Password:** `admin123`

---

## 🧠 OOP Concepts Applied

| Concept | Where Used |
|---------|-----------|
| **Abstraction** | `User` abstract class, `Notification` abstract class, `ReservationValidator` interface |
| **Encapsulation** | All model fields are `private` with getters/setters; business logic hidden in service layer |
| **Inheritance** | `Customer` & `Admin` extend `User`; `SystemNotification`, `EmailNotification`, `SmsNotification` extend `Notification` |
| **Polymorphism** | `getDashboardUrl()` overridden per role; `sendNotification()` overridden per notification type; all 3 validators implement `validate()` differently |

---

## 📄 License

This project is developed for academic purposes under the OOP module — SE1020.
