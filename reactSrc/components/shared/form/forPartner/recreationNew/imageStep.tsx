import { UseFile } from '@/components/forPartner';
import { LoadingIndicator } from '@/components/shared/parts';
import { Recreation } from '@/types';
import React, { useRef } from 'react';
import { UseFormRegister } from 'react-hook-form';
import { RecreationImage as ImageComponent } from './recreationImage';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  register: UseFormRegister<RecreationFormValues>;
  recreation: Recreation;
  useFile: UseFile;
};

export const ImageStep: React.FC<Props> = (props) => {
  const { recreation, useFile } = props;
  const sliderRef = useRef<HTMLInputElement>(null);
  const materialRef = useRef<HTMLInputElement>(null);

  const handleSliderRefClickFileInput = (): void => {
    if (!sliderRef.current) return;
    sliderRef.current.click();
  };

  const handleMaterialRefClickFileInput = (): void => {
    if (!materialRef.current) return;
    materialRef.current.click();
  };

  return (
    <div>
      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レク画像を追加</h5>
        <ul className='small my-0 ps-3'>
          <li>
            レクの魅力を最大限伝えるためにも、こだわった素材をご活用ください
          </li>
          <li>
            全体のイメージと作品等がある場合は合わせて最低2枚以上を添付してください
          </li>
          <li>施設に配布するチラシの素材としても利用します</li>
          <li>後ほど画像を追加/変更することも可能です</li>
          <li>
            目安サイズ 16×9（iPhoneで横向きで撮影した写真の大きさでも可）
          </li>
          <li>添付可能ファイルは20MB以下で、形式はJPEG、PNGです</li>
          <li>
            削除した画像は元に戻せません。必要に応じて事前にレクページからダウンロードをお願いします
          </li>
        </ul>
      </div>
      <div className='row'>
        {recreation.images
          .filter((image) => image.kind === 'slider')
          .map((image, i) => (
            <ImageComponent
              key={i}
              image={image}
              handleDelete={useFile.handleFileDelete}
            />
          ))}
      </div>

      <input
        type='file'
        accept='image/*'
        className='d-none'
        ref={sliderRef}
        onChange={(event) =>
          useFile.handleFileAdd(event.target.files, 'slider')
        }
        name='recreationImage'
      />
      <button
        type='button'
        className='w-25 py-5 100 text-center text-primary font-weight-bold border bg-white'
        onClick={handleSliderRefClickFileInput}
      >
        {useFile.isLoading ? <LoadingIndicator /> : <>+画像を追加</>}
      </button>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>
          施設に渡したいファイル
        </h5>
        <p className='small mt-1 ms-3'>
          ※添付可能ファイルは20MB以下で、形式はPDF、JPEG、PNGです
        </p>
      </div>
      <p className='small my-0'>歌詞カードやパンフレットなど</p>

      <input
        type='file'
        className='d-none'
        ref={materialRef}
        onChange={(event) =>
          useFile.handleFileAdd(event.target.files, 'material')
        }
        name='recreationProfile'
      />

      <div className='row'>
        {recreation.images
          .filter((image) => image.kind === 'material')
          .map((image, i) => (
            <ImageComponent
              key={i}
              image={image}
              handleDelete={useFile.handleFileDelete}
            />
          ))}
      </div>
      {useFile.isLoading ? (
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
    </div>
  );
};
