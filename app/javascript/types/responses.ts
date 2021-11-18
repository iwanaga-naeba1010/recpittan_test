import { Prefecture } from './prefectures';
import { City } from './cities';

export interface PrefectureResponse {
  message: string;
  result: Prefecture[];
}

export interface CityResponse {
  message: string;
  result: City[];
}
