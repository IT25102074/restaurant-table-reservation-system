<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReserveSmart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { font-family: 'Inter', sans-serif; }

        :root {
            --bg-primary: #0f172a;
            --bg-secondary: #1e293b;
            --bg-card: rgba(30, 41, 59, 0.7);
            --border-glass: rgba(255,255,255,0.08);
            --text-primary: #f1f5f9;
            --text-secondary: #94a3b8;
            --accent: #f59e0b;
            --accent-hover: #fbbf24;
            --gradient-accent: linear-gradient(135deg, #f59e0b, #ef4444);
        }

        body {
            background: var(--bg-primary);
            background-image:
                radial-gradient(ellipse at 20% 50%, rgba(245,158,11,0.04) 0%, transparent 50%),
                radial-gradient(ellipse at 80% 20%, rgba(239,68,68,0.03) 0%, transparent 50%);
        }

        .glass {
            background: var(--bg-card);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--border-glass);
        }

        .glass-strong {
            background: rgba(30, 41, 59, 0.85);
            backdrop-filter: blur(24px);
            -webkit-backdrop-filter: blur(24px);
            border: 1px solid rgba(255,255,255,0.1);
        }

        .glow-amber { box-shadow: 0 0 20px rgba(245,158,11,0.15); }
        .glow-amber-hover:hover { box-shadow: 0 0 30px rgba(245,158,11,0.25); }

        .btn-gradient {
            background: var(--gradient-accent);
            transition: all 0.3s ease;
        }
        .btn-gradient:hover {
            box-shadow: 0 4px 20px rgba(245,158,11,0.4);
            transform: translateY(-1px);
        }

        .input-dark {
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255,255,255,0.1);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }
        .input-dark:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(245,158,11,0.15);
            outline: none;
        }
        .input-dark::placeholder { color: #64748b; }

        .fade-in {
            animation: fadeInUp 0.5s ease-out both;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .nav-link-modern {
            position: relative;
            color: var(--text-secondary);
            transition: color 0.3s ease;
        }
        .nav-link-modern::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--gradient-accent);
            border-radius: 1px;
            transition: width 0.3s ease;
        }
        .nav-link-modern:hover {
            color: var(--accent);
        }
        .nav-link-modern:hover::after {
            width: 100%;
        }

        .table-dark tbody tr { transition: background 0.2s ease; }
        .table-dark tbody tr:hover { background: rgba(255,255,255,0.03); }
        .table-dark thead { background: rgba(0,0,0,0.2); }

        .pulse-dot {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .card-hover {
            transition: all 0.3s ease;
        }
        .card-hover:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.3);
            border-color: rgba(245,158,11,0.2);
        }

        select.input-dark option {
            background: #1e293b;
            color: #f1f5f9;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col text-slate-200">

<!-- Navbar -->
<nav class="glass-strong sticky top-0 z-50 px-6 py-3.5 flex items-center justify-between">

    <!-- Logo -->
    <a href="/" class="flex items-center gap-2 group">
        <span class="text-2xl">🍽️</span>
        <span class="text-xl font-bold bg-gradient-to-r from-amber-400 to-orange-500 bg-clip-text text-transparent
                     group-hover:from-amber-300 group-hover:to-red-400 transition-all duration-300">
            ReserveSmart
        </span>
    </a>

    <!-- Nav Links -->
    <div class="flex items-center gap-5">

        <!-- CUSTOMER NAV -->
        <c:if test="${sessionScope.userRole == 'CUSTOMER'}">
            <a href="/customer/dashboard" class="nav-link-modern text-sm font-medium">Dashboard</a>
            <a href="/reservations/new" class="nav-link-modern text-sm font-medium">Book Table</a>
            <a href="/reservations/my" class="nav-link-modern text-sm font-medium">My Reservations</a>
            <a href="/customer/special-requests" class="nav-link-modern text-sm font-medium">Special Requests</a>
            <a href="/feedback/my" class="nav-link-modern text-sm font-medium">Feedback</a>

            <!-- Notification bell -->
            <a href="/customer/notifications"
               class="relative nav-link-modern text-sm font-medium">
                🔔
                <c:if test="${not empty sessionScope.unreadCount && sessionScope.unreadCount > 0}">
                    <span class="absolute -top-1.5 -right-2.5 bg-red-500 text-white text-[10px]
                                 rounded-full w-4 h-4 flex items-center justify-center leading-none pulse-dot">
                        ${sessionScope.unreadCount}
                    </span>
                </c:if>
            </a>

            <a href="/profile" class="nav-link-modern text-sm font-medium">Profile</a>
        </c:if>

        <!-- ADMIN NAV -->
        <c:if test="${sessionScope.userRole == 'ADMIN'}">
            <a href="/admin/dashboard" class="nav-link-modern text-sm font-medium">Dashboard</a>
            <a href="/admin/users" class="nav-link-modern text-sm font-medium">Users</a>
            <a href="/admin/tables" class="nav-link-modern text-sm font-medium">Tables</a>
            <a href="/reservations/admin/list" class="nav-link-modern text-sm font-medium">Reservations</a>
            <a href="/admin/special-requests" class="nav-link-modern text-sm font-medium">Special Requests</a>
            <a href="/feedback/admin/list" class="nav-link-modern text-sm font-medium">Feedback</a>
        </c:if>

        <!-- USER INFO + LOGOUT -->
        <c:if test="${not empty sessionScope.loggedInUser}">
            <div class="flex items-center gap-3 ml-2 pl-4 border-l border-white/10">
                <span class="text-sm text-slate-400">
                    <strong class="text-slate-200">${sessionScope.userName}</strong>
                    <span class="ml-1.5 text-[10px] font-semibold uppercase tracking-wider
                                 bg-amber-500/20 text-amber-400 px-2 py-0.5 rounded-full">
                        ${sessionScope.userRole}
                    </span>
                </span>
                <a href="/logout"
                   class="text-sm bg-red-500/20 hover:bg-red-500/30 text-red-400 hover:text-red-300
                          px-3 py-1.5 rounded-lg transition-all duration-300 font-medium border border-red-500/20">
                    Logout
                </a>
            </div>
        </c:if>

        <!-- NOT LOGGED IN -->
        <c:if test="${empty sessionScope.loggedInUser}">
            <a href="/login" class="nav-link-modern text-sm font-medium">Login</a>
            <a href="/register"
               class="btn-gradient text-sm text-white font-semibold px-5 py-2 rounded-lg">
                Register
            </a>
        </c:if>

    </div>
</nav>

<!-- Page content wrapper -->
<main class="flex-1">

<!-- Global Flash Messages -->
<div class="max-w-6xl mx-auto px-4 mt-4">
    <c:if test="${not empty successMessage}">
        <div class="glass border-green-500/30 text-green-400 px-5 py-3.5
                    rounded-xl mb-4 text-sm flex items-center gap-2 fade-in">
            ✅ <span>${successMessage}</span>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-5 py-3.5
                    rounded-xl mb-4 text-sm flex items-center gap-2 fade-in">
            ❌ <span>${errorMessage}</span>
        </div>
    </c:if>
</div>