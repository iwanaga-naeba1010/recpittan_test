import { Essential } from '@/components/shared/parts/essential';
import { Recreation } from '@/types';
import React from 'react';

type Props = {
  recreation?: Recreation;
};

export const RecreationEditMaterialPrice: React.FC<Props> = (props) => {
  const { recreation } = props;
  return (
    <>
      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>材料費</h5>
        <Essential />
      </div>
      <p className='small my-0'>
        レク1人あたりに必要な材料費を入力してください
      </p>
      <input
        type='text'
        className='readonly p-2 w-100 rounded border border-secondary'
        placeholder='タイトルを入力'
        value={recreation.materialPrice}
        readOnly
      />
    </>
  );
};
