import { LoadingContainer } from '@/components/shared';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { RecreationPlan } from '@/types';
import { useRecreationPlan } from '../hooks';
import { RecreationRecreationPlanItem } from './recreationRecreationPlanItem';
import { RecreationPlanSection } from './recreationPlanSection';
import { AdjustmentFeeSection } from './adjustmentFeeSection';
import { TransportationExpenses } from './transportationExpenses';
import { useUserRecreationPlan, useRecreationPlanEstimate } from '../hooks';

const RecreationPlanShow: React.FC = () => {
  const [recreationPlan, setRecreationPlan] = useState<RecreationPlan>();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [numberOfPeople, setNumberOfPeople] = useState(10);
  const { fetchRecreationPlan } = useRecreationPlan();
  const handleNumberOfPeopleChange = (
    event: React.ChangeEvent<HTMLInputElement>
  ): void => {
    setNumberOfPeople(parseInt(event.target.value, 10) || 0);
  };
  const [totalPrice, setTotalPrice] = useState(0);
  const [totalMaterialPrice, setTotalMaterialPrice] = useState(0);
  const [totalTransportationCost, setTotalTransportationCost] = useState(0);
  const id = window.location.pathname.split('/')[3];
  const { postUserRecreationPlan } = useUserRecreationPlan();
  const { postRecreationPlanEstimate } = useRecreationPlanEstimate();
  const [startMonth, setStartMonth] = useState<number>(1);
  const [transportationExpenses, setTransportationExpenses] =
    useState<number>(1000);

  const handleUpdateTotalPrice = (newTotal: number) => {
    setTotalPrice(newTotal);
  };

  const handleUpdateTotalMaterialPrice = (newTotal: number): void => {
    setTotalMaterialPrice(newTotal);
  };

  const handleUpdateTotalTransportationCost = (newTotal: number): void => {
    setTotalTransportationCost(newTotal);
  };

  const handleStartMonthChange = (
    event: React.ChangeEvent<HTMLSelectElement>
  ) => {
    setStartMonth(parseInt(event.target.value, 10));
  };

  // 交通費の入力変更ハンドラ
  const handleTransportationExpensesChange = (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    setTransportationExpenses(parseInt(event.target.value, 10) || 0);
  };

  const grandTotalWithoutConsumptionTax =
    totalPrice +
    totalMaterialPrice +
    totalTransportationCost +
    (recreationPlan?.adjustmentFee || 0);

  useEffect(() => {
    (async () => {
      if (!id || recreationPlan) return; // 追加: recreationPlanが既に設定されている場合は実行しない
      try {
        const recreationPlanResponse = await fetchRecreationPlan(id);
        setRecreationPlan({ ...recreationPlanResponse });
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, [id]);

  if (isLoading) {
    return <LoadingContainer />;
  }
  if (!recreationPlan) {
    return <></>;
  }

  const monthRange = recreationPlan.recreationRecreationPlans.reduce(
    (acc, curr) => {
      const monthAsNumber = parseInt(curr.month, 10);
      if (acc.min > monthAsNumber || acc.min === 0) acc.min = monthAsNumber;
      if (acc.max < monthAsNumber) acc.max = monthAsNumber;
      return acc;
    },
    { min: 0, max: 0 }
  );
  const months = monthRange.max - monthRange.min + 1;

  const handleCreateRecreationPlanEstimate = async () => {
    if (recreationPlan?.id) {
      try {
        const response = await postRecreationPlanEstimate(
          startMonth,
          numberOfPeople,
          transportationExpenses,
          recreationPlan.id
        );
        if (response.redirectUrl) {
          window.open(response.redirectUrl, '_blank');
        }
      } catch (e) {
        if (e instanceof Error) {
          throw new Error(e.message);
        } else {
          throw new Error('An unexpected error occurred.');
        }
      }
    }
  };

  const handleStartConsultation = async () => {
    if (recreationPlan?.id) {
      try {
        const response = await postUserRecreationPlan(recreationPlan.id);
        console.log(response);
        if (response.redirectUrl) {
          window.location.href = response.redirectUrl;
        }
      } catch (e) {
        if (e instanceof Error) {
          throw new Error(e.message);
        } else {
          throw new Error('An unexpected error occurred.');
        }
      }
    }
  };

  return (
    <div id='pdf-download-elm'>
      <div className='container mt-4'>
        <div className='row'>
          <div className='col-3 ps-0'>
            <img
              src={
                recreationPlan.recreationRecreationPlans[0].recreation.images[0]
                  .imageUrl
              }
              alt='画像'
              className='plan-thumbnail rounded'
            />
          </div>
          <div className='col-9 d-flex flex-column'>
            <h2 className='plan-title fw-bold'>{recreationPlan.title}</h2>
            <div className='d-flex align-items-center mt-auto'>
              <p className='plan-code mb-0'>プラン番号 {recreationPlan.code}</p>
              <button
                className='ms-auto register-button text-white p-2 rounded'
                onClick={handleStartConsultation}
              >
                プランを保存する
              </button>
            </div>
          </div>
        </div>
      </div>

      <div className='mt-5'>
        <h5 className='text-dark fw-bold'>プラン内容</h5>
        <hr className='my-2' />
        <div className='container'>
          <div className='row'>
            {recreationPlan.recreationRecreationPlans.length ? (
              recreationPlan.recreationRecreationPlans.map(
                (recreationRecreationPlan) => (
                  <div
                    className='col-md-6 mb-3'
                    key={recreationRecreationPlan.month}
                  >
                    <RecreationRecreationPlanItem
                      recreationRecreationPlan={recreationRecreationPlan}
                    />
                  </div>
                )
              )
            ) : (
              <div className='m-3'>
                <p>レクリエーションが登録されていません</p>
              </div>
            )}
          </div>
        </div>
        <div className='estimate p-3'>
          <h5 className='text-black fw-bold'>お見積もり</h5>
          <p>お見積もり金額をシミュレーションできます</p>

          {/* formを集めた親クラス */}
          <div className='bg-white p-3 '>
            <div className='row'>
              <p className='text-black fw-bold'>
                お見積りをするために必要な項目を入力してください
              </p>
              <div className='col-3'>
                <form onSubmit={(e) => e.preventDefault()}>
                  <label className='mt-1' htmlFor='numberInput'>
                    レクを受ける人数を入力
                    <span className='ms-2 text-danger'>必須</span>
                  </label>
                  <br />
                  <input
                    type='number'
                    id='numberInput'
                    name='number_of_people'
                    placeholder='10'
                    className='form-control w-100 mt-1'
                    value={numberOfPeople}
                    onChange={handleNumberOfPeopleChange}
                    min='1'
                  />
                </form>
              </div>
              <div className='col-3'>
                <form onSubmit={(e) => e.preventDefault()}>
                  <label className='mt-1' htmlFor='numberInput'>
                    レクの開始月を選択
                    <span className='ms-2 text-danger'>必須</span>
                  </label>
                  <br />
                  {/* 1から12までのselect form */}
                  <select
                    className='form-select w-100 mt-1'
                    value={startMonth}
                    onChange={handleStartMonthChange}
                  >
                    {Array.from({ length: 12 }, (_, i) => i + 1).map(
                      (month) => (
                        <option key={month} value={month}>
                          {month}月
                        </option>
                      )
                    )}
                  </select>
                </form>
              </div>
              <div className='col-3'>
                <form>
                  <label className='mt-1' htmlFor='numberInput'>
                    1回の交通費を入力
                    <span className='ms-2 text-danger'>必須</span>
                  </label>
                  <input
                    type='number'
                    className='form-control w-100 mt-1'
                    value={transportationExpenses}
                    onChange={handleTransportationExpensesChange}
                  />
                </form>
              </div>
            </div>
          </div>

          <div className='bg-white mt-3 p-3'>
            <h2 className='plan-title fw-bold'>{recreationPlan.title}</h2>
            <p className='plan-code mb-0'>プラン番号 {recreationPlan.code}</p>
            <hr />
            <RecreationPlanSection
              title='開催費'
              priceProperty='price'
              plans={recreationPlan.recreationRecreationPlans}
              numberOfPeople={numberOfPeople}
              startMonth={startMonth}
              onTotalUpdate={handleUpdateTotalPrice}
            />
            <hr />
            <RecreationPlanSection
              title='材料費'
              priceProperty='materialPrice'
              plans={recreationPlan.recreationRecreationPlans}
              numberOfPeople={numberOfPeople}
              onTotalUpdate={handleUpdateTotalMaterialPrice}
            />
            <hr />
            <TransportationExpenses
              plans={recreationPlan.recreationRecreationPlans}
              onTotalUpdate={handleUpdateTotalTransportationCost}
              transportationCostPerVisit={transportationExpenses}
            />
            <hr />
            {recreationPlan.adjustmentFee && (
              <>
                <AdjustmentFeeSection
                  adjustmentFee={recreationPlan.adjustmentFee}
                />
                <hr />
              </>
            )}

            <div className='row'>
              <div className='col-4'>
                <p className='text-black'>小計</p>
              </div>
              <div className='col-8 text-end text-black'>
                <p>¥{grandTotalWithoutConsumptionTax.toLocaleString()}</p>
              </div>
            </div>
            <div className='row'>
              <div className='col-4'>
                <p className='text-black'>消費税</p>
              </div>
              <div className='col-8 text-end text-black'>
                <p>
                  ¥{(grandTotalWithoutConsumptionTax * 0.1).toLocaleString()}
                </p>
              </div>
            </div>
            <div className='row'>
              <div className='col-4'>
                <p className='text-black fw-bold'>合計</p>
              </div>
              <div className='col-8 text-end text-black'>
                <p>
                  ¥{(grandTotalWithoutConsumptionTax * 1.1).toLocaleString()}
                </p>
              </div>
            </div>
            <div className='row'>
              <div className='col-4'>
                <p className='text-black fw-bold'>利用者一人あたり</p>
              </div>
              <div className='col-8 text-end text-black'>
                <p>
                  ¥
                  {Math.floor(
                    (grandTotalWithoutConsumptionTax * 1.1) / numberOfPeople
                  ).toLocaleString()}
                </p>
              </div>
            </div>

            <div className='row'>
              <div className='col-4'>
                <p className='text-black fw-bold'>一月あたり</p>
              </div>
              <div className='col-8 text-end text-black'>
                <p>
                  ¥
                  {Math.floor(
                    (grandTotalWithoutConsumptionTax * 1.1) / months
                  ).toLocaleString()}
                </p>
              </div>
            </div>
          </div>
          <div className='mt-3 d-flex justify-content-center'>
            <button
              className='download-button py-2 px-3 rounded fw-bold'
              onClick={handleCreateRecreationPlanEstimate}
            >
              プランの見積もりをダウンロードする
            </button>
          </div>
        </div>
        <div className='mt-4 d-flex justify-content-center'>
          <button
            className='order-start-button text-white p-3 rounded fw-bold'
            onClick={handleStartConsultation}
          >
            このプランで相談をはじめる
          </button>
        </div>
        <p className='my-4'>
          ※ボタンを押しても依頼の決定にはなりません。次のページで各レク毎に「相談を開始する」より日程調整を行います。
        </p>
      </div>
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#recreationPlanShow');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationPlanShow />);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#recreationPlanShow');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationPlanShow />);
  }
});
