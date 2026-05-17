<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold mb-6" style="color:var(--text-primary);">⭐ All Customer Feedback</h2>

    <c:if test="${not empty successMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #16a34a;color:#16a34a;">✅ ${successMessage}</div></c:if>
    <c:if test="${not empty errorMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #dc2626;color:#dc2626;">❌ ${errorMessage}</div></c:if>

    <div class="glass rounded-2xl p-4 mb-6">
        <div class="flex flex-wrap gap-2 items-center">
            <span class="text-sm font-medium" style="color:var(--text-secondary);">Filter by Rating:</span>
            <a href="/feedback/admin/list" class="text-sm px-3 py-1.5 rounded-xl border transition ${empty filterRating ? '' : ''}" style="${empty filterRating ? 'background:rgba(139,94,60,0.1);color:var(--accent);border-color:rgba(139,94,60,0.2);' : 'border-color:var(--border-light);color:var(--text-muted);'}">All</a>
            <a href="/feedback/admin/list?rating=5" class="text-sm px-3 py-1.5 rounded-xl border transition" style="${filterRating == 5 ? 'background:rgba(139,94,60,0.1);color:var(--accent);border-color:rgba(139,94,60,0.2);' : 'border-color:var(--border-light);color:var(--text-muted);'}">⭐⭐⭐⭐⭐ 5</a>
            <a href="/feedback/admin/list?rating=4" class="text-sm px-3 py-1.5 rounded-xl border transition" style="${filterRating == 4 ? 'background:rgba(139,94,60,0.1);color:var(--accent);border-color:rgba(139,94,60,0.2);' : 'border-color:var(--border-light);color:var(--text-muted);'}">⭐⭐⭐⭐ 4</a>
            <a href="/feedback/admin/list?rating=3" class="text-sm px-3 py-1.5 rounded-xl border transition" style="${filterRating == 3 ? 'background:rgba(139,94,60,0.1);color:var(--accent);border-color:rgba(139,94,60,0.2);' : 'border-color:var(--border-light);color:var(--text-muted);'}">⭐⭐⭐ 3</a>
            <a href="/feedback/admin/list?rating=2" class="text-sm px-3 py-1.5 rounded-xl border transition" style="${filterRating == 2 ? 'background:rgba(139,94,60,0.1);color:var(--accent);border-color:rgba(139,94,60,0.2);' : 'border-color:var(--border-light);color:var(--text-muted);'}">⭐⭐ 2</a>
            <a href="/feedback/admin/list?rating=1" class="text-sm px-3 py-1.5 rounded-xl border transition" style="${filterRating == 1 ? 'background:rgba(139,94,60,0.1);color:var(--accent);border-color:rgba(139,94,60,0.2);' : 'border-color:var(--border-light);color:var(--text-muted);'}">⭐ 1</a>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty feedbackList}">
            <div class="glass rounded-2xl text-center py-16" style="color:var(--text-muted);"><div class="text-5xl mb-3">⭐</div><p>No feedback found.</p></div>
        </c:when>
        <c:otherwise>
            <div class="space-y-4">
                <c:forEach var="f" items="${feedbackList}">
                    <div class="glass rounded-2xl p-5">
                        <div class="flex items-start justify-between gap-4">
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-semibold" style="color:var(--text-primary);">${f.user.fullName}</span>
                                    <span class="text-xs" style="color:var(--text-muted);">${f.user.email}</span>
                                    <c:if test="${f.rating >= 4}"><span class="text-xs bg-green-500/15 text-green-400 px-2 py-0.5 rounded-full border border-green-500/20">Positive</span></c:if>
                                    <c:if test="${f.rating < 4}"><span class="text-xs bg-red-500/15 text-red-400 px-2 py-0.5 rounded-full border border-red-500/20">Complaint</span></c:if>
                                </div>
                                <div class="flex gap-0.5 mb-2">
                                    <c:forEach begin="1" end="5" var="s"><span class="text-base ${s <= f.rating ? '' : 'opacity-20'}">⭐</span></c:forEach>
                                    <span class="text-xs ml-1 self-center" style="color:var(--text-muted);">${f.rating}/5</span>
                                </div>
                                <p class="text-sm" style="color:var(--text-primary);">${f.message}</p>
                                <p class="text-xs mt-2" style="color:#b0a59a;">${f.createdAt}</p>
                            </div>
                            <div class="flex-shrink-0">
                                <form action="/feedback/delete/${f.feedbackId}" method="post">
                                    <button type="submit" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(220,38,38,0.05);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Delete</button>
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