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

interface PrefectureResponse {
  message: string;
  result: Prefecture[];
}

interface Props {
  defaultPrefecture: string;
}

const App: React.FC<Props> = ({ defaultPrefecture }): JSX.Element => {
  const [prefectures, setPrefectures] = useState<Prefecture[]>([]);
  useEffect(() => {
    (async () => {
      const response = await get<PrefectureResponse>('https://opendata.resas-portal.go.jp/api/v1/prefectures',{ 'X-API-KEY': 'ZNVO5KCcD10yRBAjMMUknk9MVQ2w53VWv5LWTJoN' });
      console.log(response.result);
      setPrefectures(response.result);
    })();
  }, []);

  return (
    // TODO: form全体をこちらに移行
    // TODO: addressの自動変換も対応させる
    <>
      <select id="order_prefecture" name="user[company_attributes][prefecture]" className="form-select p-region">
        <option>ー</option>
        { prefectures.map((pref) =>
          <option value={ pref.prefName } selected={ pref.prefName === defaultPrefecture }>{ pref.prefName }</option>) }
      </select>
    </>
  );
}

document.addEventListener('turbolinks:load', () => {
  const productDetailOfFree = document.querySelector('#PrefectureForEditUserForm');
  if (productDetailOfFree) {
    const prefecture = productDetailOfFree.getAttribute('prefecture');
    ReactDOM.render(
      <App defaultPrefecture={prefecture} />,
      productDetailOfFree,
    )
  }
})
