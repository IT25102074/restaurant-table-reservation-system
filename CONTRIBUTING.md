[//]: # (# 🤝 Contributing Guide — How to Work on This Project)

[//]: # ()
[//]: # (Read this carefully before writing any code.)

[//]: # ()
[//]: # (---)

[//]: # ()
[//]: # (## ✅ Step 1 — First Time Setup)

[//]: # ()
[//]: # (### Clone the repo)

[//]: # (git clone https://github.com/IT25102074/restaurant-table-reservation-system.git)

[//]: # (cd restaurant-table-reservation-system)

[//]: # ()
[//]: # (### Switch to develop branch)

[//]: # (git checkout develop)

[//]: # (git pull origin develop)

[//]: # ()
[//]: # (### Open in IntelliJ IDEA)

[//]: # (File → Open → select the project folder)

[//]: # (Wait for Maven to download all dependencies)

[//]: # ()
[//]: # (### Setup your database)

[//]: # (1. Open MySQL Workbench)

[//]: # (2. Run: CREATE DATABASE restaurant_db;)

[//]: # (3. Open application.properties)

[//]: # (4. Change password to your MySQL password)

[//]: # ()
[//]: # (### Run the project)

[//]: # (Click Run in IntelliJ)

[//]: # (Open browser: http://localhost:8080)

[//]: # ()
[//]: # (---)

[//]: # ()
[//]: # (## ✅ Step 2 — Your Files to Work On)

[//]: # ()
[//]: # (### Developer 1 — User Management)

[//]: # (Files YOU are responsible for:)

[//]: # (- model/User.java)

[//]: # (- model/Customer.java)

[//]: # (- model/Admin.java)

[//]: # (- repository/UserRepository.java)

[//]: # (- service/UserService.java)

[//]: # (- controller/UserController.java)

[//]: # (- templates/register.html)

[//]: # (- templates/login.html)

[//]: # (- templates/profile.html)

[//]: # ()
[//]: # (### Developer 2 — Table Management)

[//]: # (Files YOU are responsible for:)

[//]: # (- model/RestaurantTable.java)

[//]: # (- repository/TableRepository.java)

[//]: # (- service/TableService.java)

[//]: # (- controller/TableController.java)

[//]: # (- templates/tables.html)

[//]: # (- templates/admin-tables.html)

[//]: # ()
[//]: # (### Developer 3 — Reservation Management)

[//]: # (Files YOU are responsible for:)

[//]: # (- model/Reservation.java)

[//]: # (- repository/ReservationRepository.java)

[//]: # (- service/ReservationService.java)

[//]: # (- controller/ReservationController.java)

[//]: # (- templates/reservation-form.html)

[//]: # (- templates/my-reservations.html)

[//]: # ()
[//]: # (### Developer 4 —  and Feedback)

[//]: # (Files YOU are responsible for:)

[//]: # (- model/Notification.java)

[//]: # (- repository/NotificationRepository.java)

[//]: # (- service/NotificationService.java)

[//]: # (- controller/NotificationController.java)

[//]: # (- templates/notifications.html)

[//]: # (- templates/feedback.html)

[//]: # (- templates/home.html)

[//]: # (- static/css/style.css)

[//]: # ()
[//]: # (### Developer 5 — Admin Dashboard/ Auth)

[//]: # (Files YOU are responsible for:)

[//]: # (- controller/AdminController.java)

[//]: # (- templates/admin-dashboard.html)

[//]: # (- templates/admin-users.html)

[//]: # (- templates/admin-reservations.html)

[//]: # ()
[//]: # (### Developer 6 — Project Setup and Auth ,Notification)

[//]: # (Files YOU are responsible for:)

[//]: # (- ReservationApplication.java)

[//]: # (- application.properties)

[//]: # (- All model base classes)

[//]: # (- Security configuration)

[//]: # ()
[//]: # (---)

[//]: # ()
[//]: # (## ✅ Step 3 — Daily Workflow)

[//]: # ()
[//]: # (### Every day before coding — pull latest code)

[//]: # (git checkout develop)

[//]: # (git pull origin develop)

[//]: # ()
[//]: # (### Create your feature branch &#40;only once&#41;)

[//]: # (git checkout -b feature/user-management)

[//]: # ()
[//]: # (### After writing code — save your work)

[//]: # (git add .)

[//]: # (git commit -m "[ADD] User registration logic")

[//]: # (git push origin feature/user-management)

[//]: # ()
[//]: # (### When your feature is ready — create Pull Request)

[//]: # (1. Go to GitHub)

[//]: # (2. Click Pull Requests → New Pull Request)

[//]: # (3. Base: develop  ←  Compare: feature/user-management)

[//]: # (4. Title: [FEATURE] User Management Module)

[//]: # (5. Describe what you built)

[//]: # (6. Request review from Lead 1 or Lead 2)

[//]: # ()
[//]: # (---)

[//]: # ()
[//]: # (## ✅ Step 4 — Commit Message Rules)

[//]: # ()
[//]: # (Always use this format:)

[//]: # ([TYPE] Short description of what you did)

[//]: # ()
[//]: # (| Type | When to use |)

[//]: # (|------|------------|)

[//]: # (| [INIT] | First setup only |)

[//]: # (| [ADD] | New feature or file |)

[//]: # (| [FIX] | Bug fix |)

[//]: # (| [UPDATE] | Changing existing code |)

[//]: # (| [DOCS] | README or comments |)

[//]: # (| [REMOVE] | Deleting unused code |)

[//]: # ()
[//]: # (Examples:)

[//]: # ([ADD] User registration with MySQL)

[//]: # ([FIX] Table availability check bug)

[//]: # ([UPDATE] Reservation form validation)

[//]: # ([DOCS] Update README setup steps)

[//]: # ()
[//]: # (---)

[//]: # ()
[//]: # (## ✅ Step 5 — Important Rules)

[//]: # ()
[//]: # (1. NEVER push directly to main or develop)

[//]: # (2. ALWAYS create a feature branch for your work)

[//]: # (3. ALWAYS pull latest develop before starting)

[//]: # (4. NEVER edit another developer's files)

[//]: # (5. ALWAYS write commit messages clearly)

[//]: # (6. ALWAYS test your code before creating PR)

[//]: # (7. NEVER commit application.properties with your password)

[//]: # (   → change password back to: your_password before committing)

[//]: # ()
[//]: # (---)

[//]: # ()
[//]: # (## ✅ Step 6 — If You Have a Conflict)

[//]: # ()
[//]: # (Do not panic. Tell Lead 1 or Lead 2 immediately.)

[//]: # (They will help resolve the conflict.)

[//]: # ()
[//]: # (---)

[//]: # ()
