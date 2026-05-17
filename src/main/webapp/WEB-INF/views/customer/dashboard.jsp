<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<!-- Lucide Icons CDN -->
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<style>
    .cust-action-card {
        background: #fff;
        border-radius: 18px;
        border: 1px solid rgba(29,29,27,0.07);
        padding: 1.75rem 1.25rem 1.5rem;
        text-align: center;
        text-decoration: none;
        display: flex; flex-direction: column; align-items: center; gap: 0.65rem;
        transition: all 0.28s cubic-bezier(.22,.68,0,.99);
        box-shadow: 0 2px 10px rgba(0,0,0,0.04);
        position: relative; overflow: hidden;
    }
    .cust-action-card::before {
        content: '';
        position: absolute; inset: 0;
        background: linear-gradient(135deg, rgba(139,94,60,0.03), transparent);
        opacity: 0; transition: opacity 0.28s;
    }
    .cust-action-card:hover::before { opacity: 1; }
    .cust-action-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 32px rgba(139,94,60,0.12);
        border-color: rgba(139,94,60,0.2);
    }
    .cust-action-icon {
        width: 56px; height: 56px; border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        margin-bottom: 0.15rem;
        transition: transform 0.28s ease;
    }
    .cust-action-card:hover .cust-action-icon { transform: scale(1.1) rotate(-3deg); }
    .cust-action-icon svg {
        width: 26px; height: 26px;
        stroke-width: 1.75;
    }
    .cust-action-title {
        font-size: 0.875rem; font-weight: 700; color: #1d1d1b; line-height: 1.2;
    }
    .cust-action-sub {
        font-size: 0.71rem; color: #9a8d82; line-height: 1.4;
    }

    .welcome-banner {
        background: linear-gradient(135deg, #8B5E3C 0%, #C4956A 100%);
        border-radius: 20px;
        padding: 2rem 2.5rem;
        color: #fff;
        margin-bottom: 1.75rem;
        display: flex; justify-content: space-between; align-items: center;
        box-shadow: 0 8px 32px rgba(139,94,60,0.22);
        position: relative; overflow: hidden;
    }
    .welcome-banner::before {
        content: ''; position: absolute; top: -40px; right: -40px;
        width: 180px; height: 180px; border-radius: 50%;
        background: rgba(255,255,255,0.07);
    }
    .welcome-banner::after {
        content: ''; position: absolute; bottom: -50px; right: 80px;
        width: 120px; height: 120px; border-radius: 50%;
        background: rgba(255,255,255,0.05);
    }
    .banner-icon-wrap {
        position: relative; z-index: 1; text-align: center; flex-shrink: 0;
        width: 72px; height: 72px; border-radius: 20px;
        background: rgba(255,255,255,0.12);
        display: flex; align-items: center; justify-content: center;
        backdrop-filter: blur(4px);
    }
    .banner-icon-wrap svg { width: 36px; height: 36px; color: #fff; stroke-width: 1.5; }

    .tip-card {
        background: #fff;
        border-radius: 14px;
        border: 1px solid rgba(139,94,60,0.12);
        padding: 1rem 1.25rem;
        display: flex; align-items: flex-start; gap: 0.75rem;
        font-size: 0.875rem; color: #6b5e54;
        box-shadow: 0 2px 8px rgba(0,0,0,0.03);
        margin-top: 1.75rem;
    }
    .tip-icon {
        width: 36px; height: 36px; border-radius: 10px;
        background: rgba(139,94,60,0.1);
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0;
    }
    .tip-icon svg { width: 18px; height: 18px; color: #8B5E3C; stroke-width: 2; }

    .unread-badge {
        position: absolute; top: 10px; right: 12px;
        background: #dc2626; color: #fff;
        font-size: 0.58rem; font-weight: 800;
        border-radius: 99px; padding: 0.1rem 0.45rem;
        animation: pulse 2s infinite;
    }
</style>

<div class="max-w-5xl mx-auto px-4 py-8 fade-in">

    <!-- Welcome Banner -->
    <div class="welcome-banner">
        <div style="position:relative; z-index:1;">
            <p style="font-size:0.75rem; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; opacity:0.75; margin-bottom:0.35rem;">ReserveSmart · Customer Portal</p>
            <h1 style="font-size:1.8rem; font-weight:800; letter-spacing:-0.02em; margin-bottom:0.4rem;">
                Welcome back, ${sessionScope.userName}!
            </h1>
            <p style="font-size:0.9rem; opacity:0.85;">
                Manage your reservations and dining experience at Flor Restaurant.
            </p>
        </div>
        <div class="banner-icon-wrap">
            <i data-lucide="utensils-crossed"></i>
        </div>
    </div>

    <!-- Quick Action Grid -->
    <p style="font-size:0.72rem; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; color:#9a8d82; margin-bottom:1rem;">Quick Actions</p>

    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-4 stagger-list">

        <a href="/reservations/new" class="cust-action-card">
            <div class="cust-action-icon" style="background:rgba(22,163,74,0.09); color:#16a34a;">
                <i data-lucide="calendar-plus"></i>
            </div>
            <div class="cust-action-title">Book a Table</div>
            <div class="cust-action-sub">Reserve your spot</div>
        </a>

        <a href="/reservations/my" class="cust-action-card">
            <div class="cust-action-icon" style="background:rgba(37,99,235,0.08); color:#2563eb;">
                <i data-lucide="clipboard-list"></i>
            </div>
            <div class="cust-action-title">My Reservations</div>
            <div class="cust-action-sub">View &amp; manage bookings</div>
        </a>

        <a href="/customer/tables" class="cust-action-card">
            <div class="cust-action-icon" style="background:rgba(139,94,60,0.09); color:#8B5E3C;">
                <i data-lucide="layout-grid"></i>
            </div>
            <div class="cust-action-title">View Tables</div>
            <div class="cust-action-sub">See available tables</div>
        </a>

        <a href="/customer/notifications" class="cust-action-card">
            <div class="cust-action-icon" style="background:rgba(220,38,38,0.07); color:#dc2626;">
                <i data-lucide="bell"></i>
            </div>
            <div class="cust-action-title">Notifications</div>
            <div class="cust-action-sub">Check your alerts</div>
            <c:if test="${not empty sessionScope.unreadCount && sessionScope.unreadCount > 0}">
                <span class="unread-badge">${sessionScope.unreadCount}</span>
            </c:if>
        </a>

    </div>

    <div class="grid grid-cols-2 sm:grid-cols-3 gap-4 stagger-list">

        <a href="/feedback/my" class="cust-action-card">
            <div class="cust-action-icon" style="background:rgba(202,138,4,0.08); color:#ca8a04;">
                <i data-lucide="star"></i>
            </div>
            <div class="cust-action-title">My Feedback</div>
            <div class="cust-action-sub">Rate your experience</div>
        </a>

        <a href="/customer/special-requests" class="cust-action-card">
            <div class="cust-action-icon" style="background:rgba(139,94,60,0.09); color:#8B5E3C;">
                <i data-lucide="message-square-plus"></i>
            </div>
            <div class="cust-action-title">Special Requests</div>
            <div class="cust-action-sub">Make a custom request</div>
        </a>

        <a href="/profile" class="cust-action-card">
            <div class="cust-action-icon" style="background:rgba(100,116,139,0.08); color:#64748b;">
                <i data-lucide="user-round"></i>
            </div>
            <div class="cust-action-title">My Profile</div>
            <div class="cust-action-sub">Update your details</div>
        </a>

    </div>

    <!-- Tip -->
    <div class="tip-card">
        <div class="tip-icon"><i data-lucide="lightbulb"></i></div>
        <div>
            <strong style="color:#1d1d1b;">Pro Tip:</strong>
            Use the <a href="/customer/tables" style="color:#8B5E3C; font-weight:700; text-decoration:none;">View Tables</a>
            page to find the perfect table for your group size before making a booking.
        </div>
    </div>

</div>

<script>
    lucide.createIcons();
</script>

<%@ include file="../common/footer.jsp" %>