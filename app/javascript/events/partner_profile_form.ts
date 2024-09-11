/**
 * partner/profileのformを動的に扱うevents
 */
import * as $ from 'jquery';

$(document).on('turbolinks:load', function() {
  const imageField = $('.image_form_contents_field');
  const previewContent = $('.prev-content');
  const existingImage = $('.prev-image');

  imageField.on('change', (event) => {
    const file = (event.target as HTMLInputElement).files?.[0];
    
    if (!file) return;

    const reader = new FileReader();
    reader.onload = (e) => {
      if (!e.target?.result) return;

      const imageUrl = e.target.result.toString();
      if (existingImage.length === 0) {
        // 新しい画像要素を作成してプレビュー表示
        const newImage = $('<img>', {
          src: imageUrl,
          class: 'prev-image'
        });
        previewContent.empty().append(newImage);
      } else {
        // 既存の画像要素に画像を設定
        existingImage.attr('src', imageUrl);
      }
    };
    reader.readAsDataURL(file);
  });
});

