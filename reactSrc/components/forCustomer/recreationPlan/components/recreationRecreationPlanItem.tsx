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
        <div className='month col-1 d-flex align-items-center justify-content-center'>
          <p className='mb-0 fw-bold'>{recreationRecreationPlan.month}月</p>
        </div>
        <div className='col-3 px-2 d-flex flex-column justify-content-between'>
          <img src={recreationRecreationPlan.recreation.images[0].imageUrl} alt="recreation_image" className='recreation-image rounded' />
          <div>
            <span className='badge bg-primary'>{recreationRecreationPlan.recreation.category.text}</span>
            <span className='badge bg-primary ms-1'>{recreationRecreationPlan.recreation.kind.text}</span>
          </div>
        </div>
        <div className='col-8 ps-0'>
          <p className='title mb-0'>{recreationRecreationPlan.recreation.title}</p>
          <div className='d-flex pt-2'>
            <p className='price mb-0'>開催費 {recreationRecreationPlan.recreation.price}円</p>
            <p className='price mb-0 ps-3'>材料費 {recreationRecreationPlan.recreation.materialPrice}円</p>
          </div>
        </div>
      </div>
    </div>
  );
};