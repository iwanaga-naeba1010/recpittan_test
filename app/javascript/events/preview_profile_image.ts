import * as $ from 'jquery';

const App = (e: JQueryEventObject) => {
  const buildHTML = (image: string) => {
    return `
    <div class='prev-content'>
      <img src='${image}', alt='preview' class='prev-image'>
    </div> `;
  };

  const target = e.target as HTMLInputElement;
  if (!target.files) return;

  const file: Blob = target.files[0];
  const reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = (onClickEvent: ProgressEvent<FileReader>) => {
    const targetResult = onClickEvent.target?.result;
    if (typeof targetResult === 'string') {
      const image = targetResult;
      if ($('.prev-content').length === 0) {
        const html = buildHTML(image);
        $('.prev-contents').prepend(html);
        $('.select-photo').hide();
      } else {
        $('.prev-content .prev-image').attr({ src: image });
      }
    }
  };
};

$(document).on('turbolinks:load', () => {
  $(document).on('change', '.hidden_file', (e) => {
    App(e);
  });
});
