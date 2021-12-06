/**
 * partner画面のサイドメニューのスマホ時の開閉のeventsです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('#hamburger').on('click', () => {
      document.getElementById('line1').classList.toggle('line_top');
      document.getElementById('line2').classList.toggle('line_middle');
      document.getElementById('line3').classList.toggle('line_bottom');
      document.getElementById('nav').classList.toggle('fade-in');
    });
  });
})();
