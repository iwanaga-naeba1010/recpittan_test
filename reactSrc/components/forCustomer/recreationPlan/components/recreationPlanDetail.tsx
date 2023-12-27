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
  const [totalPrice, setTotalPrice] = React.useState(unitPrice);

  React.useEffect(() => {
    if (priceProperty === 'materialPrice') {
      setTotalPrice(unitPrice * numberOfPeople);
    }
  }, [unitPrice, numberOfPeople, priceProperty]);

  if (typeof unitPrice !== 'number' || unitPrice === 0) {
    return null;
  }

  return (
    <div className='row'>
      <div className='col-6 align-items-center'>
        {(priceProperty === 'materialPrice' && (
          <div className='row'>
            <div className='col-8 d-flex justify-content-between'>
              <p>
                {recreationRecreationPlan.recreation.title} <br /> ¥
                {recreationRecreationPlan.recreation.materialPrice.toLocaleString()}{' '}
                / 1人あたり
              </p>
            </div>
            <div className='col-2 d-flex justify-content-between'>
              <p>×</p>
            </div>
            <div className='col-2'>
              <p>人数</p>
              <p>{numberOfPeople}人</p>
            </div>
          </div>
        )) || (
          <div className='row'>
            <div className='col-12 d-flex justify-content-between'>
              <p>{recreationRecreationPlan.recreation.title}</p>
            </div>
          </div>
        )}
      </div>
      <div className='col-6 align-items-center d-flex justify-content-end'>
        <p>¥{totalPrice.toLocaleString()}</p>
      </div>
    </div>
  );
};
