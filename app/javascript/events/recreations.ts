/**
 * customersのrecreation関連のeventsです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    // NOTE: youtubeのiframeの大きさから画像のheightを動的に生成
    const youtubeSection = $('#youtubeSection');
    const height = youtubeSection.height();
    if (height) {
      $('.custom-height').css('height', height);
    }
  });
})();
