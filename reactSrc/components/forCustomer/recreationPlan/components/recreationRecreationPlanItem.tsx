import { RecreationRecreationPlan } from '@/types';
import React from 'react';

type Props = {
  recreationRecreationPlan: RecreationRecreationPlan;
};

export const RecreationRecreationPlanItem: React.FC<Props> = (props) => {
  const { recreationRecreationPlan } = props;

  return (
    <div key={recreationRecreationPlan.month}>
      <div className='row recreation-section'>
        <div className='recreation-month col-1 d-flex align-items-center justify-content-center rounded'>
          <p className='mb-0 fw-bold'>{recreationRecreationPlan.month}月</p>
        </div>
        <div className='col-3 px-2 d-flex flex-column justify-content-between'>
          <img
            src={recreationRecreationPlan.recreation.images[0].imageUrl}
            alt='recreation_image'
            className='recreation-image rounded'
          />
          <div>
            <span className='badge recreation-category'>
              {recreationRecreationPlan.recreation.category.text}
            </span>
            <span className='badge recreation-kind ms-1'>
              # {recreationRecreationPlan.recreation.kind.text}
            </span>
          </div>
        </div>
        <div className='col-8 ps-0 d-flex flex-column'>
          <a
            className='recreation-title mb-0'
            href={`/customers/recreations/${recreationRecreationPlan.recreation.id}`}
          >
            <p>{recreationRecreationPlan.recreation.title}</p>
          </a>
          <div className='d-flex mt-auto recreation-price'>
            <p className='price mb-0'>
              開催費 ¥{recreationRecreationPlan.recreation.price}円
            </p>
            <p className='price mb-0 ms-3'>
              材料費 ¥{recreationRecreationPlan.recreation.materialPrice}円/1人
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};
