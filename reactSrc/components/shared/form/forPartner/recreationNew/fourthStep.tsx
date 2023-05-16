import React from 'react';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  getValues: () => RecreationFormValues;
};

const getRecreationKind = (kind: string): string => {
  const kinds: { [key: string]: string } = { online: 'オンライン', visit: '訪問', mail: '郵送' }; 
  return kinds[kind];
}

const categoryName = (category: string): string => {
  const categories: { [key: string]: string } = {
    event: 'イベント',
    music: '音楽',
    work: '創作',
    health: '健康',
    travel: '旅行',
    hobby: '趣味',
    food: '食べ物',
    other: 'その他'
  }; 
  return categories[category];
}

export const FourthStep: React.FC<Props> = ({ getValues }) => {

  return (
    <div>
      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>入力内容を確認</h5>
      </div>
      <hr className='my-2' />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクの形式</h5>
        <p>{getRecreationKind(getValues().kind)}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>タイトル</h5>
        <p>{getValues().title}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>サブタイトル</h5>
        <p>{getValues().secondTitle}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>所要時間</h5>
        <p>{getValues().minutes}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>当日のタイムスケジュール</h5>
        <p>{getValues().flowOfDay}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクのカテゴリー</h5>
          <p>{categoryName(getValues().category)}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクの内容</h5>
        <p>{getValues().description}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>参加人数制限を設定</h5>
        <p>{getValues().capacity === 0 ? 'なし' : getValues().capacity}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>謝礼</h5>
        <p>{getValues().price}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>材料費</h5>
        <p>{getValues().materialPrice}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>追加施設費</h5>
        <p>{getValues().additionalFacilityFee}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レク画像</h5>
        <p></p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>動画URL</h5>
        <p>{getValues().youtubeId}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>持ち込むものを入力</h5>
        <p>{getValues().bringYourOwnItem}</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>その他を入力</h5>
        <p>{getValues().extraInformation}</p>
      </div>
    </div>
  );
};
