<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password — ReserveSmart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { font-family: 'Inter', sans-serif; }
        body {
            background: #0f172a;
            background-image:
                radial-gradient(ellipse at 30% 0%, rgba(245,158,11,0.08) 0%, transparent 50%),
                radial-gradient(ellipse at 70% 100%, rgba(239,68,68,0.06) 0%, transparent 50%);
        }
        .glass-card { background: rgba(30,41,59,0.7); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.08); }
        .input-dark { background: rgba(15,23,42,0.6); border: 1px solid rgba(255,255,255,0.1); color: #f1f5f9; transition: all 0.3s; }
        .input-dark:focus { border-color: #f59e0b; box-shadow: 0 0 0 3px rgba(245,158,11,0.15); outline: none; }
        .input-dark::placeholder { color: #64748b; }
        .btn-gradient { background: linear-gradient(135deg, #f59e0b, #ef4444); transition: all 0.3s; }
        .btn-gradient:hover { box-shadow: 0 4px 20px rgba(245,158,11,0.4); transform: translateY(-1px); }
        .fade-in { animation: fadeInUp 0.6s ease-out both; }
        @keyframes fadeInUp { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center px-4">

<div class="w-full max-w-md glass-card rounded-2xl p-8 fade-in" style="box-shadow: 0 8px 40px rgba(0,0,0,0.4);">

    <div class="text-center mb-8">
        <div class="text-4xl mb-2">🔑</div>
        <h1 class="text-2xl font-bold text-slate-100">Forgot Password</h1>
        <p class="text-slate-400 mt-1.5 text-sm">Enter your email to receive a reset link</p>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="bg-green-500/10 border border-green-500/30 text-green-400 px-4 py-3 rounded-xl mb-4 text-sm">
            ✅ ${successMessage}
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="bg-red-500/10 border border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">
            ❌ ${errorMessage}
        </div>
    </c:if>

    <form action="/forgot-password" method="post" class="space-y-5">
        <div>
            <label class="block text-sm font-medium text-slate-300 mb-1.5">Email</label>
            <input type="email" name="email" required placeholder="you@example.com"
                   class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
        </div>
        <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">
            Send Reset Link
        </button>
    </form>

    <p class="text-center text-sm text-slate-500 mt-6">
        Remember your password?
        <a href="/login" class="text-amber-400 font-medium hover:text-amber-300 transition">Back to Login</a>
    </p>
</div>

</body>
</html>
