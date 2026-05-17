<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — ReserveSmart</title>
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

        /* Decorative blobs */
        .blob {
            position: fixed; border-radius: 50%; filter: blur(60px); pointer-events: none; z-index: 0;
        }
        .blob-1 { width: 350px; height: 350px; background: rgba(196,149,106,0.18); top: -80px; left: -80px; }
        .blob-2 { width: 250px; height: 250px; background: rgba(139,94,60,0.12); bottom: -60px; right: -60px; }

        /* Site name */
        .site-name {
            font-size: 0.75rem; font-weight: 800; letter-spacing: 0.2em;
            text-transform: uppercase; color: #6b5e54;
            margin-bottom: 1.5rem; position: relative; z-index: 1;
        }

        /* Card */
        .auth-card {
            background: #fff;
            border-radius: 20px;
            padding: 2.5rem 2.25rem;
            width: 100%; max-width: 440px;
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
            text-align: center;
        }
        .auth-card .subtitle {
            font-size: 0.875rem; color: #9a8d82; margin-bottom: 2rem; line-height: 1.5;
            text-align: center;
        }

        /* Section label */
        .field-section {
            font-size: 0.65rem; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.12em; color: #C4956A; margin: 1.5rem 0 0.75rem;
        }
        .field-section:first-of-type { margin-top: 0; }

        /* Fields */
        .field-group { margin-bottom: 1rem; }
        .field-group label {
            display: block; font-size: 0.8rem; font-weight: 600; color: #3d3530;
            margin-bottom: 0.4rem;
        }
        .field-group .field-row { display: flex; gap: 0.75rem; }
        .field-group .field-row .field-group { flex: 1; margin-bottom: 0; }

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

        /* Forgot password — underline animation */
        .forgot-link {
            float: right; font-size: 0.75rem; font-weight: 600;
            color: #8B5E3C; text-decoration: none;
            position: relative; padding-bottom: 1px;
        }
        .forgot-link::after {
            content: ''; position: absolute; bottom: 0; left: 0;
            width: 0; height: 1.5px; background: #8B5E3C;
            transition: width 0.25s ease;
        }
        .forgot-link:hover::after { width: 100%; }

        /* Submit button + spinner */
        .btn-submit {
            width: 100%; margin-top: 1.5rem;
            background: #1d1d1b; color: #fff;
            border: none; border-radius: 10px;
            padding: 0.875rem; cursor: pointer;
            font-size: 0.9rem; font-weight: 700; letter-spacing: 0.03em;
            transition: all 0.25s ease;
            display: flex; align-items: center; justify-content: center; gap: 0.5rem;
        }
        .btn-submit:hover {
            background: #3d3530;
            box-shadow: 0 6px 20px rgba(0,0,0,0.18);
            transform: translateY(-1px);
        }
        .btn-submit .spinner {
            display: none; width: 16px; height: 16px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top-color: #fff; border-radius: 50%;
            animation: spin 0.7s linear infinite;
        }
        .btn-submit.loading .spinner { display: block; }
        .btn-submit.loading { opacity: 0.8; pointer-events: none; }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* Flash messages */
        .flash-success {
            background: rgba(22,163,74,0.06); border: 1px solid rgba(22,163,74,0.15);
            color: #16a34a; padding: 0.7rem 1rem; border-radius: 10px;
            font-size: 0.8rem; margin-bottom: 1.25rem;
        }
        .flash-error {
            background: rgba(220,38,38,0.06); border: 1px solid rgba(220,38,38,0.12);
            color: #dc2626; padding: 0.7rem 1rem; border-radius: 10px;
            font-size: 0.8rem; margin-bottom: 1.25rem;
        }

        /* Bottom link */
        .bottom-link {
            text-align: center; margin-top: 1.5rem;
            font-size: 0.8rem; color: #9a8d82;
        }
        .bottom-link a { color: #8B5E3C; font-weight: 700; text-decoration: none; }
        .bottom-link a:hover { opacity: 0.75; }

        .divider {
            text-align: center; margin: 1rem 0;
            font-size: 0.72rem; color: #b0a59a; letter-spacing: 0.05em;
        }
        .home-link {
            display: block; text-align: center; margin-top: 0.6rem;
            font-size: 0.78rem; color: #9a8d82; text-decoration: none;
            transition: color 0.2s;
        }
        .home-link:hover { color: #1d1d1b; }

        /* Animated floating particles (#9) */
        .particles { position: fixed; inset: 0; z-index: 0; pointer-events: none; overflow: hidden; }
        .particle {
            position: absolute; border-radius: 50%;
            background: rgba(139,94,60,0.12);
            animation: floatUp linear infinite;
        }
        .particle:nth-child(1)  { width:12px; height:12px; left:10%;  animation-duration:12s; animation-delay:0s;    bottom:-20px; }
        .particle:nth-child(2)  { width:8px;  height:8px;  left:25%;  animation-duration:9s;  animation-delay:2s;    bottom:-20px; background:rgba(196,149,106,0.15); }
        .particle:nth-child(3)  { width:16px; height:16px; left:40%;  animation-duration:14s; animation-delay:4s;    bottom:-20px; }
        .particle:nth-child(4)  { width:6px;  height:6px;  left:55%;  animation-duration:10s; animation-delay:1s;    bottom:-20px; background:rgba(196,149,106,0.2); }
        .particle:nth-child(5)  { width:20px; height:20px; left:70%;  animation-duration:16s; animation-delay:3s;    bottom:-20px; }
        .particle:nth-child(6)  { width:10px; height:10px; left:85%;  animation-duration:11s; animation-delay:5s;    bottom:-20px; background:rgba(196,149,106,0.12); }
        .particle:nth-child(7)  { width:14px; height:14px; left:30%;  animation-duration:13s; animation-delay:7s;    bottom:-20px; }
        .particle:nth-child(8)  { width:9px;  height:9px;  left:60%;  animation-duration:8s;  animation-delay:0.5s;  bottom:-20px; background:rgba(139,94,60,0.08); }
        @keyframes floatUp {
            0%   { transform: translateY(0) rotate(0deg);   opacity: 0; }
            10%  { opacity: 1; }
            90%  { opacity: 0.6; }
            100% { transform: translateY(-110vh) rotate(360deg); opacity: 0; }
        }

        /* Animated blob drift */
        .blob-1 { animation: blobDrift1 18s ease-in-out infinite alternate; }
        .blob-2 { animation: blobDrift2 22s ease-in-out infinite alternate; }
        @keyframes blobDrift1 {
            from { transform: translate(0, 0) scale(1); }
            to   { transform: translate(40px, 30px) scale(1.1); }
        }
        @keyframes blobDrift2 {
            from { transform: translate(0, 0) scale(1); }
            to   { transform: translate(-30px, -20px) scale(1.08); }
        }
    </style>
</head>
<body>

<div class="blob blob-1"></div>
<div class="blob blob-2"></div>

<!-- Animated floating particles (#9) -->
<div class="particles">
    <div class="particle"></div><div class="particle"></div>
    <div class="particle"></div><div class="particle"></div>
    <div class="particle"></div><div class="particle"></div>
    <div class="particle"></div><div class="particle"></div>
</div>

<p class="site-name">ReserveSmart</p>

<div class="auth-card">

    <h1>Welcome Back</h1>
    <p class="subtitle">Sign in to manage your table reservations at Flor Restaurant.</p>

    <%-- Flash messages --%>
    <c:if test="${not empty successMessage}">
        <div class="flash-success">✅ ${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="flash-error">❌ ${errorMessage}</div>
    </c:if>

    <form action="/login" method="post">

        <p class="field-section">Account Credentials</p>

        <div class="field-group">
            <label for="emailOrPhone">Email or Phone Number</label>
            <input type="text" id="emailOrPhone" name="emailOrPhone" required
                   placeholder="user@example.com or 0771234567" autocomplete="username">
        </div>

        <div class="field-group">
            <label for="password">
                Password
                <a href="/forgot-password" class="forgot-link">Forgot password?</a>
            </label>
            <input type="password" id="password" name="password" required
                   placeholder="••••••••" autocomplete="current-password">
        </div>

        <button type="submit" class="btn-submit" id="loginBtn" onclick="this.classList.add('loading');this.querySelector('.spinner').style.display='block'">
            <span class="spinner"></span>
            <span>Sign In</span>
        </button>
    </form>

    <p class="bottom-link">
        New to ReserveSmart?
        <a href="/register">Create an account</a>
    </p>

    <div class="divider">—</div>
    <a href="/" class="home-link">← Back to Homepage</a>

</div>

</body>
</html>