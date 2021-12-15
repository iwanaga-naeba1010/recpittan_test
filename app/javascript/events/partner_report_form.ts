/**
 * customersのreportのevaluationを動的に扱うformです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    $('#report_facility_count').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_FACILITY: number = 1000;
      // console.log($('#report_facility_count').val());
      console.log('chaged');
      const facilityCount: number = Number($('#report_facility_count').val());
      $('#facilityCount').text((facilityCount * PRICE_PER_ADDIOTIONAL_FACILITY).toLocaleString() + '円');
    })
  });
})();
