import React, { useEffect } from 'react';
import { RecreationRecreationPlan } from '@/types';

interface Props {
  plans: RecreationRecreationPlan[];
  onTotalUpdate: (newTotal: number) => void;
}

export const TransportationExpenses: React.FC<Props> = ({
  plans,
  onTotalUpdate,
}) => {
  const transportationCostPerVisit = 1000;
  const visitCount = plans.reduce(
    (count, plan) => (plan.recreation.kind.key === 'visit' ? count + 1 : count),
    0
  );
  const totalTransportationCost = transportationCostPerVisit * visitCount;

  useEffect(() => {
    onTotalUpdate(totalTransportationCost);
  }, [totalTransportationCost, onTotalUpdate]);

  if (visitCount === 0) return null;

  return (
    <div className='row align-items-center'>
      <div className='col-4 d-flex justify-content-between'>
        <p>交通費</p>
      </div>
      <div className='col-8'>
        <div className='row'>
          <div className='col-6 row'>
            <div className='col-6'>
              <p>1回の交通費</p>
              <p>¥{transportationCostPerVisit.toLocaleString()}</p>
            </div>
            <div className='col-6'>
              <p>レク回数</p>
              <p>{visitCount}回</p>
            </div>
          </div>
          <div className='col-6 row align-items-center'>
            <div className='col-6 d-flex justify-content-between'>
              <p>=</p>
            </div>
            <div className='col-6 d-flex justify-content-between'>
              <p>¥{totalTransportationCost.toLocaleString()}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
