<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">

    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold" style="color: var(--text-primary);">📋 My Reservations</h2>
        <a href="/reservations/new"
           class="btn-gradient text-white text-sm font-semibold px-5 py-2.5 rounded-xl">
            + New Reservation
        </a>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left: 3px solid #16a34a; color: #16a34a;">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left: 3px solid #dc2626; color: #dc2626;">❌ ${errorMessage}</div>
    </c:if>

    <!-- Status Filter Tabs -->
    <c:if test="${not empty reservations}">
        <div class="flex gap-2 mb-6 flex-wrap">
            <a href="/reservations/my"
               class="text-sm px-4 py-1.5 rounded-full border transition
                      ${empty param.status
                          ? 'border-amber-500/30 text-amber-400 bg-amber-500/20'
                          : 'border-white/10 text-slate-400 hover:bg-white/5'}">All</a>
            <a href="/reservations/my?status=PENDING"
               class="text-sm px-4 py-1.5 rounded-full border transition
                      ${param.status == 'PENDING'
                          ? 'bg-yellow-500/20 text-yellow-400 border-yellow-500/30'
                          : 'border-white/10 text-slate-400 hover:bg-white/5'}">Pending</a>
            <a href="/reservations/my?status=CONFIRMED"
               class="text-sm px-4 py-1.5 rounded-full border transition
                      ${param.status == 'CONFIRMED'
                          ? 'bg-green-500/20 text-green-400 border-green-500/30'
                          : 'border-white/10 text-slate-400 hover:bg-white/5'}">Confirmed</a>
            <a href="/reservations/my?status=CANCELLED"
               class="text-sm px-4 py-1.5 rounded-full border transition
                      ${param.status == 'CANCELLED'
                          ? 'bg-red-500/20 text-red-400 border-red-500/30'
                          : 'border-white/10 text-slate-400 hover:bg-white/5'}">Cancelled</a>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty reservations}">
            <div class="glass rounded-2xl text-center py-20" style="color: var(--text-muted);">
                <div class="text-5xl mb-3">📅</div>
                <p class="mb-4">You have no reservations yet.</p>
                <a href="/reservations/new"
                   class="btn-gradient text-white text-sm font-semibold px-6 py-2.5 rounded-xl inline-block">
                    Make Your First Reservation
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="space-y-4">
                <c:forEach var="r" items="${reservations}">
                    <c:if test="${empty param.status || param.status == r.status}">
                        <div class="glass rounded-2xl p-6 card-hover">
                            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                                <div>
                                    <div class="flex items-center gap-3 mb-2">
                                        <h3 class="font-bold" style="color: var(--text-primary);">Table ${r.table.tableNumber}</h3>
                                        <span class="text-xs px-2.5 py-0.5 rounded-full font-medium
                                            ${r.status == 'PENDING'   ? 'bg-yellow-500/15 text-yellow-400 border border-yellow-500/20' :
                                              r.status == 'CONFIRMED' ? 'bg-green-500/15 text-green-400 border border-green-500/20'  :
                                              r.status == 'CANCELLED' ? 'bg-red-500/15 text-red-400 border border-red-500/20'      :
                                                                         'bg-slate-500/15 text-slate-400 border border-slate-500/20'}">
                                            ${r.status}
                                        </span>
                                    </div>
                                    <div class="text-sm space-y-0.5" style="color: var(--text-secondary);">
                                        <p>📅 <strong style="color: var(--text-primary);">${r.reservationDate}</strong>
                                           &nbsp;🕐 <strong style="color: var(--text-primary);">${r.reservationTime}</strong></p>
                                        <p>👥 ${r.guestCount} guests &nbsp;📍 ${r.table.location}</p>
                                    </div>
                                </div>
                                <div class="flex gap-2 flex-shrink-0">
                                    <c:if test="${r.status != 'CANCELLED' && r.status != 'COMPLETED'}">
                                        <a href="/reservations/edit/${r.reservationId}"
                                           class="text-sm bg-blue-500/15 text-blue-400 px-4 py-2 rounded-xl
                                                  hover:bg-blue-500/25 transition font-medium border border-blue-500/20">Edit</a>
                                        <form action="/reservations/cancel/${r.reservationId}" method="post"
                                              onsubmit="return confirm('Cancel this reservation?')">
                                            <button type="submit"
                                                    class="text-sm bg-red-500/15 text-red-400 px-4 py-2 rounded-xl
                                                           hover:bg-red-500/25 transition font-medium border border-red-500/20">Cancel</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="../common/footer.jsp" %>