<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReserveSmart — Table Reservation System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
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

        /* ─── Empty States (#7) ─── */
        .empty-state {
            display: flex; flex-direction: column; align-items: center;
            justify-content: center; padding: 4rem 2rem; text-align: center;
            background: #fff; border-radius: 20px;
            border: 1px solid rgba(29,29,27,0.07);
            box-shadow: 0 2px 12px rgba(0,0,0,0.03);
        }
        .empty-state svg { margin-bottom: 1.25rem; opacity: 0.85; }
        .empty-state .es-title {
            font-size: 1.05rem; font-weight: 700; color: #1d1d1b;
            margin-bottom: 0.4rem; letter-spacing: -0.01em;
        }
        .empty-state .es-sub {
            font-size: 0.82rem; color: #9a8d82; margin-bottom: 1.5rem; line-height: 1.5;
        }
        .empty-state .es-cta {
            display: inline-block; padding: 0.6rem 1.4rem;
            background: linear-gradient(135deg, #8B5E3C, #C4956A);
            color: #fff; border-radius: 10px; font-size: 0.83rem;
            font-weight: 700; text-decoration: none; transition: all 0.25s;
        }
        .empty-state .es-cta:hover {
            box-shadow: 0 4px 16px rgba(139,94,60,0.25); transform: translateY(-1px);
        }

        /* ─── Staggered card animations (#2) ─── */
        .stagger-list > * {
            opacity: 0;
            transform: translateY(20px);
            animation: staggerFadeUp 0.45s ease-out forwards;
        }
        .stagger-list > *:nth-child(1) { animation-delay: 0.05s; }
        .stagger-list > *:nth-child(2) { animation-delay: 0.10s; }
        .stagger-list > *:nth-child(3) { animation-delay: 0.15s; }
        .stagger-list > *:nth-child(4) { animation-delay: 0.20s; }
        .stagger-list > *:nth-child(5) { animation-delay: 0.25s; }
        .stagger-list > *:nth-child(6) { animation-delay: 0.30s; }
        .stagger-list > *:nth-child(n+7) { animation-delay: 0.35s; }
        @keyframes staggerFadeUp {
            to { opacity: 1; transform: translateY(0); }
        }

        /* ─── Consistent page header (#4) ─── */
        .page-title-bar {
            background: #fff;
            border-radius: 16px;
            border: 1px solid rgba(29,29,27,0.07);
            padding: 1.4rem 1.75rem;
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 12px rgba(0,0,0,0.04);
        }
        .page-title-bar .ptb-eyebrow {
            font-size: 0.7rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.1em; color: #9a8d82; margin-bottom: 0.2rem;
        }
        .page-title-bar h1 {
            font-size: 1.45rem; font-weight: 800; color: #1d1d1b;
            letter-spacing: -0.02em; line-height: 1.2;
        }
        .page-title-bar .ptb-sub {
            font-size: 0.82rem; color: #6b5e54; margin-top: 0.2rem;
        }

        /* ─── Toast notifications (#1) ─── */
        #toast-container {
            position: fixed; top: 1.25rem; right: 1.25rem;
            z-index: 9999; display: flex; flex-direction: column; gap: 0.5rem;
            pointer-events: none;
        }
        .toast {
            pointer-events: all;
            display: flex; align-items: center; gap: 0.75rem;
            padding: 0.85rem 1.1rem;
            border-radius: 12px;
            font-size: 0.875rem; font-weight: 500;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
            border: 1px solid transparent;
            background: #fff;
            min-width: 280px; max-width: 360px;
            animation: toastIn 0.35s cubic-bezier(.22,.68,0,1.2) both;
        }
        .toast.toast-out { animation: toastOut 0.3s ease forwards; }
        .toast-success { color: #16a34a; border-color: rgba(22,163,74,0.2); border-left: 3px solid #16a34a; }
        .toast-error   { color: #dc2626; border-color: rgba(220,38,38,0.2); border-left: 3px solid #dc2626; }
        .toast-info    { color: #2563eb; border-color: rgba(37,99,235,0.2); border-left: 3px solid #2563eb; }
        .toast-close { margin-left: auto; cursor: pointer; opacity: 0.5; font-size: 1rem; line-height: 1; flex-shrink: 0; }
        .toast-close:hover { opacity: 1; }
        @keyframes toastIn  { from { opacity:0; transform: translateX(40px); } to { opacity:1; transform: translateX(0); } }
        @keyframes toastOut { from { opacity:1; transform: translateX(0); }  to { opacity:0; transform: translateX(40px); } }

        /* ─── Notification dropdown (#8) ─── */
        .notif-dropdown {
            display: none;
            position: absolute; top: calc(100% + 12px); right: 0;
            width: 340px;
            background: #fff;
            border: 1px solid rgba(29,29,27,0.09);
            border-radius: 16px;
            box-shadow: 0 16px 48px rgba(0,0,0,0.12);
            z-index: 1000;
            overflow: hidden;
            animation: dropdownIn 0.2s ease;
        }
        .notif-dropdown.open { display: block; }
        @keyframes dropdownIn { from { opacity:0; transform: translateY(-8px); } to { opacity:1; transform: translateY(0); } }
        .notif-header { padding: 0.85rem 1rem; border-bottom: 1px solid rgba(29,29,27,0.07); display:flex; justify-content:space-between; align-items:center; }
        .notif-header span { font-size: 0.82rem; font-weight: 700; color: #1d1d1b; }
        .notif-header a { font-size: 0.75rem; color: #8B5E3C; font-weight: 600; text-decoration:none; }
        .notif-item { padding: 0.75rem 1rem; border-bottom: 1px solid rgba(29,29,27,0.05); display:flex; gap: 0.6rem; align-items:flex-start; }
        .notif-item:last-child { border-bottom: none; }
        .notif-item.unread { background: rgba(139,94,60,0.03); }
        .notif-item-dot { width: 7px; height: 7px; border-radius: 50%; background: #8B5E3C; flex-shrink:0; margin-top: 5px; animation: pulse 2s infinite; }
        .notif-item-msg { font-size: 0.78rem; color: #3d3530; line-height: 1.4; }
        .notif-item-time { font-size: 0.68rem; color: #9a8d82; margin-top: 2px; }
        .notif-footer { padding: 0.65rem 1rem; text-align:center; border-top: 1px solid rgba(29,29,27,0.06); }
        .notif-footer a { font-size: 0.78rem; color: #8B5E3C; font-weight: 600; text-decoration:none; }

        /* ─── Mobile nav (#mobile) ─── */
        #mobile-menu { display: none; }
        @media (max-width: 768px) {
            #desktop-nav { display: none; }
            #mobile-menu-btn { display: flex; }
            #mobile-menu.open { display: flex; flex-direction: column; }
        }
        #mobile-menu-btn { display: none; cursor: pointer; flex-direction: column; gap: 5px; padding: 4px; }
        #mobile-menu-btn span { display:block; width:22px; height:2px; background: var(--accent); border-radius:2px; transition: all 0.3s; }
        #mobile-menu {
            position: absolute; top: 100%; left: 0; right: 0;
            background: rgba(255,248,242,0.98); backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-light);
            padding: 1rem 1.5rem; gap: 0.85rem;
            z-index: 49;
        }
        #mobile-menu a { font-size: 0.9rem; font-weight: 500; color: var(--text-secondary); padding: 0.3rem 0; border-bottom: 1px solid var(--border-light); }

        /* ─── Mobile table collapse (#7) ─── */
        @media (max-width: 640px) {
            .mobile-card-table thead { display: none; }
            .mobile-card-table tr {
                display: block;
                border: 1px solid var(--border-light);
                border-radius: 12px;
                margin-bottom: 0.75rem;
                padding: 0.75rem;
                background: #fff;
                box-shadow: 0 1px 4px rgba(0,0,0,0.04);
            }
            .mobile-card-table td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.35rem 0.25rem;
                border: none;
                font-size: 0.82rem;
            }
            .mobile-card-table td::before {
                content: attr(data-label);
                font-size: 0.7rem; font-weight: 700;
                text-transform: uppercase; letter-spacing: 0.06em;
                color: #9a8d82; flex-shrink: 0; margin-right: 0.5rem;
            }
        }
    </style>
</head>
<body class="min-h-screen flex flex-col" style="color: #1d1d1b;">

<!-- Toast Container (#1) -->
<div id="toast-container"></div>

<!-- Navbar -->
<nav class="glass-strong sticky top-0 z-50 px-6 py-3.5" style="position:relative;">
    <div class="flex items-center justify-between">

    <!-- Logo -->
    <a href="/" class="flex items-center gap-2 group">
        <span class="text-2xl font-hearty tracking-wide" style="color: var(--accent); font-size: 1.75rem;">
            ReserveSmart
        </span>
    </a>

    <!-- Desktop Nav Links -->
    <div id="desktop-nav" class="flex items-center gap-5">

        <!-- CUSTOMER NAV -->
        <c:if test="${sessionScope.userRole == 'CUSTOMER'}">
            <a href="/customer/dashboard" class="nav-link-modern text-sm font-medium">Dashboard</a>
            <a href="/reservations/new" class="nav-link-modern text-sm font-medium">Book Table</a>
            <a href="/reservations/my" class="nav-link-modern text-sm font-medium">My Reservations</a>
            <a href="/customer/special-requests" class="nav-link-modern text-sm font-medium">Special Requests</a>
            <a href="/feedback/my" class="nav-link-modern text-sm font-medium">Feedback</a>

            <!-- Notification bell with dropdown (#8) -->
            <div class="relative" id="notif-bell-wrapper">
                <button onclick="toggleNotifDropdown()"
                        class="relative flex items-center justify-center w-9 h-9 rounded-xl transition-all duration-200"
                        style="background: rgba(139,94,60,0.06); border: 1px solid rgba(139,94,60,0.12); color: var(--accent); cursor:pointer;"
                        aria-label="Notifications">
                    <i data-lucide="bell" style="width:18px;height:18px;stroke-width:2;"></i>
                    <c:if test="${not empty sessionScope.unreadCount && sessionScope.unreadCount > 0}">
                        <!-- Pulsing red dot -->
                        <span style="position:absolute; top:-3px; right:-3px;
                                     width:9px; height:9px; border-radius:50%;
                                     background:#dc2626; border:2px solid #FFF8F2;
                                     animation: pulse 1.5s infinite;"></span>
                    </c:if>
                </button>
                <!-- Count badge below dot, visible if > 1 -->
                <c:if test="${not empty sessionScope.unreadCount && sessionScope.unreadCount > 0}">
                    <span style="position:absolute; top:-6px; right:-8px;
                                 background:#dc2626; color:#fff;
                                 font-size:0.58rem; font-weight:800; line-height:1;
                                 border-radius:99px; padding:2px 5px;
                                 border:1.5px solid #FFF8F2;
                                 animation: pulse 1.5s infinite;">
                        ${sessionScope.unreadCount}
                    </span>
                </c:if>
                <div class="notif-dropdown" id="notif-dropdown">
                    <div class="notif-header">
                        <span>Notifications</span>
                        <a href="/customer/notifications">View All</a>
                    </div>
                    <div id="notif-preview-list">
                        <div style="padding:1.5rem;text-align:center;color:#9a8d82;font-size:0.8rem;">Loading...</div>
                    </div>
                    <div class="notif-footer">
                        <a href="/customer/notifications">Open Notification Center →</a>
                    </div>
                </div>
            </div>

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

    <!-- Mobile menu button -->
    <button id="mobile-menu-btn" onclick="toggleMobileMenu()" aria-label="Menu">
        <span></span><span></span><span></span>
    </button>

    </div>

    <!-- Mobile menu -->
    <div id="mobile-menu">
        <c:if test="${sessionScope.userRole == 'CUSTOMER'}">
            <a href="/customer/dashboard">Dashboard</a>
            <a href="/reservations/new">Book Table</a>
            <a href="/reservations/my">My Reservations</a>
            <a href="/customer/special-requests">Special Requests</a>
            <a href="/feedback/my">Feedback</a>
            <a href="/customer/notifications">Notifications</a>
            <a href="/profile">Profile</a>
            <a href="/logout" style="color:#dc2626;">Logout</a>
        </c:if>
        <c:if test="${sessionScope.userRole == 'ADMIN'}">
            <a href="/admin/dashboard">Dashboard</a>
            <a href="/admin/users">Users</a>
            <a href="/admin/tables">Tables</a>
            <a href="/reservations/admin/list">Reservations</a>
            <a href="/admin/special-requests">Special Requests</a>
            <a href="/feedback/admin/list">Feedback</a>
            <a href="/logout" style="color:#dc2626;">Logout</a>
        </c:if>
        <c:if test="${empty sessionScope.loggedInUser}">
            <a href="/login">Login</a>
            <a href="/register">Register</a>
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

<script>
// ─── Toast System (#1) ───────────────────────────────────────────
function showToast(message, type = 'success') {
    const icons = { success: '✅', error: '❌', info: 'ℹ️' };
    const container = document.getElementById('toast-container');
    const toast = document.createElement('div');
    toast.className = 'toast toast-' + type;
    toast.innerHTML = '<span>' + icons[type] + '</span><span style="flex:1">' + message + '</span><span class="toast-close" onclick="dismissToast(this.parentElement)">✕</span>';
    container.appendChild(toast);
    setTimeout(() => dismissToast(toast), 3500);
}
function dismissToast(el) {
    if (!el || !el.parentElement) return;
    el.classList.add('toast-out');
    setTimeout(() => el.remove(), 300);
}

// ─── Mobile menu (#mobile) ───────────────────────────────────────
function toggleMobileMenu() {
    document.getElementById('mobile-menu').classList.toggle('open');
}

// ─── Notification dropdown (#8) ─────────────────────────────────
function toggleNotifDropdown() {
    const dd = document.getElementById('notif-dropdown');
    if (!dd) return;
    dd.classList.toggle('open');
    if (dd.classList.contains('open')) loadNotifPreview();
}
document.addEventListener('click', function(e) {
    const wrapper = document.getElementById('notif-bell-wrapper');
    if (wrapper && !wrapper.contains(e.target)) {
        const dd = document.getElementById('notif-dropdown');
        if (dd) dd.classList.remove('open');
    }
});
async function loadNotifPreview() {
    const list = document.getElementById('notif-preview-list');
    if (!list) return;
    try {
        const res = await fetch('/customer/notifications/recent', { credentials: 'same-origin' });
        if (!res.ok) { list.innerHTML = '<div style="padding:1rem;text-align:center;color:#9a8d82;font-size:0.8rem;">No notifications.</div>'; return; }
        const data = await res.json();
        if (!data || data.length === 0) {
            list.innerHTML = '<div style="padding:1.25rem;text-align:center;color:#9a8d82;font-size:0.8rem;">🔕 No new notifications.</div>';
            return;
        }
        list.innerHTML = data.slice(0, 5).map(n => {
            const unread = n.status === 'UNREAD';
            return '<div class="notif-item ' + (unread ? 'unread' : '') + '">' +
                (unread ? '<div class="notif-item-dot"></div>' : '<div style="width:7px;flex-shrink:0;"></div>') +
                '<div><div class="notif-item-msg">' + n.message + '</div>' +
                '<div class="notif-item-time">' + new Date(n.createdAt).toLocaleDateString() + '</div></div>' +
                '</div>';
        }).join('');
    } catch(e) {
        list.innerHTML = '<div style="padding:1rem;text-align:center;color:#9a8d82;font-size:0.8rem;">Could not load notifications.</div>';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    if (typeof lucide !== 'undefined') lucide.createIcons();
});
</script>