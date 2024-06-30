import React from 'react';
import ReactDOM from 'react-dom/client'; // Import ReactDOM with createRoot

const CompleteRegistration: React.FC = () => {
  return (
    <>
      <div className='header bg-white shadow-sm'>
        <h2 className='text-black text-center font-weight-bold p-2 border-bottom'>
          登録完了
        </h2>
      </div>
      <div className='complete-registration p-3 text-black'>
        <div className='text-center mb-3'>
          <img src='/partner_registration/complete_image.svg' alt='top_image' />
        </div>
        <h4 className='text-center'>
          ありがとうございます
          <br />
          登録が完了しました！
        </h4>
        <p className='mb-0'>パートナーアカウントの登録が完了しました。</p>
        <p>
          入力したメールアドレス宛に登録完了メールをお送りしましたのでご確認ください。
        </p>
        <hr />
        <h4 className='text-center'>
          LINEでお問い合わせを簡単に
          <br />
          友達登録はこちらから
        </h4>
        <div className='d-flex justify-content-center'>
          <button className='line-button btn text-center my-2 py-2 px-3 rounded text-white fw-bold'>
            友達追加
          </button>
        </div>
        <hr />
        <div className='desc-flow'>
          <h4 className='text-center mt-3'>今後の流れ</h4>
          {renderFlowStep(
            1,
            '介護現場でレクを実施するための学習動画とチェックテストの実施をお願いします',
            '動画は約30分、チェックテストは約10分です。大事な内容となりますので、お時間ある際にしっかりとご確認ください。',
            true
          )}
          {renderFlowStep(
            2,
            'レクを登録しましょう',
            '写真やタイトル、レク内容、プロフィール、謝礼金額など流れに沿ってレク登録をお願いいたします。施設さまが選ぶための大事な内容となります。<br/>※学習コンテンツが完了しないとレクの登録ができません。',
            false
          )}
          {renderFlowStep(
            3,
            '相談・依頼を待ちましょう',
            'レク登録を行い、運営側で承認されたら通知がきます。あとは施設さまからの相談を待ちましょう。依頼の流れ詳細は完了メールに添付している依頼〜精算までの流れ、をご覧ください。',
            false
          )}
        </div>
      </div>
    </>
  );
};

const renderFlowStep = (
  number: number,
  title: string,
  description: string,
  showButton: boolean
) => (
  <div className='row mt-3 px-0 mx-0'>
    <div className='col-2 ps-0'>
      <div className='flow-number text-center fw-bold'>{number}</div>
    </div>
    <div className='col-10 px-0'>
      <p className='fw-bold'>{title}</p>
      <p className='mb-0' dangerouslySetInnerHTML={{ __html: description }} />
      {showButton && (
        <a href="/partners/registrations/confirm">
          <button
            type='submit'
            className='mt-2 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
          >
            学習コンテンツを確認する
          </button>
        </a>
      )}
    </div>
  </div>
);

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#completeRegistration');
  if (elm) {
    const root = ReactDOM.createRoot(elm);
    root.render(<CompleteRegistration />);
  }
});

// Event listener for page refreshes
$(document).ready(() => {
  const elm = document.querySelector('#completeRegistration');
  if (elm) {
    const root = ReactDOM.createRoot(elm);
    root.render(<CompleteRegistration />);
  }
});
