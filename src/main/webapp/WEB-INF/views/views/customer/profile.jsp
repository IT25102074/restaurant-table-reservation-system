<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-xl mx-auto px-4 py-10 fade-in">

    <h2 class="text-2xl font-bold text-slate-100 mb-6">👤 My Profile</h2>

    <c:if test="${not empty successMessage}">
        <div class="glass border-green-500/30 text-green-400 px-4 py-3 rounded-xl mb-4 text-sm">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">❌ ${errorMessage}</div>
    </c:if>

    <!-- Profile Info Card -->
    <div class="glass rounded-2xl p-6 mb-6">
        <div class="space-y-3 text-sm">
            <div class="flex justify-between">
                <span class="font-medium text-slate-500">Email</span>
                <span class="text-slate-300">${user.email}</span>
            </div>
            <div class="flex justify-between">
                <span class="font-medium text-slate-500">Role</span>
                <span class="bg-amber-500/15 text-amber-400 px-2.5 py-0.5 rounded-full text-xs
                             border border-amber-500/20 font-medium">${user.role}</span>
            </div>
            <div class="flex justify-between">
                <span class="font-medium text-slate-500">Member Since</span>
                <span class="text-slate-300">${user.createdAt}</span>
            </div>
        </div>
    </div>

    <!-- Update Form -->
    <div class="glass rounded-2xl p-6 mb-6">
        <h3 class="font-semibold text-slate-200 mb-4">Edit Profile</h3>
        <form action="/profile/update" method="post" class="space-y-4">

            <div>
                <label class="block text-sm font-medium text-slate-300 mb-1.5">Full Name</label>
                <input type="text" name="fullName" value="${user.fullName}" required
                       class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-300 mb-1.5">Email</label>
                <input type="email" name="email" value="${user.email}" required
                       class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
            </div>

            <div>
                <label class="block text-sm font-medium text-slate-300 mb-1.5">Phone Number</label>
                <input type="text" name="phone" value="${user.phone}"
                       class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
            </div>

            <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">
                Save Changes
            </button>
        </form>
    </div>

    <!-- Delete Account -->
    <div class="glass rounded-2xl p-6" style="border: 1px solid rgba(239,68,68,0.15);">
        <h3 class="font-semibold text-red-400 mb-2">⚠️ Danger Zone</h3>
        <p class="text-sm text-slate-500 mb-4">
            Deleting your account is permanent and cannot be undone.
        </p>
        <form action="/profile/delete" method="post"
              onsubmit="return confirm('Are you sure you want to delete your account? This cannot be undone.')">
            <button type="submit"
                    class="bg-red-500/20 hover:bg-red-500/30 text-red-400 text-sm font-semibold
                           px-5 py-2.5 rounded-xl transition border border-red-500/20">
                Delete My Account
            </button>
        </form>
    </div>

</div>

<%@ include file="../common/footer.jsp" %>