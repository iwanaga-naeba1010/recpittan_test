/**
 * admin/orderの正式依頼formです
 */
import * as $ from 'jquery';
import { findAddressByZip } from '../../packs/zip';

$(document).ready(() => {
  // NOTE(okubo): 一応念の為全てのformをdisplay noneに変更する
  const hideAllForm = () => {
    $('.official_input').css('display', 'none');
    $('.recreation_input').css('display', 'none');
    $('.cost_input').css('display', 'none');
    $('.evaluation_input').css('display', 'none');
  };

  // NOTE(okubo): 正式依頼のformを表示
  $('#officialRequestBtn').on('click', () => {
    hideAllForm();
    $('.official_input').css('display', 'block');
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

  // NOTE(okubo): 郵便番号を入力したら7文字以上で検索して自動入力する
  $('#order_zip').on('input', async () => {
    const zip: string = $('#order_zip').val() as string;
    if (zip.length < 7) {
      return;
    }
    const address = await findAddressByZip(zip);
    $('#order_prefecture').val(address.results[0].address1);
    $('#order_city').val(address.results[0].address2);
    $('#order_street').val(address.results[0].address3);
  });

  // 都道府県を初期化
  // const prefectures = await findAllPrefectures();
  // // NOTE: order/newだけでなく正式依頼formのも適用される
  // prefectures.result.map((prefecture) => {
  //   $('#order_prefecture').append($('<option>', {
  //     value: prefecture.prefName,
  //     text: prefecture.prefName,
  //   }));
  // });

  // 市区町村を都道府県のevent経由で動的set
  // $('#order_prefecture').on('change', async () => {
  //   const prefCode = prefectures.result.filter((prefecture) => prefecture.prefName === $('#order_prefecture option:selected').text())[0].prefCode;
  //   const cities = await findCityByPrefectureCode(prefCode);
  //   $('#order_city').empty();
  //   cities.result.map((city) => {
  //     $('#order_city').append($('<option>', {
  //       value: city.cityName,
  //       text: city.cityName,
  //     }));
  //   });
  // });
});
