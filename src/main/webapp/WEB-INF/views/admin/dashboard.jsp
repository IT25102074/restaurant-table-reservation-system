<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

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
        width: 44px; height: 44px; border-radius: 10px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.3rem;
    }
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
    .page-header {
        background: #fff; border-radius: 16px;
        border: 1px solid rgba(29,29,27,0.07);
        padding: 1.75rem 2rem; margin-bottom: 1.75rem;
        display: flex; justify-content: space-between; align-items: center;
        box-shadow: 0 2px 12px rgba(0,0,0,0.04);
    }
</style>

<div class="max-w-6xl mx-auto px-4 py-8 fade-in">

    <!-- Page Header -->
    <div class="page-header">
        <div>
            <p style="font-size:0.75rem; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; color:#9a8d82; margin-bottom:0.25rem;">ReserveSmart</p>
            <h1 style="font-size:1.6rem; font-weight:800; color:#1d1d1b; letter-spacing:-0.02em;">Admin Dashboard</h1>
            <p style="font-size:0.875rem; color:#6b5e54; margin-top:0.25rem;">Welcome back, <strong>${sessionScope.userName}</strong> — here's your system overview.</p>
        </div>
        <div style="text-align:right;">
            <div style="font-size:0.78rem; color:#9a8d82;">Today</div>
            <div style="font-size:0.95rem; font-weight:700; color:#1d1d1b;">
                <jsp:useBean id="now" class="java.util.Date" />
                <c:out value="${now}" />
            </div>
        </div>
    </div>

    <!-- Top Stats Row -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-5">
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(139,94,60,0.1);">👥</div>
            <div class="dash-stat-value" style="color:#8B5E3C;">${stats.totalUsers}</div>
            <div class="dash-stat-label">Total Users</div>
            <div class="dash-stat-sub">${stats.totalCustomers} customers · ${stats.totalAdmins} admins</div>
        </div>
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(37,99,235,0.08);">🪑</div>
            <div class="dash-stat-value" style="color:#2563eb;">${stats.totalTables}</div>
            <div class="dash-stat-label">Total Tables</div>
            <div class="dash-stat-sub">${stats.availableTables} available · ${stats.reservedTables} reserved</div>
        </div>
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(22,163,74,0.08);">📅</div>
            <div class="dash-stat-value" style="color:#16a34a;">${stats.totalReservations}</div>
            <div class="dash-stat-label">Reservations</div>
            <div class="dash-stat-sub">${stats.pendingCount} pending · ${stats.confirmedCount} confirmed</div>
        </div>
        <div class="dash-stat-card">
            <div class="dash-stat-icon" style="background:rgba(202,138,4,0.08);">⭐</div>
            <div class="dash-stat-value" style="color:#ca8a04;">${stats.avgRating}</div>
            <div class="dash-stat-label">Avg Rating</div>
            <div class="dash-stat-sub">from ${stats.totalFeedback} reviews</div>
        </div>
    </div>

    <!-- Reservation Status Row -->
    <div class="grid grid-cols-4 gap-4 mb-7">
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
            <div class="dash-action-icon" style="background:rgba(139,94,60,0.08);">👥</div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Users</span>
        </a>
        <a href="/admin/tables" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(37,99,235,0.08);">🪑</div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Tables</span>
        </a>
        <a href="/reservations/admin/list" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(22,163,74,0.08);">📅</div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Reservations</span>
        </a>
        <a href="/admin/special-requests" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(139,94,60,0.08);">✨</div>
            <span style="font-size:0.8rem; font-weight:700; color:#1d1d1b;">Special Requests</span>
        </a>
        <a href="/feedback/admin/list" class="dash-action-card">
            <div class="dash-action-icon" style="background:rgba(202,138,4,0.08);">⭐</div>
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
                    <div class="empty-state">📭 No reservations yet.</div>
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
                    <div class="empty-state">📭 No feedback yet.</div>
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

<%@ include file="../common/footer.jsp" %>