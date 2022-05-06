import { Essential } from '@/components/shared/parts/essential';
import { Api } from '@/infrastructure';
import React, { useEffect, useState } from 'react';
import { useForm, useFieldArray } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  handleNext: () => void;
  register: any;
  control: any;
  prefecturesIndex: number;
  removePrefecture: (index: number) => void;
};

type Config = {
  categories: Array<string>;
  minutes: Array<number>;
  prefectures: Array<string>;
  kind: Array<string>;
};

export const FirstStep: React.FC<Props> = (props) => {
  const { handleNext } = props;
  const { register, control } = useForm<RecreationFormValues>({ mode: 'onChange' });
  const [config, setConfig] = useState<Config>(undefined);
  const [show, setShow] = useState(false);
  const [count, setCount] = React.useState(0);

  useEffect(() => {
    (async () => {
      try {
        const recreationConfig = await Api.get<Config>(`/recreations/config_data`, 'partner');
        console.log('recreationConfig', recreationConfig.data);
        setConfig(recreationConfig.data);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, []);

  const PrefectureItem = ({ register, prefecturesIndex, removePrefecture }: Props) => {
    return (
      <div>
        <label>
          <p>エリア {prefecturesIndex + 1}</p>
          <select
            className='p-2 w-100 rounded border border-secondary'
            placeholder='選択してください'
            {...register(`prefectures.${prefecturesIndex}.prefectureText` as const, {
              required: true
            })}
          >
            {config?.prefectures.map((prefecture: string) => (
              <option key={prefecture} value={prefecture}>
                {prefecture}
              </option>
            ))}
          </select>
        </label>
        <button className='text-primary font-weight-bold border border-white bg-white' type={"button"} onClick={() => removePrefecture(prefecturesIndex)} style={{ marginLeft: "16px" }}>
          削除
        </button>
      </div>
    )
  }

  const { fields, append, remove } = useFieldArray({
    control,
    name: 'prefectures',
  });

  const addPrefecture = () => {
    append({ questionText: "" })
  }

  const removePrefecture = (index: number) => {
    remove(index);
  }

  return (
    <div>
      <div className='d-flex'>
        <p className='px-1 small text-black font-weight-bold border border-2 border-dark rounded-pill'>ステップ１</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>
          2
        </p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>
          3
        </p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>
          4
        </p>
      </div>

      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>レクの基本情報を入力</h5>
      </div>
      <hr className='my-2' />

      <div className='isOnline'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>レクの形式を選択</h5>
          <Essential />
        </div>
        <p className='small my-0'>
          登録するレクの形式を選択してください。 郵送レクは材料を渡して当日は施設の方々だけで実施する形式です
        </p>
          {config?.kind.map((k: string, i) => (
            <div key={i}>
              <input type='radio' id='offline' name='format_restriction' {...register('kind')} />
              <label htmlFor='offline'>{k}でレクを実施</label>
            </div>
          ))}
      </div>

      <div className='title'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>タイトルを入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクの分かりやすいタイトルを入力してください</p>
        <input
          type='text'
          className='p-2 w-100 rounded border border-secondary'
          placeholder='タイトルを入力'
          onChange={e => setCount(e.target.value.length)}
          maxLength={50}
          {...register('title', {
            required: true,
            maxLength: 50
          })}
        />
        <p className='small my-0'>{count}/50文字まで</p>
      </div>

      <div className='title'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>サブタイトルを入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクのサブタイトルを入力してください</p>
        <input
          type='text'
          className='p-2 w-100 rounded border border-secondary'
          placeholder='サブタイトルを入力'
          {...register('secondTitle', {
            required: true,
            maxLength: 50
          })}
        />
        <p className='small my-0'>0/50文字まで</p>
      </div>

      <div className='minutes'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>所要時間を入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクに必要な時間を入力してください</p>
        <select
          className='p-2 w-100 rounded border border-secondary'
          {...register('minutes', {
            required: true
          })}
        >
          {config?.minutes.map((minute: number) => (
            <option key={minute} value={minute}>
              {minute}分
            </option>
          ))}
        </select>
      </div>

      <div className='flowOfDay'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>当日のタイムスケジュールを入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクのタイムスケジュールを入力してください</p>
        <textarea
          rows={15}
          className='p-1 w-100 rounded border border-secondary'
          {...register('flowOfDay', {
            required: true
          })}
        />
      </div>

      <div className='description'>
        <div className='mt-4'>
          <h5 className='text-black font-weight-bold'>レクの内容を入力</h5>
        </div>
        <p className='small my-0'>どんな内容で、どんな体験ができるのか分かりやすく入力してください</p>
        <textarea
          rows={15}
          className='p-1 w-100 rounded border border-secondary'
          placeholder='説明を入力'
          {...register('description', {
            maxLength: 500
          })}
        />
        <p className='small my-0'>0/500文字まで</p>
      </div>

      <div className='category'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>レクのカテゴリーを選択</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクのタイムスケジュールを入力してください</p>
        <select
          className='p-2 w-100 rounded border border-secondary'
          placeholder='選択してください'
          {...register('category', {
            required: true
          })}
        >
          {config?.categories.map((category: string) => (
            <option key={category} value={category}>
              {category}
            </option>
          ))}
        </select>
      </div>

      <div className='area'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>受付可能エリアを選択</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクの受付可能エリア（都道府県）を選択してください</p>
        {/* TODO(okubo): arrayで保存できるようにreact hook formを参照する*/}
        {fields.map((field, index) => (
          <PrefectureItem
            key={field.id}
            register={register}
            prefecturesIndex={index}
            removePrefecture={removePrefecture}
            handleNext={handleNext}
            control={control}
          />
        ))}
        <div className={"question-add-action-wrapper"}>
          <p className='text-primary font-weight-bold my-1' onClick={addPrefecture} type={"button"}>
            ＋複数エリアを追加
          </p>
        </div>
      </div>

      <div className='limit_on_the_number_of_people'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>参加人数制限を設定</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクのに参加できる人数に制限を設定することができます</p>
        <input type='radio' id='true' name='number_restriction' onClick={() => setShow(true)}/>
        <label htmlFor='true' onClick={() => setShow(true)}>あり</label>
        <br />
        <input type='radio' id='false' name='number_restriction' onClick={() => setShow(false)}/>
        <label htmlFor='false' onClick={() => setShow(false)}>なし</label>
        { show ? <><p className='small my-0'>何人まで参加できますか？</p><input type='text' className='p-2 w-100 rounded border border-secondary' {...register('capacity')}/></> : null}
      </div>

      <br />
      <button
        type='button'
        className='my-3 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
        onClick={handleNext}
      >
        次へ
      </button>
    </div>
  );
};
