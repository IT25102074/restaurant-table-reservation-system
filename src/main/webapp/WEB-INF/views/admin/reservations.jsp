<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold text-slate-100 mb-6">📅 All Reservations</h2>

    <c:if test="${not empty successMessage}">
        <div class="glass border-green-500/30 text-green-400 px-4 py-3 rounded-xl mb-4 text-sm">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">❌ ${errorMessage}</div>
    </c:if>

    <!-- Search + Filter -->
    <div class="glass rounded-2xl p-4 mb-6">
        <form action="/reservations/admin/list" method="get" class="flex flex-wrap gap-3 items-end">
            <div class="flex-1 min-w-48">
                <label class="block text-xs font-medium text-slate-500 mb-1">Search by customer or table</label>
                <input type="text" name="keyword" value="${keyword}" placeholder="e.g. John or T01..." class="w-full input-dark rounded-xl px-4 py-2.5 text-sm"/>
            </div>
            <div class="min-w-36">
                <label class="block text-xs font-medium text-slate-500 mb-1">Status</label>
                <select name="status" class="w-full input-dark rounded-xl px-4 py-2.5 text-sm">
                    <option value="">All Statuses</option>
                    <option value="PENDING" ${filterStatus=='PENDING'?'selected':''}>Pending</option>
                    <option value="CONFIRMED" ${filterStatus=='CONFIRMED'?'selected':''}>Confirmed</option>
                    <option value="CANCELLED" ${filterStatus=='CANCELLED'?'selected':''}>Cancelled</option>
                    <option value="COMPLETED" ${filterStatus=='COMPLETED'?'selected':''}>Completed</option>
                </select>
            </div>
            <button type="submit" class="bg-white/10 hover:bg-white/15 text-slate-300 text-sm font-semibold px-5 py-2.5 rounded-xl transition border border-white/10">Search</button>
            <a href="/reservations/admin/list" class="border border-white/10 text-slate-500 text-sm px-4 py-2.5 rounded-xl hover:bg-white/5 transition">Clear</a>
        </form>
    </div>

    <!-- Reservations Table -->
    <div class="glass rounded-2xl overflow-hidden">
        <div class="px-6 py-4 border-b border-white/5 flex justify-between">
            <h3 class="font-semibold text-slate-200">Reservations</h3>
            <span class="text-xs text-slate-500">${reservations.size()} found</span>
        </div>
        <c:choose>
            <c:when test="${empty reservations}">
                <div class="text-center py-16 text-slate-500"><div class="text-4xl mb-3">📅</div><p>No reservations found.</p></div>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                <table class="w-full text-sm table-dark">
                    <thead><tr class="text-slate-500 text-xs uppercase">
                        <th class="px-4 py-3 text-left">ID</th><th class="px-4 py-3 text-left">Customer</th>
                        <th class="px-4 py-3 text-left">Table</th><th class="px-4 py-3 text-left">Date</th>
                        <th class="px-4 py-3 text-left">Time</th><th class="px-4 py-3 text-left">Guests</th>
                        <th class="px-4 py-3 text-left">Status</th><th class="px-4 py-3 text-left">Actions</th>
                    </tr></thead>
                    <tbody>
                        <c:forEach var="r" items="${reservations}">
                            <tr class="border-t border-white/5">
                                <td class="px-4 py-3 text-slate-600">#${r.reservationId}</td>
                                <td class="px-4 py-3 font-medium text-slate-200">${r.user.fullName}</td>
                                <td class="px-4 py-3 text-slate-400">${r.table.tableNumber}</td>
                                <td class="px-4 py-3 text-slate-400">${r.reservationDate}</td>
                                <td class="px-4 py-3 text-slate-400">${r.reservationTime}</td>
                                <td class="px-4 py-3 text-slate-400">${r.guestCount} pax</td>
                                <td class="px-4 py-3"><span class="px-2 py-0.5 rounded-full text-xs font-medium ${r.status=='PENDING'?'bg-yellow-500/15 text-yellow-400':r.status=='CONFIRMED'?'bg-green-500/15 text-green-400':r.status=='CANCELLED'?'bg-red-500/15 text-red-400':'bg-slate-500/15 text-slate-400'}">${r.status}</span></td>
                                <td class="px-4 py-3">
                                    <div class="flex gap-2">
                                        <c:if test="${r.status == 'PENDING'}">
                                            <form action="/reservations/admin/confirm/${r.reservationId}" method="post">
                                                <button type="submit" class="text-xs bg-green-500/15 text-green-400 px-3 py-1.5 rounded-lg hover:bg-green-500/25 transition border border-green-500/20">Confirm</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${r.status != 'CANCELLED' && r.status != 'COMPLETED'}">
                                            <form action="/reservations/admin/cancel/${r.reservationId}" method="post" onsubmit="return confirm('Cancel reservation #${r.reservationId}?')">
                                                <button type="submit" class="text-xs bg-red-500/15 text-red-400 px-3 py-1.5 rounded-lg hover:bg-red-500/25 transition border border-red-500/20">Cancel</button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>