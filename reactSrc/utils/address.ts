import { AddressResponse, CityResponse, PrefectureResponse } from '@/types';
import axios, { AxiosResponse } from 'axios';

export const findAddressByZip = async (
  zip: string
): Promise<AxiosResponse<AddressResponse>> =>
  axios.get<AddressResponse>(
    `https://zipcloud.ibsnet.co.jp/api/search?zipcode=${zip}`
  );

export const findAllPrefectures = async (): Promise<
  AxiosResponse<PrefectureResponse>
> =>
  axios.get<PrefectureResponse>(
    'https://opendata.resas-portal.go.jp/api/v1/prefectures',
    {
      headers: { 'X-API-KEY': 'ZNVO5KCcD10yRBAjMMUknk9MVQ2w53VWv5LWTJoN' },
    }
  );

export const findCityByPrefectureCode = async (
  prefCode: number
): Promise<AxiosResponse<CityResponse>> =>
  axios.get<CityResponse>(
    `https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=${prefCode.toString()}`,
    {
      headers: { 'X-API-KEY': 'ZNVO5KCcD10yRBAjMMUknk9MVQ2w53VWv5LWTJoN' },
    }
  );
