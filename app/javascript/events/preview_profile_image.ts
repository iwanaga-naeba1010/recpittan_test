import * as $ from 'jquery';

$(document).on('turbolinks:load', function () {
  $(function () {
    function buildHTML(image) {
      const html = `
      <div class='prev-content'>
        <img src='${String(image)}', alt='preview' class='prev-image'>
      </div>
      `;
      return html;
    }
    $(document).on('change', '.hidden_file', function () {
      const file = this.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        const image = this.result;
        if ($('.prev-content').length == 0) {
          const html = buildHTML(image);
          $('.prev-contents').prepend(html);
          $('.select-photo').hide();
        } else {
          $('.prev-content .prev-image').attr({ src: image });
        }
      };
    });
  });
});
