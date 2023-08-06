import { ModalForm } from '@/components/shared';
import { ExpenseForm } from '@/components/shared/form/forCustomer/orderChat/expenceForm';
import { NumberOfFacilitiesForm } from '@/components/shared/form/forCustomer/orderChat/numberOfFacilitiesForm';
import { TransportationExpensesForm } from '@/components/shared/form/forCustomer/orderChat/transportationExpensesForm';
import {
  Category,
  LoadingIndicator,
  SuccessFlash,
  Tag,
} from '@/components/shared/parts';
import { Order, User } from '@/types';
import {
  getQeuryStringValueByKey,
  removeQueryStringsByKey,
  strToBool,
} from '@/utils';
import * as $ from 'jquery';
import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom';
import { ChatList } from './chatList';
import { useOrder } from '../hooks';
import { useUser } from '../../hooks';

export const OrderChat: React.FC = () => {
  const [order, setOrder] = useState<Order>();
  const [user, setUser] = useState<User>();
  const [isShowFlash, setIsShowFlash] = useState<boolean>(false);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const id = window.location.pathname.split('/')[3];
  const { fetchOrder } = useOrder();
  const { fetchUser } = useUser();

  useEffect(() => {
    const isShowFlashParam = getQeuryStringValueByKey('isShowFlash');
    setIsShowFlash(isShowFlashParam ? strToBool(isShowFlashParam) : false);
    removeQueryStringsByKey();
    (async () => {
      if (id === undefined) return;
      setOrder(await fetchOrder(Number(id)));
      setUser(await fetchUser());
      setIsLoading(false);
    })();
  }, [id]);

  if (isLoading) {
    return (
      <div className='container'>
        <div className='d-flex justify-content-center'>
          <LoadingIndicator />
        </div>
      </div>
    );
  }

  if (!order || !user) {
    return <></>;
  }

  return (
    <>
      <article className='container py-4 px-0'>
        <div className='row'>
          <div className='col-md-4'>
            <a href={`/customers/orders/${order.id}`} className='clink'>
              <i className='material-icons '>navigate_before</i> 戻る
            </a>
            <div className='row align-items-center mt-2'>
              <div className='col-md-4'>
                <picture>
                  <img
                    src={order.recreation?.imageUrl}
                    alt=''
                    className='img-fluid'
                  />
                </picture>
              </div>
              <div className='col-md-7 recreation'>
                <h1 className='title-b line-height-140'>
                  {order.recreation?.title}
                </h1>
                <div className='category-tags'>
                  <Category
                    id={order.recreation?.category.id}
                    name={order.recreation?.category.text}
                  />
                  {order.recreation?.tags.map((tag) => (
                    <Tag key={tag.id} id={tag.id} name={tag.name} />
                  ))}
                </div>
              </div>
            </div>
            <div className='card mt-3'>
              <div className='card-body p-0'>
                {order.recreation?.category && (
                  <div className='border-bottom p-2'>
                    <h4 className='title'>
                      参加人数制限
                      {order.recreation?.capacity === 0 ||
                      order.recreation?.capacity === null
                        ? 'なし'
                        : `${order.recreation?.capacity}人まで`}
                    </h4>
                  </div>
                )}
                <div className='border-bottom p-2'>
                  <h4 className='title'>
                    所要時間 {order.recreation?.minutes}分
                  </h4>
                </div>
                <div className='p-2'>
                  <h4 className='title'>対象者目安</h4>
                  {[...order.recreation?.targets]
                    .sort((a, b) => a.id - b.id)
                    .map((target) => (
                      <div key={target.id} className='text-muted'>
                        ・{target.name}
                      </div>
                    ))}
                </div>
                <div className='p-2'>
                  <a
                    href={`/customers/recreations/${order.recreation?.id}`}
                    target='_blank'
                    className='clink'
                    rel='noreferrer'
                  >
                    <span className='material-icons-text'>
                      レクの詳細を見る
                    </span>
                    <i className='material-icons '>navigate_next</i>
                  </a>
                </div>
              </div>
            </div>

            <div className='card mt-3'>
              <h3 className='title-b p-3'>レク費用</h3>
              <div className='card-body py-0'>
                <div className='row justify-content-between border-bottom-dotted pb-2'>
                  <div className='col-auto'>開催費</div>
                  <div className='col-auto'>
                    &yen;
                    {order.price?.toLocaleString()}
                  </div>
                </div>

                <div className='row justify-content-between border-bottom-dotted py-2'>
                  <div className='col-auto'>
                    材料費/1人
                    <br />
                    <span className='text-muted font-12 color-ba08'>
                      ※材料費は人数分の費用が発生します
                    </span>
                  </div>
                  <div className='col-auto'>
                    &yen;
                    {order.materialPrice?.toLocaleString()}
                  </div>
                </div>
                <ExpenseForm order={order} setOrder={setOrder} />
                {order.recreation.kind.key === 'visit' && (
                  <TransportationExpensesForm
                    order={order}
                    setOrder={setOrder}
                  />
                )}
                {order.recreation.kind.key === 'online' && (
                  <NumberOfFacilitiesForm order={order} setOrder={setOrder} />
                )}
                <div className='row justify-content-between border-top py-3'>
                  <div className='col-auto'>合計(税別)</div>
                  <div id='totalPriceForSidenav' className='col-auto'>
                    &yen;
                    {order.totalPriceForCustomer?.toLocaleString()}
                  </div>
                </div>

                <div className='row justify-content-center py-3'>
                  <div className='col-auto'>
                    {order.isEditable ? (
                      <button
                        id='order-modal'
                        className='btn-cpr'
                        data-bs-toggle='modal'
                        data-bs-target='#orderModal'
                      >
                        レクを正式依頼へ進む
                      </button>
                    ) : (
                      <button className='btn-cpr disabled'>
                        正式依頼済みです
                      </button>
                    )}
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div className='col-md-7'>
            {isShowFlash && (
              <SuccessFlash message='相談を開始しました。チャットが返信されるまでお待ちください。' />
            )}
            <ChatList user={user} order={order} />
          </div>
        </div>
      </article>
      {/* NOTE(okubo): html経由で読んでる */}
      <ModalForm recreation={order.recreation} order={order} />
    </>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#OrderChat');
  if (elm) {
    ReactDOM.render(<OrderChat />, elm);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#OrderChat');
  if (elm) {
    ReactDOM.render(<OrderChat />, elm);
  }
});
