import React from 'react';
import { UseFormRegister } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  register: UseFormRegister<RecreationFormValues>;
};

export const RecreationIsWithholdingTax: React.FC<Props> = (props) => {
  const { register } = props;
  return (
    <>
      <div className='d-flex gap-3 isWithholdingTax'>
        <label htmlFor='isWithholdingTax' className='isWithholdingTax'>
          <div className='d-flex mt-4'>
            <h5 className='text-black font-weight-bold'>要源泉徴収</h5>
          </div>
        </label>
        <input
          type='checkbox'
          id='isWithholdingTax'
          className='mt-3'
          {...register('isWithholdingTax')}
        />
      </div>

      <p className='small my-0'>
        登録するレクリエーションが源泉徴収の対象となるかどうか、以下の源泉徴収対象判定フロー図にてご確認ください。
      </p>

      <img
        src='/recreations/flow_is_withholding_tax.png'
        alt='top_image'
        className='mt-3 img-fluid'
      />
    </>
  );
};
