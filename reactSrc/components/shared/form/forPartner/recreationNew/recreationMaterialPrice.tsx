import { Essential } from '@/components/shared/parts/essential';
import React from 'react';
import { UseFormRegister } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';
import { Recreation } from '@/types';

type Props = {
  register: UseFormRegister<RecreationFormValues>;
  recreation?: Recreation;
};

export const RecreationMaterialPrice: React.FC<Props> = (props) => {
  const { register } = props;
  return (
    <>
      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>材料費</h5>
        <Essential />
      </div>
      <p className='small my-0'>レク1人あたりに必要な材料費を入力してください</p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        placeholder='タイトルを入力'
        {...register('materialPrice')}
      />
      <p className='small my-0'>施設に表示される金額</p>
      <p className='small my-0'>材料費＋サービス手数料(15%)が上乗せされます</p>
    </>
  );
};
