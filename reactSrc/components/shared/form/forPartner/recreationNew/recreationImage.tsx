import { RecreationImage as Image } from '@/types/recreationImage';
import React from 'react';

type Props = {
  image: Image;
  handleDelete: (id: number) => void;
};

export const RecreationImage: React.FC<Props> = (props) => {
  const { image, handleDelete } = props;
  return (
    <div className='col-4'>
      <p className='py-5 text-center text-primary font-weight-bold border'>
        <img src={image.imageUrl} height={100} width={100} />
        <button type='button' onClick={() => handleDelete(image.id)}>削除</button>
      </p>
    </div>
  );
};
