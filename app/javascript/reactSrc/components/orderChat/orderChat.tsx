/**
 * recreationのorderの交通費・諸経費のform
 */

import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { get, put } from '../../../utils/requests/base';
import * as $ from 'jquery';
import { Order } from '../../../types';
import {ExpenseForm, ExpenseFormValues} from './expenceForm';

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

  // NOTE: それぞれの箇所でid指定だとかなり大変なので、chat.html.erbの画面下部にdummyのHTMLを用意し、そこから取得
  // const applyExpenses = () => {
  //   const regularPrice: number = Number($('#regularPrice').text());
  //   const regularMaterialPrice: number = Number($('#regularMaterialPrice').text());
  //   const expensesPrice: number = Number($('#expensesPrice').text());
  //   const transportationExpensesPrice: number = Number($('#transportationExpensesPrice').text());
  //   const totalPrice: string = '¥' + (regularPrice + regularMaterialPrice + expensesPrice + transportationExpensesPrice).toLocaleString();
  //   // NOTE: サイドバーの合計金額
  //   $('#totalPriceForSidenav').text(totalPrice);
  //   // NOTE: 正式依頼の合計金額
  //   $('#expensesForOrderForm').text('¥' + expensesPrice.toLocaleString());
  //   $('#transportationExpensesForOrderForm').text('¥' + transportationExpensesPrice.toLocaleString());
  //   $('#totalPriceForOrderForm').text(totalPrice);
  // }
  //
  // const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
  //   setExpense(Number(e.target.value));
  //   if (target === 'expenses') {
  //     $('#expensesPrice').text(Number(e.target.value));
  //   } else {
  //     $('#transportationExpensesPrice').text(Number(e.target.value));
  //   }
  //   applyExpenses();
  // }

  return (
    <>
      aaa
      <ExpenseForm order={order} />
      aaa
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


