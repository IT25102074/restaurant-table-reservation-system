# 🍽️ Restaurant Table Reservation System

A web-based **Restaurant Table Reservation System** built using **Spring Boot, MySQL, and Thymeleaf**.  
This system allows customers to reserve tables online and enables administrators to manage tables, reservations, and users efficiently.

This project was developed as a **group project for the Object-Oriented Programming (OOP) module**.

---

# 📌 Features

- User registration and login
- Online table reservation
- Table availability management
- Reservation management
- Admin dashboard
- Notification system
- Customer feedback system
- Special reservation requests

---

# 👥 Team Members

| Name | Role | Module | GitHub |
|-----|-----|-----|-----|
| Sahan | Backend Architect | Project Setup, Authentication, Notifications | https://github.com/IT25102074 |
| Thirshe | QA & Integration, Frontend | Admin Dashboard & Special Requests | @username |
| Swetha | Developer | User Management | @username |
| Kowshika | Developer | Table Management | @username |
| Binuth | Developer | Reservation Management | @username |
| Hashini | Developer | Notification & Feedback | @username |

---

# ⚙️ Technologies Used

- Java 21
- Spring Boot 3.2.x
- MySQL 8.0
- Spring Data JPA
- Thymeleaf
- Bootstrap 5
- Maven
- Git & GitHub

---

# 🖥️ How to Run the Project

## 1️⃣ Prerequisites

Make sure the following software is installed on your system:

- Java JDK 21
- MySQL Server 8.0
- Maven
- IntelliJ IDEA (recommended) or any Java IDE
- Git

---

## 2️⃣ Clone the Repository

```bash
git clone https://github.com/IT25102074/restaurant-table-reservation-system.git
cd restaurant-table-reservation-system
```

---

## 3️⃣ Create the Database

Open **MySQL Workbench** or MySQL terminal and run:

```sql
CREATE DATABASE restaurant_db;
```

---

## 4️⃣ Configure Database Connection

Open the file:

```
src/main/resources/application.properties
```

Update the following properties with your MySQL credentials:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/restaurant_db
spring.datasource.username=root
spring.datasource.password=your_password

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

---

## 5️⃣ Run the Application

Using Maven:

```bash
mvn spring-boot:run
```

Or open the project in **IntelliJ IDEA** and click the **Run** button.

---

## 6️⃣ Access the Application

Open your browser and go to:

```
http://localhost:8080
```

---

# 🌳 Branch Strategy

This project follows a **Git branching strategy for team collaboration**.

| Branch | Purpose |
|------|------|
| main | Stable production-ready code |
| develop | Integration branch for all features |
| feature/* | Individual developer feature branches |

Example feature branches:

```
feature/user-management
feature/table-management
feature/reservation-management
feature/notification-system
```

---

# 📁 Project Structure

```
src
 └── main
     ├── java
     │   └── com.restaurant.reservation
     │       ├── controller
     │       ├── service
     │       ├── model
     │       └── repository
     │
     └── resources
         ├── templates
         ├── static
         └── application.properties
```

---

# 📊 System Modules

| Module | Responsible Developer | Status |
|------|------|------|
| User Management | Swetha | In Progress |
| Table Management | Kowshika | In Progress |
| Reservation Management | Binuth | In Progress |
| Notification & Feedback | Hashini | In Progress |
| Admin Dashboard | Thirshe | In Progress |
| Authentication & Security | Sahan | In Progress |

---

# 🔐 User Roles

## Customer
- Register an account
- Login to the system
- View available tables
- Make reservations
- Submit feedback

## Admin
- Manage users
- Manage restaurant tables
- View and manage reservations
- Handle special requests
- Monitor system activity

---

# 📄 License

This project was developed for **educational purposes** as part of a **university group assignment**.

---

# 📬 Contact

For questions or issues related to the project, please contact the development team through GitHub.