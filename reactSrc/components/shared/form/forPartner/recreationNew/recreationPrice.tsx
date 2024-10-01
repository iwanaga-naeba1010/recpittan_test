import { Essential } from '@/components/shared/parts/essential';
import React from 'react';
import { UseFormRegister } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  register: UseFormRegister<RecreationFormValues>;
};

export const RecreationPrice: React.FC<Props> = (props) => {
  const { register } = props;
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
      <p className='small my-0'>レクの料金を入力してください</p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        {...register('price', {
          required: true,
        })}
      />
    </>
  );
};
