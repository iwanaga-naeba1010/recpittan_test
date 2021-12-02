/**
 * recreationのorderの交通費のform
 */

import React, { useState } from 'react';
import ReactDOM from 'react-dom'
import { put } from '../utils/requests/base';
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
  orderId: number;
  defaultExpense: number;
  target: string;
}

const App: React.FC<Props> = ({ orderId, defaultExpense, target }): JSX.Element => {
  const [expense, setExpense] = useState<number>(defaultExpense);
  
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>): Promise<void> => {
    console.log('haitta1');
    const token = document.querySelector('[name=csrf-token]').getAttribute('content');
    e.preventDefault();

    let body = {};
    body[target] = expense;
    console.log('haitta2');
    try {
      const response = await put<any>(
        `/api/orders/${orderId}`,
        { order: body },
        { 'X-CSRF-TOKEN': token }
      );
      // TODO: 正式依頼formも修正
      // TODO: 編集modeと閲覧だけmodeを切り分ける
      console.log(response);
    } catch (e) {
    
    }
    // // NOTE: このreact fileで管理しないのでjqueryで操作
    // $('#order_prefecture').val(response.results[0].address1);
    // $('#user_company_attributes_city').val(response.results[0].address2);
    // $('#user_company_attributes_street').val(response.results[0].address3);
  }

  return (
    <form className="consult" onSubmit={(e) => handleSubmit(e)}>
      <div className="row justify-content-between border-bottom-dotted py-2">
        <div className="col-3 align-self-center">
          { target === 'expenses' ? '諸経費' : '交通費' }
        </div>
        <div className="col-7">
          <input
            id={`${target}`}
            className="form-control text-end"
            type="number"
            value={ expense } onChange={(e) => setExpense(Number(e.target.value))}
          />
        </div>

        <div className="col-2 py-0">
          <button type="submit" name="action" value="transport_upadte" className="btn btn-inline-edit">
            <i className="material-icons color-pr10">done</i>
          </button>
        </div>
      </div>
    </form>
  );
}

document.addEventListener('turbolinks:load', () => {
  const transportationExpenses = document.querySelector('#TransportationExpenseForm');
  const expenses = document.querySelector('#ExpenseForm');
  if (transportationExpenses) {
    const expense: number = Number(transportationExpenses.getAttribute('expense'));
    const target: string = transportationExpenses.getAttribute('target');
    const orderId: number = Number(transportationExpenses.getAttribute('orderId'));
    console.log('----');
    console.log(expense);
    console.log(target);
    console.log(orderId);
    ReactDOM.render(
      <App orderId={orderId} defaultExpense={expense} target={target} />,
      transportationExpenses,
    )
  }
  if (expenses) {
    const expense: number = Number(expenses.getAttribute('expense'));
    const target: string = expenses.getAttribute('target');
    const orderId: number = Number(expenses.getAttribute('orderId'));
    console.log('----');
    console.log(expense);
    console.log(target);
    console.log(orderId);
    ReactDOM.render(
      <App orderId={orderId} defaultExpense={expense} target={target} />,
      expenses,
    )
  }
})
