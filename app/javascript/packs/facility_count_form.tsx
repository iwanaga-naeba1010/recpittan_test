/**
 * recreationのorderの追加施設数のform
 */

import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { put } from '../utils/requests/base';
import * as $ from 'jquery';

interface Order {
  numberOfFacilities: number;
}

interface Response {
  order: Order;
}

interface Props {
  orderId: number;
  defaultNumberOfFacilities: number;
}

const App: React.FC<Props> = ({ orderId, defaultNumberOfFacilities }): JSX.Element => {
  const [facilities, setFacilities] = useState<number>(defaultNumberOfFacilities);
  const [isSent, setIsSent] = useState<boolean>(false);
  
  useEffect(() => {
    if (defaultNumberOfFacilities !== 0) {
      setIsSent(true);
    }
  }, []);
  
  // NOTE: それぞれの箇所でid指定だとかなり大変なので、chat.html.erbの画面下部にdummyのHTMLを用意し、そこから取得
  const applyExpenses = (numberOfFacilities: number) => {
    const regularPrice: number = Number($('#regularPrice').text());
    const regularMaterialPrice: number = Number($('#regularMaterialPrice').text());
    const expensesPrice: number = Number($('#expensesPrice').text());
    const transportationExpensesPrice: number = Number($('#transportationExpensesPrice').text());
    const additionalFacilitiesPrice: number = Number($('#additionalFacilitiesPrice').text());
    const totalPrice: string = '¥' + (regularPrice + regularMaterialPrice + expensesPrice + transportationExpensesPrice + additionalFacilitiesPrice).toLocaleString() + '円';
    
    console.log(numberOfFacilities);
    console.log(numberOfFacilities + '施設');
    
    // NOTE: サイドバーの合計金額
    $('#totalPriceForSidenav').text(totalPrice);
    // NOTE: 正式依頼の合計金額
    $('#expensesForOrderForm').text('¥' + expensesPrice.toLocaleString() + '円');
    $('#transportationExpensesForOrderForm').text('¥' + transportationExpensesPrice.toLocaleString() + '円');
    $('#order_number_of_facilities').val(numberOfFacilities); // TODO: たまに動いていないので、こちらの対処必要
    $('#numberOfFacilitiesForOrderFormLabel').text(numberOfFacilities + '施設'); // TODO: たまに動いていないので、こちらの対処必要
    $('#numberOfFacilitiesForOrderForm').text((numberOfFacilities * 2000).toLocaleString() + '円'); // TODO: たまに動いていないので、こちらの対処必要
    $('#totalPriceForOrderForm').text(totalPrice);
  }
  
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFacilities(Number(e.target.value));
    $('#additionalFacilitiesPrice').text(Number(e.target.value) * 2000);
    // if (target === 'expenses') {
    //   $('#expensesPrice').text(Number(e.target.value));
    // } else {
    //   $('#transportationExpensesPrice').text(Number(e.target.value));
    // }
    applyExpenses(Number(e.target.value));
  }
  
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>): Promise<void> => {
    const token = document.querySelector('[name=csrf-token]').getAttribute('content');
    e.preventDefault();

    let body = {};
    body['number_of_facilities'] = facilities;
    try {
      await put<Response>(
        `/api/orders/${orderId}`,
        { order: body },
        { 'X-CSRF-TOKEN': token }
      );
      setIsSent(true);
    } catch (e) {
      setIsSent(false);
    }
  }

  return (
    <>
      { isSent
      ? (
          <div className="row justify-content-between border-bottom-dotted py-2">
            <div className="col-auto align-self-center">
              追加施設費 / 追加施設数 { facilities }施設
              <br/>
              <a className="clink" onClick={() => setIsSent(false)}>編集</a>
            </div>
            <div className="col-auto">&yen;
              {/* TODO: recの金額から算出 */}
              { facilities * 2000 }
            </div>
          </div>
        )
      : (
          <form className="consult" onSubmit={(e) => handleSubmit(e)}>
            <div className="row justify-content-between border-bottom-dotted py-2">
              <div className="col-3 align-self-center">
                追加施設数
              </div>
              <div className="col-7">
                <input
                  id="number_of_facilities"
                  className="form-control text-end"
                  type="number"
                  value={ facilities } onChange={(e) => handleChange(e)}
                />
              </div>
        
              <div className="col-2 py-0">
                <button type="submit" name="action" value="transport_upadte" className="btn btn-inline-edit">
                  <i className="material-icons color-pr10">done</i>
                </button>
              </div>
            </div>
          </form>
        )
      }
    </>
  );
}

document.addEventListener('turbolinks:load', () => {
  const numberOfFacilitiesForm = document.querySelector('#NumberOfFacilitiesForm');
  if (numberOfFacilitiesForm) {
    const facilities: number = Number(numberOfFacilitiesForm.getAttribute('numberOfFacilities'));
    const orderId: number = Number(numberOfFacilitiesForm.getAttribute('orderId'));
    ReactDOM.render(
      <App orderId={orderId} defaultNumberOfFacilities={facilities} />,
      numberOfFacilitiesForm,
    )
  }
})
