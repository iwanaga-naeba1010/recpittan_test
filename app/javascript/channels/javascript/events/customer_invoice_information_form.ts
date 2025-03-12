/**
 * invoice informationのzip/prefectureを動的に扱うformです
 */
import * as $ from 'jquery';
import { AddressForm, InputValue } from '../components/address_form';

const inputValue: InputValue = {
  inputZip: 'invoice_information_zip',
  inputPrefecture: 'invoice_information_prefecture',
  inputCity: 'invoice_information_city',
  inputStreet: 'invoice_information_street',
};

{
  AddressForm;
}

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  AddressForm(inputValue);
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  AddressForm(inputValue);
});
