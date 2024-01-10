import { LoadingContainer } from '@/components/shared';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { UserRecreationPlan } from '@/types';
import { useUserRecreationPlan } from '../hooks';
import { UserRecreationRecreationPlanItem } from './userRecreationRecreationPlanItem';

const RecreationPlanShow: React.FC = () => {
  const [userRecreationPlan, setUserRecreationPlan] =
    useState<UserRecreationPlan>();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { fetchUserRecreationPlan } = useUserRecreationPlan();
  const id = window.location.pathname.split('/')[3];

  useEffect(() => {
    (async () => {
      if (!id || userRecreationPlan) return;
      try {
        const userRecreationPlanResponse = await fetchUserRecreationPlan(id);
        setUserRecreationPlan({ ...userRecreationPlanResponse });
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, [id]);

  if (isLoading) {
    return <LoadingContainer />;
  }
  if (!userRecreationPlan) {
    return <></>;
  }
  console.log(userRecreationPlan);

  return (
    <div>
      <div className='container p-0 mt-4'>
        <div className='d-flex flex-column'>
          <h2 className='plan-title fw-bold'>{userRecreationPlan.title}</h2>
          <div className='d-flex align-items-center mt-auto'>
            <p className='plan-code mb-0'>
              プラン番号 {userRecreationPlan.code}
            </p>
          </div>
        </div>

        <p className='attention mt-4 p-3'>
          各レクの「相談を開始する」ボタンをクリックしてパートナーさんとレク実施に向けて調整を行なってください。
        </p>
      </div>

      <div className='mt-4'>
        <div className='container'>
          <div className='row'>
            {userRecreationPlan.userRecreationRecreationPlans.length ? (
              userRecreationPlan.userRecreationRecreationPlans.map(
                (userRecreationRecreationPlan) => (
                  <div
                    className='col-md-6 mb-3'
                    key={userRecreationRecreationPlan.month}
                  >
                    <UserRecreationRecreationPlanItem
                      userRecreationRecreationPlan={
                        userRecreationRecreationPlan
                      }
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
      </div>
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#userRecreationPlanShow');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationPlanShow />);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#userRecreationPlanShow');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationPlanShow />);
  }
});
