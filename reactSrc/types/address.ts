export interface Address {
  address1: string;
  address2: string;
  address3: string;
  kana1: string;
  kana2: string;
  kana3: string;
  prefCode: number;
  zipcide: number;
}

export interface AddressResponse {
  message: string;
  results: Array<Address>;
}

export interface Prefecture {
  prefCode: number;
  prefName: string;
}

export interface City {
  prefCode: number;
  cityCode: number;
  cityName: string;
  bigCityFlag: boolean;
}

export interface PrefectureResponse {
  message: string;
  result: Array<Prefecture>;
}

export interface CityResponse {
  message: string;
  result: Array<City>;
}
