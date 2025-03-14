import { Essential } from '@/components/shared/parts/essential';
import React from 'react';
import { UseFormRegister } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  register: UseFormRegister<RecreationFormValues>;
};

export const RecreationAdditionalFacilityFee: React.FC<Props> = (props) => {
  const { register } = props;
  return (
    <>
      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>追加施設費</h5>
        <Essential />
      </div>
      <p className='small my-0'>
        オンライン開催のみ。１回のレクで新たに施設が追加される
      </p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        placeholder='追加施設費を入力'
        {...register('additionalFacilityFee', {
          required: true,
        })}
      />
      <p className='small my-0'>基本は追加施設1施設あたり1,000円です。</p>
      <p className='small my-0'>
        ※1,000円での開催が難しい場合は金額をご入力ください
      </p>
    </>
  );
};
