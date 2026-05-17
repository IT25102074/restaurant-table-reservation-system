<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReserveSmart — Table Reservation System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="icon" href="/images/favicon.ico" type="image/x-icon">
    <style>
        @font-face {
            font-family: 'WithHearty';
            src: url('/fonts/WithHearty.woff2') format('woff2'),
                 url('/fonts/WithHearty.woff') format('woff');
            font-weight: normal;
            font-style: normal;
            font-display: swap;
        }
        @font-face {
            font-family: 'PFDinTextPro';
            src: url('/fonts/PFDinTextPro-Regular.woff2') format('woff2'),
                 url('/fonts/PFDinTextPro-Regular.woff') format('woff');
            font-weight: 400;
            font-style: normal;
            font-display: swap;
        }
        @font-face {
            font-family: 'PFDinTextPro';
            src: url('/fonts/PFDinTextPro-Medium.woff2') format('woff2'),
                 url('/fonts/PFDinTextPro-Medium.woff') format('woff');
            font-weight: 500;
            font-style: normal;
            font-display: swap;
        }
        @font-face {
            font-family: 'PFDinTextPro';
            src: url('/fonts/PFDinTextPro-Bold.woff2') format('woff2'),
                 url('/fonts/PFDinTextPro-Bold.woff') format('woff');
            font-weight: 700;
            font-style: normal;
            font-display: swap;
        }
        @font-face {
            font-family: 'PFDinTextPro';
            src: url('/fonts/PFDinTextPro-Light.woff2') format('woff2'),
                 url('/fonts/PFDinTextPro-Light.woff') format('woff');
            font-weight: 300;
            font-style: normal;
            font-display: swap;
        }

        *, *::before, *::after { font-family: 'Inter', 'PFDinTextPro', sans-serif; }

        :root {
            --bg-primary: #FFF8F2;
            --bg-secondary: #EFDACC;
            --bg-card: #FFFFFF;
            --border-light: rgba(29,29,27,0.08);
            --text-primary: #1d1d1b;
            --text-secondary: #6b5e54;
            --text-muted: #9a8d82;
            --accent: #8B5E3C;
            --accent-hover: #A0714D;
            --accent-light: rgba(139,94,60,0.1);
            --gradient-accent: linear-gradient(135deg, #8B5E3C, #C4956A);
        }

        body {
            background: var(--bg-primary);
            color: var(--text-primary);
        }

        .font-hearty { font-family: 'WithHearty', cursive; }

        .glass {
            background: var(--bg-card);
            border: 1px solid var(--border-light);
            box-shadow: 0 1px 3px rgba(0,0,0,0.04), 0 4px 12px rgba(0,0,0,0.03);
        }

        .glass-strong {
            background: rgba(255,248,242,0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-light);
            box-shadow: 0 1px 8px rgba(0,0,0,0.04);
        }

        .glow-amber { box-shadow: 0 2px 12px rgba(139,94,60,0.08); }
        .glow-amber-hover:hover { box-shadow: 0 4px 20px rgba(139,94,60,0.12); }

        .btn-gradient {
            background: var(--gradient-accent);
            color: #fff;
            transition: all 0.3s ease;
        }
        .btn-gradient:hover {
            box-shadow: 0 4px 20px rgba(139,94,60,0.3);
            transform: translateY(-1px);
        }

        .input-field {
            background: #FAFAF7;
            border: 1px solid rgba(29,29,27,0.12);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }
        .input-field:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(139,94,60,0.1);
            outline: none;
        }
        .input-field::placeholder { color: var(--text-muted); }

        /* Keep backward compat for pages using input-dark */
        .input-dark {
            background: #FAFAF7;
            border: 1px solid rgba(29,29,27,0.12);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }
        .input-dark:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(139,94,60,0.1);
            outline: none;
        }
        .input-dark::placeholder { color: var(--text-muted); }

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
        .table-dark tbody tr:hover { background: rgba(139,94,60,0.03); }
        .table-dark thead { background: rgba(139,94,60,0.04); }

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
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            border-color: rgba(139,94,60,0.15);
        }

        select.input-dark option,
        select.input-field option {
            background: #fff;
            color: var(--text-primary);
        }

        /* Override Tailwind dark text colors to match light theme */
        .text-slate-100, .text-slate-200 { color: var(--text-primary) !important; }
        .text-slate-300 { color: #3d3530 !important; }
        .text-slate-400 { color: var(--text-secondary) !important; }
        .text-slate-500 { color: var(--text-muted) !important; }
        .text-slate-600 { color: #b0a59a !important; }

        .border-white\/5, .border-white\/10 { border-color: var(--border-light) !important; }
        .divide-white\/5 > :not([hidden]) ~ :not([hidden]) { border-color: var(--border-light) !important; }

        .bg-white\/5 { background: rgba(139,94,60,0.03) !important; }
        .hover\:bg-white\/5:hover { background: rgba(139,94,60,0.05) !important; }
        .bg-white\/10 { background: rgba(139,94,60,0.06) !important; }
        .hover\:bg-white\/15:hover { background: rgba(139,94,60,0.08) !important; }
        .border-white\/10 { border-color: rgba(139,94,60,0.1) !important; }

        /* Status badge overrides for light theme */
        .bg-amber-500\/15 { background: rgba(139,94,60,0.1) !important; }
        .text-amber-400 { color: var(--accent) !important; }
        .border-amber-500\/20 { border-color: rgba(139,94,60,0.2) !important; }
        .bg-amber-500\/20 { background: rgba(139,94,60,0.1) !important; }
        .border-amber-500\/30 { border-color: rgba(139,94,60,0.2) !important; }

        /* Keep functional colors */
        .bg-green-500\/15 { background: rgba(22,163,74,0.08) !important; }
        .text-green-400 { color: #16a34a !important; }
        .border-green-500\/20 { border-color: rgba(22,163,74,0.15) !important; }
        .bg-green-500\/20 { background: rgba(22,163,74,0.08) !important; }
        .hover\:bg-green-500\/25:hover { background: rgba(22,163,74,0.12) !important; }
        .hover\:bg-green-500\/30:hover { background: rgba(22,163,74,0.15) !important; }
        .border-green-500\/30 { border-color: rgba(22,163,74,0.2) !important; }

        .bg-red-500\/10 { background: rgba(220,38,38,0.06) !important; }
        .bg-red-500\/15 { background: rgba(220,38,38,0.06) !important; }
        .text-red-400 { color: #dc2626 !important; }
        .border-red-500\/20 { border-color: rgba(220,38,38,0.12) !important; }
        .border-red-500\/30 { border-color: rgba(220,38,38,0.15) !important; }
        .bg-red-500\/20 { background: rgba(220,38,38,0.06) !important; }
        .hover\:bg-red-500\/25:hover { background: rgba(220,38,38,0.1) !important; }
        .hover\:bg-red-500\/30:hover { background: rgba(220,38,38,0.12) !important; }

        .bg-yellow-500\/15 { background: rgba(202,138,4,0.08) !important; }
        .text-yellow-400 { color: #ca8a04 !important; }
        .border-yellow-500\/20 { border-color: rgba(202,138,4,0.12) !important; }
        .border-yellow-500\/30 { border-color: rgba(202,138,4,0.15) !important; }
        .bg-yellow-500\/20 { background: rgba(202,138,4,0.08) !important; }

        .bg-blue-500\/15 { background: rgba(37,99,235,0.06) !important; }
        .text-blue-400 { color: #2563eb !important; }
        .border-blue-500\/20 { border-color: rgba(37,99,235,0.1) !important; }
        .border-blue-500\/30 { border-color: rgba(37,99,235,0.15) !important; }
        .bg-blue-500\/20 { background: rgba(37,99,235,0.06) !important; }
        .hover\:bg-blue-500\/25:hover { background: rgba(37,99,235,0.1) !important; }
        .hover\:bg-blue-500\/30:hover { background: rgba(37,99,235,0.12) !important; }

        .bg-slate-500\/15 { background: rgba(100,116,139,0.08) !important; }
        .text-slate-400-status { color: #64748b !important; }
        .bg-slate-800\/50 { background: rgba(139,94,60,0.04) !important; }

        .bg-green-500\/10 { background: rgba(22,163,74,0.06) !important; }

        /* Animate slide in */
        .animate--slide-in {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.6s ease, transform 0.6s ease;
        }
        .animate--slide-in.is-visible {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body class="min-h-screen flex flex-col" style="color: #1d1d1b;">

<!-- Navbar -->
<nav class="glass-strong sticky top-0 z-50 px-6 py-3.5 flex items-center justify-between">

    <!-- Logo -->
    <a href="/" class="flex items-center gap-2 group">
        <span class="text-2xl font-hearty tracking-wide" style="color: var(--accent); font-size: 1.75rem;">
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
                    <span class="absolute -top-1.5 -right-2.5 text-white text-[10px]
                                 rounded-full w-4 h-4 flex items-center justify-center leading-none pulse-dot"
                          style="background: #dc2626;">
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
            <div class="flex items-center gap-3 ml-2 pl-4" style="border-left: 1px solid var(--border-light);">
                <span class="text-sm" style="color: var(--text-muted);">
                    <strong style="color: var(--text-primary);">${sessionScope.userName}</strong>
                    <span class="ml-1.5 text-[10px] font-semibold uppercase tracking-wider
                                 px-2 py-0.5 rounded-full"
                          style="background: rgba(139,94,60,0.1); color: var(--accent);">
                        ${sessionScope.userRole}
                    </span>
                </span>
                <a href="/logout"
                   class="text-sm px-3 py-1.5 rounded-lg transition-all duration-300 font-medium"
                   style="background: rgba(220,38,38,0.06); color: #dc2626; border: 1px solid rgba(220,38,38,0.12);">
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
        <div class="glass px-5 py-3.5 rounded-xl mb-4 text-sm flex items-center gap-2 fade-in"
             style="border-left: 3px solid #16a34a; color: #16a34a;">
            ✅ <span>${successMessage}</span>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass px-5 py-3.5 rounded-xl mb-4 text-sm flex items-center gap-2 fade-in"
             style="border-left: 3px solid #dc2626; color: #dc2626;">
            ❌ <span>${errorMessage}</span>
        </div>
    </c:if>
</div>