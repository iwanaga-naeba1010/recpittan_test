import React, { useEffect } from 'react';
import { RecreationRecreationPlan } from '@/types';

type Props = {
  plans: RecreationRecreationPlan[];
  property: 'price' | 'materialPrice';
  title: string;
  numberOfPeople: number;
  onTotalUpdate: (newTotal: number) => void;
};

export const TotalSection: React.FC<Props> = ({
  plans,
  property,
  title,
  numberOfPeople,
  onTotalUpdate,
}) => {
  let total = 0;

  if (property === 'materialPrice') {
    total = plans.reduce(
      (sum, plan) => sum + plan.recreation.materialPrice * numberOfPeople,
      0
    );
  } else {
    total = plans.reduce((sum, plan) => sum + plan.recreation[property], 0);
  }

  useEffect(() => {
    onTotalUpdate(total);
  }, [total, onTotalUpdate]);

  if (total === 0) return null;

  return (
    <div className='row text-black'>
      <div className='col-6'>
        <p>{title}合計</p>
      </div>
      <div className='col-6 text-end'>
        <p>¥{total.toLocaleString()}</p>
      </div>
    </div>
  );
};
