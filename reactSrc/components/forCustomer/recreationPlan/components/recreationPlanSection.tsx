import React from 'react';
import { RecreationRecreationPlan } from '@/types';
import { RecreationPlanDetail } from './recreationPlanDetail';
import { TotalSection } from './totalSection';

type Props = {
  title: string;
  priceProperty: 'price' | 'materialPrice';
  plans: RecreationRecreationPlan[];
  numberOfPeople?: number;
  onTotalUpdate: (newTotal: number) => void;
};

export const RecreationPlanSection: React.FC<Props> = ({
  title,
  priceProperty,
  plans,
  numberOfPeople = 0,
  onTotalUpdate,
}) => {
  return (
    <>
      <div className='row'>
        <div className='col-4'>
          <p>{title}</p>
        </div>
        <div className='col-8'>
          {plans.length ? (
            plans.map((plan) => (
              <RecreationPlanDetail
                key={plan.month}
                recreationRecreationPlan={plan}
                priceProperty={priceProperty}
                numberOfPeople={numberOfPeople}
              />
            ))
          ) : (
            <div className='m-3'>
              <p>レクリエーションが登録されていません</p>
            </div>
          )}
          <TotalSection
            title={title}
            property={priceProperty}
            plans={plans}
            numberOfPeople={numberOfPeople}
            onTotalUpdate={onTotalUpdate}
          />
        </div>
      </div>
    </>
  );
};
