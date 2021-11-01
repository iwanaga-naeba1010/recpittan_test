/**
 * Orderのprefecture/cityのform
 */

import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { get } from '../utils/requests/base';

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

const App: React.FC = (): JSX.Element => {
  const [prefectures, setPrefectures] = useState<Prefecture[]>([]);
  const [cities, setCities] = useState<City[]>([]);
  useEffect(() => {
    (async () => {
      const response = await get<PrefectureResponse>('https://opendata.resas-portal.go.jp/api/v1/prefectures',{ 'X-API-KEY': 'ZNVO5KCcD10yRBAjMMUknk9MVQ2w53VWv5LWTJoN' });
      console.log(response.result);
      setPrefectures(response.result);
    })();
    
  }, []);
  
  const handleChangePrefecture = async (prefName: string): Promise<void> => {
    // NOTE: 本当は綺麗にstate管理したいが、formのnameやvalを変えるとRailsで制御する必要あるので、ここで管理
    const prefCode = prefectures.filter((pref) => pref.prefName === prefName)[0].prefCode;
    const response: any = await get<CityResponse>(
      `https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=${prefCode.toString()}`,
      { 'X-API-KEY': 'ZNVO5KCcD10yRBAjMMUknk9MVQ2w53VWv5LWTJoN' }
    );
    setCities(response.result);
  }
  return (
   <>
     <label className="col-12 title-b pb-3">都道府県と市区町村を選択してください</label>
     <div className="form-group col-6">
       <label htmlFor="prefecture">都道府県</label>
       {/* NOTE(okubo): Rails formとの兼ね合いあるので、nameは変えないこと */}
       <select id="order_prefecture" name="order[prefecture]" className="form-select p-region" onChange={(e) => handleChangePrefecture(e.target.value)}>
         <option>ー</option>
         { prefectures.map((pref) => <option value={ pref.prefName }>{ pref.prefName }</option>) }
       </select>
     </div>

     <div className="form-group col-6">
       <label htmlFor="city">市区町村</label>
       {/* NOTE(okubo): Rails formとの兼ね合いあるので、nameは変えないこと */}
       <select id="order_city" name="order[city]" className="form-select">
         <option>ー</option>
         { cities.map((city) => <option value={ city.cityName }>{ city.cityName }</option>) }
       </select>
     </div>
   </>
  );
}

document.addEventListener('turbolinks:load', () => {
  const productDetailOfFree = document.querySelector('#Prefectures');
  if (productDetailOfFree) {
    ReactDOM.render(
      <App />,
      productDetailOfFree,
    )
  }
})
