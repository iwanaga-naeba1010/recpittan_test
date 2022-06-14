import { Essential } from '@/components/shared/parts/essential';
import React, { useState } from 'react';
import { UseFormGetValues, UseFormRegister } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  handleNext: () => void;
  handlePrev: () => void;
  getValues: UseFormGetValues<RecreationFormValues>;
  register: UseFormRegister<RecreationFormValues>;
};

export const SecondStep: React.FC<Props> = (props) => {
  const { handleNext, handlePrev, getValues, register } = props;
  const [extraInformation, setExtraInformation] = useState<string>(getValues('extraInformation'));
  return (
    <div>
      <div className='d-flex'>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-black rounded-circle'>
          ✔︎
        </p>
        <p className='ms-1 px-1 small text-black font-weight-bold border border-2 border-dark rounded-pill'>
          ステップ2
        </p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>
          3
        </p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>
          4
        </p>
      </div>

      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>金額・メディア・その他の情報を入力</h5>
      </div>
      <hr className='my-2' />

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>謝礼</h5>
        <Essential />
      </div>
      <p className='small my-0'>レクの料金を入力してください</p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        {...register('price', {
          required: true
        })}
      />
      <p className='small my-0'>施設に表示される金額</p>
      <p className='small my-0'>謝礼＋サービス手数料が上乗せされます</p>
      <p className='small my-0'>￥13500</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>材料費</h5>
        <Essential />
      </div>
      <p className='small my-0'>レク1人あたりに必要な材料費を入力してください</p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        placeholder='タイトルを入力'
        {...register('materialPrice')}
      />
      <p className='small my-0'>施設に表示される金額</p>
      <p className='small my-0'>材料費＋サービス手数料が上乗せされます</p>
      <p className='small my-0'>￥0</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>追加施設費</h5>
        <Essential />
      </div>
      <p className='small my-0'>オンライン開催のみ。１回のレクで新たに施設が追加される</p>
      <input
        type='text'
        className='p-2 w-100 rounded border border-secondary'
        placeholder='サブタイトルを入力'
        {...register('additionalFacilityFee', {
          required: true
        })}
      />
      <p className='small my-0'>施設に表示される金額</p>
      <p className='small my-0'>追加施設費＋サービス手数料が上乗せされます</p>
      <p className='small my-0'>￥0</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>レク画像を追加</h5>
        <Essential />
      </div>
      <p className='w-25 py-5 100 text-center text-primary font-weight-bold border'>+</p>
      <p className='small my-0'>レク1人あたりに必要な材料費を入力してください</p>

      <p className='text-primary font-weight-bold my-1'>＋画像を追加</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>動画を共有</h5>
      </div>
      <ol>
        <li>
          無料大容量 ファイル転送サービス GigaFile(ギガファイル)便
          <span>
            <a href='https://gigafile.nu/' target='_blank' rel='noreferrer' className='text-primary'>
              FileGiga
            </a>
          </span>
          にアクセス
        </li>
        <li>次にファイルをアップロードして、ダウンロード専用URLをコピーします</li>
        <li>最後に専用URLを以下のフォームに入力してください</li>
      </ol>
      <input type='text' className='p-2 w-100 rounded border border-secondary' {...register('youtubeId')} />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>お借りしたいものを入力</h5>
      </div>
      <p className='small my-0'>レクに必要なものを施設から借りたいものを入力してください</p>
      <input type='text' className='p-2 w-100 rounded border border-secondary' {...register('borrowItem')} />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>持ち込むものを入力</h5>
      </div>
      <p className='small my-0'>レクに必要なものを自前で施設に持ち込むものを入力してください</p>
      <input type='text' className='p-2 w-100 rounded border border-secondary' />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>施設に渡したいファイル</h5>
      </div>
      <p className='small my-0'>オンラインのみ。歌詞カードやパンフレットなど</p>

      <p className='text-primary font-weight-bold my-1'>＋ファイルを追加</p>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>その他を入力</h5>
      </div>
      <p className='small my-0'>注意事項やその他備考などありましたら入力してください</p>
      <textarea
        rows={15}
        className='p-1 w-100 rounded border border-secondary'
        placeholder='その他を入力'
        {...register('extraInformation', {
          maxLength: 500
        })}
        onChange={(e) => setExtraInformation(e.target.value)}
        maxLength={500}
      />
      <p className='small my-0'>{extraInformation.length}/500文字まで</p>

      <br />
      <button
        type='button'
        className='my-3 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
        onClick={handleNext}
      >
        次へ
      </button>
      <button
        type='button'
        className='w-100 rounded text-primary font-weight-bold bg-white border border-white'
        onClick={handlePrev}
      >
        ＜戻る
      </button>
    </div>
  );
};
