/**
 * customersのreportのevaluationを動的に扱うformです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    // NOTE: 都道府県を初期化
    $('#approveModalSubmit').on('click', () => {
      // TODO: status:acceptedをformにhiddenで入れる
      // TODO: その後submitをclickeさせる
      $('<input>')
        .attr({
          type: 'hidden',
          name: 'report[status]',
          value: 'accepted',
        })
        .appendTo('form');
      $('input[type=submit]').click();
      console.log('approveModalSubmit clicked!!!');
    });

    $('#rejectModalSubmit').on('click', () => {
      // TODO: status:deniedをformにhiddenで入れる
      // TODO: その後submitをclickeさせる
      $('<input>')
        .attr({
          type: 'hidden',
          name: 'report[status]',
          value: 'denied',
        })
        .appendTo('form');
      $('input[type=submit]').click();
      console.log('rejectModalSubmit clicked!!!');
    });
  });
})();
