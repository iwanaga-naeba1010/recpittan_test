/**
 * customersのreportのevaluationを動的に扱うformです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    // NOTE: 追加施設数に関するイベント
    $('#report_number_of_facilities').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_FACILITY: number = Number($('#additionalFacilityFee').text());
      const numberOfFacilities: number = Number($('#report_number_of_facilities').val());
      $('#totalNumberOfFacilityPrice').text((numberOfFacilities * PRICE_PER_ADDIOTIONAL_FACILITY).toLocaleString() + '円');
    });

    // NOTE 参加人数に関するイベント
    $('#report_number_of_people').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_PERSON: number = Number($('#instructoMaterialAmount').text());
      const numberOfPeople: number = Number($('#report_number_of_people').val());
      // NOTE: 材料費総額
      $('#totalMaterialPrice').text((numberOfPeople * PRICE_PER_ADDIOTIONAL_PERSON) + '円');
      // NOTE: 追加人数
      $('#numberOfPeople').text(numberOfPeople + '人');
    })
  });
})();
