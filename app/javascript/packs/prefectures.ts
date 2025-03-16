import { get } from '../utils/requests/base';
import { xapikeyenv }  from '../utils/opendata_xapikey';


interface Prefecture {
  prefCode: number;
  prefName: string;
}

interface City {
  prefCode: number;
  cityCode: number;
  cityName: string;
  bigCityFlag: boolean;
}

interface PrefectureResponse {
  message: string;
  result: Prefecture[];
}

interface CityResponse {
  message: string;
  result: City[];
}
export const findAllPrefectures = async (): Promise<PrefectureResponse> => {
  return get<PrefectureResponse>(
    'https://opendata.resas-portal.go.jp/api/v1/prefectures',
    {
      'X-API-KEY': xapikeyenv,
    }
  );
};

export const findCityByPrefectureCode = async (
  prefCode: number
): Promise<CityResponse> => {
  return get<CityResponse>(
    `https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=${prefCode.toString()}`,
    {
      'X-API-KEY': xapikeyenv,
    }
  );
};

