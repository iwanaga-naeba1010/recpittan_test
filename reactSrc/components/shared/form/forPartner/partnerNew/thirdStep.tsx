// import { Api } from '@/infrastructure';
// import { Profile } from '@/types';
import React from 'react';

export const ThirdStep: React.FC = () => {
  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-75 bg-black'></div>
      </div>
      <div className='p-3'>
        <div className='mb-2'>
          <p className='small mb-1 text-black'>金融機関</p>
          <p className='small mb-1'>例：hogehogheohgoehgeogheog</p>
          <input type='text' className='w-100 p-2' placeholder='銀行名' />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>金融機関コード(4桁半角数字)</p>
          <p className='small mb-1'>例：hogehogheohgoehgeogheog</p>
          <input type='text' className='w-100 p-2' placeholder='0001' />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>支店名</p>
          <p className='small mb-1'>例：hogehogheohgoehgeogheog</p>
          <input type='text' className='w-100 p-2' placeholder='0001' />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>支店コード（半角数字）</p>
          <p className='small mb-1'>例：hogehogheohgoehgeogheog</p>
          <input type='text' className='w-100 p-2' placeholder='001' />
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>預金種目</p>
          <select name='' id='' className='w-100 p-2'>
            <option value=''>普通</option>
            <option value=''>当座</option>
          </select>
        </div>

        <div className='mb-2'>
          <p className='small mb-1 text-black'>口座名義(カタカナ) </p>
          <input type='text' className='w-100 p-2' placeholder='エブリタロウ' />
        </div>
      </div>
    </>
  );
};
