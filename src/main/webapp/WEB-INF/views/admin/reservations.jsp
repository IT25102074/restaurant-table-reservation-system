<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-8 fade-in">

    <!-- Consistent page header (#4) -->
    <div class="page-title-bar">
        <div>
            <div class="ptb-eyebrow">Admin Panel</div>
            <h1>📅 All Reservations</h1>
            <div class="ptb-sub">Search, filter and manage all customer reservations</div>
        </div>
    </div>

    <c:if test="${not empty successMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #16a34a;color:#16a34a;">✅ ${successMessage}</div></c:if>
    <c:if test="${not empty errorMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #dc2626;color:#dc2626;">❌ ${errorMessage}</div></c:if>

    <div class="glass rounded-2xl p-4 mb-6">
        <form action="/reservations/admin/list" method="get" class="flex flex-wrap gap-3 items-end">
            <div class="flex-1 min-w-48">
                <label class="block text-xs font-medium mb-1" style="color:var(--text-muted);">Search</label>
                <input type="text" name="keyword" value="${keyword}" placeholder="e.g. John or T01..." class="w-full input-dark rounded-xl px-4 py-2.5 text-sm"/>
            </div>
            <div class="min-w-36">
                <label class="block text-xs font-medium mb-1" style="color:var(--text-muted);">Status</label>
                <select name="status" class="w-full input-dark rounded-xl px-4 py-2.5 text-sm">
                    <option value="">All Statuses</option>
                    <option value="PENDING" ${filterStatus=='PENDING'?'selected':''}>Pending</option>
                    <option value="CONFIRMED" ${filterStatus=='CONFIRMED'?'selected':''}>Confirmed</option>
                    <option value="CANCELLED" ${filterStatus=='CANCELLED'?'selected':''}>Cancelled</option>
                    <option value="COMPLETED" ${filterStatus=='COMPLETED'?'selected':''}>Completed</option>
                </select>
            </div>
            <button type="submit" class="text-sm font-semibold px-5 py-2.5 rounded-xl transition" style="background:rgba(139,94,60,0.06);color:var(--text-primary);border:1px solid var(--border-light);">Search</button>
            <a href="/reservations/admin/list" class="text-sm px-4 py-2.5 rounded-xl transition" style="border:1px solid var(--border-light);color:var(--text-muted);">Clear</a>
        </form>
    </div>

    <div class="glass rounded-2xl overflow-hidden">
        <div class="px-6 py-4 flex justify-between" style="border-bottom:1px solid var(--border-light);">
            <h3 class="font-semibold" style="color:var(--text-primary);">Reservations</h3>
            <span class="text-xs" style="color:var(--text-muted);">${fn:length(reservations)} found</span>
        </div>
        <c:choose>
            <c:when test="${empty reservations}"><div class="text-center py-16" style="color:var(--text-muted);"><div class="text-4xl mb-3">📅</div><p>No reservations found.</p></div></c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                <table class="w-full text-sm table-dark mobile-card-table">
                    <thead><tr class="text-xs uppercase" style="color:var(--text-muted);"><th class="px-4 py-3 text-left">ID</th><th class="px-4 py-3 text-left">Customer</th><th class="px-4 py-3 text-left">Table</th><th class="px-4 py-3 text-left">Date</th><th class="px-4 py-3 text-left">Time</th><th class="px-4 py-3 text-left">Guests</th><th class="px-4 py-3 text-left">Status</th><th class="px-4 py-3 text-left">Actions</th></tr></thead>
                    <tbody>
                        <c:forEach var="r" items="${reservations}">
                            <tr style="border-top:1px solid var(--border-light);">
                                <td class="px-4 py-3" style="color:#b0a59a;" data-label="ID">#${r.reservationId}</td>
                                <td class="px-4 py-3 font-medium" style="color:var(--text-primary);" data-label="Customer">${r.user.fullName}</td>
                                <td class="px-4 py-3" style="color:var(--text-secondary);" data-label="Table">${r.table.tableNumber}</td>
                                <td class="px-4 py-3" style="color:var(--text-secondary);" data-label="Date">${r.reservationDate}</td>
                                <td class="px-4 py-3" style="color:var(--text-secondary);" data-label="Time">${r.reservationTime}</td>
                                <td class="px-4 py-3" style="color:var(--text-secondary);" data-label="Guests">${r.guestCount} pax</td>
                                <td class="px-4 py-3" data-label="Status"><span class="px-2 py-0.5 rounded-full text-xs font-medium ${r.status=='PENDING'?'bg-yellow-500/15 text-yellow-400':r.status=='CONFIRMED'?'bg-green-500/15 text-green-400':r.status=='CANCELLED'?'bg-red-500/15 text-red-400':'bg-slate-500/15 text-slate-400'}">${r.status}</span></td>
                                <td class="px-4 py-3" data-label="Actions">
                                    <div class="flex gap-2">
                                        <c:if test="${r.status == 'PENDING'}">
                                            <form action="/reservations/admin/confirm/${r.reservationId}" method="post"><button type="submit" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(22,163,74,0.06);color:#16a34a;border:1px solid rgba(22,163,74,0.15);">Confirm</button></form>
                                        </c:if>
                                        <c:if test="${r.status != 'CANCELLED' && r.status != 'COMPLETED'}">
                                            <form action="/reservations/admin/cancel/${r.reservationId}" method="post"><button type="submit" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(220,38,38,0.05);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Cancel</button></form>
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