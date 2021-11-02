/**
 * Orderのprefecture/cityのform
 */

import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { get } from '../utils/requests/base';
import * as $ from 'jquery';

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

interface Props {
  defaultZip: string;
}

const App: React.FC<Props> = ({ defaultZip }): JSX.Element => {
  const [zip, setZip] = useState<string>(defaultZip);
  
  const handleFetchZip = async (): Promise<void> => {
    console.log(zip);
    const response = await get<Response>(`https://zipcloud.ibsnet.co.jp/api/search?zipcode=${zip}`);
    console.log(response.results);
    $('#order_prefecture').val(response.results[0].address1);
    $('#user_company_attributes_city').val(response.results[0].address2);
    $('#user_company_attributes_street').val(response.results[0].address3);
  }

  return (
    <>
      <div className="input-group mb-3">
        <div className="form-group string optional user_company_zip form-group-valid">
          <input
            className="form-control is-valid string optional form-control"
            name="user[company_attributes][zip]"
            id="user_company_attributes_zip"
            value={zip}
            onChange={(e) => setZip(e.target.value)}
          />
          </div>
        <button
          className="btn btn-outline-secondary p-postal-code-find"
          type="button"
          onClick={handleFetchZip}
        >
          検索
        </button>
      </div>
    </>
  );
}

document.addEventListener('turbolinks:load', () => {
  const productDetailOfFree = document.querySelector('#ZipForEditUserForm');
  if (productDetailOfFree) {
    const zip = productDetailOfFree.getAttribute('zip');
    ReactDOM.render(
      <App defaultZip={zip} />,
      productDetailOfFree,
    )
  }
})
