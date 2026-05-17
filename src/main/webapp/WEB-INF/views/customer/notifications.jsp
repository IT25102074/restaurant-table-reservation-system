<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-3xl mx-auto px-4 py-10 fade-in">
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="text-2xl font-bold" style="color:var(--text-primary);">Notifications</h2>
            <c:if test="${unreadCount > 0}">
                <p class="text-sm mt-1" style="color:var(--accent);">${unreadCount} unread notification(s)</p>
            </c:if>
        </div>
        <c:if test="${not empty notifications}">
            <div class="flex gap-2">
                <form action="/customer/notifications/read-all" method="post">
                    <button type="submit" class="text-sm px-3.5 py-2 rounded-xl transition" style="background:rgba(139,94,60,0.04);color:var(--text-secondary);border:1px solid var(--border-light);">Mark All Read</button>
                </form>
                <form action="/customer/notifications/delete-all" method="post">
                    <button type="submit" class="text-sm px-3.5 py-2 rounded-xl transition" style="background:rgba(220,38,38,0.05);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Clear All</button>
                </form>
            </div>
        </c:if>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #16a34a;color:#16a34a;">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #dc2626;color:#dc2626;">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty notifications}">
            <div class="empty-state">
                <svg width="88" height="88" viewBox="0 0 88 88" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="44" cy="44" r="42" fill="rgba(139,94,60,0.05)" stroke="rgba(139,94,60,0.12)" stroke-width="1.5"/>
                    <path d="M44 24c-9 0-16 7-16 16v10l-4 6h40l-4-6V40c0-9-7-16-16-16z" fill="rgba(196,149,106,0.12)" stroke="#C4956A" stroke-width="1.5" stroke-linejoin="round"/>
                    <path d="M40 62a4 4 0 008 0" stroke="#C4956A" stroke-width="1.5" stroke-linecap="round"/>
                    <path d="M34 36l20 20M54 36L34 56" stroke="rgba(220,38,38,0.3)" stroke-width="1.5" stroke-linecap="round"/>
                </svg>
                <div class="es-title">All caught up!</div>
                <div class="es-sub">No notifications yet. They'll appear here<br>when you make or update a reservation.</div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="space-y-3">
                <c:forEach var="n" items="${notifications}">
                    <div class="glass rounded-2xl p-5 flex items-start gap-4 ${n.status == 'UNREAD' ? '' : 'opacity-60'}"
                         style="${n.status == 'UNREAD' ? 'border-left: 3px solid var(--accent);' : ''}">
                        <div class="text-2xl flex-shrink-0">
                            <c:choose><c:when test="${n.status == 'UNREAD'}">🔔</c:when><c:otherwise>🔕</c:otherwise></c:choose>
                        </div>
                        <div class="flex-1">
                            <p class="text-sm" style="color:var(--text-primary);">${n.message}</p>
                            <p class="text-xs mt-1" style="color:var(--text-muted);">${n.createdAt}</p>
                            <div class="flex gap-2 mt-3">
                                <c:if test="${n.status == 'UNREAD'}">
                                    <form action="/customer/notifications/read/${n.notificationId}" method="post">
                                        <button type="submit" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(139,94,60,0.06);color:var(--accent);border:1px solid rgba(139,94,60,0.15);">Mark as Read</button>
                                    </form>
                                </c:if>
                                <form action="/customer/notifications/delete/${n.notificationId}" method="post">
                                    <button type="submit" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(220,38,38,0.05);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Delete</button>
                                </form>
                            </div>
                        </div>
                        <c:if test="${n.status == 'UNREAD'}">
                            <span class="flex-shrink-0 w-2.5 h-2.5 rounded-full mt-1 pulse-dot" style="background:var(--accent);"></span>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../common/footer.jsp" %>