<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-xl mx-auto px-4 py-10 fade-in">
    <h2 class="text-2xl font-bold mb-6" style="color:var(--text-primary);">👤 My Profile</h2>

    <c:if test="${not empty successMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #16a34a;color:#16a34a;">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left:3px solid #dc2626;color:#dc2626;">❌ ${errorMessage}</div>
    </c:if>

    <div class="glass rounded-2xl p-6 mb-6">
        <div class="space-y-3 text-sm">
            <div class="flex justify-between"><span style="color:var(--text-muted);">Email</span><span style="color:var(--text-primary);">${user.email}</span></div>
            <div class="flex justify-between"><span style="color:var(--text-muted);">Role</span><span class="px-2.5 py-0.5 rounded-full text-xs font-medium" style="background:rgba(139,94,60,0.1);color:var(--accent);">${user.role}</span></div>
            <div class="flex justify-between"><span style="color:var(--text-muted);">Member Since</span><span style="color:var(--text-primary);">${user.createdAt}</span></div>
        </div>
    </div>

    <div class="glass rounded-2xl p-6 mb-6">
        <h3 class="font-semibold mb-4" style="color:var(--text-primary);">Edit Profile</h3>
        <form action="/profile/update" method="post" class="space-y-4">
            <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Full Name</label>
                <input type="text" name="fullName" value="${user.fullName}" required class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
            <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Email</label>
                <input type="email" name="email" value="${user.email}" required class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
            <div><label class="block text-sm font-medium mb-1.5" style="color:var(--text-primary);">Phone Number</label>
                <input type="text" name="phone" value="${user.phone}" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/></div>
            <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">Save Changes</button>
        </form>
    </div>

    <div class="glass rounded-2xl p-6" style="border:1px solid rgba(220,38,38,0.1);">
        <h3 class="font-semibold mb-2" style="color:#dc2626;">⚠️ Danger Zone</h3>
        <p class="text-sm mb-4" style="color:var(--text-muted);">Deleting your account is permanent and cannot be undone.</p>
        <form action="/profile/delete" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This cannot be undone.')">
            <button type="submit" class="text-sm font-semibold px-5 py-2.5 rounded-xl transition" style="background:rgba(220,38,38,0.06);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Delete My Account</button>
        </form>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>