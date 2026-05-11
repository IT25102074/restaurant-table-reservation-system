# 🤝 Contributing Guide — How to Work on This Project

Please read this guide carefully before contributing to the project.

---

# ✅ Step 1 — First Time Setup

## Clone the Repository

```bash
git clone https://github.com/IT25102074/restaurant-table-reservation-system.git
cd restaurant-table-reservation-system
```

## Switch to Develop Branch

```bash
git checkout develop
git pull origin develop
```

## Open in IntelliJ IDEA

1. Open IntelliJ IDEA
2. Click **File → Open**
3. Select the project folder

Wait for **Maven to download all dependencies**.

---

## Setup Your Database

1. Open **MySQL Workbench**
2. Run the following command:

```sql
CREATE DATABASE restaurant_db;
```

3. Open:

```
src/main/resources/application.properties
```

4. Change the database password to **your MySQL password**.

---

## Run the Project

Click **Run** in IntelliJ.

Then open your browser:

```
http://localhost:8080
```

---

# ✅ Step 2 — Your Files to Work On

## Developer 1 — User Management

Files responsible for:

- model/User.java
- model/Customer.java
- model/Admin.java
- repository/UserRepository.java
- service/UserService.java
- controller/UserController.java
- templates/register.html
- templates/login.html
- templates/profile.html

---

## Developer 2 — Table Management

Files responsible for:

- model/RestaurantTable.java
- repository/TableRepository.java
- service/TableService.java
- controller/TableController.java
- templates/tables.html
- templates/admin-tables.html

---

## Developer 3 — Reservation Management

Files responsible for:

- model/Reservation.java
- repository/ReservationRepository.java
- service/ReservationService.java
- controller/ReservationController.java
- templates/reservation-form.html
- templates/my-reservations.html

---

## Developer 4 — Notification & Feedback

Files responsible for:

- model/Notification.java
- repository/NotificationRepository.java
- service/NotificationService.java
- controller/NotificationController.java
- templates/notifications.html
- templates/feedback.html
- templates/home.html
- static/css/style.css

---

## Developer 5 — Admin Dashboard / Auth

Files responsible for:

- controller/AdminController.java
- templates/admin-dashboard.html
- templates/admin-users.html
- templates/admin-reservations.html

---

## Developer 6 — Project Setup & Auth / Notifications

Files responsible for:

- ReservationApplication.java
- application.properties
- Base model classes
- Security configuration

---

# ✅ Step 3 — Daily Workflow

## Every day before coding

Always pull the latest code first:

```bash
git checkout develop
git pull origin develop
```

---

## Create your feature branch (only once)

Example:

```bash
git checkout -b feature/user-management
```

---

## After writing code

Save your work:

```bash
git add .
git commit -m "[ADD] User registration logic"
git push origin feature/user-management
```

---

## When your feature is ready — Create a Pull Request

1. Go to **GitHub**
2. Click **Pull Requests → New Pull Request**
3. Base branch: `develop`
4. Compare branch: `feature/user-management`
5. Title example:

```
[FEATURE] User Management Module
```

6. Describe what you built
7. Request review from **Lead 1 or Lead 2**

---

# ✅ Step 4 — Commit Message Rules

Always follow this format:

```
[TYPE] Short description
```

| Type | When to Use |
|-----|-------------|
| INIT | First setup only |
| ADD | Adding new feature or file |
| FIX | Bug fix |
| UPDATE | Changing existing code |
| DOCS | Documentation updates |
| REMOVE | Removing unused code |

Examples:

```
[ADD] User registration with MySQL
[FIX] Table availability check bug
[UPDATE] Reservation form validation
[DOCS] Update README setup steps
```

---

# ✅ Step 5 — Important Rules

1. **Never push directly to `main` or `develop`.**
2. Always create a **feature branch**.
3. Always **pull the latest develop branch before coding**.
4. Do not edit another developer's files without discussion.
5. Always write **clear commit messages**.
6. Test your code before creating a **Pull Request**.
7. Never commit `application.properties` with your real password.

Before committing, make sure:

```
spring.datasource.password=your_password
```

---



---
