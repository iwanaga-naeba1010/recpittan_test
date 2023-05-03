/**
 * partner/profileのformを動的に扱うevents
 */
import * as $ from 'jquery';

const App = (inputSelector: string, displaySelector: string) => {
  $(`#${inputSelector}`).on('input', () => {
    const currentValue = $(`#${inputSelector}`).val()?.toString().length || 0;
    $(`#${displaySelector}`).text(currentValue);
  });
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  App('profile_name', 'countOfProfileName');
  App('profile_title', 'countOfProfileTitle');
  App('profile_description', 'countOfProfileDescription');
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  App('profile_name', 'countOfProfileName');
  App('profile_title', 'countOfProfileTitle');
  App('profile_description', 'countOfProfileDescription');
});
