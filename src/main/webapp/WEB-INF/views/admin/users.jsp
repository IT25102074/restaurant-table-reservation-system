<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold mb-6" style="color:var(--text-primary);">👥 Manage Users</h2>

    <c:if test="${not empty successMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #16a34a;color:#16a34a;">✅ ${successMessage}</div></c:if>
    <c:if test="${not empty errorMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #dc2626;color:#dc2626;">❌ ${errorMessage}</div></c:if>

    <div class="glass rounded-2xl p-4 mb-6">
        <form action="/admin/users" method="get" class="flex gap-3">
            <input type="text" name="keyword" value="${keyword}" placeholder="Search by name or email..." class="flex-1 input-dark rounded-xl px-4 py-2.5 text-sm"/>
            <button type="submit" class="text-sm font-semibold px-5 py-2.5 rounded-xl transition" style="background:rgba(139,94,60,0.06);color:var(--text-primary);border:1px solid var(--border-light);">Search</button>
            <a href="/admin/users" class="text-sm px-4 py-2.5 rounded-xl transition" style="border:1px solid var(--border-light);color:var(--text-muted);">Clear</a>
        </form>
    </div>

    <div class="glass rounded-2xl overflow-hidden">
        <div class="px-6 py-4 flex justify-between" style="border-bottom:1px solid var(--border-light);">
            <h3 class="font-semibold" style="color:var(--text-primary);">All Users</h3>
            <span class="text-xs" style="color:var(--text-muted);">${users.size()} found</span>
        </div>
        <c:choose>
            <c:when test="${empty users}"><div class="text-center py-16" style="color:var(--text-muted);"><div class="text-4xl mb-2">👥</div><p>No users found.</p></div></c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm table-dark">
                        <thead><tr class="text-xs uppercase" style="color:var(--text-muted);"><th class="px-4 py-3 text-left">ID</th><th class="px-4 py-3 text-left">Name</th><th class="px-4 py-3 text-left">Email</th><th class="px-4 py-3 text-left">Phone</th><th class="px-4 py-3 text-left">Role</th><th class="px-4 py-3 text-left">Joined</th><th class="px-4 py-3 text-left">Actions</th></tr></thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr style="border-top:1px solid var(--border-light);">
                                    <td class="px-4 py-3" style="color:#b0a59a;">${u.userId}</td>
                                    <td class="px-4 py-3 font-medium" style="color:var(--text-primary);">${u.fullName}</td>
                                    <td class="px-4 py-3" style="color:var(--text-secondary);">${u.email}</td>
                                    <td class="px-4 py-3" style="color:var(--text-secondary);">${u.phone}</td>
                                    <td class="px-4 py-3"><span class="text-xs px-2 py-0.5 rounded-full font-medium ${u.role == 'ADMIN' ? '' : ''}" style="${u.role == 'ADMIN' ? 'background:#1d1d1b;color:#EFDACC;' : 'background:rgba(139,94,60,0.1);color:var(--accent);'}">${u.role}</span></td>
                                    <td class="px-4 py-3 text-xs" style="color:#b0a59a;">${u.createdAt}</td>
                                    <td class="px-4 py-3">
                                        <form action="/admin/users/delete/${u.userId}" method="post" onsubmit="return confirm('Delete user ${u.fullName}?')">
                                            <button type="submit" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(220,38,38,0.05);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Delete</button>
                                        </form>
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