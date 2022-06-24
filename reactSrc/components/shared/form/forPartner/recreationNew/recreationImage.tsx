import { Essential } from '@/components/shared/parts/essential';
import React from 'react';

type Props = {
  imageUrl?: string;
};

export const RecreationImage: React.FC<Props> = (props) => {
  const { imageUrl } = props;
  return (
    <div>
      {imageUrl ? (
        <div>削除</div>
      ) : (
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>レク画像を追加</h5>
          <Essential />
        </div>
      )}
    </div>
  );
};
