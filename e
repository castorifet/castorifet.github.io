<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover" />
  <title>ElytraSky</title>
  <meta name="color-scheme" content="light dark" />

  <style>
    /* ==== CSS Variables (Theme) ==== */
    :root{
      --brand-50:#ecfdf5;
      --brand-200:#a7f3d0;
      --brand-400:#34d399;
      --brand-500:#22c55e;   /* 主綠 */
      --brand-600:#16a34a;   /* 深綠 */
      --brand-700:#15803d;
      --ink:#0f172a;         /* 文字 */
      --ink-muted:#475569;
      --card:#ffffff;
      --bg:#f5fff8;
      --radius:16px;
      --shadow:0 10px 30px rgba(0,0,0,.08);
      --blur: saturate(160%) blur(4px);
    }
    @media (prefers-color-scheme: dark){
      :root{
        --ink:#e6f4ea;
        --ink-muted:#b8d3c1;
        --card:#0b1410;
        --bg:#041a0c;
        --shadow:0 10px 30px rgba(0,0,0,.4);
      }
    }

    /* ==== Base Reset ==== */
    *,*::before,*::after{ box-sizing:border-box }
    html,body{ height:100% }
    body{
      margin:0;
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Noto Sans", "Helvetica Neue", Arial, "Apple Color Emoji","Segoe UI Emoji";
      color:var(--ink);
      background: radial-gradient(1200px 600px at 10% -10%, var(--brand-200) 0%, transparent 60%),
                  radial-gradient(900px 500px at 120% 10%, var(--brand-50) 0%, transparent 60%),
                  linear-gradient(180deg, var(--bg), var(--bg));
      min-height:100%;
      overflow-x:hidden;
    }

    /* 背景柔和流動動畫 */
    .bg-animated::before{
      content:"";
      position:fixed;
      inset:-20vmax;
      background:
         radial-gradient(40vmax 30vmax at 20% 10%, color-mix(in srgb, var(--brand-400) 25%, transparent) 0%, transparent 70%),
         radial-gradient(35vmax 25vmax at 80% -10%, color-mix(in srgb, var(--brand-500) 22%, transparent) 0%, transparent 70%),
         radial-gradient(30vmax 20vmax at -10% 80%, color-mix(in srgb, var(--brand-600) 15%, transparent) 0%, transparent 70%);
      filter: blur(40px) opacity(.6);
      animation: floaty 24s linear infinite alternate;
      z-index:-1;
      pointer-events:none;
    }
    @keyframes floaty{
      0%{ transform: translateY(-2%) scale(1) rotate(0deg); }
      50%{ transform: translateY(2%) scale(1.03) rotate(1deg); }
      100%{ transform: translateY(-1%) scale(1.01) rotate(-1deg); }
    }

    /* ==== Header/Nav ==== */
    header{
      position:sticky; top:0; z-index:50;
      backdrop-filter: var(--blur);
      -webkit-backdrop-filter: var(--blur);
      background: color-mix(in srgb, var(--brand-50) 60%, transparent);
      border-bottom: 1px solid color-mix(in srgb, var(--brand-500) 15%, transparent);
    }
    .nav-wrap{
      max-width:1100px; margin:0 auto; padding:10px 16px;
      display:flex; align-items:center; gap:14px;
    }
    .brand{
      display:flex; align-items:center; gap:10px; text-decoration:none; color:inherit;
    }
    .brand img{
      width:40px; height:40px; border-radius:10px; object-fit:cover;
      box-shadow:0 6px 14px color-mix(in srgb, var(--brand-600) 25%, transparent);
      transform: translateZ(0); /* 開啟硬體加速避免抖動 */
    }
    .brand .title{
      font-weight:800; letter-spacing:.2px;
      background: linear-gradient(90deg, var(--brand-700), var(--brand-500));
      -webkit-background-clip:text; background-clip:text; color:transparent;
    }

    nav{
      margin-left:auto;
      display:flex; align-items:center; gap:8px;
    }
    .links{
      display:flex; gap:4px; align-items:center;
    }
    .links a{
      --pad:10px;
      color:var(--ink); text-decoration:none; font-weight:600;
      padding:8px var(--pad); border-radius:999px;
      position:relative; transition:.25s ease;
      outline-offset:4px;
    }
    .links a:hover{
      color:#fff; background:var(--brand-600);
      box-shadow:0 10px 16px color-mix(in srgb, var(--brand-600) 28%, transparent);
      transform: translateY(-1px);
    }
    .links a[aria-current="page"]{
      color:#fff; background: var(--brand-600);
    }

    /* 語言下拉 */
    .lang{
      position:relative;
    }
    .lang-btn{
      display:flex; align-items:center; gap:8px;
      background: linear-gradient(180deg, var(--brand-500), var(--brand-600));
      color:#fff; border:none; padding:10px 14px; border-radius:999px;
      font-weight:700; cursor:pointer; box-shadow: var(--shadow);
      transition: transform .18s ease, filter .18s ease;
    }
    .lang-btn:hover{ transform: translateY(-1px) }
    .lang-list{
      position:absolute; right:0; top:calc(100% + 8px);
      background: var(--card);
      border:1px solid color-mix(in srgb, var(--brand-600) 18%, transparent);
      border-radius:14px; box-shadow: var(--shadow);
      overflow:hidden; min-width:220px; display:none;
    }
    .lang.open .lang-list{ display:block }
    .lang-list button{
      display:flex; width:100%; text-align:left; gap:8px; align-items:center;
      padding:10px 14px; background:transparent; border:0; cursor:pointer; color:var(--ink);
    }
    .lang-list button:hover{ background: color-mix(in srgb, var(--brand-200) 30%, transparent) }

    /* 漢堡按鈕 (手機) */
    .burger{
      display:none; margin-left: auto;
      width:44px; height:44px; border-radius:10px; border:1px solid color-mix(in srgb, var(--brand-600) 20%, transparent);
      background: var(--card); box-shadow: var(--shadow); cursor:pointer;
      align-items:center; justify-content:center;
    }
    .burger span,.burger::before,.burger::after{
      content:""; display:block; width:22px; height:2px; background:var(--ink); border-radius:2px; transition:.2s ease;
    }
    .burger::before{ transform: translateY(-6px) }
    .burger::after{ transform: translateY(6px) }
    .burger[aria-expanded="true"] span{ opacity:0 }
    .burger[aria-expanded="true"]::before{ transform: rotate(45deg) }
    .burger[aria-expanded="true"]::after{ transform: rotate(-45deg) }

    /* 手機導覽彈出 */
    .mobile-panel{
      display:none; position:fixed; inset:64px 12px auto 12px; z-index:40;
      background: var(--card); border-radius:16px; box-shadow: var(--shadow);
      border:1px solid color-mix(in srgb, var(--brand-600) 20%, transparent);
      padding:10px;
    }
    .mobile-panel a{
      display:block; padding:12px 14px; border-radius:12px; text-decoration:none; color:var(--ink); font-weight:700;
    }
    .mobile-panel a:hover{ background: color-mix(in srgb, var(--brand-200) 30%, transparent) }
    .mobile-panel .lang{ width:100% }

    /* Breakpoints */
    @media (max-width: 900px){
      nav .links{ display:none }
      nav .lang{ display:none }
      .burger{ display:flex }
      .mobile-panel.show{ display:block }
    }

    /* ==== Main / Sections ==== */
    main{ max-width:1100px; margin: 24px auto; padding: 0 16px 40px }
    .hero{
      display:grid; grid-template-columns: 1.1fr .9fr; gap:20px; align-items:center;
      padding: clamp(16px, 4vw, 28px);
      background: color-mix(in srgb, var(--brand-50) 70%, transparent);
      border:1px solid color-mix(in srgb, var(--brand-600) 15%, transparent);
      border-radius: calc(var(--radius) + 8px); box-shadow: var(--shadow);
      overflow:hidden; position:relative;
    }
    @media (max-width: 900px){
      .hero{ grid-template-columns:1fr }
    }
    .hero h1{
      margin:8px 0 6px; font-size: clamp(24px, 3.2vw, 36px); line-height:1.12;
      background: linear-gradient(90deg, var(--brand-700), var(--brand-500));
      -webkit-background-clip:text; background-clip:text; color:transparent;
      letter-spacing:.3px;
    }
    .hero p{ color:var(--ink-muted); margin:0 0 10px; font-size: clamp(14px, 1.6vw, 16px) }
    .hero .cta{
      display:flex; gap:10px; flex-wrap:wrap; margin-top:8px
    }
    .btn{
      display:inline-flex; align-items:center; gap:8px;
      padding:12px 16px; border-radius:12px; border:1px solid color-mix(in srgb, var(--brand-600) 18%, transparent);
      background: #fff; color:var(--ink); font-weight:800; text-decoration:none; transition:.22s ease;
      box-shadow: var(--shadow);
    }
    .btn:hover{ transform: translateY(-2px); background: var(--brand-200) }

    .illus{
      height:100%; min-height:180px; border-radius:14px;
      background:
       radial-gradient(120px 120px at 20% 30%, color-mix(in srgb, var(--brand-500) 40%, transparent) 0, transparent 70%),
       radial-gradient(140px 100px at 80% 40%, color-mix(in srgb, var(--brand-400) 36%, transparent) 0, transparent 70%),
       radial-gradient(200px 160px at 50% 80%, color-mix(in srgb, var(--brand-600) 24%, transparent) 0, transparent 70%);
      filter: blur(0.3px) saturate(120%); position:relative;
      animation: floaty 18s ease-in-out infinite alternate;
      border:1px dashed color-mix(in srgb, var(--brand-600) 26%, transparent);
    }

    .section{
      margin-top:22px; padding: clamp(14px, 3vw, 22px);
      background: var(--card); border-radius: var(--radius);
      border:1px solid color-mix(in srgb, var(--brand-600) 16%, transparent);
      box-shadow: var(--shadow);
      opacity:0; transform: translateY(8px) scale(.99);
      transition: opacity .5s ease, transform .5s ease;
    }
    .section.in-view{ opacity:1; transform: translateY(0) scale(1) }
    .section h2{
      margin-top:0; margin-bottom:8px;
      font-size: clamp(20px, 2.6vw, 28px);
    }
    .muted{ color:var(--ink-muted) }

    /* ==== Footer ==== */
    footer{
      margin-top: 32px;
      background: linear-gradient(180deg, var(--brand-600), var(--brand-700));
      color:#eafff1;
      border-top: 1px solid color-mix(in srgb, #000 10%, transparent);
    }
    .footer-wrap{ max-width:1100px; margin:0 auto; padding:18px 16px; text-align:center; font-weight:700 }

    /* 無動畫偏好尊重 */
    @media (prefers-reduced-motion: reduce){
      *{ animation:none !important; transition:none !important }
    }
  </style>
</head>
<body class="bg-animated">
  <!-- ===== Header / Navigation ===== -->
  <header>
    <div class="nav-wrap" role="navigation" aria-label="Primary">
      <a class="brand" href="#menu" data-route="menu">
        <img src="logo.jpg" alt="ElytraSky Logo" />
        <span class="title">ElytraSky</span>
      </a>

      <button class="burger" aria-label="Open menu" aria-expanded="false" aria-controls="mobilePanel">
        <span></span>
      </button>

      <nav>
        <div class="links" id="desktopLinks">
          <a href="#menu" data-route="menu" data-i18n="nav.menu" aria-current="page">Menu</a>
          <a href="#about" data-route="about" data-i18n="nav.about">About Us</a>
          <a href="#join" data-route="join" data-i18n="nav.join">Join</a>
          <a href="#support" data-route="support" data-i18n="nav.support">Support</a>
        </div>

        <div class="lang" id="langDesktop">
          <button class="lang-btn" aria-haspopup="true" aria-expanded="false" aria-controls="langListDesktop">
            <span data-i18n="nav.language">Language</span>
          </button>
          <div class="lang-list" id="langListDesktop" role="menu">
            <button type="button" data-lang="en">English</button>
            <button type="button" data-lang="zh-Hant">繁體中文</button>
            <button type="button" data-lang="zh-Hans">简体中文</button>
            <button type="button" data-lang="ja">日本語</button>
          </div>
        </div>
      </nav>
    </div>

    <!-- Mobile flyout -->
    <div id="mobilePanel" class="mobile-panel" aria-hidden="true">
      <a href="#menu" data-route="menu" data-i18n="nav.menu">Menu</a>
      <a href="#about" data-route="about" data-i18n="nav.about">About Us</a>
      <a href="#join" data-route="join" data-i18n="nav.join">Join</a>
      <a href="#support" data-route="support" data-i18n="nav.support">Support</a>
      <div class="lang" id="langMobile" style="margin-top:6px">
        <button class="lang-btn" aria-haspopup="true" aria-expanded="false" aria-controls="langListMobile">
          <span data-i18n="nav.language">Language</span>
        </button>
        <div class="lang-list" id="langListMobile" role="menu">
          <button type="button" data-lang="en">English</button>
          <button type="button" data-lang="zh-Hant">繁體中文</button>
          <button type="button" data-lang="zh-Hans">简体中文</button>
          <button type="button" data-lang="ja">日本語</button>
        </div>
      </div>
    </div>
  </header>

  <!-- ===== Main ===== -->
  <main>
    <!-- Hero -->
    <section class="hero section in-view">
      <div>
        <h1 data-i18n="hero.title">Welcome to ElytraSky</h1>
        <p class="muted" data-i18n="hero.subtitle">
          A clean, mobile-first template with a green base and smooth animations. Replace this text with your own content.
        </p>
        <div class="cta">
          <a href="#join" data-route="join" class="btn" data-i18n="hero.ctaJoin">Get Started</a>
          <a href="#support" data-route="support" class="btn" data-i18n="hero.ctaSupport">Support</a>
        </div>
      </div>
      <div class="illus" aria-hidden="true"></div>
    </section>

    <!-- Content Sections (每頁請把 placeholder 換成你的內容) -->
    <section class="section route" data-route="menu" id="section-menu">
      <h2 data-i18n="sections.menu.title">Menu</h2>
      <p class="muted" data-i18n="sections.menu.desc">
        Put your unique “Menu” page content here. You can add any HTML/components you like.
      </p>
      <!-- Your Menu content goes here -->
    </section>

    <section class="section route" data-route="about" id="section-about" hidden>
      <h2 data-i18n="sections.about.title">About Us</h2>
      <p class="muted" data-i18n="sections.about.desc">
        Introduce ElytraSky here. Replace this placeholder with real text, images, or cards.
      </p>
      <!-- Your About content goes here -->
    </section>

    <section class="section route" data-route="join" id="section-join" hidden>
      <h2 data-i18n="sections.join.title">Join</h2>
      <p class="muted" data-i18n="sections.join.desc">
        Explain how to join. Forms, links, or steps can be placed here.
      </p>
      <!-- Your Join content goes here -->
    </section>

    <section class="section route" data-route="support" id="section-support" hidden>
      <h2 data-i18n="sections.support.title">Support</h2>
      <p class="muted" data-i18n="sections.support.desc">
        Provide support channels, FAQs, or contact info here.
      </p>
      <!-- Your Support content goes here -->
    </section>
  </main>

  <!-- ===== Footer ===== -->
  <footer>
    <div class="footer-wrap">
      Copyright 2022-2025 ElytraSky. All rights reserved
    </div>
  </footer>

  <script>
    // ===== Simple SPA Router + i18n + UI Interactions =====

    // Translations
    const dict = {
      "en": {
        "nav.menu":"Menu",
        "nav.about":"About Us",
        "nav.join":"Join",
        "nav.support":"Support",
        "nav.language":"Language",
        "hero.title":"Welcome to ElytraSky",
        "hero.subtitle":"A clean, mobile-first template with a green base and smooth animations. Replace this text with your own content.",
        "hero.ctaJoin":"Get Started",
        "hero.ctaSupport":"Support",
        "sections.menu.title":"Menu",
        "sections.menu.desc":"Put your unique “Menu” page content here. You can add any HTML/components you like.",
        "sections.about.title":"About Us",
        "sections.about.desc":"Introduce ElytraSky here. Replace this placeholder with real text, images, or cards.",
        "sections.join.title":"Join",
        "sections.join.desc":"Explain how to join. Forms, links, or steps can be placed here.",
        "sections.support.title":"Support",
        "sections.support.desc":"Provide support channels, FAQs, or contact info here."
      },
      "zh-Hant": {
        "nav.menu":"Menu",
        "nav.about":"About Us",
        "nav.join":"Join",
        "nav.support":"Support",
        "nav.language":"語言",
        "hero.title":"歡迎來到 ElytraSky",
        "hero.subtitle":"行動優先、綠色基調、順暢動畫的範本。把這段字替換成你的內容即可。",
        "hero.ctaJoin":"開始使用",
        "hero.ctaSupport":"支援",
        "sections.menu.title":"Menu",
        "sections.menu.desc":"在此放入你的「Menu」頁內容，任何 HTML 或元件都可以。",
        "sections.about.title":"關於我們",
        "sections.about.desc":"在這裡介紹 ElytraSky，將此處替換為真實文字、圖片或卡片。",
        "sections.join.title":"加入我們",
        "sections.join.desc":"說明如何加入，可放表單、連結或步驟。",
        "sections.support.title":"支援",
        "sections.support.desc":"提供支援管道、常見問題或聯絡方式。"
      },
      "zh-Hans": {
        "nav.menu":"Menu",
        "nav.about":"About Us",
        "nav.join":"Join",
        "nav.support":"Support",
        "nav.language":"语言",
        "hero.title":"欢迎来到 ElytraSky",
        "hero.subtitle":"移动优先、绿色基调、流畅动画的模板。把这段文字替换成你的内容。",
        "hero.ctaJoin":"开始使用",
        "hero.ctaSupport":"支持",
        "sections.menu.title":"Menu",
        "sections.menu.desc":"在此放入你的「Menu」页内容，支持任意 HTML 或组件。",
        "sections.about.title":"关于我们",
        "sections.about.desc":"在这里介绍 ElytraSky，替换为真实文字、图片或卡片。",
        "sections.join.title":"加入我们",
        "sections.join.desc":"说明如何加入，可放表单、链接或步骤。",
        "sections.support.title":"支持",
        "sections.support.desc":"提供支持渠道、常见问题或联系方式。"
      },
      "ja": {
        "nav.menu":"メニュー",
        "nav.about":"私たちについて",
        "nav.join":"参加",
        "nav.support":"サポート",
        "nav.language":"言語",
        "hero.title":"ElytraSky へようこそ",
        "hero.subtitle":"グリーン基調で滑らかなアニメのモバイルファースト・テンプレート。ここをあなたの文章に差し替えてください。",
        "hero.ctaJoin":"はじめる",
        "hero.ctaSupport":"サポート",
        "sections.menu.title":"メニュー",
        "sections.menu.desc":"ここに「メニュー」ページの独自コンテンツを配置してください。",
        "sections.about.title":"私たちについて",
        "sections.about.desc":"ElytraSky を紹介するセクション。文章や画像などに置き換えてください。",
        "sections.join.title":"参加",
        "sections.join.desc":"参加方法を説明。フォームやリンク、手順を配置できます。",
        "sections.support.title":"サポート",
        "sections.support.desc":"サポート窓口、FAQ、連絡先などを掲載。"
      }
    };

    // ===== Utilities =====
    const $ = (sel, root=document) => root.querySelector(sel);
    const $$ = (sel, root=document) => Array.from(root.querySelectorAll(sel));

    // Update active route (hash-based)
    function setRoute(route){
      // sections
      $$('.route').forEach(sec => {
        const show = sec.dataset.route === route;
        sec.hidden = !show;
      });
      // nav active + aria-current
      $$('a[data-route]').forEach(a=>{
        const isActive = a.dataset.route === route;
        a.setAttribute('aria-current', isActive ? 'page' : 'false');
      });
      // keep hash tidy
      if(location.hash.replace('#','') !== route){
        history.replaceState(null, "", `#${route}`);
      }
    }

    // Language switcher
    function setLanguage(lang){
      const pack = dict[lang] || dict['zh-Hant'];
      document.documentElement.lang = lang;
      $$('[data-i18n]').forEach(el=>{
        const key = el.getAttribute('data-i18n');
        if(pack[key]) el.textContent = pack[key];
      });
      localStorage.setItem('elytra.lang', lang);
    }

    // IntersectionObserver for section reveal
    const io = new IntersectionObserver((entries)=>{
      for(const e of entries){
        if(e.isIntersecting) e.target.classList.add('in-view');
      }
    }, { threshold:.1 });

    // ===== Init =====
    (function init(){
      // reveal effects
      $$('.section').forEach(sec=> io.observe(sec));

      // nav click (both desktop + hero buttons)
      document.addEventListener('click', (e)=>{
        const routeLink = e.target.closest('[data-route]');
        if(routeLink){
          const route = routeLink.getAttribute('data-route');
          setRoute(route);
          // close mobile panel if open
          toggleMobile(false);
        }
      });

      // language dropdowns
      setupLangDropdown($('#langDesktop'));
      setupLangDropdown($('#langMobile'));

      // burger / mobile panel
      const burger = $('.burger');
  
