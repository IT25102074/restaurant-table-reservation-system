<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — ReserveSmart</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            min-height: 100vh;
            background: #EFDACC;
            background-image:
                radial-gradient(ellipse at 15% 10%, rgba(196,149,106,0.25) 0%, transparent 45%),
                radial-gradient(ellipse at 85% 90%, rgba(139,94,60,0.15) 0%, transparent 45%);
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            padding: 2rem 1rem;
        }

        .blob {
            position: fixed; border-radius: 50%; filter: blur(60px); pointer-events: none; z-index: 0;
        }
        .blob-1 { width: 350px; height: 350px; background: rgba(196,149,106,0.18); top: -80px; left: -80px; }
        .blob-2 { width: 250px; height: 250px; background: rgba(139,94,60,0.12); bottom: -60px; right: -60px; }

        .site-name {
            font-size: 0.75rem; font-weight: 800; letter-spacing: 0.2em;
            text-transform: uppercase; color: #6b5e54;
            margin-bottom: 1.5rem; position: relative; z-index: 1;
        }

        .auth-card {
            background: #fff;
            border-radius: 20px;
            padding: 2.5rem 2.25rem;
            width: 100%; max-width: 480px;
            border-top: 4px solid #C4956A;
            box-shadow: 0 20px 60px rgba(139,94,60,0.12), 0 4px 16px rgba(0,0,0,0.06);
            position: relative; z-index: 1;
            animation: slideUp 0.45s ease both;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .auth-card h1 {
            font-size: 1.75rem; font-weight: 800; color: #1d1d1b;
            letter-spacing: -0.02em; margin-bottom: 0.4rem;
        }
        .auth-card .subtitle {
            font-size: 0.875rem; color: #9a8d82; margin-bottom: 1.5rem; line-height: 1.5;
        }

        .field-section {
            font-size: 0.65rem; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.12em; color: #C4956A; margin: 1.5rem 0 0.75rem;
        }

        .field-group { margin-bottom: 1rem; }
        .field-group label {
            display: block; font-size: 0.8rem; font-weight: 600; color: #3d3530;
            margin-bottom: 0.4rem;
        }
        .field-row { display: flex; gap: 0.75rem; }
        .field-row .field-group { flex: 1; margin-bottom: 0; }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            background: #F5F0EB;
            border: 1.5px solid transparent;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 0.875rem; color: #1d1d1b;
            outline: none;
            transition: border-color 0.25s, box-shadow 0.25s, background 0.25s;
        }
        input::placeholder { color: #b0a59a; }
        input:focus {
            background: #fff;
            border-color: #C4956A;
            box-shadow: 0 0 0 3px rgba(196,149,106,0.15);
        }

        .pw-hint {
            font-size: 0.7rem; color: #b0a59a; margin-top: 0.3rem;
        }

        .btn-submit {
            width: 100%; margin-top: 1.5rem;
            background: #1d1d1b; color: #fff;
            border: none; border-radius: 10px;
            padding: 0.875rem; cursor: pointer;
            font-size: 0.9rem; font-weight: 700; letter-spacing: 0.03em;
            transition: all 0.25s ease;
        }
        .btn-submit:hover {
            background: #3d3530;
            box-shadow: 0 6px 20px rgba(0,0,0,0.18);
            transform: translateY(-1px);
        }

        .flash-error {
            background: rgba(220,38,38,0.06); border: 1px solid rgba(220,38,38,0.12);
            color: #dc2626; padding: 0.7rem 1rem; border-radius: 10px;
            font-size: 0.8rem; margin-bottom: 1.25rem;
        }

        .bottom-link {
            text-align: center; margin-top: 1.5rem;
            font-size: 0.8rem; color: #9a8d82;
        }
        .bottom-link a { color: #8B5E3C; font-weight: 700; text-decoration: none; }
        .bottom-link a:hover { opacity: 0.75; }

        .divider { text-align: center; margin: 1rem 0; font-size: 0.72rem; color: #b0a59a; }
        .home-link {
            display: block; text-align: center; margin-top: 0.6rem;
            font-size: 0.78rem; color: #9a8d82; text-decoration: none;
            transition: color 0.2s;
        }
        .home-link:hover { color: #1d1d1b; }
    </style>
</head>
<body>

<div class="blob blob-1"></div>
<div class="blob blob-2"></div>

<p class="site-name">ReserveSmart</p>

<div class="auth-card">

    <h1>Create Your Account</h1>
    <p class="subtitle">Join ReserveSmart for quick &amp; easy table reservations at Flor Restaurant.</p>

    <c:if test="${not empty errorMessage}">
        <div class="flash-error">❌ ${errorMessage}</div>
    </c:if>

    <form action="/register" method="post">

        <p class="field-section">Account Security</p>

        <div class="field-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required
                   placeholder="you@example.com" autocomplete="email">
        </div>

        <div class="field-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required
                   placeholder="••••••••" autocomplete="new-password">
            <p class="pw-hint">Minimum 6 characters</p>
        </div>

        <p class="field-section">Personal Profile</p>

        <div class="field-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required
                   placeholder="John Doe" autocomplete="name">
        </div>

        <div class="field-group">
            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone" required
                   placeholder="0771234567" autocomplete="tel">
        </div>

        <button type="submit" class="btn-submit">Sign Up</button>
    </form>

    <p class="bottom-link">
        Already have an account?
        <a href="/login">Sign in instead</a>
    </p>

    <div class="divider">—</div>
    <a href="/" class="home-link">← Back to Homepage</a>

</div>

</body>
</html>
