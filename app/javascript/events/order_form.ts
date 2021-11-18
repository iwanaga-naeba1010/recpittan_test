/**
 * order/newのprefectureとcityを動的に扱うformです
 */
import * as $ from 'jquery';
import { findAllPrefectures, findCityByPrefectureCode } from '../packs/prefectures';

(() => {
  document.addEventListener('turbolinks:load', async () => {
    const prefectures = await findAllPrefectures();
    prefectures.result.map((prefecture) => {
      $('#order_prefecture').append($('<option>', {
        value: prefecture.prefName,
        text: prefecture.prefName,
      }));
    });
    
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
  });
})();
