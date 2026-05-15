<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error — ReserveSmart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { font-family: 'Inter', sans-serif; }
        body { background: #0f172a; background-image: radial-gradient(ellipse at 50% 50%, rgba(239,68,68,0.06) 0%, transparent 60%); }
        .glass-card { background: rgba(30,41,59,0.7); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.08); }
        .fade-in { animation: fadeInUp 0.6s ease-out both; }
        @keyframes fadeInUp { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center px-4">
<div class="w-full max-w-md glass-card rounded-2xl p-8 text-center fade-in" style="box-shadow: 0 8px 40px rgba(0,0,0,0.4);">
    <h1 class="text-6xl font-bold bg-gradient-to-r from-red-400 to-amber-400 bg-clip-text text-transparent mb-2">Oops!</h1>
    <h2 class="text-2xl font-semibold text-slate-200 mb-4">Error ${statusCode}</h2>
    <div class="bg-red-500/10 border border-red-500/20 text-red-400 p-4 rounded-xl mb-6 text-sm">
        <p>${errorMessage}</p>
    </div>
    <p class="text-slate-500 mb-8 text-sm">Something went wrong. Please try again or go back to the homepage.</p>
    <a href="/" class="inline-block bg-gradient-to-r from-amber-500 to-red-500 hover:shadow-lg hover:shadow-amber-500/20 text-white font-semibold py-2.5 px-6 rounded-xl transition-all duration-300 text-sm">
        Back to Home
    </a>
</div>
</body>
</html>
