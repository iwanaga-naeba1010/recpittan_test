/**
 * customersのreportのevaluationを動的に扱うformです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    // NOTE: 追加施設数に関するイベント
    $('#report_number_of_facilities').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_FACILITY: number = Number($('#dummyAdditionalFacilityFee').text());
      const numberOfFacilities: number = Number($('#report_number_of_facilities').val());
      $('#totalNumberOfFacilityPrice').text((numberOfFacilities * PRICE_PER_ADDIOTIONAL_FACILITY).toLocaleString() + '円');

      console.log(PRICE_PER_ADDIOTIONAL_FACILITY * numberOfFacilities);
      $('#dummyTotalFacilityFee').text(PRICE_PER_ADDIOTIONAL_FACILITY * numberOfFacilities);

      updateTotalPrice();
    });

    // NOTE 参加人数に関するイベント
    $('#report_number_of_people').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_PERSON: number = Number($('#dummyInstructoMaterialAmount').text());
      const numberOfPeople: number = Number($('#report_number_of_people').val());
      // NOTE: 材料費総額
      $('#totalMaterialPrice').text((numberOfPeople * PRICE_PER_ADDIOTIONAL_PERSON) + '円');
      // NOTE: 追加人数
      $('#numberOfPeople').text(numberOfPeople + '人');

      console.log(PRICE_PER_ADDIOTIONAL_PERSON * numberOfPeople);
      $('#dummyTotalMaterialPrice').text(PRICE_PER_ADDIOTIONAL_PERSON * numberOfPeople);
      updateTotalPrice();
    });

    // NOTE 交通費に関するイベント
    $('#report_transportation_expenses').on('change', () => {
      const transportationEpenses: number = Number($('#report_transportation_expenses').val());
      // NOTE: 材料費総額
      $('#transportationEpenses').text(transportationEpenses + '円');

      console.log(transportationEpenses);
      $('#dummyTransportationExpenses').text(transportationEpenses);
      updateTotalPrice();
    });


    // NOTE: 諸経費に関するイベント
    $('#report_expenses').on('change', () => {
      const expenses: number = Number($('#report_expenses').val()) * 0.9;
      // NOTE: 材料費総額
      $('#expenses').text(expenses + '円');

      console.log(expenses);
      $('#dummyExpenses').text(expenses);
      updateTotalPrice();
    });

    const updateTotalPrice = () => {
      const dummyInstructorAmount: number = Number($('#dummyInstructorAmount').text());
      const dummyTotalMaterialPrice: number = Number($('#dummyTotalMaterialPrice').text());
      const dummyTransportationExpenses: number = Number($('#dummyTransportationExpenses').text());
      const dummyExpenses: number = Number($('#dummyExpenses').text());
      const dummyTotalFacilityFee: number = Number($('#dummyTotalFacilityFee').text());
      const dummyZoomPrice: number = Number($('#dummyZoomPrice').text());

      const totalPrice: number = dummyInstructorAmount + dummyTotalMaterialPrice + dummyTransportationExpenses + dummyExpenses + dummyTotalFacilityFee - dummyZoomPrice;
      $('#totalPrice').text(totalPrice.toLocaleString() + '円');
    }
  });
})();
