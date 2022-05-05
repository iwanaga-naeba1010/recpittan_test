import * as $ from 'jquery';

const App = (e) => {
  const buildHTML = (image) => {
    return `
    <div class='prev-content'>
      <img src='${String(image)}', alt='preview' class='prev-image'>
    </div> `;
  };
  const file: Blob = e.target.files[0];
  const reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = (onClickEvent) => {
    const image = onClickEvent.target.result;
    if ($('.prev-content').length == 0) {
      const html = buildHTML(image);
      $('.prev-contents').prepend(html);
      $('.select-photo').hide();
    } else {
      $('.prev-content .prev-image').attr({ src: image });
    }
  };
};

$(document).on('turbolinks:load', () => {
  $(document).on('change', '.hidden_file', (e) => {
    App(e);
  });
});
