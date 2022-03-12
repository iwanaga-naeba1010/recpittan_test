/**
 * partnersの最終確認時のeventsです
 */
 import * as $ from 'jquery';

 (() => {
   document.addEventListener('turbolinks:load', async () => {
    $('#finalCheckBox').on('click', () => {
      const elements = document.getElementById('checklink');
      elements.classList.remove('disabled');
    });
   });
 })();
