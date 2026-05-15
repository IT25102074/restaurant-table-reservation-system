<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold text-slate-100 mb-6">⭐ All Customer Feedback</h2>

    <c:if test="${not empty successMessage}">
        <div class="glass border-green-500/30 text-green-400 px-4 py-3 rounded-xl mb-4 text-sm">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">❌ ${errorMessage}</div>
    </c:if>

    <!-- Rating Filter -->
    <div class="glass rounded-2xl p-4 mb-6">
        <div class="flex flex-wrap gap-2 items-center">
            <span class="text-sm font-medium text-slate-400">Filter by Rating:</span>
            <a href="/feedback/admin/list" class="text-sm px-3 py-1.5 rounded-xl border transition ${empty filterRating ? 'bg-amber-500/20 text-amber-400 border-amber-500/30' : 'border-white/10 text-slate-400 hover:bg-white/5'}">All</a>
            <a href="/feedback/admin/list?rating=5" class="text-sm px-3 py-1.5 rounded-xl border transition ${filterRating == 5 ? 'bg-amber-500/20 text-amber-400 border-amber-500/30' : 'border-white/10 text-slate-400 hover:bg-white/5'}">⭐⭐⭐⭐⭐ 5</a>
            <a href="/feedback/admin/list?rating=4" class="text-sm px-3 py-1.5 rounded-xl border transition ${filterRating == 4 ? 'bg-amber-500/20 text-amber-400 border-amber-500/30' : 'border-white/10 text-slate-400 hover:bg-white/5'}">⭐⭐⭐⭐ 4</a>
            <a href="/feedback/admin/list?rating=3" class="text-sm px-3 py-1.5 rounded-xl border transition ${filterRating == 3 ? 'bg-amber-500/20 text-amber-400 border-amber-500/30' : 'border-white/10 text-slate-400 hover:bg-white/5'}">⭐⭐⭐ 3</a>
            <a href="/feedback/admin/list?rating=2" class="text-sm px-3 py-1.5 rounded-xl border transition ${filterRating == 2 ? 'bg-amber-500/20 text-amber-400 border-amber-500/30' : 'border-white/10 text-slate-400 hover:bg-white/5'}">⭐⭐ 2</a>
            <a href="/feedback/admin/list?rating=1" class="text-sm px-3 py-1.5 rounded-xl border transition ${filterRating == 1 ? 'bg-amber-500/20 text-amber-400 border-amber-500/30' : 'border-white/10 text-slate-400 hover:bg-white/5'}">⭐ 1</a>
        </div>
    </div>

    <!-- Feedback List -->
    <c:choose>
        <c:when test="${empty feedbackList}">
            <div class="glass rounded-2xl text-center py-16 text-slate-500">
                <div class="text-5xl mb-3">⭐</div><p>No feedback found.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="space-y-4">
                <c:forEach var="f" items="${feedbackList}">
                    <div class="glass rounded-2xl p-5">
                        <div class="flex items-start justify-between gap-4">
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-semibold text-slate-200">${f.user.fullName}</span>
                                    <span class="text-xs text-slate-500">${f.user.email}</span>
                                    <c:if test="${f.rating >= 4}">
                                        <span class="text-xs bg-green-500/15 text-green-400 px-2 py-0.5 rounded-full border border-green-500/20">Positive</span>
                                    </c:if>
                                    <c:if test="${f.rating < 4}">
                                        <span class="text-xs bg-red-500/15 text-red-400 px-2 py-0.5 rounded-full border border-red-500/20">Complaint</span>
                                    </c:if>
                                </div>
                                <div class="flex gap-0.5 mb-2">
                                    <c:forEach begin="1" end="5" var="s">
                                        <span class="text-base ${s <= f.rating ? '' : 'opacity-20'}">⭐</span>
                                    </c:forEach>
                                    <span class="text-xs text-slate-500 ml-1 self-center">${f.rating}/5</span>
                                </div>
                                <p class="text-sm text-slate-300">${f.message}</p>
                                <p class="text-xs text-slate-600 mt-2">${f.createdAt}</p>
                            </div>
                            <div class="flex-shrink-0">
                                <form action="/feedback/delete/${f.feedbackId}" method="post" onsubmit="return confirm('Delete this feedback?')">
                                    <button type="submit" class="text-xs bg-red-500/15 text-red-400 px-3 py-1.5 rounded-lg hover:bg-red-500/25 transition border border-red-500/20">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="../common/footer.jsp" %>