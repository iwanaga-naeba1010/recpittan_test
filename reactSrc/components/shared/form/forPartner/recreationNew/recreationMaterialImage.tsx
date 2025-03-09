import { RecreationImage as Image } from '@/types/recreationImage';
import React, { useState, useEffect } from 'react';

type Props = {
  image: Image;
  handleDelete: (id: number) => void;
  handleChangeTitle: (id: number, title: string) => void;
  handleDownload: (imageUrl: string, filename: string) => void;
};

export const RecreationMaterialImage: React.FC<Props> = (props) => {
  const { image, handleDelete, handleDownload, handleChangeTitle } = props;
  const [title, setTitle] = useState<string>(image.title);

  const [debouncedValue, setDebouncedValue] = useState<string>(null);
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(title);
    }, 500);

    return () => clearTimeout(handler);
  }, [title]);

  useEffect(() => {
    if (debouncedValue !== null) {
      handleChangeTitle(image.id, debouncedValue);
    }
  }, [debouncedValue, image, handleChangeTitle]);

  const checkIsImageFile = (fileName) => {
    const imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'bmp',
      'webp',
      'svg',
      'tiff',
    ];
    const match = fileName.match(/\.(\w+)(?:\s*\(\d+\))?$/);

    return match ? imageExtensions.includes(match[1].toLowerCase()) : false;
  };

  const isImageFile = checkIsImageFile(image.filename);
  const alt = isImageFile ? image.filename : 'no image';

  return (
    <div className='row border mb-2 p-3'>
      <div className='col-md-3 col-sm-4 text-center'>
        <img src={image.imageUrl} alt={alt} className='img-fluid' />
      </div>
      <div className='col-md-9 col-sm-8'>
        <div className='mb-3'>
          <label htmlFor='titleInput' className='form-label'>
            タイトル
          </label>
          <input
            className='col-12'
            type='text'
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
        </div>
        <div className='d-flex gap-2'>
          <button
            type='button'
            onClick={() => handleDownload(image.imageUrl, image.filename)}
          >
            ダウンロード
          </button>
          <button type='button' onClick={() => handleDelete(image.id)}>
            削除
          </button>
        </div>
      </div>
    </div>
  );
};
