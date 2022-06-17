import React from 'react';
import { UseFormRegister } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  register: UseFormRegister<RecreationFormValues>;
  handleRemove: (index: number) => void;
  index: number;
  prefectures: Array<string>;
};

export const PrefectureItem: React.FC<Props> = (props) => {
  const { register, handleRemove, index, prefectures } = props;
  return (
    <div>
      <label>
        <p>エリア</p>
        <select
          className='p-2 w-100 rounded border border-secondary'
          placeholder='選択してください'
          {...register(`prefectures.${index}`, {
            required: true
          })}
        >
          {prefectures.map((prefecture: string) => (
            <option key={prefecture} value={prefecture}>
              {prefecture}
            </option>
          ))}
        </select>
      </label>
      <button
        className='text-primary font-weight-bold border border-white bg-white'
        type='button'
        style={{ marginLeft: '16px' }}
        onClick={() => handleRemove(index)}
      >
        削除
      </button>
    </div>
  );
};
