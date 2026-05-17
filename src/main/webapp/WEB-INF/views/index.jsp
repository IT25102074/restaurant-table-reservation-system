<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="description"
                content="Flor — Authentic Sri Lankan dining. Reserve your table online with ReserveSmart.">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Flor — Authentic Sri Lankan Dining</title>
            <link rel="icon" href="/images/favicon.ico" type="image/x-icon">

            <link rel="preload" href="/fonts/PFDinTextPro-Bold.woff2" as="font" type="font/woff2" crossorigin="">
            <link rel="preload" href="/fonts/PFDinTextPro-Regular.woff2" as="font" type="font/woff2" crossorigin="">
            <link rel="preload" href="/fonts/WithHearty.woff2" as="font" type="font/woff2" crossorigin="">

            <script src="https://cdn.tailwindcss.com"></script>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">

            <style>
                @font-face {
                    font-family: 'WithHearty';
                    src: url('/fonts/WithHearty.woff2') format('woff2'), url('/fonts/WithHearty.woff') format('woff');
                    font-weight: normal;
                    font-style: normal;
                    font-display: swap;
                }

                @font-face {
                    font-family: 'PFDinTextPro';
                    src: url('/fonts/PFDinTextPro-Regular.woff2') format('woff2'), url('/fonts/PFDinTextPro-Regular.woff') format('woff');
                    font-weight: 400;
                    font-style: normal;
                    font-display: swap;
                }

                @font-face {
                    font-family: 'PFDinTextPro';
                    src: url('/fonts/PFDinTextPro-Bold.woff2') format('woff2'), url('/fonts/PFDinTextPro-Bold.woff') format('woff');
                    font-weight: 700;
                    font-style: normal;
                    font-display: swap;
                }

                @font-face {
                    font-family: 'PFDinTextPro';
                    src: url('/fonts/PFDinTextPro-Light.woff2') format('woff2'), url('/fonts/PFDinTextPro-Light.woff') format('woff');
                    font-weight: 300;
                    font-style: normal;
                    font-display: swap;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'PFDinTextPro', 'Inter', sans-serif;
                    background: #EFDACC;
                    color: #1d1d1b;
                    overflow-x: hidden;
                }

                /* ── Navbar ── */
                .flor-nav {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    z-index: 100;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 1rem 2.5rem;
                    background: rgba(239, 218, 204, 0.95);
                    backdrop-filter: blur(12px);
                    -webkit-backdrop-filter: blur(12px);
                    border-bottom: 1px solid rgba(29, 29, 27, 0.08);
                    transition: background 0.3s;
                }

                .flor-nav a {
                    color: #1d1d1b;
                    text-decoration: none;
                    font-size: 0.9rem;
                    font-weight: 600;
                    letter-spacing: 0.07em;
                    text-transform: uppercase;
                    transition: opacity 0.3s;
                }

                .flor-nav a:hover {
                    opacity: 0.55;
                }

                .flor-nav-logo {
                    font-family: 'WithHearty', cursive;
                    font-size: 10rem;
                    letter-spacing: 0.02em;
                    text-transform: none;
                }

                .flor-nav-links {
                    display: flex;
                    gap: 2.2rem;
                    align-items: center;
                }

                .flor-nav-actions {
                    display: flex;
                    gap: 1.5rem;
                    align-items: center;
                }

                .flor-btn-reserve {
                    background: #1d1d1b;
                    color: #EFDACC !important;
                    padding: 0.65rem 1.8rem;
                    border-radius: 0.5rem;
                    font-size: 0.85rem;
                    font-weight: 700;
                    letter-spacing: 0.08em;
                    text-transform: uppercase;
                    transition: all 0.3s;
                }

                .flor-btn-reserve:hover {
                    background: #3d3530;
                    transform: translateY(-1px);
                    box-shadow: 0 4px 18px rgba(0, 0, 0, 0.18);
                }

                /* ── Hero ── */
                .hero-section {
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    text-align: center;
                    padding: 5rem 2rem 3rem;
                    position: relative;
                    gap: 1.2rem;
                }

                /* FLOR text — food photo fills all 4 letters */
                .flor-hero-brand {
                    font-family: 'PFDinTextPro', sans-serif;
                    font-weight: 900;
                    font-size: clamp(8rem, 22vw, 18rem);
                    line-height: 1;
                    letter-spacing: 0.08em;
                    /* Use multiple images stitched across the text */
                    background-image:
                        url('/images/ss25-menu-haven-1.png_2.webp'),
                        url('/images/ss25-menu-haven-4.png_8.webp'),
                        url('/images/ss25-menu-haven-3.png_10.webp'),
                        url('/images/ss25-menu-haven-2.png_9.webp');
                    background-size: 25% 100%, 25% 100%, 25% 100%, 25% 100%;
                    background-position: 0% 50%, 33% 50%, 66% 50%, 100% 50%;
                    background-repeat: no-repeat;
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                    color: transparent;
                    text-transform: uppercase;
                    display: block;
                    width: 100%;
                    margin-bottom: 0;
                }

                .hero-section h1 {
                    font-family: 'PFDinTextPro', sans-serif;
                    font-weight: 300;
                    font-size: clamp(1.4rem, 3vw, 2.6rem);
                    line-height: 1.3;
                    max-width: 700px;
                    margin-bottom: 0;
                    letter-spacing: 0.03em;
                }

                .hero-section .hero-body {
                    font-size: 1.1rem;
                    line-height: 1.75;
                    max-width: 560px;
                    color: #4a3f36;
                    margin-bottom: 0;
                }

                .hero-section .hero-welcome {
                    font-family: 'WithHearty', cursive;
                    font-size: 3rem;
                    color: #8B5E3C;
                }

                /* ── Sections ── */
                .flor-section {
                    padding: 3.5rem 2rem;
                    max-width: 1100px;
                    margin: 0 auto;
                }

                .flor-section-bg {
                    background: #FFF8F2;
                    padding: 3.5rem 2rem;
                }

                .flor-section-heading {
                    font-family: 'PFDinTextPro', sans-serif;
                    font-weight: 300;
                    font-size: 0.9rem;
                    letter-spacing: 0.14em;
                    text-transform: uppercase;
                    color: #9a8d82;
                    margin-bottom: 0.75rem;
                }

                .flor-section-title {
                    font-family: 'WithHearty', cursive;
                    font-size: clamp(2.4rem, 4.5vw, 4rem);
                    line-height: 1.15;
                    margin-bottom: 2rem;
                    color: #1d1d1b;
                }

                .flor-two-col {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 3rem;
                    max-width: 1100px;
                    margin: 2rem auto 0;
                }

                .flor-two-col h2 {
                    font-family: 'PFDinTextPro', sans-serif;
                    font-weight: 700;
                    font-size: 1.5rem;
                    margin-bottom: 1rem;
                }

                .flor-two-col p {
                    font-size: 1rem;
                    line-height: 1.75;
                    color: #4a3f36;
                }

                .flor-link {
                    display: inline-block;
                    margin-top: 1rem;
                    font-size: 0.9rem;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 0.09em;
                    color: #1d1d1b;
                    text-decoration: none;
                    border-bottom: 1.5px solid #1d1d1b;
                    padding-bottom: 2px;
                    transition: opacity 0.3s;
                }

                .flor-link:hover {
                    opacity: 0.55;
                }

                /* ── Carousel ── */
                .flor-carousel {
                    display: flex;
                    gap: 1.5rem;
                    overflow-x: auto;
                    padding: 2rem 0;
                    scroll-snap-type: x mandatory;
                    -webkit-overflow-scrolling: touch;
                    scrollbar-width: none;
                }

                .flor-carousel::-webkit-scrollbar {
                    display: none;
                }

                .flor-carousel img {
                    width: 340px;
                    height: 340px;
                    object-fit: cover;
                    border-radius: 1rem;
                    scroll-snap-align: start;
                    flex-shrink: 0;
                    transition: transform 0.4s ease;
                }

                .flor-carousel img:hover {
                    transform: scale(1.03);
                }

                /* ── Teaser ── */
                .flor-teaser {
                    text-align: center;
                    padding: 4rem 2rem;
                }

                .flor-teaser img {
                    max-width: 220px;
                    margin: 0 auto 1rem;
                }

                .flor-teaser .title-special {
                    font-family: 'WithHearty', cursive;
                    font-size: 3.5rem;
                    color: #1d1d1b;
                }

                /* ── About ── */
                .flor-about {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 4rem;
                    max-width: 1100px;
                    margin: 0 auto;
                    padding: 3.5rem 2rem;
                    align-items: center;
                }

                .flor-about img {
                    width: 100%;
                }

                .flor-about h2 {
                    font-family: 'PFDinTextPro', sans-serif;
                    font-weight: 700;
                    font-size: 1.8rem;
                    line-height: 1.3;
                    margin-bottom: 1.5rem;
                }

                /* ── Footer ── */
                .flor-footer {
                    background: #1d1d1b;
                    color: #EFDACC;
                    padding: 3rem 2rem 1.5rem;
                }

                .flor-footer .title-special {
                    font-family: 'WithHearty', cursive;
                    font-size: 5rem;
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .flor-footer-grid {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 2rem;
                    max-width: 900px;
                    margin: 0 auto;
                }

                .flor-footer-grid strong {
                    display: block;
                    font-size: 0.78rem;
                    text-transform: uppercase;
                    letter-spacing: 0.1em;
                    margin-bottom: 0.75rem;
                    color: #c4a98a;
                }

                .flor-footer-grid p,
                .flor-footer-grid a {
                    font-size: 0.95rem;
                    line-height: 1.75;
                    color: #d4c4b4;
                }

                .flor-footer-grid a {
                    text-decoration: none;
                    transition: opacity 0.3s;
                }

                .flor-footer-grid a:hover {
                    opacity: 0.7;
                }

                .flor-bottombar {
                    text-align: center;
                    padding: 1.5rem 2rem;
                    font-size: 0.8rem;
                    color: #7a6b5e;
                    border-top: 1px solid rgba(239, 218, 204, 0.1);
                    margin-top: 2rem;
                }

                /* ── Animations ── */
                .animate--slide-in {
                    opacity: 0;
                    transform: translateY(30px);
                    transition: opacity 0.7s ease, transform 0.7s ease;
                }

                .animate--slide-in.is-visible {
                    opacity: 1;
                    transform: translateY(0);
                }

                @media (max-width: 768px) {

                    .flor-two-col,
                    .flor-about {
                        grid-template-columns: 1fr;
                    }

                    .flor-footer-grid {
                        grid-template-columns: 1fr;
                    }

                    .flor-nav-links {
                        display: none;
                    }

                    .flor-carousel img {
                        width: 270px;
                        height: 270px;
                    }

                    .flor-hero-brand {
                        font-size: clamp(5rem, 28vw, 9rem);
                        background-size: 25% 100%, 25% 100%, 25% 100%, 25% 100%;
                    }
                }
            </style>
        </head>

        <body>

            <!-- ═══ NAVBAR ═══ -->
            <nav class="flor-nav">
                <a href="/" class="flor-nav-logo">Flor</a>
                <div class="flor-nav-links">
                    <a href="/">Home</a>
                    <a href="#menu">Menu</a>
                    <a href="#about">About</a>
                </div>
                <div class="flor-nav-actions">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <c:if test="${sessionScope.userRole == 'CUSTOMER'}">
                                <a href="/customer/dashboard">Dashboard</a>
                            </c:if>
                            <c:if test="${sessionScope.userRole == 'ADMIN'}">
                                <a href="/admin/dashboard">Dashboard</a>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                    <%-- Smart Reserve: CUSTOMER → dashboard; guest → login --%>
                        <c:choose>
                            <c:when test="${sessionScope.userRole == 'CUSTOMER'}">
                                <a href="/customer/dashboard" class="flor-btn-reserve">Reserve</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="flor-btn-reserve">Reserve</a>
                            </c:otherwise>
                        </c:choose>
                </div>
            </nav>

            <!-- ═══ HERO ═══ -->
            <section class="hero-section">
                <%-- CSS food-photo fill text "FLOR" replacing the HAVEN banner image --%>
                    <div class="animate--slide-in">
                        <div class="flor-hero-brand">FLOR</div>
                    </div>
                    <div class="animate--slide-in">
                        <h1>Authentic Sri Lankan Cuisine in a Warm, Welcoming Atmosphere</h1>
                    </div>
                    <div class="animate--slide-in">
                        <p class="hero-body">We believe food is more than a simple pleasure — it's a moment to connect,
                            to travel differently, and to feel right at home.</p>
                        <p class="hero-welcome">Welcome to Flor!</p>
                    </div>
            </section>

            <!-- ═══ SEASON SECTION ═══ -->
            <div class="flor-section-bg">
                <div class="flor-section" style="text-align:center;">
                    <div class="animate--slide-in">
                        <p class="flor-section-heading">This Season at Flor</p>
                        <p class="flor-section-title">A New Season, A New Menu</p>
                    </div>
                </div>

                <div class="flor-two-col" style="padding: 0 2rem;" id="menu">
                    <div class="animate--slide-in">
                        <h2>Flor Seasonal Menu</h2>
                        <p>Our menu takes on seasonal tones — fresh Sri Lankan spices, vibrant curries, and colourful
                            tropical desserts prepared with authentic local ingredients.</p>
                        <c:choose>
                            <c:when test="${sessionScope.userRole == 'CUSTOMER'}">
                                <a href="/customer/dashboard" class="flor-link">Reserve a Table →</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="flor-link">Reserve a Table →</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="animate--slide-in">
                        <h2>Signature Ceylon Tea &amp; Drinks</h2>
                        <p>Each season brings new specialty teas and drinks. This month discover our exclusive Ceylon
                            tea collection alongside refreshing king coconut water and tropical fruit blends.</p>
                        <c:choose>
                            <c:when test="${sessionScope.userRole == 'CUSTOMER'}">
                                <a href="/customer/dashboard" class="flor-link">Book Now →</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="flor-link">Book Now →</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- ═══ BRUNCH TEASER ═══ -->
            <div class="flor-teaser">
                <img loading="lazy" src="/images/BRUNCH_0.svg" alt="Dining Hours">
                <p class="title-special">11am – 10pm</p>
            </div>

            <!-- ═══ CUISINE DESCRIPTION ═══ -->
            <div class="flor-section" style="max-width: 720px; text-align: center;">
                <div class="animate--slide-in">
                    <h2
                        style="font-family:'PFDinTextPro',sans-serif; font-weight:700; font-size:1.8rem; margin-bottom:1.5rem;">
                        Rich, authentic recipes inspired by traditional Sri Lankan culinary heritage
                    </h2>
                    <p style="font-size:1.05rem; line-height:1.8; color:#4a3f36;">
                        At Flor, dining means colourful, generous and creative plates, prepared with the finest spices
                        and freshest seasonal ingredients from across Sri Lanka.
                    </p>
                    <p style="font-size:1.05rem; line-height:1.8; color:#4a3f36; margin-top:1rem;">
                        <strong>Every season brings its own menu!</strong><br>
                        Three months to explore new sweet and savoury recipes imagined by our chef and his team.
                    </p>
                    <c:choose>
                        <c:when test="${sessionScope.userRole == 'CUSTOMER'}">
                            <a href="/customer/dashboard" class="flor-link" style="margin-top:1.5rem;">Make a
                                Reservation →</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/login" class="flor-link" style="margin-top:1.5rem;">Make a Reservation →</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- ═══ FOOD CAROUSEL ═══ -->
            <div style="padding: 2rem 0;">
                <div class="flor-carousel" style="padding-left: 2rem;">
                    <img loading="lazy" src="/images/ss25-menu-haven-1.png_2.webp" alt="Signature Dish at Flor">
                    <img loading="lazy" src="/images/ss25-menu-haven-4.png_8.webp" alt="Traditional Sri Lankan Curry">
                    <img loading="lazy" src="/images/ss25-menu-haven-3.png_10.webp" alt="Dessert Platter at Flor">
                    <img loading="lazy" src="/images/ss25-menu-haven-2.png_9.webp" alt="Fresh Focaccia">
                    <img loading="lazy" src="/images/ss25-menu-haven-6.png_9.webp" alt="Granola Bowl">
                    <img loading="lazy" src="/images/ss25-menu-haven-5.png_7.webp" alt="Signature Smoothie">
                    <img loading="lazy" src="/images/ss25-menu-haven-7.png_8.webp" alt="Ube Latte">
                    <img loading="lazy" src="/images/ss25-menu-haven-8.png_10.webp" alt="Smoothie Bowl">
                </div>
            </div>

            <!-- ═══ COFFEE / TEA TEASER ═══ -->
            <div class="flor-teaser">
                <img loading="lazy" src="/images/COFFEE.svg" alt="Tea &amp; Drinks">
                <p class="title-special">All day</p>
            </div>

            <div class="flor-section" style="max-width: 720px; text-align: center;">
                <div class="animate--slide-in">
                    <h2
                        style="font-family:'PFDinTextPro',sans-serif; font-weight:700; font-size:1.8rem; margin-bottom:1.5rem;">
                        Explore specialty Ceylon tea in a warm, welcoming atmosphere
                    </h2>
                    <p style="font-size:1.05rem; line-height:1.8; color:#4a3f36;">
                        We offer a curated selection of premium Ceylon teas, aromatic Sri Lankan spiced coffee, fresh
                        king coconut water, and tropical fruit juices.
                    </p>
                    <p style="font-size:1.05rem; line-height:1.8; color:#4a3f36; margin-top:1rem;">
                        <strong>Not a tea lover?</strong><br>
                        Try our signature drinks — spiced ginger beer, fresh lime soda, or our tropical smoothie bowls.
                    </p>
                    <c:choose>
                        <c:when test="${sessionScope.userRole == 'CUSTOMER'}">
                            <a href="/customer/dashboard" class="flor-link" style="margin-top:1.5rem;">Reserve Your
                                Table →</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/login" class="flor-link" style="margin-top:1.5rem;">Reserve Your Table →</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- ═══ ABOUT SECTION ═══ -->
            <div class="flor-section-bg" id="about">
                <div class="flor-about">
                    <div>
                        <img loading="lazy" src="/images/haven-lineart-about-2026.svg"
                            alt="Illustration of Flor Restaurant" style="opacity: 0.75;">
                    </div>
                    <div class="animate--slide-in">
                        <h2>A warm place, a passionate team… a story to share</h2>
                        <p style="font-size:1.05rem; line-height:1.8; color:#4a3f36;">
                            Flor promises an authentic Sri Lankan escape — where rich flavours, warm hospitality, and
                            cultural heritage come together.
                            Passion and people are at the centre of everything we do. Let's share together a love for
                            flavour and craftsmanship.
                        </p>
                        <c:choose>
                            <c:when test="${sessionScope.userRole == 'CUSTOMER'}">
                                <a href="/customer/dashboard" class="flor-link" style="margin-top:1.5rem;">Join Us for
                                    Dinner →</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="flor-link" style="margin-top:1.5rem;">Join Us for Dinner →</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- ═══ FOOTER ═══ -->
            <footer class="flor-footer">
                <p class="title-special">Come Dine with Us</p>
                <div class="flor-footer-grid">
                    <div>
                        <strong>Flor Restaurant</strong>
                        <p>123 Galle Road<br>Colombo 03, Sri Lanka</p>
                        <p style="margin-top: 0.5rem;"><a href="tel:+94112345678">+94 (0) 11 234 5678</a></p>
                    </div>
                    <div>
                        <strong>Dining Hours</strong>
                        <p>Monday to Friday<br>11:00am – 10:00pm</p>
                        <p style="margin-top: 0.5rem;">Saturday &amp; Sunday<br>9:00am – 11:00pm</p>
                    </div>
                    <div>
                        <strong>Quick Links</strong>
                        <p>
                            <c:choose>
                                <c:when test="${sessionScope.userRole == 'CUSTOMER'}">
                                    <a href="/customer/dashboard" style="display:block; margin-bottom:0.3rem;">Reserve a
                                        Table</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/login" style="display:block; margin-bottom:0.3rem;">Reserve a Table</a>
                                </c:otherwise>
                            </c:choose>
                            <a href="/login" style="display:block; margin-bottom:0.3rem;">Login / Register</a>
                            <a href="#menu" style="display:block;">View Menu</a>
                        </p>
                    </div>
                </div>
                <div class="flor-bottombar">
                    <p>&copy; Flor 2026 — All rights reserved &nbsp;|&nbsp; Powered by ReserveSmart</p>
                </div>
            </footer>

            <!-- ═══ ANIMATIONS JS ═══ -->
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const observer = new IntersectionObserver(function (entries) {
                        entries.forEach(function (entry) {
                            if (entry.isIntersecting) { entry.target.classList.add('is-visible'); }
                        });
                    }, { threshold: 0.12 });
                    document.querySelectorAll('.animate--slide-in').forEach(function (el) {
                        observer.observe(el);
                    });
                });
            </script>
        </body>

        </html>