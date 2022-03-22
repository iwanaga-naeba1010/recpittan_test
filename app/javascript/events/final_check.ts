/**
 * partnersの最終確認時のeventsです
 */
 import * as $ from 'jquery';

 const App = () => {
  $('#finalCheckBox').on('click', () => {
    const checkBox =  document.getElementById('finalCheckBox') as HTMLInputElement;
    const elements = document.getElementById('checklink');
    if (checkBox.checked === true) {
      return elements.classList.remove('disabled');
    } else {
      return elements.classList.add('disabled');
    }
  });
 };

// NOTE: 画面遷移した時用
document.addEventListener("turbolinks:load", () => {
  App();
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  App();
});
