<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password — Flor</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { font-family: 'Inter', sans-serif; }
        body { background: #EFDACC; background-image: radial-gradient(ellipse at 30% 0%, rgba(139,94,60,0.06) 0%, transparent 50%), radial-gradient(ellipse at 70% 100%, rgba(196,149,106,0.08) 0%, transparent 50%); }
        .auth-card { background: #FFFFFF; border: 1px solid rgba(29,29,27,0.06); box-shadow: 0 8px 40px rgba(0,0,0,0.06); }
        .input-field { background: #FAFAF7; border: 1px solid rgba(29,29,27,0.1); color: #1d1d1b; transition: all 0.3s; }
        .input-field:focus { border-color: #8B5E3C; box-shadow: 0 0 0 3px rgba(139,94,60,0.1); outline: none; }
        .input-field::placeholder { color: #9a8d82; }
        .btn-gradient { background: linear-gradient(135deg, #8B5E3C, #C4956A); transition: all 0.3s; }
        .btn-gradient:hover { box-shadow: 0 4px 20px rgba(139,94,60,0.3); transform: translateY(-1px); }
        .fade-in { animation: fadeInUp 0.6s ease-out both; }
        @keyframes fadeInUp { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center px-4">

<div class="w-full max-w-md auth-card rounded-2xl p-8 fade-in">

    <div class="text-center mb-8">
        <div class="text-4xl mb-2">🔑</div>
        <h1 class="text-2xl font-bold" style="color: #1d1d1b;">Forgot Password</h1>
        <p class="mt-1.5 text-sm" style="color: #9a8d82;">Enter your email to receive a reset link</p>
    </div>

    <c:if test="${not empty successMessage}">
        <div style="background: rgba(22,163,74,0.06); border: 1px solid rgba(22,163,74,0.15); color: #16a34a;"
             class="px-4 py-3 rounded-xl mb-4 text-sm">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div style="background: rgba(220,38,38,0.06); border: 1px solid rgba(220,38,38,0.12); color: #dc2626;"
             class="px-4 py-3 rounded-xl mb-4 text-sm">❌ ${errorMessage}</div>
    </c:if>

    <form action="/forgot-password" method="post" class="space-y-5">
        <div>
            <label class="block text-sm font-medium mb-1.5" style="color: #3d3530;">Email</label>
            <input type="email" name="email" required placeholder="you@example.com"
                   class="w-full input-field rounded-xl px-4 py-3 text-sm"/>
        </div>
        <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">
            Send Reset Link
        </button>
    </form>

    <p class="text-center text-sm mt-6" style="color: #9a8d82;">
        Remember your password?
        <a href="/login" class="font-medium transition" style="color: #8B5E3C;">Back to Login</a>
    </p>
</div>

</body>
</html>
