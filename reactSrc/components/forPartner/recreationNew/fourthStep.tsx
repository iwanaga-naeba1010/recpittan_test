import React from 'react';

type Props = {
  handleNext: () => void;
  handlePrev: () => void;
};

export const FourthStep: React.FC<Props> = (props) => {
  const { handlePrev } = props;
  return (
    <div>
      <div className='d-flex'>
        <p className='px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>✔︎</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>✔︎</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>✔︎</p>
        <p className='ms-1 px-1 small text-black font-weight-bold border border-2 border-dark rounded-pill'>ステップ4</p>
      </div>

      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>入力内容を確認</h5>
      </div>
      <hr className='my-2'/>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクの形式</h5>
        <p>オンライン</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>タイトル</h5>
        <p>タイトルタイトルタイトルタイトル</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>サブタイトル</h5>
        <p>サブタイトルサブタイトルサブタイトル</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクの形式</h5>
        <p>オンライン</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>当日のタイムスケジュール</h5>
        <p>当日のタイムスケジュール</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクのカテゴリー</h5>
        <p>レクのカテゴリー</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクの内容</h5>
        <p>例：hogehogheohgoehgeogheogレクの内容例：hogehogheohgoehgeogheogレクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容レクの内容</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>受付可能エリアを選択</h5>
        <p>東京</p>
     </div>
 
      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>参加人数制限を設定</h5>
        <p>あり、10人</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>謝礼</h5>
        <p>¥1,000</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>追加施設費</h5>
        <p>¥1,000</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レク画像</h5>
        <p></p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>動画URL</h5>
        <p>hogehoge</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>持ち込むものを入力</h5>
        <p>例：hogehogheohgoehgeogheog</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>その他を入力</h5>
        <p>例：その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他その他</p>
      </div>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>申請に関する注意事項</h5>
        <ol>
          <li>注意事項注意事項注意事項注意事項注意事項注意事項注意事項注意事項注意事項注意事項</li>
        </ol>
      </div>

      <button type='button' className="mt-2 py-2 w-100 rounded text-primary font-weight-bold bg-white border border-primary">編集する</button>
      <button type='button' className="mt-2 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary">申請する</button>
      <button type='button' className="mt-2 w-100 rounded text-primary font-weight-bold bg-white border border-white" onClick={handlePrev}>＜戻る</button>
    </div>
  );
};
