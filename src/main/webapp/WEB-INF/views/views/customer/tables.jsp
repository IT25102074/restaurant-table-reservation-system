<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">

    <h2 class="text-2xl font-bold text-slate-100 mb-6">🪑 Available Tables</h2>

    <!-- Table Recommendation -->
    <div class="glass rounded-2xl p-6 mb-8" style="border: 1px solid rgba(245,158,11,0.15);">
        <h3 class="font-semibold text-amber-400 mb-3">🔍 Find the Best Table for Your Group</h3>
        <form action="/customer/tables" method="get" class="flex gap-3 items-end">
            <div class="flex-1">
                <label class="block text-sm font-medium text-slate-300 mb-1.5">Number of Guests</label>
                <input type="number" name="guests" min="1" value="${guests}" placeholder="e.g. 4"
                       class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
            </div>
            <button type="submit" class="btn-gradient text-white font-semibold px-6 py-3 rounded-xl text-sm">
                Recommend
            </button>
        </form>

        <c:if test="${not empty recommended}">
            <div class="mt-4 glass rounded-xl p-4" style="border: 1px solid rgba(34,197,94,0.2);">
                <p class="text-sm text-green-400 font-semibold mb-1">✅ Best table for ${guests} guests:</p>
                <p class="text-slate-300 text-sm">
                    Table <strong>${recommended.tableNumber}</strong> — ${recommended.capacity} pax — ${recommended.location}
                </p>
                <a href="/reservations/new?tableId=${recommended.tableId}&guests=${guests}"
                   class="inline-block mt-3 bg-green-500/20 hover:bg-green-500/30 text-green-400 border border-green-500/20
                          text-xs font-semibold px-4 py-2 rounded-xl transition">Book This Table →</a>
            </div>
        </c:if>

        <c:if test="${not empty guests && empty recommended}">
            <div class="mt-4 glass rounded-xl p-4" style="border: 1px solid rgba(239,68,68,0.2);">
                <p class="text-sm text-red-400">❌ No available table found for ${guests} guests. Please try a different number.</p>
            </div>
        </c:if>
    </div>

    <!-- Tables Grid -->
    <c:choose>
        <c:when test="${empty tables}">
            <div class="glass rounded-2xl text-center py-16 text-slate-500">
                <div class="text-5xl mb-3">🪑</div>
                <p>No tables available right now. Please check back later.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
                <c:forEach var="t" items="${tables}">
                    <div class="glass rounded-2xl p-6 card-hover">
                        <div class="flex justify-between items-start mb-3">
                            <h3 class="font-bold text-lg text-slate-100">Table ${t.tableNumber}</h3>
                            <span class="text-xs bg-green-500/15 text-green-400 px-2.5 py-0.5 rounded-full
                                         font-medium border border-green-500/20">AVAILABLE</span>
                        </div>
                        <div class="text-sm text-slate-400 space-y-1 mb-4">
                            <p>👥 Capacity: <strong class="text-slate-300">${t.capacity} pax</strong></p>
                            <p>📍 Location: <strong class="text-slate-300">${t.location}</strong></p>
                        </div>
                        <a href="/reservations/new?tableId=${t.tableId}"
                           class="block text-center btn-gradient text-white text-sm font-semibold py-2.5 rounded-xl">
                            Book This Table
                        </a>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<%@ include file="../common/footer.jsp" %>