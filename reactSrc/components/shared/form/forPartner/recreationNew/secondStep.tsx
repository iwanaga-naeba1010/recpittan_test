import { LoadingIndicator } from '@/components/shared/parts';
import { Essential } from '@/components/shared/parts/essential';
import { Api } from '@/infrastructure';
import { Recreation } from '@/types';
import { RecreationImage } from '@/types/recreationImage';
import React, { useRef, useState } from 'react';
import { UseFormGetValues, UseFormRegister } from 'react-hook-form';
import { RecreationAdditionalFacilityFee } from './recreationAdditionalFacilityFee';
import { RecreationImage as ImageComponent } from './recreationImage';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  getValues: UseFormGetValues<RecreationFormValues>;
  register: UseFormRegister<RecreationFormValues>;
  recreation: Recreation;
  setRecreation: React.Dispatch<React.SetStateAction<Recreation>>;
};

export const SecondStep: React.FC<Props> = (props) => {
  const { getValues, register, recreation, setRecreation } = props;
  const [extraInformation, setExtraInformation] = useState<string>(getValues('extraInformation'));
  const sliderRef = useRef(null);
  const materialRef = useRef(null);
  const [isSending, setIsSending] = useState<boolean>(false);

  const handleSliderRefClickFileInput = (): void => {
    sliderRef.current.click();
  };

  const handleMaterialRefClickFileInput = (): void => {
    materialRef.current.click();
  };

  const handleFileChanged = (files: FileList | null, kind = 'slider') => {
    if (!files || files.length <= 0) return;
    const file = files[0];
    const reader = new FileReader();
    reader.onload = async (event) => {
      if (event.target?.result && typeof event.target?.result === 'string') {
        const requestBody: { [key: string]: Record<string, unknown> } = {
          recreationImage: {
            image: event.target?.result,
            filename: file.name,
            kind: kind
          }
        };
        setIsSending(true);
        const createdImage = await Api.post<RecreationImage>(
          `recreations/${recreation.id}/recreation_images`,
          'partner',
          requestBody
        );
        setRecreation({ ...recreation, images: [...recreation.images, createdImage.data] });
        setIsSending(false);
      }
    };
    reader.readAsDataURL(file);
  };

  const handleDelete = async (id: number): Promise<void> => {
    try {
      await Api.delete(`recreations/${recreation.id}/recreation_images/${id}`, 'partner', {});
      setRecreation({ ...recreation, images: recreation.images.filter((recreation) => recreation.id !== id) });
    } catch (e) {
      console.log(e);
    }
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
      <p className='small my-0'>謝礼＋サービス手数料(35%)が上乗せされます</p>
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
      <p className='small my-0'>材料費＋サービス手数料(15%)が上乗せされます</p>
      {(recreation === undefined || recreation?.kind.key === 'online') && (
        <RecreationAdditionalFacilityFee register={register} />
      )}

      {/* 修正のタイミングで利用可能に */}
      {recreation !== undefined && (
        <>
          <h5 className='text-black font-weight-bold'>レク画像を追加</h5>
          <div className='row'>
            {recreation.images
              .filter((image) => image.kind === 'slider')
              .map((image, i) => (
                <ImageComponent key={i} image={image} handleDelete={handleDelete} />
              ))}
          </div>

          <input
            type='file'
            accept='image/*'
            className='d-none'
            ref={sliderRef}
            onChange={(event) => handleFileChanged(event.target.files)}
            name='recreationImage'
          />
          <button
            type='button'
            className='w-25 py-5 100 text-center text-primary font-weight-bold border bg-white'
            onClick={handleSliderRefClickFileInput}
          >
            {isSending ? <LoadingIndicator /> : <>+画像を追加</>}
          </button>
        </>
      )}

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
      <p className='small my-0'>レクに必要なものを施設から借りたい場合は入力してください</p>
      <input type='text' className='p-2 w-100 rounded border border-secondary' {...register('borrowItem')} />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>持ち込むものを入力</h5>
      </div>
      <p className='small my-0'>レクに必要なものを自前で施設に持ち込む場合は入力してください</p>
      <input type='text' className='p-2 w-100 rounded border border-secondary' />

      {recreation !== undefined && (
        <>
          <div className='mt-4'>
            <h5 className='text-black font-weight-bold'>施設に渡したいファイル</h5>
          </div>
          <p className='small my-0'>歌詞カードやパンフレットなど</p>

          <input
            type='file'
            className='d-none'
            ref={materialRef}
            onChange={(event) => handleFileChanged(event.target.files, 'material')}
            name='recreationProfile'
          />

          <div className='row'>
            {recreation.images
              .filter((image) => image.kind === 'material')
              .map((image, i) => (
                <ImageComponent key={i} image={image} handleDelete={handleDelete} />
              ))}
          </div>
          {isSending ? (
            <LoadingIndicator />
          ) : (
            <button
              type='button'
              className='text-primary bg-white border-0 font-weight-bold my-1'
              onClick={handleMaterialRefClickFileInput}
            >
              ＋ファイルを追加
            </button>
          )}
        </>
      )}

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
