<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-10 fade-in">

    <!-- Welcome Banner -->
    <div class="glass rounded-2xl p-8 mb-8 relative overflow-hidden" style="border-left: 3px solid #64748b;">
        <h2 class="text-2xl font-bold text-slate-100">Admin Dashboard</h2>
        <p class="text-slate-400 mt-1 text-sm">Welcome, ${sessionScope.userName}. Full system overview below.</p>
    </div>

    <!-- STATS ROW 1 -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-4">
        <div class="glass rounded-2xl p-5 text-center glow-amber-hover transition-all duration-300">
            <div class="text-3xl font-bold text-amber-400">${stats.totalUsers}</div>
            <div class="text-xs text-slate-500 mt-1">Total Users</div>
            <div class="text-xs text-slate-600 mt-0.5">${stats.totalCustomers} customers · ${stats.totalAdmins} admins</div>
        </div>
        <div class="glass rounded-2xl p-5 text-center card-hover">
            <div class="text-3xl font-bold text-blue-400">${stats.totalTables}</div>
            <div class="text-xs text-slate-500 mt-1">Total Tables</div>
            <div class="text-xs text-slate-600 mt-0.5">${stats.availableTables} available · ${stats.reservedTables} reserved</div>
        </div>
        <div class="glass rounded-2xl p-5 text-center card-hover">
            <div class="text-3xl font-bold text-green-400">${stats.totalReservations}</div>
            <div class="text-xs text-slate-500 mt-1">Total Reservations</div>
            <div class="text-xs text-slate-600 mt-0.5">${stats.pendingCount} pending · ${stats.confirmedCount} confirmed</div>
        </div>
        <div class="glass rounded-2xl p-5 text-center card-hover">
            <div class="text-3xl font-bold text-yellow-400">${stats.avgRating}</div>
            <div class="text-xs text-slate-500 mt-1">Avg Feedback Rating</div>
            <div class="text-xs text-slate-600 mt-0.5">from ${stats.totalFeedback} reviews</div>
        </div>
    </div>

    <!-- STATS ROW 2 -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-10">
        <div class="glass rounded-2xl p-4 text-center" style="border: 1px solid rgba(234,179,8,0.15);">
            <div class="text-2xl font-bold text-yellow-400">${stats.pendingCount}</div>
            <div class="text-xs text-yellow-500/70 mt-1">Pending</div>
        </div>
        <div class="glass rounded-2xl p-4 text-center" style="border: 1px solid rgba(34,197,94,0.15);">
            <div class="text-2xl font-bold text-green-400">${stats.confirmedCount}</div>
            <div class="text-xs text-green-500/70 mt-1">Confirmed</div>
        </div>
        <div class="glass rounded-2xl p-4 text-center" style="border: 1px solid rgba(239,68,68,0.15);">
            <div class="text-2xl font-bold text-red-400">${stats.cancelledCount}</div>
            <div class="text-xs text-red-500/70 mt-1">Cancelled</div>
        </div>
        <div class="glass rounded-2xl p-4 text-center">
            <div class="text-2xl font-bold text-slate-400">${stats.completedCount}</div>
            <div class="text-xs text-slate-500 mt-1">Completed</div>
        </div>
    </div>

    <!-- QUICK MANAGEMENT -->
    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-10">
        <a href="/admin/users" class="glass rounded-2xl p-5 text-center card-hover cursor-pointer">
            <div class="text-3xl mb-2">👥</div>
            <div class="text-sm font-semibold text-slate-300">Manage Users</div>
        </a>
        <a href="/admin/tables" class="glass rounded-2xl p-5 text-center card-hover cursor-pointer">
            <div class="text-3xl mb-2">🪑</div>
            <div class="text-sm font-semibold text-slate-300">Manage Tables</div>
        </a>
        <a href="/reservations/admin/list" class="glass rounded-2xl p-5 text-center card-hover cursor-pointer">
            <div class="text-3xl mb-2">📅</div>
            <div class="text-sm font-semibold text-slate-300">Reservations</div>
        </a>
        <a href="/feedback/admin/list" class="glass rounded-2xl p-5 text-center card-hover cursor-pointer">
            <div class="text-3xl mb-2">⭐</div>
            <div class="text-sm font-semibold text-slate-300">Feedback</div>
        </a>
    </div>

    <!-- RECENT DATA -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

        <!-- Recent Reservations -->
        <div class="glass rounded-2xl overflow-hidden">
            <div class="px-6 py-4 border-b border-white/5 flex justify-between items-center">
                <h3 class="font-semibold text-slate-200">Recent Reservations</h3>
                <a href="/reservations/admin/list" class="text-xs text-amber-400 hover:text-amber-300 transition">View All</a>
            </div>
            <c:choose>
                <c:when test="${empty recentReservations}">
                    <div class="text-center py-8 text-slate-500 text-sm">No reservations yet.</div>
                </c:when>
                <c:otherwise>
                    <table class="w-full text-sm table-dark">
                        <thead>
                            <tr class="text-slate-500 text-xs uppercase">
                                <th class="px-4 py-2.5 text-left">Customer</th>
                                <th class="px-4 py-2.5 text-left">Table</th>
                                <th class="px-4 py-2.5 text-left">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${recentReservations}">
                                <tr class="border-t border-white/5">
                                    <td class="px-4 py-2.5 text-slate-300">${r.user.fullName}</td>
                                    <td class="px-4 py-2.5 text-slate-400">${r.table.tableNumber}</td>
                                    <td class="px-4 py-2.5">
                                        <span class="text-xs px-2 py-0.5 rounded-full
                                            ${r.status == 'PENDING'   ? 'bg-yellow-500/15 text-yellow-400' :
                                              r.status == 'CONFIRMED' ? 'bg-green-500/15 text-green-400'  :
                                              r.status == 'CANCELLED' ? 'bg-red-500/15 text-red-400'      :
                                                                         'bg-slate-500/15 text-slate-400'}">
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
        <div class="glass rounded-2xl overflow-hidden">
            <div class="px-6 py-4 border-b border-white/5 flex justify-between items-center">
                <h3 class="font-semibold text-slate-200">Recent Feedback</h3>
                <a href="/feedback/admin/list" class="text-xs text-amber-400 hover:text-amber-300 transition">View All</a>
            </div>
            <c:choose>
                <c:when test="${empty recentFeedback}">
                    <div class="text-center py-8 text-slate-500 text-sm">No feedback yet.</div>
                </c:when>
                <c:otherwise>
                    <div class="divide-y divide-white/5">
                        <c:forEach var="f" items="${recentFeedback}">
                            <div class="px-4 py-3">
                                <div class="flex justify-between items-start">
                                    <span class="text-sm font-medium text-slate-300">${f.user.fullName}</span>
                                    <span class="text-xs text-slate-500">
                                        <c:forEach begin="1" end="${f.rating}" var="s">⭐</c:forEach>
                                    </span>
                                </div>
                                <p class="text-xs text-slate-500 mt-0.5 line-clamp-1">${f.message}</p>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>