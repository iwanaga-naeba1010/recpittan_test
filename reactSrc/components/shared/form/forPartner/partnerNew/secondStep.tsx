// import { LoadingIndicator } from '@/components/shared/parts';
import React from 'react';

export const SecondStep: React.FC = () => {
  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-50 bg-black'></div>
      </div>
      <div className='p-3'>
        <div className='mt-3'>
          <div className='mb-3'>
            <p className='small text-black mb-0'>
              氏名<span className='essential ms-2'>必須</span>
            </p>
            <input type='text' className='w-100 p-2' placeholder='田中太郎' />
          </div>

          <div className='mb-3'>
            <p className='small text-black mb-0'>
              氏名（カナ）<span className='essential ms-2'>必須</span>
            </p>
            <input
              type='text'
              className='w-100 p-2'
              placeholder='タナカタロウ'
            />
          </div>

          <div className='mb-3'>
            <p className='small text-black mb-0'>
              電話番号<span className='essential ms-2'>必須</span>
            </p>
            <input
              type='text'
              className='w-100 p-2'
              placeholder='タナカタロウ'
            />
          </div>

          <div className='mb-3'>
            <p className='small text-black mb-0'>
              住所<span className='essential ms-2'>必須</span>
            </p>
            <input
              type='text'
              className='w-100 p-2 mb-1'
              placeholder='郵便番号'
            />
            <input
              type='text'
              className='w-100 p-2 mb-1'
              placeholder='都道府県'
            />
            <input
              type='text'
              className='w-100 p-2 mb-1'
              placeholder='市区町村'
            />
            <input type='text' className='w-100 p-2 mb-1' placeholder='住所1' />
            <input
              type='text'
              className='w-100 p-2'
              placeholder='建物名・部屋（任意）'
            />
          </div>

          <p className='small mb-0 text-black'>会社名</p>
          <p className='small mb-1'>会社名または団体名など</p>
          <input
            type='text'
            className='w-100 p-2'
            placeholder='タイトルを入力'
          />
        </div>
      </div>
    </>
  );
};
