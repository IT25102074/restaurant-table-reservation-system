<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-3xl mx-auto px-4 py-10 fade-in">

    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="text-2xl font-bold text-slate-100">Notifications</h2>
            <c:if test="${unreadCount > 0}">
                <p class="text-sm text-amber-400 mt-1">${unreadCount} unread notification(s)</p>
            </c:if>
        </div>

        <c:if test="${not empty notifications}">
            <div class="flex gap-2">
                <form action="/customer/notifications/read-all" method="post">
                    <button type="submit"
                            class="text-sm bg-white/5 hover:bg-white/10 text-slate-400 px-3.5 py-2
                                   rounded-xl transition border border-white/10">Mark All Read</button>
                </form>
                <form action="/customer/notifications/delete-all" method="post"
                      onsubmit="return confirm('Clear all notifications?')">
                    <button type="submit"
                            class="text-sm bg-red-500/15 hover:bg-red-500/25 text-red-400 px-3.5 py-2
                                   rounded-xl transition border border-red-500/20">Clear All</button>
                </form>
            </div>
        </c:if>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="glass border-green-500/30 text-green-400 px-4 py-3 rounded-xl mb-4 text-sm">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty notifications}">
            <div class="glass rounded-2xl text-center py-20 text-slate-500">
                <div class="text-5xl mb-3">🔔</div>
                <p>No notifications yet.</p>
                <p class="text-sm mt-1">Notifications appear here when you make a reservation.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="space-y-3">
                <c:forEach var="n" items="${notifications}">
                    <div class="glass rounded-2xl p-5 flex items-start gap-4
                                ${n.status == 'UNREAD' ? 'border-l-3' : 'opacity-60'}"
                         style="${n.status == 'UNREAD' ? 'border-left: 3px solid #f59e0b;' : ''}">

                        <div class="text-2xl flex-shrink-0">
                            <c:choose>
                                <c:when test="${n.status == 'UNREAD'}">🔔</c:when>
                                <c:otherwise>🔕</c:otherwise>
                            </c:choose>
                        </div>

                        <div class="flex-1">
                            <p class="text-sm text-slate-300">${n.message}</p>
                            <p class="text-xs text-slate-500 mt-1">${n.createdAt}</p>

                            <div class="flex gap-2 mt-3">
                                <c:if test="${n.status == 'UNREAD'}">
                                    <form action="/customer/notifications/read/${n.notificationId}" method="post">
                                        <button type="submit"
                                                class="text-xs bg-amber-500/15 text-amber-400 px-3 py-1.5 rounded-lg
                                                       hover:bg-amber-500/25 transition border border-amber-500/20">Mark as Read</button>
                                    </form>
                                </c:if>
                                <form action="/customer/notifications/delete/${n.notificationId}" method="post"
                                      onsubmit="return confirm('Delete this notification?')">
                                    <button type="submit"
                                            class="text-xs bg-red-500/15 text-red-400 px-3 py-1.5 rounded-lg
                                                   hover:bg-red-500/25 transition border border-red-500/20">Delete</button>
                                </form>
                            </div>
                        </div>

                        <c:if test="${n.status == 'UNREAD'}">
                            <span class="flex-shrink-0 w-2.5 h-2.5 bg-amber-400 rounded-full mt-1 pulse-dot"></span>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="../common/footer.jsp" %>