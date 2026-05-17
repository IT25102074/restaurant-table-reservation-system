<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error — Flor</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { font-family: 'Inter', sans-serif; }
        body { background: #EFDACC; background-image: radial-gradient(ellipse at 50% 50%, rgba(220,38,38,0.04) 0%, transparent 60%); }
        .auth-card { background: #FFFFFF; border: 1px solid rgba(29,29,27,0.06); box-shadow: 0 8px 40px rgba(0,0,0,0.06); }
        .fade-in { animation: fadeInUp 0.6s ease-out both; }
        @keyframes fadeInUp { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center px-4">
<div class="w-full max-w-md auth-card rounded-2xl p-8 text-center fade-in">
    <h1 class="text-6xl font-bold mb-2" style="background: linear-gradient(135deg, #dc2626, #8B5E3C); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Oops!</h1>
    <h2 class="text-2xl font-semibold mb-4" style="color: #1d1d1b;">Error ${statusCode}</h2>
    <div style="background: rgba(220,38,38,0.05); border: 1px solid rgba(220,38,38,0.1); color: #dc2626;" class="p-4 rounded-xl mb-6 text-sm">
        <p>${errorMessage}</p>
    </div>
    <p class="mb-8 text-sm" style="color: #9a8d82;">Something went wrong. Please try again or go back to the homepage.</p>
    <a href="/" class="inline-block text-white font-semibold py-2.5 px-6 rounded-xl transition-all duration-300 text-sm"
       style="background: linear-gradient(135deg, #8B5E3C, #C4956A);">
        Back to Home
    </a>
</div>
</body>
</html>
