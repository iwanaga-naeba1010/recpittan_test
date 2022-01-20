/**
 * recreationのorderの交通費・諸経費のform
 */

import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { put } from '../utils/requests/base';
import * as $ from 'jquery';

interface Order {
  expenses: number;
  transportation_expenses: number;
}

interface Response {
  order: Order;
}

type TargetEnum = 'expenses' | 'transportation_expenses';

interface Props {
  orderId: number;
  defaultExpense: number;
  target: TargetEnum;
  canEdit: boolean;
}

const App: React.FC<Props> = ({ orderId, defaultExpense, target, canEdit }): JSX.Element => {
  const [expense, setExpense] = useState<number>(defaultExpense);
  const [isSent, setIsSent] = useState<boolean>(false);

  useEffect(() => {
    if (defaultExpense !== 0) {
      setIsSent(true);
    }
  }, []);

  // NOTE: それぞれの箇所でid指定だとかなり大変なので、chat.html.erbの画面下部にdummyのHTMLを用意し、そこから取得
  const applyExpenses = () => {
    const regularPrice: number = Number($('#regularPrice').text());
    const regularMaterialPrice: number = Number($('#regularMaterialPrice').text());
    const expensesPrice: number = Number($('#expensesPrice').text());
    const transportationExpensesPrice: number = Number($('#transportationExpensesPrice').text());
    const totalPrice: string = '¥' + (regularPrice + regularMaterialPrice + expensesPrice + transportationExpensesPrice).toLocaleString() + '円';
    // NOTE: サイドバーの合計金額
    $('#totalPriceForSidenav').text(totalPrice);
    // NOTE: 正式依頼の合計金額
    $('#expensesForOrderForm').text('¥' + expensesPrice.toLocaleString() + '円');
    $('#transportationExpensesForOrderForm').text('¥' + transportationExpensesPrice.toLocaleString() + '円');
    $('#totalPriceForOrderForm').text(totalPrice);
  }

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setExpense(Number(e.target.value));
    if (target === 'expenses') {
      $('#expensesPrice').text(Number(e.target.value));
    } else {
      $('#transportationExpensesPrice').text(Number(e.target.value));
    }
    applyExpenses();
  }

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>): Promise<void> => {
    const token = document.querySelector('[name=csrf-token]').getAttribute('content');
    e.preventDefault();

    let body = {};
    body[target] = expense;
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
              { target === 'expenses' ? '諸経費' : '交通費' }
              <br />
              {!canEdit && <a className="clink" onClick={() => setIsSent(false)}>編集</a> }
            </div>
            <div className="col-auto">&yen;
              { expense.toLocaleString() + '円' }
            </div>
          </div>
        )
      : (
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
                  value={ expense } onChange={(e) => handleChange(e)}
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
  const transportationExpenses = document.querySelector('#TransportationExpenseForm');
  const expenses = document.querySelector('#ExpenseForm');
  if (transportationExpenses) {
    const expense: number = Number(transportationExpenses.getAttribute('expense'));
    const target: TargetEnum = transportationExpenses.getAttribute('target') as TargetEnum;
    const orderId: number = Number(transportationExpenses.getAttribute('orderId'));
    const canEdit: boolean = transportationExpenses.getAttribute('canEdit') === 'true';

    ReactDOM.render(
      <App orderId={orderId} defaultExpense={expense} target={target} canEdit={canEdit} />,
      transportationExpenses,
    )
  }
  if (expenses) {
    const expense: number = Number(expenses.getAttribute('expense'));
    const target: TargetEnum = expenses.getAttribute('target') as TargetEnum;
    const orderId: number = Number(expenses.getAttribute('orderId'));
    const canEdit: boolean = expenses.getAttribute('canEdit') === 'true';

    ReactDOM.render(
      <App orderId={orderId} defaultExpense={expense} target={target} canEdit={canEdit} />,
      expenses,
    )
  }
})
