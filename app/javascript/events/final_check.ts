/**
 * partnersの最終確認時のeventsです
 */
 import * as $ from 'jquery';

 (() => {
   document.addEventListener('turbolinks:load', () => {
    $('#finalCheckBox').on('click', () => {
      const checkBox =  document.getElementById('finalCheckBox') as HTMLInputElement;
      const elements = document.getElementById('checklink');
      if (checkBox.checked === true) {
        return elements.classList.remove('disabled');
      } else {
        return elements.classList.add('disabled');
      }
    });
   });
 })();
