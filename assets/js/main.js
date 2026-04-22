// PORA — Site JS
(function () {
  'use strict';

  // Mobile nav toggle
  const nav = document.querySelector('.nav');
  const toggle = document.querySelector('.nav-toggle');
  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', nav.classList.contains('open'));
    });
    // close on link click (mobile)
    nav.querySelectorAll('.nav-links a').forEach((a) => {
      a.addEventListener('click', () => nav.classList.remove('open'));
    });
  }

  // FAQ accordions
  document.querySelectorAll('.faq-item').forEach((item) => {
    const q = item.querySelector('.faq-question');
    if (!q) return;
    q.addEventListener('click', () => {
      const wasOpen = item.classList.contains('open');
      // close all others in same list (optional)
      if (!wasOpen) {
        item.closest('.faq-list')
          ?.querySelectorAll('.faq-item.open')
          .forEach((o) => o.classList.remove('open'));
      }
      item.classList.toggle('open');
      q.setAttribute('aria-expanded', item.classList.contains('open'));
    });
  });

  // Contact form (Formspree fallback)
  const form = document.querySelector('.form[data-form]');
  if (form) {
    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      const btn = form.querySelector('button[type="submit"]');
      const success = document.querySelector('.form-success');
      const data = new FormData(form);
      btn.disabled = true;
      btn.textContent = 'Envoi...';
      try {
        const endpoint = form.getAttribute('action');
        const res = await fetch(endpoint, {
          method: 'POST',
          body: data,
          headers: { Accept: 'application/json' },
        });
        if (res.ok) {
          form.reset();
          if (success) success.classList.add('show');
          btn.textContent = 'Message envoyé ✓';
        } else {
          btn.textContent = 'Erreur — réessayer';
          btn.disabled = false;
        }
      } catch (err) {
        // Fallback : mailto
        const mailto = form.getAttribute('data-mailto');
        if (mailto) {
          const subj = encodeURIComponent('Demande de devis — ' + (data.get('nom') || 'Site PORA'));
          const body = encodeURIComponent(
            `Nom: ${data.get('nom') || ''}\nTél: ${data.get('telephone') || ''}\nEmail: ${data.get('email') || ''}\nVéhicule: ${data.get('vehicule') || ''}\nPrestation: ${data.get('prestation') || ''}\n\n${data.get('message') || ''}`
          );
          window.location.href = `mailto:${mailto}?subject=${subj}&body=${body}`;
        }
        btn.textContent = 'Envoyer ma demande';
        btn.disabled = false;
      }
    });
  }

  // Set active nav link
  const path = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-links a').forEach((a) => {
    const href = a.getAttribute('href');
    if (href === path || (path === '' && href === 'index.html')) {
      a.classList.add('active');
    }
  });
})();
