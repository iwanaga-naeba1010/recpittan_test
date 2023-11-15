import { LoadingContainer } from '@/components/shared';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { RecreationPlan } from '@/types';
import { useRecreationPlan } from '../hooks';

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
        setRecreationPlan({ ...recreationPlanResponse  });
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
      ffffffffffff
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
