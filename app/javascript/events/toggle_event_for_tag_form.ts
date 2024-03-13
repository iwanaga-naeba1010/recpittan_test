import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('#display-tag-form-btn').on('click', () => {
      $('#tag-form').toggleClass('d-none');
    });
  });
})();
