import * as React from 'react';
import { RecreationRecreationPlan } from '@/types';
import { calculateTotal } from '../util/calculateTotal';

type Props = {
  plans: RecreationRecreationPlan[];
  property: 'price' | 'materialPrice';
  title: string;
};

export const TotalSection: React.FC<Props> = ({ plans, property, title }) => {
  const total = calculateTotal(plans, property);
  // 合計が0の場合は表示しない
  if (total === 0) return null;

  return (
    <div className='row text-black'>
      <div className='col-md-6'>
        <p>{title}</p>
      </div>
      <div className='col-md-6'>
        <p>¥{total.toLocaleString()}</p>
      </div>
    </div>
  );
};
