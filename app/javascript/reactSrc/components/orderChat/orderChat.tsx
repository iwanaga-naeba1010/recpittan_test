import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { get, put } from '../../../utils/requests/base';
import * as $ from 'jquery';
import { Order } from '../../../types';
import {ExpenseForm} from './expenceForm';
import { TranspotationExpensesForm } from './transportationExpensesForm'

export interface Response {
  order: Order;
}

type TargetEnum = 'expenses' | 'transportation_expenses';

export const App: React.FC = (): JSX.Element => {
  const [order, setOrder] = useState<Order>({} as Order);

  useEffect(() => {
    (async() => {
      const arr = window.location.pathname.split('/');
      const response = await get<Response>(`/api/orders/${arr[3]}`);
      setOrder(response.order)
    })()
  }, []);

  return (
    <>
      <ExpenseForm order={order} />
      <TranspotationExpensesForm order={order} />
    </>
  );
}

// NOTE: 画面遷移した時用
document.addEventListener("turbolinks:load", () => {
  console.log('haitta!!2');
  const elm = document.querySelector('#OrderChat');
  if (elm) {
    ReactDOM.render( <App  />, elm)
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  console.log('haitta!!1');
  const elm = document.querySelector('#OrderChat');
  if (elm) {
    ReactDOM.render( <App  />, elm)
  }
});


