<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold mb-6" style="color:var(--text-primary);">🪑 Manage Tables</h2>

    <c:if test="${not empty successMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #16a34a;color:#16a34a;">✅ ${successMessage}</div></c:if>
    <c:if test="${not empty errorMessage}"><div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #dc2626;color:#dc2626;">❌ ${errorMessage}</div></c:if>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div class="lg:col-span-1">
            <c:if test="${empty table}">
                <div class="glass rounded-2xl p-6 mb-6">
                    <h3 class="font-semibold mb-4" style="color:var(--text-primary);">➕ Add New Table</h3>
                    <form action="/admin/tables/add" method="post" class="space-y-4">
                        <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Table Number</label><input type="text" name="tableNumber" required placeholder="T01" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Capacity</label><input type="number" name="capacity" required min="1" placeholder="4" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Location</label><input type="text" name="location" placeholder="Indoor / Outdoor / VIP" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">Add Table</button>
                    </form>
                </div>
            </c:if>
            <c:if test="${not empty table}">
                <div class="glass rounded-2xl p-6 mb-6" style="border:1px solid rgba(139,94,60,0.15);">
                    <h3 class="font-semibold mb-1" style="color:var(--text-primary);">✏️ Edit Table</h3>
                    <p class="text-xs mb-4" style="color:var(--accent);">Editing: <strong>${table.tableNumber}</strong></p>
                    <form action="/admin/tables/update/${table.tableId}" method="post" class="space-y-4">
                        <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Capacity</label><input type="number" name="capacity" required min="1" value="${table.capacity}" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Location</label><input type="text" name="location" value="${table.location}" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
                        <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Status</label>
                            <select name="status" class="w-full input-dark rounded-xl px-4 py-3 text-sm">
                                <option value="AVAILABLE" ${table.status=='AVAILABLE'?'selected':''}>Available</option>
                                <option value="RESERVED" ${table.status=='RESERVED'?'selected':''}>Reserved</option>
                                <option value="INACTIVE" ${table.status=='INACTIVE'?'selected':''}>Inactive</option>
                            </select></div>
                        <button type="submit" class="w-full font-semibold py-3 rounded-xl transition text-sm" style="background:rgba(37,99,235,0.06);color:#2563eb;border:1px solid rgba(37,99,235,0.15);">Save Changes</button>
                        <a href="/admin/tables" class="block text-center text-sm transition" style="color:var(--text-muted);">Cancel</a>
                    </form>
                </div>
            </c:if>
            <div class="glass rounded-2xl p-6">
                <h3 class="font-semibold mb-4" style="color:var(--text-primary);">🔍 Search & Filter</h3>
                <form action="/admin/tables" method="get" class="space-y-3">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Table number or location..." class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                    <select name="status" class="w-full input-dark rounded-xl px-4 py-3 text-sm">
                        <option value="">All Statuses</option>
                        <option value="AVAILABLE" ${filterStatus=='AVAILABLE'?'selected':''}>Available</option>
                        <option value="RESERVED" ${filterStatus=='RESERVED'?'selected':''}>Reserved</option>
                        <option value="INACTIVE" ${filterStatus=='INACTIVE'?'selected':''}>Inactive</option>
                    </select>
                    <button type="submit" class="w-full font-semibold py-2.5 rounded-xl transition text-sm" style="background:rgba(139,94,60,0.06);color:var(--text-primary);border:1px solid var(--border-light);">Apply Filter</button>
                    <a href="/admin/tables" class="block text-center text-sm transition" style="color:var(--text-muted);">Clear</a>
                </form>
            </div>
        </div>
        <div class="lg:col-span-2">
            <div class="glass rounded-2xl overflow-hidden">
                <div class="px-6 py-4 flex justify-between items-center" style="border-bottom:1px solid var(--border-light);">
                    <h3 class="font-semibold" style="color:var(--text-primary);">All Tables</h3>
                    <span class="text-xs" style="color:var(--text-muted);">${tables.size()} tables found</span>
                </div>
                <c:choose>
                    <c:when test="${empty tables}"><div class="text-center py-16" style="color:var(--text-muted);"><div class="text-5xl mb-3">🪑</div><p>No tables found.</p></div></c:when>
                    <c:otherwise>
                        <div class="overflow-x-auto">
                        <table class="w-full text-sm table-dark">
                            <thead><tr class="text-xs uppercase" style="color:var(--text-muted);"><th class="px-4 py-3 text-left">Table No.</th><th class="px-4 py-3 text-left">Capacity</th><th class="px-4 py-3 text-left">Location</th><th class="px-4 py-3 text-left">Status</th><th class="px-4 py-3 text-left">Actions</th></tr></thead>
                            <tbody>
                                <c:forEach var="t" items="${tables}">
                                    <tr style="border-top:1px solid var(--border-light);">
                                        <td class="px-4 py-3 font-semibold" style="color:var(--text-primary);">${t.tableNumber}</td>
                                        <td class="px-4 py-3" style="color:var(--text-secondary);">${t.capacity} pax</td>
                                        <td class="px-4 py-3" style="color:var(--text-secondary);">${t.location}</td>
                                        <td class="px-4 py-3"><span class="px-2 py-0.5 rounded-full text-xs font-medium ${t.status=='AVAILABLE'?'bg-green-500/15 text-green-400 border border-green-500/20':t.status=='RESERVED'?'bg-amber-500/15 text-amber-400 border border-amber-500/20':'bg-slate-500/15 text-slate-400'}">${t.status}</span></td>
                                        <td class="px-4 py-3 flex gap-2">
                                            <a href="/admin/tables/edit/${t.tableId}" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(37,99,235,0.06);color:#2563eb;border:1px solid rgba(37,99,235,0.1);">Edit</a>
                                            <form action="/admin/tables/delete/${t.tableId}" method="post">
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
    </div>
</div>

<%@ include file="../common/footer.jsp" %>