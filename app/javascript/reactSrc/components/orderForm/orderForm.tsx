import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { get } from '../../../utils/requests/base';
import * as $ from 'jquery';
import { Order } from '../../../types';

export const OrderForm: React.FC = (): JSX.Element => {
  const [order, setOrder] = useState<Order>({} as Order);

  useEffect(() => {
    (async() => {
      const arr = window.location.pathname.split('/');
      const response = await get<Order>(`/api/orders/${arr[3]}`);
      setOrder(response);
    })()
  }, []);

  return (
    <>
      <div className="card-body">
        <h5 className="card-title title-b">レク 費用</h5>
        <div className="row justify-content-between border-bottom-dotted pb-2">
          <div className="col-auto">開催費</div>
          <div className="col-auto">&yen;
            { order.price?.toLocaleString() }
          </div>
        </div>
        <div className="row justify-content-between border-bottom-dotted py-2">
          <div className="col-auto">
            <span id="participantNum">材料費/1人</span>
            <br />
            <span className="text-muted font-12 color-ba08">※材料費は人数分の費用が発生します</span>
          </div>
          <div id="materialPrice" className="col-auto">&yen;
            { order.material_price?.toLocaleString() }
          </div>
        </div>
        <div className="row justify-content-between border-bottom-dotted pb-2">
          <div className="col-auto">交通費</div>
          <div id="transportationExpensesForOrderForm" className="col-auto">&yen;
            { order.transportation_expenses?.toLocaleString() }
          </div>
        </div>
        <div className="row justify-content-between border-bottom-dotted pb-2">
          <div className="col-auto">諸経費</div>
          <div id="expensesForOrderForm" className="col-auto">&yen;
            { order.expenses?.toLocaleString() }
          </div>
        </div>

        { order?.recreation?.is_online &&
          <div className="row justify-content-between border-bottom-dotted pb-2">
            <div className="col-auto">追加施設費 / <span id="numberOfFacilitiesForOrderFormLabel">{order.number_of_facilities}施設</span></div>
            <div id="numberOfFacilitiesForOrderForm" className="col-auto">&yen;
              { order.total_facility_price_for_customer?.toLocaleString() }
            </div>
          </div>
        }

        <div className="row justify-content-between border-top py-3">
          <div className="col-auto">合計(税別)</div>
          <div id="totalPriceForOrderForm" className="col-auto">&yen;
            { order.total_price_for_customer?.toLocaleString() }
          </div>
        </div>
      </div>
    </>
  );
}

// NOTE: 画面遷移した時用
document.addEventListener("turbolinks:load", () => {
  const elm = document.querySelector('#OrderForm');
  if (elm) {
    ReactDOM.render( <OrderForm  />, elm)
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#OrderForm');
  if (elm) {
    ReactDOM.render( <OrderForm  />, elm)
  }
});
