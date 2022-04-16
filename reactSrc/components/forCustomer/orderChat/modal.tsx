import {Api} from '@/infrastructure';
import {Order, Recreation} from '@/types';
import React from 'react';
import {useForm} from 'react-hook-form';

type Props = {
  order: Order;
  recreation: Recreation;
}

export type OrderFormValues = Pick<Order, 'status' | 'numberOfPeople' | 'numberOfFacilities'>;

export const Modal: React.FC<Props> = (props) => {
  const {order, recreation} = props;

  const {
    register,
    handleSubmit,
    setValue,
  } = useForm<OrderFormValues>({
    mode: 'onChange',
    defaultValues: {
      status: order.status,
      numberOfPeople: order.numberOfPeople
    }
  });


  const onSubmit = async (values: OrderFormValues): Promise<void> => {
    const requestBody: {[key: string]: OrderFormValues} = {
      order: {
        status: values.status,
        numberOfPeople: values.numberOfPeople,
        numberOfFacilities: values.numberOfFacilities
      }
    };

    try {
      const response = await Api.patch<Order>(`/orders/${order.id}`, 'customer', requestBody);
      {/* setOrder({ */}
      {/*   ...order, */}
      {/*   expenses: response.data.expenses, */}
      {/*   totalPriceForCustomer: response.data.totalPriceForCustomer */}
      {/* }); */}
      {/* setCanEdit(false); */}
    } catch (e) {
      {/* setCanEdit(true); */}
    }
  };

  return (
    <div className="modal" id="orderModal" tabIndex={-1} aria-labelledby="orderModalLabel" aria-hidden="true">
      <div className="modal-dialog modal-lg">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title" id="orderModalLabel">正式依頼フォーム</h5>
          </div>
          <div className="modal-body p-2">
            <form className='order h-adr'>
              <input {...register('status')} value={30} type='hidden' />
              <div className="container-fluid">
                <div className="row pb-3">
                  <div className="col-auto">
                    <h3 className="title-b p-0">開催したい希望日と時間を選択してください
                      <span className="label required">必須</span>
                    </h3>
                    <span className="text-muted">
                      パートナー都合で希望日時の開催が難しい場合がございます。事前にチャットでの開催日時の相談をお願いします。
                    </span>
                  </div>
                </div>
                <div className="date-form">
                  <div className="row">
                    <div className="col-12">希望日</div>
                    <div className="form-group col-3">
                      <select className='form-control'>
                        <option value="1">1</option>
                      </select>
                    </div>
                    <div className="col-auto p-0 flex-v-c">年</div>
                    <div className="form-group col-3">
                      <select className='form-control'>
                        <option value="1">1</option>
                      </select>
                    </div>
                    <div className="col-auto p-0 flex-v-c">月</div>
                    <div className="form-group col-3">
                      <select className='form-control'>
                        <option value="1">1</option>
                      </select>
                    </div>
                    <div className="col-auto p-0 flex-v-c">日</div>
                  </div>
                  <div className="row">
                    <div className="col-12">希望時間</div>
                    <div className="form-group col-2 pe-0">
                      <select className='form-control'>
                        <option value="1">1</option>
                      </select>
                    </div>
                    <div className="col-auto p-0 flex-v-c">:</div>
                    <div className="form-group col-2 pe-0">
                      <select className='form-control'>
                        <option value="1">1</option>
                      </select>
                    </div>
                    <div className="col-auto p-0 flex-v-c">~</div>
                    <div className="form-group col-2 pe-0">
                      <select className='form-control'>
                        <option value="1">1</option>
                      </select>
                    </div>
                    <div className="col-auto p-0 flex-v-c">:</div>
                    <div className="form-group col-2 pe-0">
                      <select className='form-control'>
                        <option value="1">1</option>
                      </select>
                    </div>
                  </div>
                </div>
                <div className="row pt-3">
                  <label className="col-12 title-b pb-3" htmlFor="participant">
                    希望人数を入力してください
                    <span className="label required">必須</span>
                  </label>
                  <div className="form-group col-3">
                    <input {...register('numberOfPeople')} className='form-control text-right' />
                  </div>
                  <div className="col-auto p-0 flex-v-c">人</div>
                </div>

                {recreation.isOnline && (
                  <div className="row pt-3">
                    <label className="col-12 title-b pb-3" htmlFor="participant">
                      追加で参加する施設がある場合施設数をご記入ください
                      <span className="label required">必須</span>
                    </label>
                    <div className="form-group col-3">
                      <input {...register('numberOfFacilities')} className='form-control text-right' />
                    </div>
                    <div className="col-auto p-0 flex-v-c">施設</div>
                  </div>
                )}

                <div className="row pt-3">
                  <span className="p-country-name" style={{display: 'none'}}>Japan</span>
                  <label className="col-12 title-b pb-3" htmlFor="participant">
                    <span>住所を入力してください</span>
                    <span className="label required">必須</span>
                  </label>
                  <div className="form-group col-6">
                    <label htmlFor="postalCode">郵便番号</label>
                    <div className="input-group mb-3">
                      <input className='form-control p-postal-control' placeholder='郵便番号を入力' />
                      <button id="searchAddressWithZipForOrder" className="btn btn-outline-secondary p-postal-code-find" type="button">検索</button>
                    </div>
                  </div>
                  <div className="form-group col-6">
                    <select className='form-control p-region'>
                      <option value="1">1</option>
                    </select>
                  </div>
                  <div className="form-group col-6">
                    <select className='form-control p-region'>
                      <option value="1">1</option>
                    </select>
                  </div>
                  <div className="form-group col-6">
                    <input className='form-control p-postal-control' />
                  </div>
                  <div className="form-group col-12">
                    <input className='form-control p-postal-control' />
                  </div>
                </div>

                <div className="card mt-3">
                  <div id="OrderForm"></div>
                  <div className="card-body">
                    <h5 className="card-title title-b">レク 費用</h5>
                    <div className="row justify-content-between border-bottom-dotted pb-2">
                      <div className="col-auto">開催費</div>
                      <div className="col-auto">&yen;
                        {order?.price?.toLocaleString()}
                      </div>
                    </div>
                    <div className="row justify-content-between border-bottom-dotted py-2">
                      <div className="col-auto">
                        <span id="participantNum">材料費/1人</span>
                        <br />
                        <span className="text-muted font-12 color-ba08">※材料費は人数分の費用が発生します</span>
                      </div>
                      <div id="materialPrice" className="col-auto">&yen;
                        {order?.materialPrice?.toLocaleString()}
                      </div>
                    </div>
                    <div className="row justify-content-between border-bottom-dotted pb-2">
                      <div className="col-auto">交通費</div>
                      <div id="transportationExpensesForOrderForm" className="col-auto">&yen;
                        {order?.transportationExpenses?.toLocaleString()}
                      </div>
                    </div>
                    <div className="row justify-content-between border-bottom-dotted pb-2">
                      <div className="col-auto">諸経費</div>
                      <div id="expensesForOrderForm" className="col-auto">&yen;
                        {order?.expenses?.toLocaleString()}
                      </div>
                    </div>

                    {recreation.isOnline && (
                      <div className="row justify-content-between border-bottom-dotted pb-2">
                        <div className="col-auto">
                          追加施設費 /
                          <span id="numberOfFacilitiesForOrderFormLabel">
                            {order.numberOfFacilities} 施設
                          </span>
                        </div>
                        <div id="numberOfFacilitiesForOrderForm" className="col-auto">
                          {order?.totalFacilityPriceForCustomer?.toLocaleString()}
                        </div>
                      </div>
                    )}

                    <div className="row justify-content-between border-top py-3">
                      <div className="col-auto">合計(税別)</div>
                      <div id="totalPriceForOrderForm" className="col-auto">
                        {order?.totalPriceForCustomer?.toLocaleString()}
                      </div>
                    </div>
                  </div>
                </div>

                <div className="card mt-4">
                  <div className="card-body">
                    <h5 className="card-title title-b">注意事項</h5>
                    <p>・一度承認されたレクのキャンセルはできません。規約に準じた日程の変更は可能です。詳しくは利用規約をご確認ください。</p>
                    <p>・材料費、オンラインレクの追加施設数、諸経費は開催までの間にパートナーとチャットで相談をして変更することが可能です。その場合、金額の変動がございます。
                    </p>
                    <p>・材料費が必要なレクは参加人数が増える場合や減る場合はパートナーとチャット相談をしてくださ　い。人数が減る場合、レクによっては準備した分の材料費分の請
                      求が発生する場合がございます。詳しくはパートナーにご確認をお願い致します。</p>
                  </div>
                </div>
                <div className="row justify-content-center py-3">
                  <div className="col-7 mb-3 text-center">
                    <span className="text-muted">※パートナーが承認をする事で正式に開催が決まります</span>
                  </div>
                  <div className="col-7 text-center">
                    <button type='submit' className='btn btn-cprimary rounded-pill font-14 py-3 px-4 font-weight-bold text-white'>
                      パートナーにレク開催を正式依頼する
                    </button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  )
}
