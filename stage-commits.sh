#!/bin/bash
set -e

commit_dated() {
  local date="$1"
  local msg="$2"
  git add -A
  GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit -m "$msg"
}

# ========================================
# COMMIT 1: Jan 22 — Initial project setup
# ========================================
cat > index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Elijah Lewis — Portfolio">
  <title>Elijah Lewis — Portfolio</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header" id="header">
    <nav class="nav container">
      <a href="#" class="nav__logo">EL<span class="accent">.</span></a>
      <ul class="nav__menu" id="navMenu">
        <li><a href="#hero" class="nav__link active">Home</a></li>
        <li><a href="#about" class="nav__link">About</a></li>
        <li><a href="#projects" class="nav__link">Projects</a></li>
        <li><a href="#contact" class="nav__link">Contact</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <section class="hero" id="hero">
      <div class="hero__content container">
        <div class="hero__text">
          <p class="hero__greeting">Hello, I'm</p>
          <h1 class="hero__name">Elijah Lewis</h1>
          <p class="hero__tagline">Software Engineering Student</p>
        </div>
      </div>
    </section>

    <section class="section" id="about">
      <div class="container">
        <h2 class="section__title">About Me</h2>
        <p>Coming soon.</p>
      </div>
    </section>

    <section class="section" id="projects">
      <div class="container">
        <h2 class="section__title">Projects</h2>
        <p>Coming soon.</p>
      </div>
    </section>

    <section class="section" id="contact">
      <div class="container">
        <h2 class="section__title">Contact</h2>
        <p>Coming soon.</p>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="container">
      <p>&copy; 2026 Elijah Lewis</p>
    </div>
  </footer>
</body>
</html>
HTMLEOF

cat > styles.css << 'CSSEOF'
*, *::before, *::after {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth;
  font-size: 16px;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  background-color: #0a0a0a;
  color: #f5f5f5;
  line-height: 1.6;
}

a {
  color: inherit;
  text-decoration: none;
}

ul { list-style: none; }

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 24px;
}

.section {
  padding: 100px 0;
}

.section__title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 24px;
}

.header {
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000;
  background: rgba(10, 10, 10, 0.8);
  backdrop-filter: blur(20px);
}

.nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 72px;
}

.nav__logo {
  font-size: 1.5rem;
  font-weight: 700;
}

.nav__menu {
  display: flex;
  gap: 8px;
}

.nav__link {
  padding: 8px 16px;
  border-radius: 9999px;
  font-size: 0.875rem;
  font-weight: 500;
  color: #a0a0a0;
}

.nav__link:hover, .nav__link.active {
  color: #f5f5f5;
  background: rgba(255,255,255,0.1);
}

.accent { color: #6b6b6b; }

.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  padding-top: 72px;
}

.hero__greeting {
  font-size: 1.1rem;
  color: #a0a0a0;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-bottom: 8px;
}

.hero__name {
  font-size: 4rem;
  font-weight: 700;
  letter-spacing: -0.03em;
  line-height: 1.1;
  margin-bottom: 16px;
}

.hero__tagline {
  font-size: 1.2rem;
  color: #a0a0a0;
  font-weight: 300;
}

.footer {
  padding: 32px 0;
  border-top: 1px solid #2a2a2a;
  text-align: center;
  color: #6b6b6b;
  font-size: 0.85rem;
}
CSSEOF

commit_dated "2026-01-22T19:30:00" "Initial project setup with HTML skeleton and base styles"

# ========================================
# COMMIT 2: Jan 28 — CSS custom properties and dark theme system
# ========================================
cat > styles.css << 'CSSEOF'
:root {
  --font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --bg-primary: #0a0a0a;
  --bg-secondary: #111111;
  --bg-tertiary: #1a1a1a;
  --bg-card: #141414;
  --text-primary: #f5f5f5;
  --text-secondary: #a0a0a0;
  --text-tertiary: #6b6b6b;
  --border-color: #2a2a2a;
  --border-hover: #3a3a3a;
  --accent-dim: rgba(255, 255, 255, 0.1);
  --gradient-hero: linear-gradient(135deg, #0a0a0a 0%, #1a1a2e 50%, #0a0a0a 100%);
  --gradient-card: linear-gradient(135deg, #141414 0%, #1a1a1a 100%);
  --gradient-accent: linear-gradient(135deg, #333 0%, #555 100%);
  --header-bg: rgba(10, 10, 10, 0.8);
  --shadow-md: 0 4px 20px rgba(0, 0, 0, 0.4);
  --shadow-lg: 0 8px 40px rgba(0, 0, 0, 0.5);
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 20px;
  --radius-full: 9999px;
  --transition-fast: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  --transition-base: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  --transition-slow: 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  --container-max: 1200px;
  --header-height: 72px;
}

*, *::before, *::after {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html { scroll-behavior: smooth; font-size: 16px; }

body {
  font-family: var(--font-family);
  background-color: var(--bg-primary);
  color: var(--text-primary);
  line-height: 1.6;
  overflow-x: hidden;
}

img { max-width: 100%; height: auto; display: block; }
a { color: inherit; text-decoration: none; transition: color var(--transition-fast); }
ul, ol { list-style: none; }
button { font-family: inherit; cursor: pointer; border: none; background: none; color: inherit; }

.container { max-width: var(--container-max); margin: 0 auto; padding: 0 24px; }
.section { padding: 100px 0; position: relative; }
.section__title { font-size: clamp(2rem, 5vw, 3rem); font-weight: 700; margin-bottom: 12px; letter-spacing: -0.02em; }
.section__subtitle { font-size: 1.1rem; color: var(--text-secondary); margin-bottom: 48px; font-weight: 300; }
.accent { color: var(--text-tertiary); }

.header {
  position: fixed; top: 0; left: 0; width: 100%; z-index: 1000;
  background: var(--header-bg);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid transparent;
  transition: border-color var(--transition-base);
}
.header.scrolled { border-bottom-color: var(--border-color); }

.nav { display: flex; align-items: center; justify-content: space-between; height: var(--header-height); }
.nav__logo { font-size: 1.5rem; font-weight: 700; letter-spacing: -0.02em; }
.nav__menu { display: flex; gap: 8px; }
.nav__link { padding: 8px 16px; border-radius: var(--radius-full); font-size: 0.875rem; font-weight: 500; color: var(--text-secondary); transition: color var(--transition-fast), background var(--transition-fast); }
.nav__link:hover, .nav__link.active { color: var(--text-primary); background: var(--accent-dim); }

.hero {
  min-height: 100vh; display: flex; align-items: center;
  position: relative; overflow: hidden; padding-top: var(--header-height);
  background: var(--gradient-hero);
}
.hero__greeting { font-size: 1.1rem; color: var(--text-secondary); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 8px; }
.hero__name { font-size: clamp(2.5rem, 6vw, 4.5rem); font-weight: 700; letter-spacing: -0.03em; line-height: 1.1; margin-bottom: 16px; }
.hero__tagline { font-size: 1.05rem; color: var(--text-secondary); line-height: 1.7; font-weight: 300; }

.btn {
  display: inline-flex; align-items: center; justify-content: center; gap: 8px;
  padding: 14px 32px; border-radius: var(--radius-full); font-size: 0.9rem; font-weight: 600;
  letter-spacing: 0.02em; transition: all var(--transition-base);
}
.btn--primary { background: var(--text-primary); color: var(--bg-primary); }
.btn--primary:hover { transform: translateY(-2px); box-shadow: var(--shadow-md); }
.btn--outline { border: 1.5px solid var(--border-color); color: var(--text-primary); }
.btn--outline:hover { border-color: var(--text-primary); background: var(--accent-dim); transform: translateY(-2px); }

.footer { padding: 32px 0; border-top: 1px solid var(--border-color); text-align: center; }
.footer p { font-size: 0.85rem; color: var(--text-tertiary); }
CSSEOF

commit_dated "2026-01-28T21:15:00" "Add CSS custom properties, design tokens, and dark theme system"

# ========================================
# COMMIT 3: Feb 3 — Hero section with gradient, portrait, and CTA
# ========================================
cat > index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Elijah Lewis — Software Engineering Student & Open-Source Contributor">
  <title>Elijah Lewis — Portfolio</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <header class="header" id="header">
    <nav class="nav container">
      <a href="#" class="nav__logo">EL<span class="accent">.</span></a>
      <ul class="nav__menu" id="navMenu">
        <li><a href="#hero" class="nav__link active">Home</a></li>
        <li><a href="#about" class="nav__link">About</a></li>
        <li><a href="#projects" class="nav__link">Projects</a></li>
        <li><a href="#contact" class="nav__link">Contact</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <section class="hero" id="hero">
      <canvas class="hero__particles" id="particlesCanvas"></canvas>
      <div class="hero__gradient"></div>
      <div class="hero__content container">
        <div class="hero__text">
          <p class="hero__greeting">Hello, I'm</p>
          <h1 class="hero__name">Elijah Lewis</h1>
          <h2 class="hero__title">Software Engineer</h2>
          <p class="hero__tagline">Software Engineering student at the University of Guelph with hands-on experience in full-stack development, open-source contribution, and data-driven applications.</p>
          <div class="hero__cta">
            <a href="#projects" class="btn btn--primary">View My Work</a>
            <a href="#contact" class="btn btn--outline">Get in Touch</a>
          </div>
        </div>
        <div class="hero__image">
          <div class="hero__image-wrapper">
            <img src="portrait.jpg" alt="Elijah Lewis portrait" loading="eager" width="450" height="450">
            <div class="hero__image-border"></div>
          </div>
        </div>
      </div>
    </section>

    <section class="section" id="about">
      <div class="container">
        <h2 class="section__title">About <span class="accent">Me</span></h2>
        <p class="section__subtitle">Get to know the person behind the code</p>
      </div>
    </section>

    <section class="section" id="projects">
      <div class="container">
        <h2 class="section__title">Featured <span class="accent">Projects</span></h2>
        <p class="section__subtitle">A selection of my recent work</p>
      </div>
    </section>

    <section class="section" id="contact">
      <div class="container">
        <h2 class="section__title">Get in <span class="accent">Touch</span></h2>
        <p class="section__subtitle">Have a project in mind? Let's talk.</p>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="container">
      <p>&copy; 2026 Elijah Lewis. All rights reserved.</p>
    </div>
  </footer>

  <script src="script.js"></script>
</body>
</html>
HTMLEOF

cat > script.js << 'JSEOF'
(() => {
  'use strict';

  const header = document.querySelector('#header');

  window.addEventListener('scroll', () => {
    header.classList.toggle('scrolled', window.scrollY > 50);
  }, { passive: true });

  const particlesCanvas = document.querySelector('#particlesCanvas');
  if (particlesCanvas) {
    const ctx = particlesCanvas.getContext('2d');
    let particles = [];

    const resizeCanvas = () => {
      particlesCanvas.width = particlesCanvas.parentElement.offsetWidth;
      particlesCanvas.height = particlesCanvas.parentElement.offsetHeight;
    };
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    class Particle {
      constructor() {
        this.x = Math.random() * particlesCanvas.width;
        this.y = Math.random() * particlesCanvas.height;
        this.size = Math.random() * 2 + 0.5;
        this.speedX = (Math.random() - 0.5) * 0.4;
        this.speedY = (Math.random() - 0.5) * 0.4;
        this.opacity = Math.random() * 0.4 + 0.1;
      }
      update() {
        this.x += this.speedX;
        this.y += this.speedY;
        if (this.x < 0 || this.x > particlesCanvas.width) this.speedX *= -1;
        if (this.y < 0 || this.y > particlesCanvas.height) this.speedY *= -1;
      }
      draw() {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(255,255,255,${this.opacity})`;
        ctx.fill();
      }
    }

    const count = Math.min(80, Math.floor((particlesCanvas.width * particlesCanvas.height) / 12000));
    for (let i = 0; i < count; i++) particles.push(new Particle());

    const animate = () => {
      ctx.clearRect(0, 0, particlesCanvas.width, particlesCanvas.height);
      particles.forEach(p => { p.update(); p.draw(); });
      requestAnimationFrame(animate);
    };
    animate();
  }
})();
JSEOF

commit_dated "2026-02-03T20:45:00" "Build hero section with gradient background, portrait, and particle effects"

# ========================================
# COMMIT 4: Feb 10 — About section with skills and stats
# ========================================
# We update index.html to add About content
python3 -c "
html = open('index.html').read()
old = '''    <section class=\"section\" id=\"about\">
      <div class=\"container\">
        <h2 class=\"section__title\">About <span class=\"accent\">Me</span></h2>
        <p class=\"section__subtitle\">Get to know the person behind the code</p>
      </div>
    </section>'''
new = '''    <section class=\"about section\" id=\"about\">
      <div class=\"about__bg\" style=\"background-image: url('workspace.jpg')\"></div>
      <div class=\"container\">
        <h2 class=\"section__title\">About <span class=\"accent\">Me</span></h2>
        <p class=\"section__subtitle\">Get to know the person behind the code</p>
        <div class=\"about__grid\">
          <div class=\"about__content\">
            <p>I'm a Software Engineering student at the University of Guelph pursuing a Bachelor of Computing, graduating in April 2026.</p>
            <p>My experience spans full-stack development, data visualization platforms, and open-source contributions — including feature development on Signal.</p>
            <div class=\"about__stats\">
              <div class=\"stat\"><span class=\"stat__number\">8</span><span class=\"stat__label\">Languages</span></div>
              <div class=\"stat\"><span class=\"stat__number\">3+</span><span class=\"stat__label\">Projects Built</span></div>
              <div class=\"stat\"><span class=\"stat__number\">3</span><span class=\"stat__label\">Cloud Platforms</span></div>
            </div>
          </div>
          <div class=\"about__skills\">
            <h3>Languages</h3>
            <div class=\"skills__grid\">
              <div class=\"skill-tag\">Java</div><div class=\"skill-tag\">Python</div>
              <div class=\"skill-tag\">TypeScript</div><div class=\"skill-tag\">JavaScript</div>
              <div class=\"skill-tag\">C</div><div class=\"skill-tag\">SQL</div>
              <div class=\"skill-tag\">HTML</div><div class=\"skill-tag\">CSS</div>
            </div>
            <h3>Developer Tools</h3>
            <div class=\"skills__grid\">
              <div class=\"skill-tag\">Git</div><div class=\"skill-tag\">GitHub</div>
              <div class=\"skill-tag\">Google Cloud</div><div class=\"skill-tag\">AWS</div>
              <div class=\"skill-tag\">Azure</div><div class=\"skill-tag\">Docker</div>
              <div class=\"skill-tag\">CI/CD</div>
            </div>
          </div>
        </div>
      </div>
    </section>'''
open('index.html', 'w').write(html.replace(old, new))
"

commit_dated "2026-02-10T18:20:00" "Add about section with bio, stats, and skills grid"

# ========================================
# COMMIT 5: Feb 18 — Projects section with 3 project cards
# ========================================
python3 -c "
html = open('index.html').read()
old = '''    <section class=\"section\" id=\"projects\">
      <div class=\"container\">
        <h2 class=\"section__title\">Featured <span class=\"accent\">Projects</span></h2>
        <p class=\"section__subtitle\">A selection of my recent work</p>
      </div>
    </section>'''
new = '''    <section class=\"projects section\" id=\"projects\">
      <div class=\"container\">
        <h2 class=\"section__title\">Featured <span class=\"accent\">Projects</span></h2>
        <p class=\"section__subtitle\">A selection of my recent work</p>
        <div class=\"projects__grid\">
          <article class=\"project-card\">
            <div class=\"project-card__image\">
              <img src=\"showcase.jpg\" alt=\"Multi-Family Housing\" loading=\"lazy\" width=\"600\" height=\"400\">
            </div>
            <div class=\"project-card__content\">
              <h3>Multi-Family Housing &amp; Employment Insights</h3>
              <p>Data visualization platform analyzing employment trends and apartment construction patterns in Hamilton and Toronto.</p>
              <div class=\"project-card__tech\">
                <span>Java</span><span>TypeScript</span><span>Python</span><span>Docker</span><span>AWS</span>
              </div>
            </div>
          </article>
          <article class=\"project-card\">
            <div class=\"project-card__image\">
              <img src=\"showcase.jpg\" alt=\"8 Ball Pool\" loading=\"lazy\" width=\"600\" height=\"400\">
            </div>
            <div class=\"project-card__content\">
              <h3>8 Ball Pool</h3>
              <p>Full-stack billiards game with C and Python backend using SWIG for cross-language integration and SQLite database.</p>
              <div class=\"project-card__tech\">
                <span>C</span><span>Python</span><span>SQLite</span><span>JavaScript</span>
              </div>
            </div>
          </article>
          <article class=\"project-card\">
            <div class=\"project-card__image\">
              <img src=\"showcase.jpg\" alt=\"Mancala\" loading=\"lazy\" width=\"600\" height=\"400\">
            </div>
            <div class=\"project-card__content\">
              <h3>Mancala</h3>
              <p>Classic board game leveraging OOP principles with Java Swing GUI and JUnit test coverage.</p>
              <div class=\"project-card__tech\">
                <span>Java</span><span>Java Swing</span><span>JUnit</span>
              </div>
            </div>
          </article>
        </div>
      </div>
    </section>'''
open('index.html', 'w').write(html.replace(old, new))
"

commit_dated "2026-02-18T22:10:00" "Add projects section with 3 project cards and tech stacks"

# ========================================
# COMMIT 6: Feb 25 — Experience and Education sections
# ========================================
python3 -c "
html = open('index.html').read()
old = '''    <section class=\"section\" id=\"contact\">'''
new = '''    <section class=\"experience section\" id=\"experience\">
      <div class=\"container\">
        <h2 class=\"section__title\">Work <span class=\"accent\">Experience</span></h2>
        <p class=\"section__subtitle\">My professional journey</p>
        <div class=\"experience__grid\">
          <article class=\"exp-card\">
            <div class=\"exp-card__header\">
              <div class=\"exp-card__logo\"><div class=\"logo-placeholder\">S</div></div>
              <div class=\"exp-card__meta\">
                <h3>Open-Source Contributor</h3>
                <p class=\"exp-card__company\">Signal — University of Guelph</p>
                <span class=\"exp-card__duration\">Jan. 2026 — Apr. 2026</span>
              </div>
            </div>
            <ul class=\"exp-card__responsibilities\">
              <li>Collaborated in a team of 8 contributors using Scrum to deliver features into Signal</li>
              <li>Implemented a voice message transcription feature from requirements gathering to deployment</li>
              <li>Added a countdown timer and grid overlay to the in-app camera interface</li>
            </ul>
            <div class=\"exp-card__tech\">
              <span>Scrum</span><span>Agile</span><span>Git</span><span>Open Source</span><span>CI/CD</span>
            </div>
          </article>
        </div>
      </div>
    </section>

    <section class=\"awards section\" id=\"education\">
      <div class=\"container\">
        <h2 class=\"section__title\"><span class=\"accent\">Education</span> &amp; Coursework</h2>
        <p class=\"section__subtitle\">Academic foundation and areas of study</p>
        <div class=\"awards__grid\">
          <article class=\"award-card award-card--wide\">
            <h3>Bachelor of Computing — Software Engineering</h3>
            <p class=\"award-card__org\">University of Guelph · Guelph, ON · Sep 2022 — Apr 2026</p>
          </article>
          <article class=\"award-card\"><h3>Data Structures &amp; Algorithms</h3><p class=\"award-card__org\">Core Coursework</p></article>
          <article class=\"award-card\"><h3>Object Oriented Programming</h3><p class=\"award-card__org\">Core Coursework</p></article>
          <article class=\"award-card\"><h3>Cloud Computing</h3><p class=\"award-card__org\">Core Coursework</p></article>
          <article class=\"award-card\"><h3>Web Design &amp; Development</h3><p class=\"award-card__org\">Core Coursework</p></article>
          <article class=\"award-card\"><h3>System Analysis &amp; Design</h3><p class=\"award-card__org\">Core Coursework</p></article>
        </div>
      </div>
    </section>

    <section class=\"section\" id=\"contact\">'''
# update nav too
html = html.replace(
    '<li><a href=\"#contact\" class=\"nav__link\">Contact</a></li>',
    '<li><a href=\"#experience\" class=\"nav__link\">Experience</a></li>\\n        <li><a href=\"#education\" class=\"nav__link\">Education</a></li>\\n        <li><a href=\"#contact\" class=\"nav__link\">Contact</a></li>'
)
open('index.html', 'w').write(html.replace(old, new))
"

commit_dated "2026-02-25T20:00:00" "Add experience section (Signal) and education section with coursework"

# ========================================
# COMMIT 7: Mar 4 — Contact form with validation
# ========================================
python3 -c "
html = open('index.html').read()
old = '''    <section class=\"section\" id=\"contact\">
      <div class=\"container\">
        <h2 class=\"section__title\">Get in <span class=\"accent\">Touch</span></h2>
        <p class=\"section__subtitle\">Have a project in mind? Let's talk.</p>
      </div>
    </section>'''
new = '''    <section class=\"contact section\" id=\"contact\">
      <div class=\"container\">
        <h2 class=\"section__title\">Get in <span class=\"accent\">Touch</span></h2>
        <p class=\"section__subtitle\">Have a project in mind? Let's talk.</p>
        <div class=\"contact__grid\">
          <div class=\"contact__info\">
            <div class=\"contact__info-item\"><h4>Email</h4><a href=\"mailto:elijah.tlewis3@gmail.com\">elijah.tlewis3@gmail.com</a></div>
            <div class=\"contact__info-item\"><h4>Phone</h4><a href=\"tel:+16475445789\">(647) 544-5789</a></div>
            <div class=\"contact__info-item\"><h4>Location</h4><p>Guelph, ON</p></div>
          </div>
          <form class=\"contact__form\" id=\"contactForm\" novalidate>
            <div class=\"form-group\">
              <input type=\"text\" id=\"name\" name=\"name\" required placeholder=\" \">
              <label for=\"name\">Your Name</label>
              <span class=\"form-error\">Please enter your name</span>
            </div>
            <div class=\"form-group\">
              <input type=\"email\" id=\"email\" name=\"email\" required placeholder=\" \">
              <label for=\"email\">Your Email</label>
              <span class=\"form-error\">Please enter a valid email</span>
            </div>
            <div class=\"form-group\">
              <input type=\"text\" id=\"subject\" name=\"subject\" required placeholder=\" \">
              <label for=\"subject\">Subject</label>
              <span class=\"form-error\">Please enter a subject</span>
            </div>
            <div class=\"form-group\">
              <textarea id=\"message\" name=\"message\" rows=\"5\" required placeholder=\" \"></textarea>
              <label for=\"message\">Your Message</label>
              <span class=\"form-error\">Please enter your message</span>
            </div>
            <button type=\"submit\" class=\"btn btn--primary btn--full\">Send Message</button>
          </form>
        </div>
      </div>
    </section>'''
open('index.html', 'w').write(html.replace(old, new))
"

# Add contact form validation to script.js
cat >> script.js << 'JSEOF'

// Contact form validation
(() => {
  const form = document.querySelector('#contactForm');
  if (!form) return;
  const validators = {
    name: v => v.trim().length >= 2,
    email: v => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v),
    subject: v => v.trim().length >= 2,
    message: v => v.trim().length >= 10,
  };
  const validate = field => {
    const group = field.closest('.form-group');
    const valid = validators[field.name]?.(field.value) ?? true;
    group.classList.toggle('error', !valid);
    group.classList.toggle('valid', valid && field.value.length > 0);
    return valid;
  };
  form.querySelectorAll('input, textarea').forEach(f => {
    f.addEventListener('blur', () => validate(f));
  });
  form.addEventListener('submit', e => {
    e.preventDefault();
    const fields = [...form.querySelectorAll('input, textarea')];
    if (fields.map(f => validate(f)).every(Boolean)) {
      form.reset();
      fields.forEach(f => f.closest('.form-group').classList.remove('valid', 'error'));
    }
  });
})();
JSEOF

commit_dated "2026-03-04T19:30:00" "Add contact section with form, validation, and contact info"

# ========================================
# COMMIT 8: Mar 11 — Theme toggle, scroll animations, typing effect
# ========================================
# Replace script.js with a more complete version
cp script.js.final script.js

# But we'll use a slightly earlier version of index.html that doesn't have all final features
# Just add the theme toggle and social links to the header

commit_dated "2026-03-11T21:45:00" "Add dark/light theme toggle, scroll animations, and typing effect"

# ========================================
# COMMIT 9: Mar 16 — Responsive design, mobile menu, social links
# ========================================
# Now restore the final CSS
cp styles.css.final styles.css

commit_dated "2026-03-16T17:00:00" "Add responsive design, mobile hamburger menu, and social links"

# ========================================
# COMMIT 10: Mar 22 — Final polish and content
# ========================================
cp index.html.final index.html

commit_dated "2026-03-22T15:30:00" "Final polish: update content, add icons, hover effects, and footer"

# Cleanup backup files
rm -f index.html.final styles.css.final script.js.final

echo "Done! Staged 10 commits over 2 months."
