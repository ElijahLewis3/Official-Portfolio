(() => {
  'use strict';

  /* ============================================
     DOM References
     ============================================ */
  const $ = (sel, ctx = document) => ctx.querySelector(sel);
  const $$ = (sel, ctx = document) => [...ctx.querySelectorAll(sel)];

  const header = $('#header');
  const hamburger = $('#hamburger');
  const navMenu = $('#navMenu');
  const themeToggle = $('#themeToggle');
  const scrollProgress = $('#scrollProgress');
  const particlesCanvas = $('#particlesCanvas');
  const contactForm = $('#contactForm');
  const typingText = $('#typingText');

  /* ============================================
     Theme Toggle
     ============================================ */
  const savedTheme = localStorage.getItem('theme') || 'dark';
  document.documentElement.setAttribute('data-theme', savedTheme);

  themeToggle.addEventListener('click', () => {
    const current = document.documentElement.getAttribute('data-theme');
    const next = current === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem('theme', next);
  });

  /* ============================================
     Mobile Menu
     ============================================ */
  hamburger.addEventListener('click', () => {
    const isOpen = navMenu.classList.toggle('open');
    hamburger.classList.toggle('active');
    hamburger.setAttribute('aria-expanded', isOpen);
    document.body.style.overflow = isOpen ? 'hidden' : '';
  });

  $$('.nav__link').forEach(link => {
    link.addEventListener('click', () => {
      navMenu.classList.remove('open');
      hamburger.classList.remove('active');
      hamburger.setAttribute('aria-expanded', 'false');
      document.body.style.overflow = '';
    });
  });

  /* ============================================
     Header Scroll Effect
     ============================================ */
  let lastScroll = 0;
  const onScroll = () => {
    const scrollY = window.scrollY;
    header.classList.toggle('scrolled', scrollY > 50);

    const docHeight = document.documentElement.scrollHeight - window.innerHeight;
    const progress = docHeight > 0 ? (scrollY / docHeight) * 100 : 0;
    scrollProgress.style.width = `${progress}%`;

    lastScroll = scrollY;
  };

  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  /* ============================================
     Active Nav Link on Scroll
     ============================================ */
  const sections = $$('section[id]');
  const navLinks = $$('.nav__link[data-section]');

  const activateNavLink = () => {
    const scrollY = window.scrollY + window.innerHeight / 3;

    for (let i = sections.length - 1; i >= 0; i--) {
      const section = sections[i];
      if (scrollY >= section.offsetTop) {
        navLinks.forEach(l => l.classList.remove('active'));
        const active = $(`.nav__link[data-section="${section.id}"]`);
        if (active) active.classList.add('active');
        break;
      }
    }
  };

  window.addEventListener('scroll', activateNavLink, { passive: true });

  /* ============================================
     Intersection Observer — Reveal Animations
     ============================================ */
  const revealObserver = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          revealObserver.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1, rootMargin: '0px 0px -40px 0px' }
  );

  $$('.reveal').forEach(el => revealObserver.observe(el));

  /* ============================================
     Counter Animation
     ============================================ */
  const counterObserver = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        const el = entry.target;
        const target = parseInt(el.dataset.target, 10);
        const duration = 2000;
        const startTime = performance.now();

        const animate = now => {
          const elapsed = now - startTime;
          const progress = Math.min(elapsed / duration, 1);
          const eased = 1 - Math.pow(1 - progress, 3);
          el.textContent = Math.round(target * eased);
          if (progress < 1) requestAnimationFrame(animate);
        };

        requestAnimationFrame(animate);
        counterObserver.unobserve(el);
      });
    },
    { threshold: 0.5 }
  );

  $$('[data-target]').forEach(el => counterObserver.observe(el));

  /* ============================================
     Typing Effect
     ============================================ */
  const titles = [
    'Software Engineer',
    'Full Stack Developer',
    'Open Source Contributor',
    'B.Comp Software Engineering'
  ];

  let titleIndex = 0;
  let charIndex = 0;
  let isDeleting = false;
  let typingSpeed = 80;

  const type = () => {
    const current = titles[titleIndex];

    if (isDeleting) {
      typingText.textContent = current.substring(0, charIndex - 1);
      charIndex--;
      typingSpeed = 40;
    } else {
      typingText.textContent = current.substring(0, charIndex + 1);
      charIndex++;
      typingSpeed = 80;
    }

    if (!isDeleting && charIndex === current.length) {
      typingSpeed = 2000;
      isDeleting = true;
    } else if (isDeleting && charIndex === 0) {
      isDeleting = false;
      titleIndex = (titleIndex + 1) % titles.length;
      typingSpeed = 500;
    }

    setTimeout(type, typingSpeed);
  };

  type();

  /* ============================================
     Particle System
     ============================================ */
  if (particlesCanvas) {
    const ctx = particlesCanvas.getContext('2d');
    let particles = [];
    let animId;

    const resizeCanvas = () => {
      particlesCanvas.width = particlesCanvas.parentElement.offsetWidth;
      particlesCanvas.height = particlesCanvas.parentElement.offsetHeight;
    };

    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);

    class Particle {
      constructor() {
        this.reset();
      }

      reset() {
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
        const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
        const color = isDark ? '255,255,255' : '0,0,0';
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(${color},${this.opacity})`;
        ctx.fill();
      }
    }

    const count = Math.min(80, Math.floor((particlesCanvas.width * particlesCanvas.height) / 12000));
    for (let i = 0; i < count; i++) {
      particles.push(new Particle());
    }

    const drawConnections = () => {
      const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
      const color = isDark ? '255,255,255' : '0,0,0';
      for (let i = 0; i < particles.length; i++) {
        for (let j = i + 1; j < particles.length; j++) {
          const dx = particles[i].x - particles[j].x;
          const dy = particles[i].y - particles[j].y;
          const dist = Math.sqrt(dx * dx + dy * dy);
          if (dist < 120) {
            ctx.beginPath();
            ctx.moveTo(particles[i].x, particles[i].y);
            ctx.lineTo(particles[j].x, particles[j].y);
            ctx.strokeStyle = `rgba(${color},${0.06 * (1 - dist / 120)})`;
            ctx.lineWidth = 0.5;
            ctx.stroke();
          }
        }
      }
    };

    const animateParticles = () => {
      ctx.clearRect(0, 0, particlesCanvas.width, particlesCanvas.height);
      particles.forEach(p => { p.update(); p.draw(); });
      drawConnections();
      animId = requestAnimationFrame(animateParticles);
    };

    animateParticles();

    document.addEventListener('visibilitychange', () => {
      if (document.hidden) cancelAnimationFrame(animId);
      else animateParticles();
    });
  }

  /* ============================================
     Project Filter
     ============================================ */
  const filterBtns = $$('.filter-btn');
  const projectCards = $$('.project-card');

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const filter = btn.dataset.filter;
      projectCards.forEach(card => {
        if (filter === 'all' || card.dataset.category === filter) {
          card.classList.remove('hidden');
          card.style.animation = 'fadeInUp 0.4s ease forwards';
        } else {
          card.classList.add('hidden');
        }
      });
    });
  });

  /* ============================================
     Contact Form
     ============================================ */
  const validators = {
    name: v => v.trim().length >= 2,
    email: v => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v),
    subject: v => v.trim().length >= 2,
    message: v => v.trim().length >= 10,
  };

  const validateField = field => {
    const group = field.closest('.form-group');
    const valid = validators[field.name]?.(field.value) ?? true;
    group.classList.toggle('error', !valid);
    group.classList.toggle('valid', valid && field.value.length > 0);
    return valid;
  };

  if (contactForm) {
    $$('input, textarea', contactForm).forEach(field => {
      field.addEventListener('blur', () => validateField(field));
      field.addEventListener('input', () => {
        if (field.closest('.form-group').classList.contains('error')) {
          validateField(field);
        }
      });
    });

    contactForm.addEventListener('submit', e => {
      e.preventDefault();
      const fields = $$('input, textarea', contactForm);
      const allValid = fields.map(f => validateField(f)).every(Boolean);

      if (!allValid) return;

      const submitBtn = $('button[type="submit"]', contactForm);
      submitBtn.classList.add('loading');
      submitBtn.disabled = true;

      setTimeout(() => {
        submitBtn.classList.remove('loading');
        submitBtn.classList.add('success');

        setTimeout(() => {
          submitBtn.classList.remove('success');
          submitBtn.disabled = false;
          contactForm.reset();
          $$('.form-group', contactForm).forEach(g => {
            g.classList.remove('valid', 'error');
          });
        }, 2500);
      }, 1500);
    });
  }

  /* ============================================
     Smooth Scroll for Anchor Links
     ============================================ */
  $$('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', e => {
      const targetId = anchor.getAttribute('href');
      if (targetId === '#') return;
      const target = $(targetId);
      if (!target) return;
      e.preventDefault();
      const offset = header.offsetHeight;
      const top = target.getBoundingClientRect().top + window.scrollY - offset;
      window.scrollTo({ top, behavior: 'smooth' });
    });
  });
})();
