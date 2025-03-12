import { City } from './cities';
import { Prefecture } from './prefectures';

export interface PrefectureResponse {
  message: string;
  result: Prefecture[];
}

export interface CityResponse {
  message: string;
  result: City[];
}
