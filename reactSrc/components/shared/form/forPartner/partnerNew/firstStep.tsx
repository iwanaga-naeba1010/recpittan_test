import React from 'react';

export const FirstStep: React.FC = () => {
  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-25 bg-black'></div>
      </div>
      <div className='p-3'>
        <div className='text-center mb-3'>
          <img src='/partner_registration/top_image.svg' alt='top_image' />
        </div>
        <div>
          <h5 className='text-center text-black'>あともう少しです！</h5>
          <p className='pt-2 m-0 text-black'>おめでとうございます！</p>
          <p className='m-0 text-black'>
            あなたは審査を通過しましたのでサービスへ新規登録をお願いします。
          </p>
        </div>

        <div className='mt-3'>
          <p className='small mb-1 text-black'>メールアドレス</p>
          <input type='text' className='w-100 p-2' />

          <p className='small mt-3 mb-0 text-black'>パスワード</p>
          <p className='small mb-1'>6文字以上の英数字を入力してください。</p>
          <input type='text' className='w-100 p-2' />

          <p className='small mt-3 mb-0 text-black'>パスワード確認</p>
          <p className='small mb-1'>同じパスワードをご入力ください。</p>
          <input type='text' className='w-100 p-2' />

          <div>
            <input type='checkbox' id='terms' className='mt-3' />
            <label htmlFor='terms' className='terms'>
              <span>
                <a href='#' className='ms-1 text-primary fw-bold'>
                  利用規約
                </a>
              </span>
              に同意します
            </label>
          </div>

          <div>
            <input type='checkbox' id='privacy' className='mt-3' />
            <label htmlFor='privacy' className='privacy'>
              <span>
                <a href='#' className='ms-1 text-primary fw-bold'>
                  プライバシーポリシー
                </a>
              </span>
              に同意します
            </label>
          </div>
        </div>
      </div>
    </>
  );
};
