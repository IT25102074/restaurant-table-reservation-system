<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<style>
    /* Timeline layout (#5) */
    .timeline { position: relative; padding-left: 2rem; }
    .timeline::before {
        content: '';
        position: absolute; left: 0.55rem; top: 0; bottom: 0;
        width: 2px;
        background: linear-gradient(to bottom, rgba(139,94,60,0.2), transparent);
        border-radius: 2px;
    }
    .timeline-item { position: relative; margin-bottom: 1.25rem; }
    .timeline-dot {
        position: absolute; left: -2rem;
        width: 14px; height: 14px; border-radius: 50%;
        top: 1.35rem; border: 2px solid #fff;
        box-shadow: 0 0 0 2px currentColor;
    }
    .timeline-dot.pending   { color: #ca8a04; background: #ca8a04; }
    .timeline-dot.confirmed { color: #16a34a; background: #16a34a; }
    .timeline-dot.cancelled { color: #dc2626; background: #dc2626; }
    .timeline-dot.completed { color: #2563eb; background: #2563eb; }
</style>

<div class="max-w-3xl mx-auto px-4 py-8 fade-in">

    <!-- Consistent page header (#4) -->
    <div class="page-title-bar">
        <div>
            <div class="ptb-eyebrow">My Account</div>
            <h1>📋 My Reservations</h1>
            <div class="ptb-sub">Track and manage all your table bookings</div>
        </div>
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
    <div class="flex gap-2 mb-6 flex-wrap">
        <a href="/reservations/my"
           class="text-sm px-4 py-1.5 rounded-full border transition
                  ${empty filterStatus
                      ? 'border-amber-500/30 text-amber-400 bg-amber-500/20'
                      : 'border-white/10 text-slate-400 hover:bg-white/5'}">All</a>
        <a href="/reservations/my?status=PENDING"
           class="text-sm px-4 py-1.5 rounded-full border transition
                  ${filterStatus == 'PENDING'
                      ? 'bg-yellow-500/20 text-yellow-400 border-yellow-500/30'
                      : 'border-white/10 text-slate-400 hover:bg-white/5'}">Pending</a>
        <a href="/reservations/my?status=CONFIRMED"
           class="text-sm px-4 py-1.5 rounded-full border transition
                  ${filterStatus == 'CONFIRMED'
                      ? 'bg-green-500/20 text-green-400 border-green-500/30'
                      : 'border-white/10 text-slate-400 hover:bg-white/5'}">Confirmed</a>
        <a href="/reservations/my?status=CANCELLED"
           class="text-sm px-4 py-1.5 rounded-full border transition
                  ${filterStatus == 'CANCELLED'
                      ? 'bg-red-500/20 text-red-400 border-red-500/30'
                      : 'border-white/10 text-slate-400 hover:bg-white/5'}">Cancelled</a>
        <a href="/reservations/my?status=COMPLETED"
           class="text-sm px-4 py-1.5 rounded-full border transition
                  ${filterStatus == 'COMPLETED'
                      ? 'bg-blue-500/20 text-blue-400 border-blue-500/30'
                      : 'border-white/10 text-slate-400 hover:bg-white/5'}">Completed</a>
    </div>

    <c:choose>
        <c:when test="${empty reservations && not empty filterStatus}">
            <!-- Empty state: filtered, no results -->
            <div class="empty-state">
                <svg width="80" height="80" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="40" cy="40" r="38" fill="rgba(139,94,60,0.06)" stroke="rgba(139,94,60,0.15)" stroke-width="1.5"/>
                    <path d="M28 40h24M40 28v24" stroke="rgba(139,94,60,0.3)" stroke-width="2" stroke-linecap="round"/>
                    <circle cx="40" cy="40" r="12" stroke="#C4956A" stroke-width="1.5" fill="none" stroke-dasharray="4 3"/>
                    <path d="M52 52l8 8" stroke="#C4956A" stroke-width="2" stroke-linecap="round"/>
                </svg>
                <div class="es-title">No ${filterStatus} reservations</div>
                <div class="es-sub">You don't have any bookings with this status yet.</div>
                <a href="/reservations/my" class="es-cta">View All Reservations</a>
            </div>
        </c:when>
        <c:when test="${empty reservations}">
            <!-- Empty state: no reservations at all -->
            <div class="empty-state">
                <svg width="90" height="90" viewBox="0 0 90 90" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <rect x="15" y="22" width="60" height="52" rx="8" fill="rgba(139,94,60,0.06)" stroke="rgba(139,94,60,0.15)" stroke-width="1.5"/>
                    <path d="M15 34h60" stroke="rgba(139,94,60,0.2)" stroke-width="1.5"/>
                    <rect x="28" y="44" width="14" height="3" rx="1.5" fill="rgba(139,94,60,0.2)"/>
                    <rect x="28" y="52" width="22" height="3" rx="1.5" fill="rgba(139,94,60,0.15)"/>
                    <rect x="28" y="60" width="18" height="3" rx="1.5" fill="rgba(139,94,60,0.1)"/>
                    <circle cx="62" cy="56" r="10" fill="rgba(196,149,106,0.12)" stroke="#C4956A" stroke-width="1.5"/>
                    <path d="M62 51v5l3 3" stroke="#C4956A" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M30 22V17M60 22V17" stroke="#C4956A" stroke-width="1.5" stroke-linecap="round"/>
                </svg>
                <div class="es-title">No reservations yet</div>
                <div class="es-sub">Book your first table at Flor Restaurant<br>and start your dining journey.</div>
                <a href="/reservations/new" class="es-cta">+ Book a Table</a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Timeline layout (#5) with stagger animation (#2) -->
            <div class="timeline stagger-list">
                <c:forEach var="r" items="${reservations}">
                    <div class="timeline-item">
                        <div class="timeline-dot ${r.status == 'PENDING' ? 'pending' : r.status == 'CONFIRMED' ? 'confirmed' : r.status == 'CANCELLED' ? 'cancelled' : 'completed'}"></div>
                        <div class="glass rounded-2xl p-5 card-hover">
                            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                                <div>
                                    <div class="flex items-center gap-3 mb-2">
                                        <h3 class="font-bold" style="color: var(--text-primary);">Table ${r.table.tableNumber}</h3>
                                        <span class="text-xs px-2.5 py-0.5 rounded-full font-medium
                                            ${r.status == 'PENDING'   ? 'bg-yellow-500/15 text-yellow-400 border border-yellow-500/20' :
                                              r.status == 'CONFIRMED' ? 'bg-green-500/15 text-green-400 border border-green-500/20'  :
                                              r.status == 'CANCELLED' ? 'bg-red-500/15 text-red-400 border border-red-500/20'      :
                                                                         'bg-blue-500/15 text-blue-400 border border-blue-500/20'}">
                                            ${r.status}
                                        </span>
                                    </div>
                                    <div class="flex flex-wrap gap-4 text-sm" style="color: var(--text-secondary);">
                                        <span>📅 <strong style="color:var(--text-primary);">${r.reservationDate}</strong></span>
                                        <span>🕐 <strong style="color:var(--text-primary);">${r.reservationTime}</strong></span>
                                        <span>👥 ${r.guestCount} guests</span>
                                        <span>📍 ${r.table.location}</span>
                                    </div>
                                </div>
                                <div class="flex gap-2 flex-shrink-0">
                                    <c:if test="${r.status != 'CANCELLED' && r.status != 'COMPLETED'}">
                                        <a href="/reservations/edit/${r.reservationId}"
                                           class="text-sm bg-blue-500/15 text-blue-400 px-4 py-2 rounded-xl
                                                  hover:bg-blue-500/25 transition font-medium border border-blue-500/20">Edit</a>
                                        <form action="/reservations/cancel/${r.reservationId}" method="post">
                                            <button type="submit"
                                                    class="text-sm bg-red-500/15 text-red-400 px-4 py-2 rounded-xl
                                                           hover:bg-red-500/25 transition font-medium border border-red-500/20">Cancel</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="../common/footer.jsp" %>