import { LoadingContainer } from '@/components/shared';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { RecreationPlan } from '@/types';
import { useRecreationPlan } from '../hooks';
import { RecreationRecreationPlanItem } from './recreationRecreationPlanItem';
import { RecreationPlanSection } from './recreationPlanSection';

const RecreationPlanShow: React.FC = () => {
  const [recreationPlan, setRecreationPlan] = useState<RecreationPlan>();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { fetchRecreationPlan } = useRecreationPlan();
  const id = window.location.pathname.split('/')[3];

  useEffect(() => {
    (async () => {
      if (!id) return;
      try {
        const recreationPlanResponse = await fetchRecreationPlan(id);
        setRecreationPlan({ ...recreationPlanResponse });
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, [fetchRecreationPlan, id]);

  if (isLoading) {
    return <LoadingContainer />;
  }
  if (!recreationPlan) {
    return <></>;
  }
  console.log(recreationPlan);

  return (
    <div>
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
              <button className='ms-auto register-button text-white p-2 rounded'>
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
          <form>
            <label htmlFor='numberInput'>
              レンタルする人数を入力してください
            </label>
            <br />
            <input
              type='number'
              id='numberInput'
              name='number_of_people'
              placeholder='10'
            />
          </form>

          <div className='bg-white mt-3 p-3'>
            <RecreationPlanSection
              title='開催費'
              priceProperty='price'
              plans={recreationPlan.recreationRecreationPlans}
            />
            <RecreationPlanSection
              title='材料費'
              priceProperty='materialPrice'
              plans={recreationPlan.recreationRecreationPlans}
            />

            <div className='row'>
              <div className='col-4'>
                <p>交通費</p>
              </div>
              <div className='col-8'></div>
            </div>

            <div className='row'>
              <div className='col-4'>
                <p>合計</p>
              </div>
              <div className='col-8'></div>
            </div>
          </div>
        </div>
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
