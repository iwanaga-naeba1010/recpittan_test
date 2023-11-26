import * as React from 'react';
import { RecreationRecreationPlan } from '@/types';

type PriceProperty = 'price' | 'materialPrice';

type Props = {
  recreationRecreationPlan: RecreationRecreationPlan;
  priceProperty: PriceProperty;
  numberOfPeople: number; // PropsにnumberOfPeopleを追加
};

export const RecreationPlanDetail: React.FC<Props> = ({
  recreationRecreationPlan,
  priceProperty,
  numberOfPeople,
}) => {
  const unitPrice = recreationRecreationPlan.recreation[priceProperty];
  let totalPrice = unitPrice;

  if (priceProperty === 'materialPrice') {
    totalPrice *= numberOfPeople;
  }

  if (typeof unitPrice !== 'number' || unitPrice === 0) {
    return null;
  }

  return (
    <div className='row'>
      <div className='col-6 row align-items-center'>
        <div className='col-8 d-flex justify-content-between'>
          <p>{recreationRecreationPlan.recreation.title}</p>
        </div>
        {priceProperty === 'materialPrice' && (
          <>
            <div className='col-2 d-flex justify-content-between'>
              <p>×</p>
            </div>
            <div className='col-2'>
              <p>人数</p>
              <p>{numberOfPeople}人</p>
            </div>
          </>
        )}
      </div>
      <div className='col-6 row align-items-center'>
        <div className='col-6'></div>
        <div className='col-6 d-flex justify-content-between'>
          <p>¥{totalPrice.toLocaleString()}</p>
        </div>
      </div>
    </div>
  );
};
