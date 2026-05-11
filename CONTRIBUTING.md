# 🤝 Contributing Guide — How to Work on This Project

Please read this guide carefully before contributing to the project.

---

## ✅ Step 1 — First Time Setup

### Clone the Repository

```bash
git clone https://github.com/IT25102074/restaurant-table-reservation-system.git
cd restaurant-table-reservation-system
```

### Switch to Develop Branch

```bash
git checkout develop
git pull origin develop
```

### Open in IntelliJ IDEA

1. Open IntelliJ IDEA
2. Click **File → Open**
3. Select the project folder

Wait for **Maven to download all dependencies**.

---

### Setup Your Database

1. Open **MySQL Workbench**
2. Run:

```sql
CREATE DATABASE reservesmart_db;
```

3. Open `src/main/resources/application.properties`
4. Change the database password to **your MySQL password**

> ⚠️ **Never commit your real password.** Before pushing, reset it to:
> ```properties
> spring.datasource.password=your_password
> ```

---

### Run the Project

Click **Run** in IntelliJ, then open:

```
http://localhost:8080
```

---

## ✅ Step 2 — Your Files to Work On

### Developer 1 — Sahan (Backend Architect & Lead)

**Responsible for:**

```
ReserveSmartApplication.java
application.properties
model/User.java                       ← abstract base class
model/Admin.java
model/Customer.java
model/Notification.java               ← abstract base class
model/SystemNotification.java
model/EmailNotification.java
model/SmsNotification.java
service/ReservationValidator.java     ← interface
service/ConflictValidator.java
service/CapacityValidator.java
service/DateTimeValidator.java
repository/NotificationRepository.java
service/NotificationService.java
service/EmailNotificationService.java
service/SmsNotificationService.java
controller/NotificationController.java
controller/AuthController.java
views/auth/login.jsp
views/auth/register.jsp
views/common/header.jsp
views/common/footer.jsp
```

---

### Developer 2 — Thirshe (QA & Frontend Lead)

**Responsible for:**

```
service/AnalyticsService.java
controller/AdminController.java
views/admin/dashboard.jsp
views/admin/users.jsp
views/admin/tables.jsp         ← UI polish only
views/admin/reservations.jsp   ← UI polish only
views/admin/feedback.jsp       ← UI polish only
```

**Also responsible for:**
- Final UI review across all pages
- Testing all CRUD operations
- Verifying role-based access works correctly

---

### Developer 3 — Swetha (User Management)

**Responsible for:**

```
repository/UserRepository.java
service/UserService.java
controller/UserController.java
views/customer/profile.jsp
views/customer/dashboard.jsp
```

---

### Developer 4 — Kowshika (Table Management)

**Responsible for:**

```
model/RestaurantTable.java
repository/TableRepository.java
service/TableService.java
controller/TableController.java
views/customer/tables.jsp
```

---

### Developer 5 — Binuth (Reservation Management)

**Responsible for:**

```
model/Reservation.java
repository/ReservationRepository.java
service/ReservationService.java
controller/ReservationController.java
views/customer/reservation-form.jsp
views/customer/my-reservations.jsp
```

---

### Developer 6 — Hashini (Feedback Management)

**Responsible for:**

```
model/Feedback.java
repository/FeedbackRepository.java
service/FeedbackService.java
controller/FeedbackController.java
views/customer/feedback.jsp
views/customer/notifications.jsp
```

---

## ✅ Step 3 — Daily Workflow

### Every day before coding — pull first

```bash
git checkout develop
git pull origin develop
```

---

### Create your feature branch (only once)

```bash
git checkout -b feature/user-management
git checkout -b feature/table-management
git checkout -b feature/reservation-management
git checkout -b feature/feedback-management
git checkout -b feature/admin-dashboard
git checkout -b feature/notification-system
```

---

### After writing code — save your work

```bash
git add .
git commit -m "[ADD] User registration logic"
git push origin feature/user-management
```

---

### When your feature is ready — Create a Pull Request

1. Go to **GitHub**
2. Click **Pull Requests → New Pull Request**
3. Base branch: `develop`
4. Compare branch: `feature/your-feature-name`
5. Title example:

```
[FEATURE] User Management Module
```

6. Describe what you built
7. Request review from **Sahan or Thirshe**

---

## ✅ Step 4 — Commit Message Rules

Always follow this format:

```
[TYPE] Short description
```

| Type | When to Use |
|------|-------------|
| `INIT` | First setup only |
| `ADD` | Adding new feature or file |
| `FIX` | Bug fix |
| `UPDATE` | Changing existing code |
| `DOCS` | Documentation updates |
| `REMOVE` | Removing unused code |

**Examples:**

```
[ADD] User registration with MySQL
[FIX] Table availability check bug
[UPDATE] Reservation conflict validation
[DOCS] Update README setup steps
[ADD] Gmail email notification service
[FIX] JSP view resolver path issue
```

---

## ✅ Step 5 — Branch Strategy

```
main          ← production-ready code only (Lead merges here at the end)
  └── develop ← integration branch (everyone merges features here)
        ├── feature/user-management
        ├── feature/table-management
        ├── feature/reservation-management
        ├── feature/feedback-management
        ├── feature/admin-dashboard
        └── feature/notification-system
```

---

## ✅ Step 6 — Important Rules

1. **Never push directly to `main` or `develop`.**
2. Always work on your own **feature branch**.
3. Always **pull the latest develop** before starting to code each day.
4. Do not edit another developer's files without discussion.
5. Always write **clear commit messages** following the format above.
6. Test your code before creating a **Pull Request**.
7. **Never commit `application.properties` with your real MySQL password.**

Before every commit, verify:

```properties
spring.datasource.password=your_password
```

---

## ✅ Step 7 — If You Have a Merge Conflict

```bash
git checkout develop
git pull origin develop
git checkout feature/your-feature-name
git merge develop
# Fix the conflicts in IntelliJ
git add .
git commit -m "[FIX] Resolve merge conflict with develop"
git push origin feature/your-feature-name
```

Then create your Pull Request as normal.

---

## ✅ Step 8 — File Ownership Quick Reference

| File / Folder | Owner |
|---------------|-------|
| `model/User.java`, `Admin.java`, `Customer.java` | Sahan |
| `model/Notification*.java`, `*Notification*.java` | Sahan |
| `service/*Validator.java`, `ReservationValidator.java` | Sahan |
| `controller/AuthController.java` | Sahan |
| `views/auth/*.jsp`, `views/common/*.jsp` | Sahan |
| `service/AnalyticsService.java` | Thirshe |
| `controller/AdminController.java`, `views/admin/*.jsp` | Thirshe |
| `repository/UserRepository.java`, `service/UserService.java` | Swetha |
| `controller/UserController.java`, `views/customer/profile.jsp` | Swetha |
| `model/RestaurantTable.java`, `service/TableService.java` | Kowshika |
| `controller/TableController.java`, `views/customer/tables.jsp` | Kowshika |
| `model/Reservation.java`, `service/ReservationService.java` | Binuth |
| `controller/ReservationController.java`, `views/customer/reservation-form.jsp` | Binuth |
| `model/Feedback.java`, `service/FeedbackService.java` | Hashini |
| `controller/FeedbackController.java`, `views/customer/feedback.jsp` | Hashini |

---

*ReserveSmart — OOP Module Project — SE1020*
