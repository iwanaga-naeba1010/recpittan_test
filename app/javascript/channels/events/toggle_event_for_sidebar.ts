import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('#hamburger').on('click', () => {
      const nav = document.getElementById('nav');

      if (nav) {
        nav.classList.toggle('fade-in');
      }
    });

    $('#close-sidebar').on('click', () => {
      const nav = document.getElementById('nav');

      if (nav) {
        nav.classList.remove('fade-in');
      }
    });
  });
})();
