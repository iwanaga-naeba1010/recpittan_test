import { UserRecreationRecreationPlan } from '@/types';
import React from 'react';

type Props = {
  userRecreationRecreationPlan: UserRecreationRecreationPlan;
};

export const UserRecreationRecreationPlanItem: React.FC<Props> = (props) => {
  const { userRecreationRecreationPlan } = props;

  return (
    <div key={userRecreationRecreationPlan.month}>
      <div className='row recreation-section'>
        <div className='recreation-month col-1 d-flex align-items-center justify-content-center rounded'>
          <p className='mb-0 fw-bold'>{userRecreationRecreationPlan.month}月</p>
        </div>
        <div className='col-3 px-2 d-flex flex-column justify-content-between'>
          <img
            src={userRecreationRecreationPlan.recreation.images[0].imageUrl}
            alt='recreation_image'
            className='recreation-image rounded'
          />
          <div className='d-flex mt-2'>
            <span className='badge recreation-category'>
              {userRecreationRecreationPlan.recreation.category.text}
            </span>
            <span className='badge recreation-kind ms-1'>
              # {userRecreationRecreationPlan.recreation.kind.text}
            </span>
          </div>
          <a
            href={`/customers/recreations/${userRecreationRecreationPlan.recreation.id}/orders/new`}
          >
            <button className='start-consultation mt-2 fw-bold'>
              相談を開始する
            </button>
          </a>
        </div>
        <div className='col-8 ps-0'>
          <a
            className='recreation-title mb-0'
            href={`/customers/recreations/${userRecreationRecreationPlan.recreation.id}`}
          >
            <p>{userRecreationRecreationPlan.recreation.title}</p>
          </a>
          <div className='d-flex mt-auto recreation-price'>
            <p className='price mb-0'>
              開催費 ¥{userRecreationRecreationPlan.recreation.price}円
            </p>
            <p className='price mb-0 ms-3'>
              材料費 ¥{userRecreationRecreationPlan.recreation.materialPrice}
              円/1人
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};
