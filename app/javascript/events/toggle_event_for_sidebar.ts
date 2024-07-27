import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('#hamburger').on('click', () => {
      const line1 = document.getElementById('line1');
      const line2 = document.getElementById('line2');
      const line3 = document.getElementById('line3');
      const nav = document.getElementById('nav');

      if (line1) {
        line1.classList.toggle('line_top');
      }
      if (line2) {
        line2.classList.toggle('line_middle');
      }
      if (line3) {
        line3.classList.toggle('line_bottom');
      }
      if (nav) {
        nav.classList.toggle('fade-in');
      }
    });

    $('#close-sidebar').on('click', () => {
      const line1 = document.getElementById('line1');
      const line2 = document.getElementById('line2');
      const line3 = document.getElementById('line3');
      const nav = document.getElementById('nav');

      if (line1) {
        line1.classList.remove('line_top');
      }
      if (line2) {
        line2.classList.remove('line_middle');
      }
      if (line3) {
        line3.classList.remove('line_bottom');
      }
      if (nav) {
        nav.classList.remove('fade-in');
      }
    });
  });
})();
