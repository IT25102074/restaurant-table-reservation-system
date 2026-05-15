<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold text-slate-100 mb-6">🪑 Manage Tables</h2>

    <c:if test="${not empty successMessage}">
        <div class="glass border-green-500/30 text-green-400 px-4 py-3 rounded-xl mb-4 text-sm">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">❌ ${errorMessage}</div>
    </c:if>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div class="lg:col-span-1">
            <c:if test="${empty table}">
                <div class="glass rounded-2xl p-6 mb-6">
                    <h3 class="font-semibold text-slate-200 mb-4">➕ Add New Table</h3>
                    <form action="/admin/tables/add" method="post" class="space-y-4">
                        <div><label class="block text-sm font-medium text-slate-300 mb-1.5">Table Number</label>
                            <input type="text" name="tableNumber" required placeholder="T01" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium text-slate-300 mb-1.5">Capacity</label>
                            <input type="number" name="capacity" required min="1" placeholder="4" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium text-slate-300 mb-1.5">Location</label>
                            <input type="text" name="location" placeholder="Indoor / Outdoor / VIP" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">Add Table</button>
                    </form>
                </div>
            </c:if>
            <c:if test="${not empty table}">
                <div class="glass rounded-2xl p-6 mb-6" style="border:1px solid rgba(245,158,11,0.2);">
                    <h3 class="font-semibold text-slate-200 mb-1">✏️ Edit Table</h3>
                    <p class="text-xs text-amber-400 mb-4">Editing: <strong>${table.tableNumber}</strong></p>
                    <form action="/admin/tables/update/${table.tableId}" method="post" class="space-y-4">
                        <div><label class="block text-sm font-medium text-slate-300 mb-1.5">Capacity</label>
                            <input type="number" name="capacity" required min="1" value="${table.capacity}" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium text-slate-300 mb-1.5">Location</label>
                            <input type="text" name="location" value="${table.location}" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium text-slate-300 mb-1.5">Status</label>
                            <select name="status" class="w-full input-dark rounded-xl px-4 py-3 text-sm">
                                <option value="AVAILABLE" ${table.status=='AVAILABLE'?'selected':''}>Available</option>
                                <option value="RESERVED" ${table.status=='RESERVED'?'selected':''}>Reserved</option>
                                <option value="INACTIVE" ${table.status=='INACTIVE'?'selected':''}>Inactive</option>
                            </select></div>
                        <button type="submit" class="w-full bg-blue-500/20 hover:bg-blue-500/30 text-blue-400 border border-blue-500/30 font-semibold py-3 rounded-xl transition text-sm">Save Changes</button>
                        <a href="/admin/tables" class="block text-center text-sm text-slate-500 hover:text-slate-300 mt-1 transition">Cancel</a>
                    </form>
                </div>
            </c:if>
            <div class="glass rounded-2xl p-6">
                <h3 class="font-semibold text-slate-200 mb-4">🔍 Search & Filter</h3>
                <form action="/admin/tables" method="get" class="space-y-3">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Table number or location..." class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                    <select name="status" class="w-full input-dark rounded-xl px-4 py-3 text-sm">
                        <option value="">All Statuses</option>
                        <option value="AVAILABLE" ${filterStatus=='AVAILABLE'?'selected':''}>Available</option>
                        <option value="RESERVED" ${filterStatus=='RESERVED'?'selected':''}>Reserved</option>
                        <option value="INACTIVE" ${filterStatus=='INACTIVE'?'selected':''}>Inactive</option>
                    </select>
                    <button type="submit" class="w-full bg-white/10 hover:bg-white/15 text-slate-300 font-semibold py-2.5 rounded-xl transition text-sm border border-white/10">Apply Filter</button>
                    <a href="/admin/tables" class="block text-center text-sm text-slate-500 hover:text-slate-300 transition">Clear</a>
                </form>
            </div>
        </div>
        <div class="lg:col-span-2">
            <div class="glass rounded-2xl overflow-hidden">
                <div class="px-6 py-4 border-b border-white/5 flex justify-between items-center">
                    <h3 class="font-semibold text-slate-200">All Tables</h3>
                    <span class="text-xs text-slate-500">${tables.size()} tables found</span>
                </div>
                <c:choose>
                    <c:when test="${empty tables}">
                        <div class="text-center py-16 text-slate-500"><div class="text-5xl mb-3">🪑</div><p>No tables found.</p></div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                        <table class="w-full text-sm table-dark">
                            <thead><tr class="text-slate-500 text-xs uppercase">
                                <th class="px-4 py-3 text-left">Table No.</th><th class="px-4 py-3 text-left">Capacity</th>
                                <th class="px-4 py-3 text-left">Location</th><th class="px-4 py-3 text-left">Status</th><th class="px-4 py-3 text-left">Actions</th>
                            </tr></thead>
                            <tbody>
                                <c:forEach var="t" items="${tables}">
                                    <tr class="border-t border-white/5">
                                        <td class="px-4 py-3 font-semibold text-slate-200">${t.tableNumber}</td>
                                        <td class="px-4 py-3 text-slate-400">${t.capacity} pax</td>
                                        <td class="px-4 py-3 text-slate-400">${t.location}</td>
                                        <td class="px-4 py-3"><span class="px-2 py-0.5 rounded-full text-xs font-medium ${t.status=='AVAILABLE'?'bg-green-500/15 text-green-400 border border-green-500/20':t.status=='RESERVED'?'bg-amber-500/15 text-amber-400 border border-amber-500/20':'bg-slate-500/15 text-slate-400'}">${t.status}</span></td>
                                        <td class="px-4 py-3 flex gap-2">
                                            <a href="/admin/tables/edit/${t.tableId}" class="text-xs bg-blue-500/15 text-blue-400 px-3 py-1.5 rounded-lg hover:bg-blue-500/25 transition border border-blue-500/20">Edit</a>
                                            <form action="/admin/tables/delete/${t.tableId}" method="post" onsubmit="return confirm('Delete table ${t.tableNumber}?')">
                                                <button type="submit" class="text-xs bg-red-500/15 text-red-400 px-3 py-1.5 rounded-lg hover:bg-red-500/25 transition border border-red-500/20">Delete</button>
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
    </div>
</div>

<%@ include file="../common/footer.jsp" %>