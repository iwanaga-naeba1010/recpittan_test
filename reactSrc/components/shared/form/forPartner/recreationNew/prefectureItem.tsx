import { RecreationPrefecture } from '@/types';
import React from 'react';

type Props = {
  handleUpdate: (id: number, prefectureName: string) => void;
  handleRemove: (index: number) => void;
  prefecture: RecreationPrefecture;
  prefectures: Array<string>;
};

export const PrefectureItem: React.FC<Props> = (props) => {
  const { handleUpdate, handleRemove, prefecture, prefectures } = props;
  return (
    <div>
      <label>
        <p>エリア</p>
        <select
          className='p-2 w-100 rounded border border-secondary'
          onChange={(e) => handleUpdate(prefecture.id, e.target.value)}
        >
          <option value='' disabled selected>
            選択してください
          </option>
          {prefectures?.map((p: string) => (
            <option key={p} value={p} selected={p == prefecture.name}>
              {p}
            </option>
          ))}
        </select>
      </label>
      <button
        className='text-primary font-weight-bold border border-white bg-white'
        type='button'
        style={{ marginLeft: '16px' }}
        onClick={() => handleRemove(prefecture.id)}
      >
        削除
      </button>
    </div>
  );
};
