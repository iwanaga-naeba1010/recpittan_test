import * as $ from 'jquery';
import { findAllPrefectures } from '../packs/prefectures';
import { findAddressByZip } from '../packs/zip';

export type InputValue = {
  inputZip: string;
  inputPrefecture: string;
  inputCity: string;
  inputStreet: string;
};

export const AddressForm = async ({
  inputZip,
  inputPrefecture,
  inputCity,
  inputStreet,
}: InputValue): Promise<void> => {
  const defaultPrefecture: string = $(`#${inputPrefecture}`)
    .text()
    .replace(/\s/g, '');
  // NOTE: 都道府県を初期化
  const prefectures = await findAllPrefectures();
  prefectures.result.map((prefecture) => {
    $(`#${inputPrefecture}`).append(
      $('<option>', {
        value: prefecture.prefName,
        text: prefecture.prefName,
      })
    );
  });

  if (defaultPrefecture !== '') {
    $(`#${inputPrefecture} option[value=${defaultPrefecture}]`).attr(
      'selected',
      'selected'
    );
  }
  $('#searchAddressWithZipInRegistrationEditForm').on('click', async () => {
    const zip: string = $(`#${inputZip}`).val() as string;
    const address = await findAddressByZip(zip);
    $(`#${inputPrefecture}`).val(address.results[0].address1);
    $(`#${inputCity}`).val(address.results[0].address2);
    $(`#${inputStreet}`).val(address.results[0].address3);
  });
};
