import { Essential } from '@/components/shared/parts/essential';
import { Recreation } from '@/types';
import React from 'react';

type Props = {
  recreation?: Recreation;
};

export const RecreationEditPrice: React.FC<Props> = (props) => {
  const { recreation } = props;
  if (!recreation) {
    return <></>;
  }

  return (
    <>
      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>
          金額・その他の情報を入力
        </h5>
      </div>
      <hr className='my-2' />

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>謝礼</h5>
        <Essential />
      </div>
      <input
        type='text'
        className='readonly p-2 w-100 rounded border border-secondary'
        value={recreation.amount}
        readOnly
      />
      <p className='small my-0'>マイページでの金額変更はできません</p>
      <p className='small my-0'>ご希望の際はご一報下さい</p>
      <p className='small my-0'>謝礼＋サービス手数料(35%)が上乗せされます</p>
    </>
  );
};
