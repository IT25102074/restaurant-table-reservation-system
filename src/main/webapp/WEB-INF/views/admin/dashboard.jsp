<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<style>
    .dash-stat-card {
        background: #fff;
        border-radius: 16px;
        padding: 1.5rem;
        border: 1px solid rgba(29,29,27,0.07);
        box-shadow: 0 2px 12px rgba(0,0,0,0.04);
        transition: all 0.25s ease;
    }
    .dash-stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 28px rgba(0,0,0,0.08);
    }
    .dash-stat-icon {
        width: 48px; height: 48px; border-radius: 12px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.3rem; margin-bottom: 0.85rem;
    }
    .dash-stat-icon svg { width: 24px; height: 24px; stroke-width: 1.75; }
    .dash-stat-value {
        font-size: 2rem; font-weight: 800; line-height: 1;
        letter-spacing: -0.02em;
    }
    .dash-stat-label {
        font-size: 0.75rem; font-weight: 600; text-transform: uppercase;
        letter-spacing: 0.07em; color: #9a8d82; margin-top: 0.3rem;
    }
    .dash-stat-sub {
        font-size: 0.72rem; color: #b0a59a; margin-top: 0.25rem;
    }
    .dash-action-card {
        background: #fff;
        border-radius: 14px;
        border: 1px solid rgba(29,29,27,0.07);
        padding: 1.25rem 1rem;
        text-align: center;
        text-decoration: none;
        display: flex; flex-direction: column; align-items: center; gap: 0.5rem;
        transition: all 0.25s ease;
        box-shadow: 0 1px 4px rgba(0,0,0,0.03);
    }
    .dash-action-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 24px rgba(139,94,60,0.1);
        border-color: rgba(139,94,60,0.2);
    }
    .dash-action-icon {
        width: 44px; height: 44px; border-radius: 12px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.3rem; transition: transform 0.25s ease;
    }
    .dash-action-icon svg { width: 22px; height: 22px; stroke-width: 1.75; }
    .dash-action-card:hover .dash-action-icon { transform: scale(1.12) rotate(-4deg); }
    .dash-table { width: 100%; border-collapse: collapse; font-size: 0.875rem; }
    .dash-table thead tr { border-bottom: 1px solid rgba(29,29,27,0.07); }
    .dash-table thead th {
        padding: 0.75rem 1rem; text-align: left;
        font-size: 0.7rem; font-weight: 700; text-transform: uppercase;
        letter-spacing: 0.08em; color: #9a8d82;
    }
    .dash-table tbody tr {
        border-bottom: 1px solid rgba(29,29,27,0.05);
        transition: background 0.2s;
    }
    .dash-table tbody tr:hover { background: rgba(139,94,60,0.03); }
    .dash-table td { padding: 0.75rem 1rem; color: #3d3530; }
    .badge {
        display: inline-block; padding: 0.2rem 0.65rem;
        border-radius: 99px; font-size: 0.65rem; font-weight: 700;
        text-transform: uppercase; letter-spacing: 0.06em;
    }
    .badge-pending  { background: rgba(202,138,4,0.1);  color: #ca8a04; }
    .badge-confirmed{ background: rgba(22,163,74,0.1);  color: #16a34a; }
    .badge-cancelled{ background: rgba(220,38,38,0.08); color: #dc2626; }
    .badge-completed{ background: rgba(37,99,235,0.08); color: #2563eb; }
    .section-card {
        background: #fff; border-radius: 16px;
        border: 1px solid rgba(29,29,27,0.07);
        box-shadow: 0 2px 12px rgba(0,0,0,0.04);
        overflow: hidden;
    }
    .section-header {
        padding: 1rem 1.25rem;
        border-bottom: 1px solid rgba(29,29,27,0.07);
        display: flex; justify-content: space-between; align-items: center;
    }
    .section-header h3 { font-size: 0.95rem; font-weight: 700; color: #1d1d1b; }
    .section-header a { font-size: 0.78rem; font-weight: 600; color: #8B5E3C; text-decoration: none; }
    .section-header a:hover { opacity: 0.7; }
    .empty-state { text-align: center; padding: 2.5rem 1rem; color: #9a8d82; font-size: 0.875rem; }
    .feedback-row { padding: 0.85rem 1.25rem; border-bottom: 1px solid rgba(29,29,27,0.05); }
    .feedback-row:last-child { border-bottom: none; }
    .admin-welcome-banner {
        background: linear-gradient(135deg, #3d3530 0%, #6b5e54 60%, #8B5E3C 100%);
        border-radius: 20px;
        padding: 2rem 2.5rem;
        color: #fff;
        margin-bottom: 1.75rem;
        display: flex; justify-content: space-between; align-items: center;
        box-shadow: 0 8px 32px rgba(29,29,27,0.22);
        position: relative; overflow: hidden;
    }
    .admin-welcome-banner::before {
        content: ''; position: absolute; top: -40px; right: -40px;
        width: 200px; height: 200px; border-radius: 50%;
        background: rgba(255,255,255,0.05);
    }
    .admin-welcome-banner::after {
        content: ''; position: absolute; bottom: -50px; right: 90px;
        width: 130px; height: 130px; border-radius: 50%;
        background: rgba(196,149,106,0.08);
    }
    .admin-banner-icon {
        position: relative; z-index: 1; flex-shrink: 0;
        width: 68px; height: 68px; border-radius: 18px;
        background: rgba(255,255,255,0.1);
        border: 1px solid rgba(255,255,255,0.15);
        display: flex; align-items: center; justify-content: center;
        backdrop-filter: blur(6px);
    }
    .admin-banner-icon svg { width: 32px; height: 32px; color: #fff; stroke-width: 1.5; }
    .admin-banner-date {
        position: relative; z-index: 1; text-align: right; flex-shrink: 0;
    }
</style>

<div class="max-w-6xl mx-auto px-4 py-8 fade-in">

    <!-- Welcome Banner -->
    <div class="admin-welcome-banner">
        <div style="position:relative; z-index:1;">
            <p style="font-size:0.72rem; font-weight:700; text-transform:uppercase; letter-spacing:0.12em; opacity:0.65; margin-bottom:0.35rem;">ReserveSmart &middot; Admin Portal</p>
            <h1 style="font-size:1.75rem; font-weight:800; letter-spacing:-0.02em; margin-bottom:0.4rem;">Admin Dashboard</h1>
            <p style="font-size:0.88rem; opacity:0.8;">Welcome back, <strong>${sessionScope.userName}</strong> &mdash; here's your system overview.</p>
        </div>
        <div style="display:flex; align-items:center; gap:1.25rem; position:relative; z-index:1;">
            <div class="admin-banner-date">
                <div style="font-size:0.72rem; opacity:0.65; margin-bottom:0.2rem;">Today</div>
                <div style="font-size:0.88rem; font-weight:700; opacity:0.9;">
                    <jsp:useBean id="now" class="java.util.Date" />
                    <c:out value="${now}" />
                </div>
            </div>
            <div class="admin-banner-icon">
                <i data-lucide="shield-check"></i>
            </div>
        </div>
    </div>

    <!-- Top Stats Row -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-5 stagger-list">
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(139,94,60,0.1); color:#8B5E3C;"><i data-lucide="users"></i></div>
            <div class="dash-stat-value" style="color:#8B5E3C;">${stats.totalUsers}</div>
            <div class="dash-stat-label">Total Users</div>
            <div class="dash-stat-sub">${stats.totalCustomers} customers · ${stats.totalAdmins} admins</div>
        </div>
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(37,99,235,0.08); color:#2563eb;"><i data-lucide="layout-grid"></i></div>
            <div class="dash-stat-value" style="color:#2563eb;">${stats.totalTables}</div>
            <div class="dash-stat-label">Total Tables</div>
            <div class="dash-stat-sub">${stats.availableTables} available · ${stats.reservedTables} reserved</div>
        </div>
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(22,163,74,0.08); color:#16a34a;"><i data-lucide="calendar-check"></i></div>
            <div class="dash-stat-value" style="color:#16a34a;">${stats.totalReservations}</div>
            <div class="dash-stat-label">Reservations</div>
            <div class="dash-stat-sub">${stats.pendingCount} pending · ${stats.confirmedCount} confirmed</div>
        </div>
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(202,138,4,0.08); color:#ca8a04;"><i data-lucide="star"></i></div>
            <div class="dash-stat-value" style="color:#ca8a04;">${stats.avgRating}</div>
            <div class="dash-stat-label">Avg Rating</div>
            <div class="dash-stat-sub">from ${stats.totalFeedback} reviews</div>
        </div>
    </div>

    <!-- Reservation Status Row -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-7">
        <div class="dash-stat-card" style="border-left:3px solid #ca8a04; padding:1rem 1.25rem;">
            <div class="dash-stat-value" style="color:#ca8a04; font-size:1.6rem;">${stats.pendingCount}</div>
            <div class="dash-stat-label" style="color:rgba(202,138,4,0.75);">Pending</div>
        </div>
        <div class="dash-stat-card" style="border-left:3px solid #16a34a; padding:1rem 1.25rem;">
            <div class="dash-stat-value" style="color:#16a34a; font-size:1.6rem;">${stats.confirmedCount}</div>
            <div class="dash-stat-label" style="color:rgba(22,163,74,0.75);">Confirmed</div>
        </div>
        <div class="dash-stat-card" style="border-left:3px solid #dc2626; padding:1rem 1.25rem;">
            <div class="dash-stat-value" style="color:#dc2626; font-size:1.6rem;">${stats.cancelledCount}</div>
            <div class="dash-stat-label" style="color:rgba(220,38,38,0.75);">Cancelled</div>
        </div>
        <div class="dash-stat-card" style="border-left:3px solid #2563eb; padding:1rem 1.25rem;">
            <div class="dash-stat-value" style="color:#2563eb; font-size:1.6rem;">${stats.completedCount}</div>
            <div class="dash-stat-label" style="color:rgba(37,99,235,0.75);">Completed</div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="grid grid-cols-2 sm:grid-cols-5 gap-3 mb-7">
        <a href="/admin/users" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(139,94,60,0.08); color:#8B5E3C;"><i data-lucide="users"></i></div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Users</span>
        </a>
        <a href="/admin/tables" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(37,99,235,0.08); color:#2563eb;"><i data-lucide="layout-grid"></i></div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Tables</span>
        </a>
        <a href="/reservations/admin/list" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(22,163,74,0.08); color:#16a34a;"><i data-lucide="calendar-check"></i></div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Reservations</span>
        </a>
        <a href="/admin/special-requests" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(139,94,60,0.08); color:#8B5E3C;"><i data-lucide="message-square-plus"></i></div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Special Requests</span>
        </a>
        <a href="/feedback/admin/list" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(202,138,4,0.08); color:#ca8a04;"><i data-lucide="star"></i></div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Feedback</span>
        </a>
    </div>

    <!-- Tables Row -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">

        <!-- Recent Reservations -->
        <div class="section-card">
            <div class="section-header">
                <h3>Recent Reservations</h3>
                <a href="/reservations/admin/list">View All →</a>
            </div>
            <c:choose>
                <c:when test="${empty recentReservations}">
                    <div class="empty-state" style="padding:2rem;">
                        <svg width="56" height="56" viewBox="0 0 56 56" fill="none" style="margin-bottom:0.75rem;opacity:0.6;">
                            <rect x="8" y="12" width="40" height="36" rx="6" fill="rgba(139,94,60,0.06)" stroke="rgba(139,94,60,0.2)" stroke-width="1.5"/>
                            <path d="M8 20h40" stroke="rgba(139,94,60,0.2)" stroke-width="1.5"/>
                            <path d="M20 12V8M36 12V8" stroke="#C4956A" stroke-width="1.5" stroke-linecap="round"/>
                        </svg>
                        <div class="es-title" style="font-size:0.88rem;">No reservations yet</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="dash-table">
                        <thead>
                            <tr>
                                <th>Customer</th>
                                <th>Table</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${recentReservations}">
                                <tr>
                                    <td style="font-weight:600; color:#1d1d1b;">${r.user.fullName}</td>
                                    <td style="color:#6b5e54;">#${r.table.tableNumber}</td>
                                    <td>
                                        <span class="badge
                                            ${r.status == 'PENDING'   ? 'badge-pending'   :
                                              r.status == 'CONFIRMED' ? 'badge-confirmed' :
                                              r.status == 'CANCELLED' ? 'badge-cancelled' : 'badge-completed'}">
                                            ${r.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Recent Feedback -->
        <div class="section-card">
            <div class="section-header">
                <h3>Recent Feedback</h3>
                <a href="/feedback/admin/list">View All →</a>
            </div>
            <c:choose>
                <c:when test="${empty recentFeedback}">
                    <div class="empty-state" style="padding:2rem;">
                        <svg width="56" height="56" viewBox="0 0 56 56" fill="none" style="margin-bottom:0.75rem;opacity:0.6;">
                            <circle cx="28" cy="28" r="20" fill="rgba(202,138,4,0.05)" stroke="rgba(202,138,4,0.2)" stroke-width="1.5"/>
                            <path d="M28 16l3.5 7 7.5 1.1-5.4 5.3 1.3 7.5L28 33.4l-6.9 3.5 1.3-7.5-5.4-5.3 7.5-1.1z" stroke="#ca8a04" stroke-width="1.5" fill="rgba(202,138,4,0.08)" stroke-linejoin="round"/>
                        </svg>
                        <div class="es-title" style="font-size:0.88rem;">No feedback yet</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="f" items="${recentFeedback}">
                        <div class="feedback-row">
                            <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:0.25rem;">
                                <span style="font-size:0.875rem; font-weight:700; color:#1d1d1b;">${f.user.fullName}</span>
                                <span style="font-size:0.8rem;">
                                    <c:forEach begin="1" end="${f.rating}" var="s">⭐</c:forEach>
                                </span>
                            </div>
                            <p style="font-size:0.78rem; color:#9a8d82; margin:0; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; max-width:100%;">${f.message}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    lucide.createIcons();
    document.querySelectorAll('.dash-stat-value').forEach(el => {
        const target = parseFloat(el.textContent.trim());
        if (isNaN(target)) return;
        const isDecimal = el.textContent.includes('.');
        let duration = 900, startTime = null;
        function step(ts) {
            if (!startTime) startTime = ts;
            const progress = Math.min((ts - startTime) / duration, 1);
            const ease = 1 - Math.pow(1 - progress, 3);
            el.textContent = isDecimal ? (ease * target).toFixed(1) : Math.round(ease * target);
            if (progress < 1) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    });
});
</script>

<%@ include file="../common/footer.jsp" %>