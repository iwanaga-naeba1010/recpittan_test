/**
 * order/newと正式依頼のprefectureとcityを動的に扱うformです
 */
import * as $ from 'jquery';
import { findAllPrefectures, findCityByPrefectureCode } from '../packs/prefectures';
import { findAddressByZip } from '../packs/zip';

(() => {
  document.addEventListener('turbolinks:load', async () => {
    // 都道府県を初期化
    const prefectures = await findAllPrefectures();
    // NOTE: order/newだけでなく正式依頼formのも適用される
    prefectures.result.map((prefecture) => {
      $('#order_prefecture').append($('<option>', {
        value: prefecture.prefName,
        text: prefecture.prefName,
      }));
    });

    // 市区町村を都道府県のevent経由で動的set
    $('#order_prefecture').on('change', async () => {
      const prefCode = prefectures.result.filter((prefecture) => prefecture.prefName === $('#order_prefecture option:selected').text())[0].prefCode;
      const cities = await findCityByPrefectureCode(prefCode);
      $('#order_city').empty();
      cities.result.map((city) => {
        $('#order_city').append($('<option>', {
          value: city.cityName,
          text: city.cityName,
        }));
      });
    });

    // 仮リリース版のボタン押下動作の処理
    // 料金記載のレクで依頼をかける場合は、rails formをremote:trueにして、ajaxで通信してOKならmodal発火
    $(document).on('ajax:success', () => {
      $('#priceModalTrigger').trigger('click');
    });

    $(document).on('ajax:error', () => {
      console.log('失敗!!!!');
    });

    // NOTE: 正式依頼のzipの郵便番号をevent経由で動的set
    $('#searchAddressWithZipForOrder').on('click', async () => {
      const zip: string = $('#order_zip').val() as string;
      const address = await findAddressByZip(zip);
      $('#order_prefecture').val(address.results[0].address1);
      $('#order_city').val(address.results[0].address2);
      $('#order_street').val(address.results[0].address3);
    });
  });
})();
