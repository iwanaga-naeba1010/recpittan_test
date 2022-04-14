import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom'
import { get } from '../../../utils/requests/base';
import * as $ from 'jquery';
import { Order } from '../../types';
import { ExpenseForm } from './expenceForm';
import { TranspotationExpensesForm } from './transportationExpensesForm'
import { NumberOfFacilitiesForm } from './numberOfFacilitiesForm';
import {Category, Tag} from '../shared/form/parts';
import {ChatList} from './chatList';

export const App: React.FC = (): JSX.Element => {
  const [order, setOrder] = useState<Order>({} as Order);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  useEffect(() => {
    (async() => {
      const arr = window.location.pathname.split('/');
      const response = await get<Order>(`/api/orders/${arr[3]}`);
      setIsLoading(false);
      console.log({ response });
      setOrder(response);
    })()
  }, []);

  if (isLoading) {
    return <>Loading....</>;
  }

  return (
    <>
      <ChatList orderId={order.id} />
      <article className="container py-4 px-0">
        <div className="row">
          <div className="col-md-4">
          <a href={`/customers/orders/${order.id}`} className="clink">
            <i className="material-icons ">navigate_before</i> 戻る
          </a>
            <div className="row align-items-center mt-2">
              <div className="col-md-4">
                <picture>
                  <img src={order.recreation?.image_url} alt="" className='img-fluid' />
                </picture>
              </div>
              <div className="col-md-7 recreation">
                <h1 className="title-b line-height-140">{order.recreation?.title}</h1>
                <div className="category-tags">
                  <Category id={order.recreation?.category_id} name={order.recreation?.category}/>
                  {order.recreation?.tags.map((tag) => <Tag id={tag.id} name={tag.name} />)}
                </div>
              </div>
            </div>
            <div className="card mt-3">
              <div className="card-body p-0">
                {order.recreation?.category &&
                  <div className="border-bottom p-2">
                    <h4 className="title">
                      参加人数制限
                      {order.recreation?.capacity}
                      人まで
                    </h4>
                  </div>
                }
                <div className="border-bottom p-2">
                  <h4 className="title">所要時間 {order.recreation?.minutes}分</h4>
                </div>
                <div className="p-2">
                  <h4 className="title">対象者目安</h4>
                  {order.recreation?.targets.map((target) => <div className="text-muted">・{target.name}</div>)}
                </div>
                <div className="p-2">
                  <a href={`/customers/recreations/${order.recreation?.id}`} target="_blank" className='clink'>
                    <span className="material-icons-text">レクの詳細を見る</span>
                    <i className="material-icons ">navigate_next</i>
                  </a>
                </div>
              </div>
            </div>

            <div className="card mt-3">
              <h3 className="title-b p-3">レク費用</h3>
              <div className="card-body py-0">
                <div className="row justify-content-between border-bottom-dotted pb-2">
                  <div className="col-auto">開催費</div>
                  <div className="col-auto">&yen;
                    {order.price?.toLocaleString()}
                  </div>
                </div>

                <div className="row justify-content-between border-bottom-dotted py-2">
                  <div className="col-auto">材料費/1人<br/>
                    <span
                      className="text-muted font-12 color-ba08">※材料費は人数分の費用が発生します
                    </span>
                  </div>
                  <div className="col-auto">&yen;
                    {order.material_price?.toLocaleString()}
                  </div>
                </div>
                <ExpenseForm order={order} setOrder={setOrder} />
                <TranspotationExpensesForm order={order} setOrder={setOrder} />
                <NumberOfFacilitiesForm order={order} setOrder={setOrder} />
                <div className="row justify-content-between border-top py-3">
                  <div className="col-auto">合計(税別)</div>
                  <div id="totalPriceForSidenav" className="col-auto">&yen;
                    { order.total_price_for_customer?.toLocaleString() }
                  </div>
                </div>

                <div className="row justify-content-center py-3">
                  <div className="col-auto">
                    {order.status <= 30
                      ? (
                        <button id="order-modal" className="btn-cpr" data-bs-toggle="modal" data-bs-target="#orderModal">
                          レクを正式依頼へ進む
                        </button>
                        )
                      : (
                        <button className="btn-cpr disabled">正式依頼済みです</button>
                      )
                    }
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/*<%= render 'shared/customer/order/chat', order: @order, chat: @chat %> */}
         </div>
        {/*<%= render 'shared/customer/order/order_modal', order: @order %>*/}
      </article>
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
