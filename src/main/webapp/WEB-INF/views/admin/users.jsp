<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">

    <h2 class="text-2xl font-bold text-slate-100 mb-6">👥 Manage Users</h2>

    <c:if test="${not empty successMessage}">
        <div class="glass border-green-500/30 text-green-400 px-4 py-3 rounded-xl mb-4 text-sm">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">❌ ${errorMessage}</div>
    </c:if>

    <!-- Search -->
    <div class="glass rounded-2xl p-4 mb-6">
        <form action="/admin/users" method="get" class="flex gap-3">
            <input type="text" name="keyword" value="${keyword}" placeholder="Search by name or email..."
                   class="flex-1 input-dark rounded-xl px-4 py-2.5 text-sm"/>
            <button type="submit"
                    class="bg-white/10 hover:bg-white/15 text-slate-300 text-sm font-semibold
                           px-5 py-2.5 rounded-xl transition border border-white/10">Search</button>
            <a href="/admin/users"
               class="border border-white/10 text-slate-500 text-sm px-4 py-2.5 rounded-xl
                      hover:bg-white/5 transition">Clear</a>
        </form>
    </div>

    <!-- Users Table -->
    <div class="glass rounded-2xl overflow-hidden">
        <div class="px-6 py-4 border-b border-white/5 flex justify-between">
            <h3 class="font-semibold text-slate-200">All Users</h3>
            <span class="text-xs text-slate-500">${users.size()} found</span>
        </div>

        <c:choose>
            <c:when test="${empty users}">
                <div class="text-center py-16 text-slate-500">
                    <div class="text-4xl mb-2">👥</div>
                    <p>No users found.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm table-dark">
                        <thead>
                            <tr class="text-slate-500 text-xs uppercase">
                                <th class="px-4 py-3 text-left">ID</th>
                                <th class="px-4 py-3 text-left">Name</th>
                                <th class="px-4 py-3 text-left">Email</th>
                                <th class="px-4 py-3 text-left">Phone</th>
                                <th class="px-4 py-3 text-left">Role</th>
                                <th class="px-4 py-3 text-left">Joined</th>
                                <th class="px-4 py-3 text-left">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${users}">
                                <tr class="border-t border-white/5">
                                    <td class="px-4 py-3 text-slate-600">${u.userId}</td>
                                    <td class="px-4 py-3 font-medium text-slate-200">${u.fullName}</td>
                                    <td class="px-4 py-3 text-slate-400">${u.email}</td>
                                    <td class="px-4 py-3 text-slate-400">${u.phone}</td>
                                    <td class="px-4 py-3">
                                        <span class="text-xs px-2 py-0.5 rounded-full font-medium
                                            ${u.role == 'ADMIN'
                                                ? 'bg-slate-200 text-slate-800'
                                                : 'bg-amber-500/15 text-amber-400 border border-amber-500/20'}">
                                            ${u.role}
                                        </span>
                                    </td>
                                    <td class="px-4 py-3 text-slate-600 text-xs">${u.createdAt}</td>
                                    <td class="px-4 py-3">
                                        <form action="/admin/users/delete/${u.userId}" method="post"
                                              onsubmit="return confirm('Delete user ${u.fullName}? This cannot be undone.')">
                                            <button type="submit"
                                                    class="text-xs bg-red-500/15 text-red-400 px-3 py-1.5
                                                           rounded-lg hover:bg-red-500/25 transition border border-red-500/20">Delete</button>
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