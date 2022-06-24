import { Essential } from '@/components/shared/parts/essential';
import React from 'react';

type Props = {
  imageUrl?: string;
};

export const RecreationImage: React.FC<Props> = (props) => {
  const { imageUrl } = props;
  return (
    <div className='col-4'>
      {imageUrl ? (
        <p className='py-5 text-center text-primary font-weight-bold border'>
          <img src={imageUrl} height={100} width={100} />
          削除
        </p>
      ) : (
        <div className='d-flex mt-4'>
          <p className='w-25 py-5 100 text-center text-primary font-weight-bold border'>+</p>
          <Essential />
        </div>
      )}
    </div>
  );
};
