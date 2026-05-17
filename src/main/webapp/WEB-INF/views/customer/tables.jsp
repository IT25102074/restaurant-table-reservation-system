<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold mb-6" style="color: var(--text-primary);">🪑 Available Tables</h2>

    <div class="glass rounded-2xl p-6 mb-8" style="border: 1px solid rgba(139,94,60,0.12);">
        <h3 class="font-semibold mb-3" style="color: var(--accent);">🔍 Find the Best Table</h3>
        <form action="/customer/tables" method="get" class="flex gap-3 items-end">
            <div class="flex-1">
                <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Guests</label>
                <input type="number" name="guests" min="1" value="${guests}" placeholder="e.g. 4" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
            </div>
            <button type="submit" class="btn-gradient text-white font-semibold px-6 py-3 rounded-xl text-sm">Recommend</button>
        </form>
        <c:if test="${not empty recommended}">
            <div class="mt-4 glass rounded-xl p-4" style="border:1px solid rgba(22,163,74,0.15);">
                <p class="text-sm font-semibold mb-1" style="color:#16a34a;">✅ Best table for ${guests} guests:</p>
                <p class="text-sm">Table <strong>${recommended.tableNumber}</strong> — ${recommended.capacity} pax — ${recommended.location}</p>
                <a href="/reservations/new?tableId=${recommended.tableId}&guests=${guests}" class="inline-block mt-3 text-xs font-semibold px-4 py-2 rounded-xl transition" style="background:rgba(22,163,74,0.06);color:#16a34a;border:1px solid rgba(22,163,74,0.15);">Book This Table →</a>
            </div>
        </c:if>
        <c:if test="${not empty guests && empty recommended}">
            <div class="mt-4 glass rounded-xl p-4" style="border:1px solid rgba(220,38,38,0.12);">
                <p class="text-sm" style="color:#dc2626;">❌ No available table found for ${guests} guests.</p>
            </div>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${empty tables}">
            <div class="glass rounded-2xl text-center py-16" style="color:var(--text-muted);"><div class="text-5xl mb-3">🪑</div><p>No tables available.</p></div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
                <c:forEach var="t" items="${tables}">
                    <div class="glass rounded-2xl p-6 card-hover">
                        <div class="flex justify-between items-start mb-3">
                            <h3 class="font-bold text-lg" style="color:var(--text-primary);">Table ${t.tableNumber}</h3>
                            <span class="text-xs bg-green-500/15 text-green-400 px-2.5 py-0.5 rounded-full font-medium border border-green-500/20">AVAILABLE</span>
                        </div>
                        <div class="text-sm space-y-1 mb-4" style="color:var(--text-secondary);">
                            <p>👥 <strong>${t.capacity} pax</strong></p>
                            <p>📍 <strong>${t.location}</strong></p>
                        </div>
                        <a href="/reservations/new?tableId=${t.tableId}" class="block text-center btn-gradient text-white text-sm font-semibold py-2.5 rounded-xl">Book This Table</a>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../common/footer.jsp" %>