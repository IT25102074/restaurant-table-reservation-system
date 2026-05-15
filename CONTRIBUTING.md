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

> 💡 **Tip:** Install the **Lombok plugin** from **File → Settings → Plugins** and enable **Annotation Processing** from **File → Settings → Build → Compiler → Annotation Processors** for the best IDE experience.

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
dto/UserDTO.java
dto/NotificationDTO.java
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
```

---

### Developer 2 — Thirshe (QA & Frontend Lead)

**Responsible for all frontend (JSP) files:**

```
service/AnalyticsService.java
controller/AdminController.java
views/auth/login.jsp
views/auth/register.jsp
views/auth/forgot-password.jsp
views/auth/reset-password.jsp
views/common/header.jsp
views/common/footer.jsp
views/error.jsp
views/customer/dashboard.jsp
views/customer/profile.jsp
views/customer/tables.jsp
views/customer/reservation-form.jsp
views/customer/my-reservations.jsp
views/customer/feedback.jsp
views/customer/notifications.jsp
views/admin/dashboard.jsp
views/admin/users.jsp
views/admin/tables.jsp
views/admin/reservations.jsp
views/admin/feedback.jsp
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
```

---

### Developer 4 — Kowshika (Table Management)

**Responsible for:**

```
model/RestaurantTable.java
dto/TableDTO.java
repository/TableRepository.java
service/TableService.java
controller/TableController.java
```

---

### Developer 5 — Binuth (Reservation Management)

**Responsible for:**

```
model/Reservation.java
dto/ReservationDTO.java
repository/ReservationRepository.java
service/ReservationService.java
controller/ReservationController.java
```

---

### Developer 6 — Hashini (Feedback Management)

**Responsible for:**

```
model/Feedback.java
dto/FeedbackDTO.java
repository/FeedbackRepository.java
service/FeedbackService.java
controller/FeedbackController.java
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
git commit -m " User registration logic"
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

## ✅ Step 4 — Branch Strategy

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

## ✅ Step 5 — Important Rules

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
git commit -m " Resolve merge conflict with develop"
git push origin feature/your-feature-name
```

Then create your Pull Request as normal.

---

## ✅ Step 8 — File Ownership Quick Reference

| File / Folder | Owner |
|---------------|-------|
| `model/User.java`, `Admin.java`, `Customer.java` | Sahan |
| `model/Notification*.java`, `*Notification*.java` | Sahan |
| `dto/UserDTO.java`, `dto/NotificationDTO.java` | Sahan |
| `service/*Validator.java`, `ReservationValidator.java` | Sahan |
| `controller/AuthController.java`, `controller/NotificationController.java` | Sahan |
| **All `views/*.jsp` files** (auth, common, customer, admin, error) | **Thirshe** |
| `service/AnalyticsService.java`, `controller/AdminController.java` | Thirshe |
| `repository/UserRepository.java`, `service/UserService.java` | Swetha |
| `controller/UserController.java` | Swetha |
| `model/RestaurantTable.java`, `dto/TableDTO.java` | Kowshika |
| `service/TableService.java`, `controller/TableController.java` | Kowshika |
| `model/Reservation.java`, `dto/ReservationDTO.java` | Binuth |
| `service/ReservationService.java`, `controller/ReservationController.java` | Binuth |
| `model/Feedback.java`, `dto/FeedbackDTO.java` | Hashini |
| `service/FeedbackService.java`, `controller/FeedbackController.java` | Hashini |

---

*ReserveSmart — OOP Module Project — SE1020*
