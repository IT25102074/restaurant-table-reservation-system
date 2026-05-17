<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-4xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold mb-6" style="color:var(--text-primary);">⭐ My Feedback</h2>

    <c:if test="${not empty successMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #16a34a;color:#16a34a;">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #dc2626;color:#dc2626;">❌ ${errorMessage}</div>
    </c:if>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <div>
            <div class="glass rounded-2xl p-6">
                <h3 class="font-semibold mb-4" style="color:var(--text-primary);">
                    <c:choose><c:when test="${not empty editFeedback}">✏️ Edit Feedback</c:when><c:otherwise>✍️ Submit New Feedback</c:otherwise></c:choose>
                </h3>
                <c:if test="${empty editFeedback}">
                    <form action="/feedback/submit" method="post" class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Your Message <span style="color:var(--text-muted);">(min 10 characters)</span></label>
                            <textarea name="message" required rows="4" placeholder="Share your dining experience..." class="w-full input-dark rounded-xl px-4 py-3 text-sm resize-none"></textarea>
                        </div>
                        <div>
                            <label class="block text-sm font-medium mb-2" style="color:var(--text-primary);">Rating</label>
                            <div class="flex gap-2">
                                <c:forEach begin="1" end="5" var="star">
                                    <label class="cursor-pointer">
                                        <input type="radio" name="rating" value="${star}" class="hidden peer" required/>
                                        <span class="text-2xl peer-checked:opacity-100 opacity-30 hover:opacity-70 transition select-none">⭐</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                        <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">Submit Feedback</button>
                    </form>
                </c:if>
                <c:if test="${not empty editFeedback}">
                    <form action="/feedback/update/${editFeedback.feedbackId}" method="post" class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Your Message</label>
                            <textarea name="message" required rows="4" class="w-full input-dark rounded-xl px-4 py-3 text-sm resize-none">${editFeedback.message}</textarea>
                        </div>
                        <div>
                            <label class="block text-sm font-medium mb-2" style="color:var(--text-primary);">Rating</label>
                            <div class="flex gap-2">
                                <c:forEach begin="1" end="5" var="star">
                                    <label class="cursor-pointer">
                                        <input type="radio" name="rating" value="${star}" class="hidden peer" ${editFeedback.rating == star ? 'checked' : ''}/>
                                        <span class="text-2xl peer-checked:opacity-100 opacity-30 hover:opacity-70 transition select-none">⭐</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                        <button type="submit" class="w-full font-semibold py-3 rounded-xl transition text-sm" style="background:rgba(37,99,235,0.06);color:#2563eb;border:1px solid rgba(37,99,235,0.15);">Save Changes</button>
                        <a href="/feedback/my" class="block text-center text-sm mt-1 transition" style="color:var(--text-muted);">Cancel</a>
                    </form>
                </c:if>
            </div>
        </div>

        <div>
            <c:choose>
                <c:when test="${empty feedbackList}">
                    <div class="glass rounded-2xl p-10 text-center" style="color:var(--text-muted);"><div class="text-4xl mb-3">⭐</div><p>You haven't submitted any feedback yet.</p></div>
                </c:when>
                <c:otherwise>
                    <div class="space-y-4">
                        <c:forEach var="f" items="${feedbackList}">
                            <div class="glass rounded-2xl p-5 ${not empty editFeedback && editFeedback.feedbackId == f.feedbackId ? '' : ''}">
                                <div class="flex items-center gap-1 mb-2">
                                    <c:forEach begin="1" end="5" var="s">
                                        <span class="text-lg ${s <= f.rating ? '' : 'opacity-20'}">⭐</span>
                                    </c:forEach>
                                    <span class="text-xs ml-2" style="color:var(--text-muted);">${f.rating}/5</span>
                                    <c:if test="${f.rating >= 4}">
                                        <span class="ml-auto text-xs bg-green-500/15 text-green-400 px-2 py-0.5 rounded-full border border-green-500/20">Positive</span>
                                    </c:if>
                                    <c:if test="${f.rating < 4}">
                                        <span class="ml-auto text-xs bg-red-500/15 text-red-400 px-2 py-0.5 rounded-full border border-red-500/20">Complaint</span>
                                    </c:if>
                                </div>
                                <p class="text-sm mb-3" style="color:var(--text-primary);">${f.message}</p>
                                <p class="text-xs mb-3" style="color:var(--text-muted);">${f.createdAt}</p>
                                <div class="flex gap-2">
                                    <a href="/feedback/edit/${f.feedbackId}" class="text-xs bg-blue-500/15 text-blue-400 px-3 py-1.5 rounded-lg hover:bg-blue-500/25 transition border border-blue-500/20">Edit</a>
                                    <form action="/feedback/delete/${f.feedbackId}" method="post" onsubmit="return confirm('Delete this feedback?')">
                                        <button type="submit" class="text-xs bg-red-500/15 text-red-400 px-3 py-1.5 rounded-lg hover:bg-red-500/25 transition border border-red-500/20">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>