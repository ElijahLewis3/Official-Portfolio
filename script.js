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
