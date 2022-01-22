/**
 * admin/orderの正式依頼formです
 */
import * as $ from 'jquery';

$(document).ready(() => {
  // NOTE(okubo): 一応念の為全てのformをdisplay noneに変更する
  const hideAllForm = () => {
    $('.official_input').css('display', 'none');
    $('.recreation_input').css('display', 'none');
    $('.cost_input').css('display', 'none');
  }
  // NOTE(okubo): 正式依頼のformを表示
  $('#officialRequestBtn').on('click', () => {
    hideAllForm();
    $('.official_input').css('display', 'block');
  });

  // NOTE(okubo): 正式依頼のレク金額formを表示
  $('#recreationBtn').on('click', () => {
    hideAllForm();
    $('.recreation_input').css('display', 'block');
  });

  // NOTE(okubo): 正式依頼のcostのform表示
  $('#costBtn').on('click', () => {
    hideAllForm();
    $('.cost_input').css('display', 'block');
  });
  $('#evaluationBtn').on('click', () => {
    hideAllForm();
    $('.evaluation_input').css('display', 'block');
  });
});
