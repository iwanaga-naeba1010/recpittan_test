/**
 * customersのreportのevaluationを動的に扱うformです
 */
import * as $ from 'jquery';

(() => {
  document.addEventListener('turbolinks:load', () => {
    // NOTE: 追加施設数に関するイベント
    $('#report_number_of_facilities').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_FACILITY = Number(
        $('#dummyAdditionalFacilityFee').text()
      );
      const numberOfFacilities = Number(
        $('#report_number_of_facilities').val()
      );
      $('#totalNumberOfFacilityPrice').text(
        (numberOfFacilities * PRICE_PER_ADDIOTIONAL_FACILITY).toLocaleString(
          'ja-JP',
          {
            style: 'currency',
            currency: 'JPY',
          }
        )
      );

      $('#dummyTotalFacilityFee').text(
        PRICE_PER_ADDIOTIONAL_FACILITY * numberOfFacilities
      );

      updateTotalPrice();
    });

    // NOTE 参加人数に関するイベント
    $('#report_number_of_people').on('change', () => {
      const PRICE_PER_ADDIOTIONAL_PERSON = Number(
        $('#dummyMaterialAmount').text()
      );
      const numberOfPeople = Number($('#report_number_of_people').val());
      // NOTE: 材料費総額
      $('#totalMaterialPrice').text(
        (numberOfPeople * PRICE_PER_ADDIOTIONAL_PERSON).toLocaleString(
          'ja-JP',
          { style: 'currency', currency: 'JPY' }
        )
      );
      // NOTE: 追加人数
      $('#numberOfPeople').text(numberOfPeople.toString() + '人');

      $('#dummyTotalMaterialPrice').text(
        PRICE_PER_ADDIOTIONAL_PERSON * numberOfPeople
      );
      updateTotalPrice();
    });

    // NOTE 交通費に関するイベント
    $('#report_transportation_expenses').on('change', () => {
      const transportationEpenses = Number(
        $('#report_transportation_expenses').val()
      );
      // NOTE: 材料費総額
      $('#transportationEpenses').text(
        transportationEpenses.toLocaleString('ja-JP', {
          style: 'currency',
          currency: 'JPY',
        })
      );

      $('#dummyTransportationExpenses').text(transportationEpenses);
      updateTotalPrice();
    });

    // NOTE: 諸経費に関するイベント
    $('#report_expenses').on('change', () => {
      const expenses: number = Number($('#report_expenses').val()) * 0.9;
      // NOTE: 材料費総額
      $('#expenses').text(
        expenses.toLocaleString('ja-JP', { style: 'currency', currency: 'JPY' })
      );

      $('#dummyExpenses').text(expenses);
      updateTotalPrice();
    });

    const updateTotalPrice = () => {
      const dummyAmount = Number($('#dummyAmount').text());
      const dummyTotalMaterialPrice = Number(
        $('#dummyTotalMaterialPrice').text()
      );
      const dummyTransportationExpenses = Number(
        $('#dummyTransportationExpenses').text()
      );
      const dummyExpenses = Number($('#dummyExpenses').text());
      const dummyTotalFacilityFee = Number($('#dummyTotalFacilityFee').text());
      const dummyZoomPrice = Number($('#dummyZoomPrice').text());

      const totalPrice: number =
        dummyAmount +
        dummyTotalMaterialPrice +
        dummyTransportationExpenses +
        dummyExpenses +
        dummyTotalFacilityFee -
        dummyZoomPrice;
      $('#totalPrice').text(
        totalPrice.toLocaleString('ja-JP', {
          style: 'currency',
          currency: 'JPY',
        })
      );
    };
  });
})();
