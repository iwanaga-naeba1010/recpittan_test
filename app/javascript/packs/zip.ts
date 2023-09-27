import { get } from '../utils/requests/base';

interface Address {
  address1: string;
  address2: string;
  address3: string;
  kana1: string;
  kana2: string;
  kana3: string;
  prefCode: number;
  zipcide: number;
}

interface Response {
  message: string;
  results: Address[];
}

export const findAddressByZip = async (zip: string): Promise<Response> => {
  return get<Response>(
    `https://zipcloud.ibsnet.co.jp/api/search?zipcode=${zip}`
  );
};
