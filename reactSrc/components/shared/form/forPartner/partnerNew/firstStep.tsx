import React from 'react';
import { useFormContext } from 'react-hook-form';

export const FirstStep: React.FC = () => {
  const {
    register,
    getValues,
    formState: { errors },
  } = useFormContext();

  return (
    <>
      <div className='progress-bar w-100'></div>
      <div className='p-3'>
        {Object.keys(errors).length > 0 && (
          <div className='alert alert-danger'>
            <ul>
              {errors.email && <li>{errors.email.message as string}</li>}
              {errors.password && <li>{errors.password.message as string}</li>}
              {errors.passwordConfirmation && (
                <li>{errors.passwordConfirmation.message as string}</li>
              )}
              {errors.terms && <li>{errors.terms.message as string}</li>}
              {errors.privacy && <li>{errors.privacy.message as string}</li>}
            </ul>
          </div>
        )}
        <div className='text-center mb-3'>
          <img src='/partner_registration/top_image.svg' alt='top_image' />
        </div>
        <div>
          <h5 className='text-center text-black'>あともう少しです！</h5>
          <p className='pt-2 m-0 text-black'>パートナー登録にあたり新規アカウントの作成をお願いいたします。</p>
        </div>

        <div className='mt-3'>
          <p className='small mb-1 text-black'>メールアドレス</p>
          <input
            type='text'
            className='w-100 p-2'
            {...register('email', { required: 'メールアドレスは必須です' })}
          />

          <p className='small mt-3 mb-0 text-black'>パスワード</p>
          <p className='small mb-1'>6文字以上の英数字を入力してください。</p>
          <input
            type='password'
            className='w-100 p-2'
            {...register('password', {
              required: 'パスワードは必須です',
              minLength: {
                value: 6,
                message: 'パスワードは6文字以上でなければなりません',
              },
            })}
          />

          <p className='small mt-3 mb-0 text-black'>パスワード確認</p>
          <p className='small mb-1'>同じパスワードをご入力ください。</p>
          <input
            type='password'
            className='w-100 p-2'
            {...register('passwordConfirmation', {
              required: 'パスワード確認は必須です',
              validate: (value) =>
                value === getValues('password') || 'パスワードが一致しません',
            })}
          />

          <div>
            <input
              type='checkbox'
              id='terms'
              className='mt-3'
              {...register('terms', { required: '利用規約への同意は必須です' })}
            />
            <label htmlFor='terms' className='terms'>
              <span>
                <a href='https://drive.google.com/file/d/1FsBuayCcZDgqD6g6xjpf6Xh0Yxgw4Fgy/view' className='ms-1 text-primary fw-bold'>
                  利用規約
                </a>
              </span>
              に同意します
            </label>
          </div>

          <div>
            <input
              type='checkbox'
              id='privacy'
              className='mt-3'
              {...register('privacy', {
                required: 'プライバシーポリシーへの同意は必須です',
              })}
            />
            <label htmlFor='privacy' className='privacy'>
              <span>
                <a href='https://everyplus.jp/policy_privacy' className='ms-1 text-primary fw-bold'>
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
