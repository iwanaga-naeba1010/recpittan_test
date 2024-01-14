import { LoadingContainer } from '@/components/shared';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { RecreationPlan } from '@/types';
import { useRecreationPlan } from '../hooks';
import { RecreationRecreationPlanItem } from './recreationRecreationPlanItem';
import { RecreationPlanSection } from './recreationPlanSection';
import { TransportationExpenses } from './transportationExpenses';
import { useUserRecreationPlan } from '../hooks';
import html2canvas from 'html2canvas';
import jsPDF from 'jspdf';

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

  const handleUpdateTotalPrice = (newTotal: number) => {
    setTotalPrice(newTotal);
  };

  const handleUpdateTotalMaterialPrice = (newTotal: number): void => {
    setTotalMaterialPrice(newTotal);
  };

  const handleUpdateTotalTransportationCost = (newTotal: number): void => {
    setTotalTransportationCost(newTotal);
  };

  const grandTotal = totalPrice + totalMaterialPrice + totalTransportationCost;

  const pdhDownloadHandler = () => {
    const target = document.getElementById('pdf-content');
    if (target === null) return;

    html2canvas(target, { scale: 2.5 }).then((canvas) => {
      const imgData = canvas.toDataURL('image/svg', 1.0);
      const pdf = new jsPDF();
      pdf.addImage(
        imgData,
        'SVG',
        5,
        10,
        canvas.width / 18,
        canvas.height / 18
      );
      pdf.save(`recreation-plan.pdf`);
    });
  };

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
    <div id='pdf-content'>
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
          <form onSubmit={(e) => e.preventDefault()}>
            <label className='num-of-people mt-1' htmlFor='numberInput'>
              レクを受ける人数を入力してください
            </label>
            <br />
            <input
              type='number'
              id='numberInput'
              name='number_of_people'
              placeholder='10'
              className='form-control w-25 border-0'
              value={numberOfPeople}
              onChange={handleNumberOfPeopleChange}
              min='1'
            />
          </form>

          <div className='bg-white mt-3 p-3'>
            <RecreationPlanSection
              title='開催費'
              priceProperty='price'
              plans={recreationPlan.recreationRecreationPlans}
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
            />
            <hr />

            <div className='row'>
              <div className='col-4'>
                <p className='text-black fw-bold'>合計</p>
              </div>
              <div className='col-8 text-end text-black'>
                <p>¥{grandTotal.toLocaleString()}</p>
              </div>
            </div>
            <div className='row'>
              <div className='col-4'>
                <p className='text-black fw-bold'>利用者一人あたり</p>
              </div>
              <div className='col-8 text-end text-black'>
                <p>
                  ¥{Math.floor(grandTotal / numberOfPeople).toLocaleString()}
                </p>
              </div>
            </div>
            <p className=''>※交通費は1回あたり1000円を基準値</p>
          </div>
          <div className='mt-3 d-flex justify-content-center'>
            <button
              onClick={pdhDownloadHandler}
              className='download-button py-2 px-3 rounded fw-bold'
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
