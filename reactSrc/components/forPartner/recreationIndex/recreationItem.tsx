import { Recreation } from '@/types';
import React from 'react';

type Props = {
  recreation: Recreation;
};

export const RecreationItem: React.FC<Props> = (props) => {
  const { recreation } = props;

  return (
    <a key={recreation.id} href={`/partners/recreations/${recreation.id}`}>
      <div className='my-2 border-bottom p-3'>
        <div className='company_name'>
          <h6 className='text-black font-weight-bold'>
            {`${recreation.title} ${recreation.secondTitle}`.slice(0, 100)}
          </h6>
        </div>
        <div className='category'>
          <p className='my-1'>{recreation.category}</p>
        </div>
        <div className='d-flex'>
          <p className='my-1 px-2 d-inline-block rounded border'>{recreation.status}</p>
          <p className='my-1 ms-auto'>{recreation.price?.toLocaleString()}</p>
        </div>
      </div>
    </a>
  );
};
