import React from 'react';

export const FourthStep: React.FC = () => {
  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-75 bg-black'></div>
      </div>
      <div className='p-3 text-black'>
        <h4 className='text-center'>エブリぷらすで依頼を行うために</h4>
        <p className='mb-0'>
          だるまさんが転んだ法人の要望に合わせた完全カスタマイズプランです。
        </p>
        <p>
          日程調節代行をまるっと依頼したい、オリジナルのレクイベント開発や運営を依頼したい、法人一括導入をしたいので全体に説明をしてほしいなど、要望に合わせてご相談が可能です。
        </p>
        <ul>
          <li>学習コンテンツはレクを実施する上で重要なこと</li>
          <li>などを記載</li>
        </ul>
      </div>
    </>
  );
};
