/**
 * customersのrecreation関連のeventsです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('button[name="download-recreation-flyer"]').on('click', function() {
      const self = $(this);
      const fileName = this.dataset.fileName || '';
      const fileUrl = this.dataset.fileUrl || '';
      const xhr = new XMLHttpRequest();

      self.prop('disabled', true);

      xhr.open('GET', fileUrl, true);
      xhr.responseType = 'blob';
      xhr.onload = function() {
        if (xhr.status === 200) {
          const blob = xhr.response as Blob;
          const link = document.createElement('a');
          link.href = URL.createObjectURL(blob);
          link.download = fileName;

          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
          URL.revokeObjectURL(link.href);
        }

        self.prop('disabled', false);
      };
      xhr.onerror = function() {
        console.error('Failed to download image');
        self.prop('disabled', false);
      };

      xhr.send();
    });

    // NOTE: youtubeのiframeの大きさから画像のheightを動的に生成
    const youtubeSection = $('#youtubeSection');
    const height = youtubeSection.height();
    if (height) {
      $('.custom-height').css('height', height);
    }
  });
})();
