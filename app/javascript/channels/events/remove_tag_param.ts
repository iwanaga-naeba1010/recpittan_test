import * as $ from 'jquery';

$(document).ready(() => {
  $('.remove-tag-param').on('click', function () {
    const tagContainer = $(this).closest('.tag-params');
    const tagName = tagContainer.text().trim().substring(2);

    const urlParams = new URLSearchParams(window.location.search);
    const tags: string[] = urlParams.getAll('tags[]');

    const index = tags.indexOf(tagName);
    if (index > -1) {
      tags.splice(index, 1);
    }

    urlParams.delete('tags[]');
    tags.forEach((tag) => urlParams.append('tags[]', tag));

    window.location.search = urlParams.toString();
  });
});
