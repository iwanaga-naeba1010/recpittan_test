/**
 * registration editのzip/prefectureを動的に扱うformです
 */
import * as $ from 'jquery';
import { findAllPrefectures } from '../packs/prefectures';
import { findAddressByZip } from '../packs/zip';

const App = async () => {
  // NOTE: 都道府県を初期化
  const prefectures = await findAllPrefectures();
  prefectures.result.map((prefecture) => {
    $('#user_company_attributes_prefecture').append($('<option>', {
      value: prefecture.prefName,
      text: prefecture.prefName,
    }));
  });

  // NOTE: user registration eidtの郵便番号をevent経由で動的set
  $('#searchAddressWithZipInRegistrationEditForm').on('click', async () => {
    const zip: string = $('#user_company_attributes_zip').val() as string;
    const address = await findAddressByZip(zip);
    $('#user_company_attributes_prefecture').val(address.results[0].address1);
    $('#user_company_attributes_city').val(address.results[0].address2);
    $('#user_company_attributes_street').val(address.results[0].address3);
  });
}

// NOTE: 画面遷移した時用
document.addEventListener("turbolinks:load", () => {
  App();
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  App();
});
