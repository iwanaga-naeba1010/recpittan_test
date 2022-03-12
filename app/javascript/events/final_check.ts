/**
 * partnersの最終確認時のeventsです
 */
 import * as $ from 'jquery';

 (() => {
   document.addEventListener('turbolinks:load', async () => {
    $('#finalCheckBox').on('click', () => {
      var elements = document.getElementById("checklink");
      console.log(elements);
      elements.classList.remove("disabled");
    });
   });
 })();
