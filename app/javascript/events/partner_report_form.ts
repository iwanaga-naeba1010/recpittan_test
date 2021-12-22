/**
 * customersのreportのevaluationを動的に扱うformです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('#report_number_of_facilities').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_FACILITY: number = Number($('#additionalFacilityFee').text());
      console.log('chaged');
      console.log(PRICE_PER_ADDIOTIONAL_FACILITY);

      const numberOfFacilities: number = Number($('#report_number_of_facilities').val());
      $('#totalNumberOfFacilityPrice').text((numberOfFacilities * PRICE_PER_ADDIOTIONAL_FACILITY).toLocaleString() + '円');
    })
  });
})();
