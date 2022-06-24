import { Essential } from '@/components/shared/parts/essential';
import {Api} from '@/infrastructure';
import {Recreation} from '@/types';
import React, { useState } from 'react';
import { UseFormGetValues, UseFormRegister } from 'react-hook-form';
import { RecreationImage as ImageComponent } from './recreationImage';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  getValues: UseFormGetValues<RecreationFormValues>;
  register: UseFormRegister<RecreationFormValues>;
  recreation: Recreation;
};

export const SecondStep: React.FC<Props> = (props) => {
  const { getValues, register, recreation } = props;
  const [extraInformation, setExtraInformation] = useState<string>(getValues('extraInformation'));

  const handleFileChanged = (files: FileList | null)  => {
    if (!files || files.length <= 0) return;
    const file = files[0];
    const reader = new FileReader();
    console.log('-----------------');
    console.log(file);
    // TODO(okubo): ここで画像送信
    reader.onload = async (event) => {
      console.log(event.target?.result);
      console.log('-----------------');
      if (event.target?.result && typeof event.target?.result === 'string') {
        console.log(event.target?.result);

        const requestBody: { [key: string]: Record<string, unknown> } = {
          recreationImage: {
            image: event.target?.result,
          },
        };

      const createdImage = await Api.post(`recreations/${recreation.id}/recreation_images`, 'partner', requestBody);
      console.log('--------------------');
      console.log(createdImage);
      console.log('--------------------');
        // setImage(event.target?.result);
        // setValue('uploadImageUrl', event.target?.result);
      }
    };
    reader.readAsDataURL(file);
  };

  return (
    <div>
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

      {recreation.images.map((image, i) => (
        <ImageComponent key={i} />
      ))}

      <input
        type='file'
        id='profileImageUrl'
        accept='image/*'
        onChange={(event) => handleFileChanged(event.target.files)}
      />
      <p className='w-25 py-5 100 text-center text-primary font-weight-bold border'>+</p>
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
      <p className='small my-0'>{extraInformation?.length}/500文字まで</p>
    </div>
  );
};
