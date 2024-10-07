import React, { useState } from 'react';
import { UseFormGetValues, UseFormRegister } from 'react-hook-form';
import { Recreation } from '@/types';
import { RecreationAdditionalFacilityFee } from './recreationAdditionalFacilityFee';
import { RecreationEditAdditionalFacilityFee } from './recreationEditAdditionalFacilityFee';
import { RecreationEditMaterialPrice } from './recreationEditMaterialPrice';
import { RecreationEditPrice } from './recreationEditPrice';
import { RecreationMaterialPrice } from './recreationMaterialPrice';
import { RecreationFormValues } from './recreationNewForm';
import { RecreationPrice } from './recreationPrice';

type Props = {
  getValues: UseFormGetValues<RecreationFormValues>;
  register: UseFormRegister<RecreationFormValues>;
  recreation?: Recreation;
};

const descriptionPlaceholderText = `交通費について
東京都 北区、豊島区０円
北区、豊島区以外の東京都内 500円
神奈川 1000円
千葉 1500円
埼玉 1500円
上記以外はご相談ください
`;

export const SecondStep: React.FC<Props> = (props) => {
  const { getValues, register, recreation } = props;
  const [extraInformation, setExtraInformation] = useState<string>(
    getValues('extraInformation')
  );

  const isShowAdditionalFacilityFee = (): boolean => {
    if (!recreation) {
      const kind = getValues('kind');
      return kind === 'online';
    }

    return recreation.kind?.key === 'online' || false;
  };

  return (
    <div>
      {!recreation && <RecreationPrice register={register} />}
      {recreation && <RecreationEditPrice recreation={recreation} />}

      {!recreation && <RecreationMaterialPrice register={register} />}
      {recreation && <RecreationEditMaterialPrice recreation={recreation} />}

      {!recreation && isShowAdditionalFacilityFee() && (
        <RecreationAdditionalFacilityFee register={register} />
      )}
      {recreation && isShowAdditionalFacilityFee() && (
        <RecreationEditAdditionalFacilityFee recreation={recreation} />
      )}

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>お借りしたいものを入力</h5>
      </div>
      <p className='small my-0'>
        レクに必要なものを施設から借りたい場合は入力してください
      </p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        {...register('borrowItem')}
      />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>持ち込むものを入力</h5>
      </div>
      <p className='small my-0'>
        レクに必要なものを自前で施設に持ち込む場合は入力してください
      </p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        {...register('bringYourOwnItem')}
      />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>その他を入力</h5>
      </div>
      <p className='small my-0'>
        交通費に関する補足や、サポート必要人数、注意事項やその他備考などありました入力してください
      </p>
      <textarea
        rows={15}
        className='p-1 w-100 rounded border border-secondary'
        placeholder={descriptionPlaceholderText}
        {...register('extraInformation', {
          maxLength: 500,
        })}
        onChange={(e) => setExtraInformation(e.target.value)}
        maxLength={500}
      />
      <p className='small my-0'>{extraInformation?.length}/500文字まで</p>
    </div>
  );
};
