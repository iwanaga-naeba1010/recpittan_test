import * as React from 'react';
import { RecreationRecreationPlan } from '@/types';
import { RecreationPlanDetail } from './recreationPlanDetail';
import { TotalSection } from './totalSection';

type Props = {
  title: string;
  priceProperty: 'price' | 'materialPrice';
  plans: RecreationRecreationPlan[];
};

export const RecreationPlanSection: React.FC<Props> = (props) => {
  const { title, priceProperty, plans } = props;

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
              />
            ))
          ) : (
            <div className='m-3'>
              <p>レクリエーションが登録されていません</p>
            </div>
          )}
          <TotalSection
            title={`${title}合計`}
            plans={plans}
            property={priceProperty}
          />
        </div>
      </div>
    </>
  );
};
