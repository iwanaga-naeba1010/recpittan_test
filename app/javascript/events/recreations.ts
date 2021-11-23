/**
 * customersのrecreation関連のeventsです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', async () => {
    // NOTE: youtubeのiframeの大きさから画像のheightを動的に生成
    const height = $('#youtubeSection').height();
    $('.custom-height').css('height', height);
  });
})();
