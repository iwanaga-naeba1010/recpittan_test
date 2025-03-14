import React, { useState } from 'react';
import { useFormContext } from 'react-hook-form';
import { findAddressByZip } from '@/utils/address';
import { AddressResponse } from '@/types';

export const PartnerInformationForm: React.FC = () => {
  const { register, setValue } = useFormContext();
  const [isLoading, setIsLoading] = useState(false);

  const handlePostalCodeChange = async (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    const postalCode = e.target.value;
    setValue('postalCode', postalCode);

    if (postalCode.length === 7) {
      setIsLoading(true);
      try {
        const response = await findAddressByZip(postalCode);
        const data: AddressResponse = response.data;
        if (data.results) {
          const address = data.results[0];
          setValue('prefecture', address.address1);
          setValue('city', address.address2);
          setValue('address1', address.address3);
        } else {
          console.error('住所が見つかりません');
          throw new Error('住所が見つかりません');
        }
      } catch (error) {
        console.error('住所取得中にエラーが発生しました', error);
        throw new Error(String(error));
      } finally {
        setIsLoading(false);
      }
    }
  };

  return (
    <>
      <div className='mt-3'>
        <div className='mb-3'>
          <p className='small text-black mb-0'>
            氏名<span className='essential ms-2'>必須</span>
          </p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='田中太郎'
            {...register('userName', { required: '氏名は必須です' })}
            autoComplete='new-off'
          />
        </div>

        <div className='mb-3'>
          <p className='small text-black mb-0'>
            氏名（カナ）<span className='essential ms-2'>必須</span>
          </p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='タナカタロウ'
            {...register('userNameKana', {
              required: '氏名（カナ）は必須です',
            })}
            autoComplete='new-off'
          />
        </div>

        <div className='mb-3'>
          <p className='small text-black mb-0'>
            電話番号<span className='essential ms-2'>必須</span>
          </p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='電話番号'
            {...register('phoneNumber', { required: '電話番号は必須です' })}
            autoComplete='new-off'
          />
        </div>

        <div className='mb-3'>
          <p className='small text-black mb-0'>
            住所<span className='essential ms-2'>必須</span>
          </p>
          <input
            type='text'
            className='w-100 p-2 mb-1'
            placeholder='郵便番号(-は不要です)'
            {...register('postalCode', { required: '郵便番号は必須です' })}
            onChange={handlePostalCodeChange}
            autoComplete='new-off'
          />
          {isLoading && <p>Loading...</p>}
          <input
            type='text'
            className='w-100 p-2 mb-1'
            placeholder='都道府県'
            {...register('prefecture', { required: '都道府県は必須です' })}
            autoComplete='new-off'
          />
          <input
            type='text'
            className='w-100 p-2 mb-1'
            placeholder='市区町村'
            {...register('city', { required: '市区町村は必須です' })}
            autoComplete='new-off'
          />
          <input
            type='text'
            className='w-100 p-2 mb-1'
            placeholder='住所1'
            {...register('address1', { required: '住所1は必須です' })}
            autoComplete='new-off'
          />
          <input
            type='text'
            className='w-100 p-2'
            placeholder='建物名・部屋（任意）'
            {...register('address2')}
            autoComplete='new-off'
          />
        </div>

        <p className='small mb-0 text-black'>会社名</p>
        <p className='small mb-1'>会社名または団体名など</p>
        <input
          type='text'
          className='w-100 p-2'
          placeholder='会社名または団体名などを入力'
          {...register('companyName')}
          autoComplete='new-off'
        />
      </div>
    </>
  );
};
