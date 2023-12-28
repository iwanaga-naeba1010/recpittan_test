import React, { useEffect, useState } from 'react';
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
  const [total, setTotal] = useState(0);

  useEffect(() => {
    const newTotal =
      property === 'materialPrice'
        ? plans.reduce(
            (sum, plan) => sum + plan.recreation.materialPrice * numberOfPeople,
            0
          )
        : plans.reduce((sum, plan) => sum + plan.recreation[property], 0);

    setTotal(newTotal);
    onTotalUpdate(newTotal);
  }, [plans, property, numberOfPeople, onTotalUpdate]);

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
