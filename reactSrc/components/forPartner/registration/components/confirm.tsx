import React from 'react';
import ReactDOM from 'react-dom/client'; // Import ReactDOM with createRoot

const Confirm: React.FC = () => {
  return (
    <>
      <div className='header bg-white shadow-sm'>
        <h2 className='text-black text-center p-2 border-bottom'>
          登録中のレク
        </h2>
      </div>
      <div className='confirm p-3 text-black'>
        <div className='text-center mb-3'>
          <img src='/partner_registration/complete_image.svg' alt='top_image' />
        </div>
        <h4 className='text-center'>
          レクを新しく登録するために
          <br />
          学習コンテンツをご確認ください
        </h4>
        <p>
          学習コンテンツをご確認の上、ページ下部のチェックを行うと新しくレクを登録することができます。
        </p>
        <button
          type='submit'
          className='mt-2 py-2 w-100 rounded text-primary font-weight-bold bg-white border'
        >
          学習コンテンツを確認する
        </button>
        <p className='text-center mt-2 mb-3 text-secondary'>
          学習コンテンツは外部サイトへ遷移します
        </p>
        <div className='reason'>
          <div className='top-section pt-3 pb-2 px-3 d-flex align-items-center justify-content-between'>
            <div className='d-flex align-items-center'>
              <img
                src='/partner_registration/attention_image.svg'
                alt='top_image'
                className='me-2'
              />
              <p className='fw-bold mb-0'>学習コンテンツがある理由</p>
            </div>
            <img src='/partner_registration/up_arrow.svg' alt='top_image' />
          </div>
          <hr className='my-2' />
          <div className='bottom-section py-1 px-3'>
            <p>
              これから現場にでていただき、レクのプロとして活動していただきます。高齢者、現場のスタッフの皆様はレクの開催を楽しみにしています。
              <br />
              同時に一般高齢者とはまた異なる環境での開催となります。
              <br />
              そのため
            </p>
            <ul className='mb-0'>
              <li>老人ホームやデイサービスなど施設毎の違いの理解</li>
              <li>認知症についての理解</li>
              <li>高齢者の心や体の状態を理解</li>
              <li>現場スタッフの期待すること</li>
            </ul>
            <p>など不安を抱えています。</p>
            <p>
              そのため、エブリ・プラスでは皆様に
              <br />
              学習動画とチェックテストの実施を必須としています。大事な内容となりますので、お時間ある際にしっかりとご確認ください。
            </p>
          </div>
        </div>
        <div className='text-center py-1'>
          <input
            type='checkbox'
            id='check'
            className='mt-3'
            style={{ transform: 'scale(1.2)' }}
          />
          <label htmlFor='check' className='check ms-2'>
            <a href='#' className='text-primary fw-bold'>
              学習コンテンツ
            </a>
            を確認しました
          </label>
        </div>
      </div>
    </>
  );
};

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#confirm');
  if (elm) {
    const root = ReactDOM.createRoot(elm);
    root.render(<Confirm />);
  }
});

// Event listener for page refreshes
$(document).ready(() => {
  const elm = document.querySelector('#confirm');
  if (elm) {
    const root = ReactDOM.createRoot(elm);
    root.render(<Confirm />);
  }
});
