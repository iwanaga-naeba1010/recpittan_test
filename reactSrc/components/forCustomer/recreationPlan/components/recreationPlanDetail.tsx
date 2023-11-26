import * as React from 'react';
import { RecreationRecreationPlan } from '@/types';

type PriceProperty = 'price' | 'materialPrice';

type Props = {
  recreationRecreationPlan: RecreationRecreationPlan;
  priceProperty: PriceProperty;
};

export const RecreationPlanDetail: React.FC<Props> = ({
  recreationRecreationPlan,
  priceProperty,
}) => {
  const price = recreationRecreationPlan.recreation[priceProperty];

  // 'price' の型が数値であることを確認し、0の場合は何も表示しない
  if (typeof price !== 'number' || price === 0) {
    return null;
  }

  return (
    <div className='row'>
      <div className='col-md-6'>
        <p>{recreationRecreationPlan.recreation.title}</p>
      </div>
      <div className='col-md-6'>
        <p>¥{price.toLocaleString()}</p>
      </div>
    </div>
  );
};
