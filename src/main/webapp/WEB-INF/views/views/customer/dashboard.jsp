<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">

    <!-- Welcome Banner -->
    <div class="glass rounded-2xl p-8 mb-8 relative overflow-hidden" style="border-left: 3px solid #f59e0b;">
        <div class="absolute top-0 right-0 w-64 h-64 bg-amber-500/5 rounded-full -translate-y-1/2 translate-x-1/2"></div>
        <h2 class="text-2xl font-bold text-slate-100 relative z-10">
            👋 Welcome back, ${sessionScope.userName}!
        </h2>
        <p class="text-slate-400 mt-1.5 text-sm relative z-10">
            Manage your reservations and dining experience from here.
        </p>
    </div>

    <!-- Quick Action Cards -->
    <div class="grid grid-cols-2 sm:grid-cols-3 gap-5 mb-10">

        <a href="/reservations/new"
           class="glass rounded-2xl p-6 text-center group card-hover cursor-pointer">
            <div class="text-4xl mb-3 group-hover:scale-110 transition-transform duration-300">📅</div>
            <h3 class="font-semibold text-slate-200 text-sm">Book a Table</h3>
            <p class="text-xs text-slate-500 mt-1">Reserve your spot</p>
        </a>

        <a href="/reservations/my"
           class="glass rounded-2xl p-6 text-center group card-hover cursor-pointer">
            <div class="text-4xl mb-3 group-hover:scale-110 transition-transform duration-300">📋</div>
            <h3 class="font-semibold text-slate-200 text-sm">My Reservations</h3>
            <p class="text-xs text-slate-500 mt-1">View and manage bookings</p>
        </a>

        <a href="/customer/tables"
           class="glass rounded-2xl p-6 text-center group card-hover cursor-pointer">
            <div class="text-4xl mb-3 group-hover:scale-110 transition-transform duration-300">🪑</div>
            <h3 class="font-semibold text-slate-200 text-sm">View Tables</h3>
            <p class="text-xs text-slate-500 mt-1">See available tables</p>
        </a>

        <a href="/feedback/my"
           class="glass rounded-2xl p-6 text-center group card-hover cursor-pointer">
            <div class="text-4xl mb-3 group-hover:scale-110 transition-transform duration-300">⭐</div>
            <h3 class="font-semibold text-slate-200 text-sm">My Feedback</h3>
            <p class="text-xs text-slate-500 mt-1">Rate your experience</p>
        </a>

        <a href="/customer/notifications"
           class="glass rounded-2xl p-6 text-center group card-hover cursor-pointer relative">
            <div class="text-4xl mb-3 group-hover:scale-110 transition-transform duration-300">🔔</div>
            <h3 class="font-semibold text-slate-200 text-sm">Notifications</h3>
            <p class="text-xs text-slate-500 mt-1">Check your alerts</p>
        </a>

        <a href="/profile"
           class="glass rounded-2xl p-6 text-center group card-hover cursor-pointer">
            <div class="text-4xl mb-3 group-hover:scale-110 transition-transform duration-300">👤</div>
            <h3 class="font-semibold text-slate-200 text-sm">My Profile</h3>
            <p class="text-xs text-slate-500 mt-1">Update your details</p>
        </a>

    </div>

    <!-- Quick Tip -->
    <div class="glass rounded-2xl p-5 text-sm text-amber-400/80" style="border: 1px solid rgba(245,158,11,0.15);">
        <strong>💡 Tip:</strong> Use the
        <a href="/customer/tables" class="underline font-medium text-amber-400 hover:text-amber-300">View Tables</a>
        page to find the best table for your group size before booking.
    </div>

</div>

<%@ include file="../common/footer.jsp" %>