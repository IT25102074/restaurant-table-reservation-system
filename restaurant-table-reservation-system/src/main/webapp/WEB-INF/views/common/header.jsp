<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReserveSmart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .nav-link {
            @apply text-sm text-gray-600 hover:text-orange-500 transition-colors;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">

<!-- Navbar -->
<nav class="bg-white shadow-sm border-b border-gray-100 px-6 py-3 flex items-center justify-between sticky top-0 z-50">

    <!-- Logo -->
    <a href="/" class="text-xl font-bold text-orange-500 tracking-tight">
        🍽️ ReserveSmart
    </a>

    <!-- Nav Links -->
    <div class="flex items-center gap-5">

        <!-- CUSTOMER NAV -->
        <c:if test="${sessionScope.userRole == 'CUSTOMER'}">
            <a href="/customer/dashboard"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Dashboard</a>
            <a href="/reservations/new"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Book Table</a>
            <a href="/reservations/my"
               class="text-sm text-gray-600 hover:text-orange-500 transition">My Reservations</a>
            <a href="/feedback/my"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Feedback</a>

            <!-- Notification link with unread badge -->
            <a href="/customer/notifications"
               class="relative text-sm text-gray-600 hover:text-orange-500 transition">
                🔔
                <c:if test="${not empty sessionScope.unreadCount && sessionScope.unreadCount > 0}">
                    <span class="absolute -top-1 -right-2 bg-red-500 text-white text-xs
                                 rounded-full w-4 h-4 flex items-center justify-center leading-none">
                        ${sessionScope.unreadCount}
                    </span>
                </c:if>
            </a>

            <a href="/profile"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Profile</a>
        </c:if>

        <!-- ADMIN NAV -->
        <c:if test="${sessionScope.userRole == 'ADMIN'}">
            <a href="/admin/dashboard"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Dashboard</a>
            <a href="/admin/users"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Users</a>
            <a href="/admin/tables"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Tables</a>
            <a href="/reservations/admin/list"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Reservations</a>
            <a href="/feedback/admin/list"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Feedback</a>
        </c:if>

        <!-- USER INFO + LOGOUT -->
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="flex items-center gap-3 ml-2 pl-3 border-l border-gray-200">
                <span class="text-sm text-gray-500">
                    <strong class="text-gray-700">${sessionScope.userName}</strong>
                    <span class="ml-1 text-xs bg-orange-100 text-orange-500
                                 px-2 py-0.5 rounded-full">
                        ${sessionScope.userRole}
                    </span>
                </span>
                <a href="/logout"
                   class="text-sm bg-red-500 hover:bg-red-600 text-white
                          px-3 py-1.5 rounded-lg transition font-medium">
                    Logout
                </a>
            </div>
        </c:if>

        <!-- NOT LOGGED IN -->
        <c:if test="${empty sessionScope.loggedInUser}">
            <a href="/login"
               class="text-sm text-gray-600 hover:text-orange-500 transition">Login</a>
            <a href="/register"
               class="text-sm bg-orange-500 hover:bg-orange-600 text-white
                      px-4 py-1.5 rounded-lg transition font-medium">
                Register
            </a>
        </c:if>

    </div>
</nav>

<!-- Page content wrapper starts here -->
<main class="flex-1">

<!-- Global Flash Messages (shown on every page) -->
<div class="max-w-6xl mx-auto px-4 mt-4">
    <c:if test="${not empty successMessage}">
        <div class="bg-green-50 border border-green-300 text-green-700 px-4 py-3
                    rounded-xl mb-4 text-sm flex items-center gap-2">
            ✅ <span>${successMessage}</span>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="bg-red-50 border border-red-300 text-red-700 px-4 py-3
                    rounded-xl mb-4 text-sm flex items-center gap-2">
            ❌ <span>${errorMessage}</span>
        </div>
    </c:if>
</div>