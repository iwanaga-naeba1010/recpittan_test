import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { get } from '../../../utils/requests/base';
import * as $ from 'jquery';
import { Order } from '../../../types';
import { ExpenseForm } from './expenceForm';
import { TranspotationExpensesForm } from './transportationExpensesForm'
import { NumberOfFacilitiesForm } from './numberOfFacilitiesForm';

export const App: React.FC = (): JSX.Element => {
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
      <ExpenseForm order={order} />
      <TranspotationExpensesForm order={order} />
      <NumberOfFacilitiesForm order={order} />
    </>
  );
}

// NOTE: 画面遷移した時用
document.addEventListener("turbolinks:load", () => {
  const elm = document.querySelector('#OrderChat');
  if (elm) {
    ReactDOM.render( <App  />, elm)
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#OrderChat');
  if (elm) {
    ReactDOM.render( <App  />, elm)
  }
});
