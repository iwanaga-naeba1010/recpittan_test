import { createRoot } from 'react-dom/client';
import React, { useEffect, useState } from 'react';
import { useForm, FormProvider, useFormContext } from 'react-hook-form';
import { findAddressByZip } from '@/utils/address';
import { AddressResponse } from '@/types';
import { usePartnerInformation } from '../hook/usePartnerInformation';

export const InformationEdit: React.FC = () => {
  const {
    register,
    setValue,
    formState: { errors },
    handleSubmit,
  } = useFormContext();

  const { fetchPartnerInformation, updatePartnerInformation } =
    usePartnerInformation();
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
        }
      } catch (error) {
        console.error('住所取得中にエラーが発生しました', error);
      } finally {
        setIsLoading(false);
      }
    }
  };

  useEffect(() => {
    const fetchData = async () => {
      const id = window.location.pathname.split('/')[3];
      const partnerInformation = await fetchPartnerInformation(id);
      console.log(partnerInformation);
      setValue('userName', partnerInformation.username);
      setValue('userNameKana', partnerInformation.usernameKana);
      setValue('phoneNumber', partnerInformation.partnerInfo.phoneNumber);
      setValue('postalCode', partnerInformation.partnerInfo.postalCode);
      setValue('prefecture', partnerInformation.partnerInfo.prefecture);
      setValue('city', partnerInformation.partnerInfo.city);
      setValue('address1', partnerInformation.partnerInfo.address1);
      setValue('address2', partnerInformation.partnerInfo.address2);
      setValue('companyName', partnerInformation.partnerInfo.companyName);
    };

    fetchData();
  }, [fetchPartnerInformation, setValue]);

  const onSubmit = async (data: any) => {
    const id = window.location.pathname.split('/')[3]; // 動的にIDを取得
    const requestBody = {
      user: {
        username: data.userName,
        username_kana: data.userNameKana,
        partner_info_attributes: {
          phone_number: data.phoneNumber,
          postal_code: data.postalCode,
          prefecture: data.prefecture,
          city: data.city,
          address1: data.address1,
          address2: data.address2,
          company_name: data.companyName,
        },
      },
    };

    try {
      await updatePartnerInformation(id, requestBody);
      console.log('Information updated successfully');
    } catch (error) {
      console.error('Failed to update information', error);
    }
  };

  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-50 bg-black'></div>
      </div>
      <div className='p-3'>
        {Object.keys(errors).length > 0 && (
          <div className='alert alert-danger'>
            <ul>
              {errors.userName && <li>{errors.userName.message as string}</li>}
              {errors.userNameKana && (
                <li>{errors.userNameKana.message as string}</li>
              )}
              {errors.phoneNumber && (
                <li>{errors.phoneNumber.message as string}</li>
              )}
              {errors.postalCode && (
                <li>{errors.postalCode.message as string}</li>
              )}
              {errors.prefecture && (
                <li>{errors.prefecture.message as string}</li>
              )}
              {errors.city && <li>{errors.city.message as string}</li>}
              {errors.address1 && <li>{errors.address1.message as string}</li>}
            </ul>
          </div>
        )}
        <form onSubmit={handleSubmit(onSubmit)}>
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
              />
              {isLoading && <p>Loading...</p>}
              <input
                type='text'
                className='w-100 p-2 mb-1'
                placeholder='都道府県'
                {...register('prefecture', { required: '都道府県は必須です' })}
              />
              <input
                type='text'
                className='w-100 p-2 mb-1'
                placeholder='市区町村'
                {...register('city', { required: '市区町村は必須です' })}
              />
              <input
                type='text'
                className='w-100 p-2 mb-1'
                placeholder='住所1'
                {...register('address1', { required: '住所1は必須です' })}
              />
              <input
                type='text'
                className='w-100 p-2'
                placeholder='建物名・部屋（任意）'
                {...register('address2')}
              />
            </div>

            <p className='small mb-0 text-black'>会社名</p>
            <p className='small mb-1'>会社名または団体名など</p>
            <input
              type='text'
              className='w-100 p-2'
              placeholder='タイトルを入力'
              {...register('companyName')}
            />
          </div>
          <div className='mt-2'>
            <button
              type='submit'
              className='w-100 py-2 rounded text-white font-weight-bold bg-primary border border-primary'
            >
              保存する
            </button>
          </div>
        </form>
      </div>
    </>
  );
};

const App: React.FC = () => {
  const methods = useForm(); // フォームコンテキストを初期化

  return (
    <FormProvider {...methods}>
      <InformationEdit />
    </FormProvider>
  );
};

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#partnerInformationEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});

$(document).ready(() => {
  const elm = document.querySelector('#partnerInformationEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});
