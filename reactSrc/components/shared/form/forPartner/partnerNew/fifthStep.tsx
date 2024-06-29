import React from 'react';

export const FifthStep: React.FC = () => {
  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-100 bg-black'></div>
      </div>
      <div className='mt-3 px-3 text-black'>
        <h4 className='text-center'>
          学習コンテンツの
          <br />
          ご確認ありがとうございます
        </h4>
        <p className='mb-0'>
          だるまさんが転んだ法人の要望に合わせた完全カスタマイズプランです。
        </p>
        <p>
          日程調節代行をまるっと依頼したい、オリジナルのレクイベント開発や運営を依頼したい、法人一括導入をしたいので全体に説明をしてほしいなど、要望に合わせてご相談が可能です。
        </p>
      </div>
      <div className='px-3'>
        <input type='checkbox' id='check' className='mt-3' />
        <label htmlFor='check' className='check ms-2'>
          学習動画を確認した
        </label>
      </div>
    </>
  );
};
