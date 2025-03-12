/**
 * registration editのzip/prefectureを動的に扱うformです
 */
import * as $ from 'jquery';
import { AddressForm, InputValue } from '../components/address_form';

const inputValue: InputValue = {
  inputZip: 'user_company_attributes_zip',
  inputPrefecture: 'user_company_attributes_prefecture',
  inputCity: 'user_company_attributes_city',
  inputStreet: 'user_company_attributes_street',
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
