import { LoadingIndicator, ValidationErrorMessage } from '@/components/shared/parts';
import { Essential } from '@/components/shared/parts/essential';
import { Api } from '@/infrastructure';
import { Recreation, RecreationPrefecture } from '@/types';
import React, { useEffect, useState } from 'react';
import { FieldErrors, UseFormGetValues, UseFormRegister } from 'react-hook-form';
import { PrefectureItem } from './prefectureItem';
import { RecreationFormValues } from './recreationNewForm';

type Config = {
  categories: Array<{ name: string; enumKey: string }>;
  minutes: Array<number>;
  prefectures: Array<string>;
  kind: Array<{ name: string; enumKey: string }>;
};

type Props = {
  register: UseFormRegister<RecreationFormValues>;
  getValues: UseFormGetValues<RecreationFormValues>;
  recreation?: Recreation;
  setRecreation?: React.Dispatch<React.SetStateAction<Recreation>>;
  errors: FieldErrors<RecreationFormValues>;
};

// TODO(okubo): 命名は変更する
const flowOfDayPlaceholderText = `5分 挨拶
10分 ピアノ演奏
10分 リクエストコーナー
(皆さんとトークをしながらリクエストにお応えします)
15分 ピアノ弾き語り
10分 合唱
(日本の名曲を皆様ご一緒に)
`;

const descriptionPlaceholderText = `しっとりと大人な時間を堪能できるコンサート。ジャズ、ポップス、クラシックなど日本・世界各国の名曲を演奏します。
幅広いレパートリーから皆様のリクエストにもお応えします！
画面越しでも生演奏の美しい音色をお届けできるよう、様々な機材を駆使しています。
演奏だけでなく曲に関するトークやクイズ、質問など皆様とコミュニケーションを取りながら進める参加型コンサートです。
`;

export const FirstStep: React.FC<Props> = (props) => {
  const { register, getValues, recreation, setRecreation, errors } = props;
  const [config, setConfig] = useState<Config>();
  const [show, setShow] = useState(false);
  const [isSending, setIsSending] = useState<boolean>(false);
  const [title, setTitle] = useState<string>(getValues('title'));
  const [secondTitle, setSecondTitle] = useState<string>(getValues('secondTitle'));
  const [description, setDescription] = useState<string>(getValues('description'));

  useEffect(() => {
    (async () => {
      try {
        const recreationConfig = await Api.get<Config>(`/recreations/config_data`, 'partner');
        setConfig(recreationConfig.data);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, []);

  const handleAddPrefecture = async (prefecture: string) => {
    if (recreation && setRecreation) {
      try {
        const createdPrefecture = await Api.post<RecreationPrefecture>(
          `recreations/${recreation.id}/recreation_prefectures`,
          'partner',
          { recreationPrefecture: { name: prefecture } }
        );
        setRecreation({ ...recreation, prefectures: [...recreation.prefectures, createdPrefecture.data] });
        setIsSending(false);
      } catch (e) {
        console.log(e);
      }
    }
  };

  const handleUpdatePrefecture = async (id: number, prefectureName: string): Promise<void> => {
    if (recreation && setRecreation) {
      try {
        const updatedPrefecture = await Api.patch<RecreationPrefecture>(
          `recreations/${recreation.id}/recreation_prefectures/${id}`,
          'partner',
          { recreationPrefecture: { name: prefectureName } }
        );
        const oldPrefectures = [...recreation.prefectures];
        const index = oldPrefectures.indexOf(oldPrefectures.filter((p) => p.id == id)[0]);
        const newPrefectures = oldPrefectures;
        newPrefectures[index] = updatedPrefecture.data;
        setRecreation({ ...recreation, prefectures: newPrefectures });
      } catch (e) {
        console.log(e);
      }
    }
  };

  const handleRemove = async (id: number): Promise<void> => {
    if (recreation && setRecreation) {
      try {
        await Api.delete(`recreations/${recreation.id}/recreation_prefectures/${id}`, 'partner', {});
        setRecreation({ ...recreation, prefectures: recreation.prefectures.filter((p) => p.id !== id) });
      } catch (e) {
        console.log(e);
      }
    }
  };
  // const disabled = errors?.kind !== undefined || errors?.title !== undefined || errors?.secondTitle !== undefined;

  return (
    <div>
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
        {config?.kind.map((kind) => (
          <div key={kind.name}>
            <input
              type='radio'
              id={`kind${kind.enumKey}`}
              value={kind.enumKey}
              {...register('kind')}
            />
            <label htmlFor={`kind${kind.enumKey}`}>{kind.name}でレクを実施</label>
          </div>
        ))}
      </div>

      <div>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>タイトルを入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクの分かりやすいタイトルを入力してください(オンラインの記載は必要ありません)</p>
        <input
          className='p-2 w-100 rounded border border-secondary'
          placeholder='ピアノと歌のジャズコンサート'
          maxLength={42}
          {...register('title', {
            required: 'タイトルは必須です',
            maxLength: 42
          })}
          onChange={(e) => setTitle(e.target.value)}
        />
        {errors.title && errors.title.message && <ValidationErrorMessage message={errors.title.message} />}
        <p className='small my-0'>{title.length}/42文字まで</p>
      </div>

      <div className='title'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>サブタイトルを入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクのサブタイトルを入力してください</p>
        <input
          className='p-2 w-100 rounded border border-secondary'
          placeholder='世界の名曲とともに、しっとり大人な時間'
          maxLength={35}
          {...register('secondTitle', {
            required: 'サブタイトルは必須です',
            maxLength: 35
          })}
          onChange={(e) => setSecondTitle(e.target.value)}
        />
        {errors.secondTitle && errors.secondTitle.message && <ValidationErrorMessage message={errors?.secondTitle?.message} />}
        <p className='small my-0'>{secondTitle.length}/35文字まで</p>
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
            required: '所要時間は必須です'
          })}
        >
          <option></option>
          {config?.minutes.map((minute: number) => (
            <option key={minute} value={minute} selected={getValues('minutes') === minute}>
              {minute}分
            </option>
          ))}
        </select>
        {errors.title && errors.title.message && <ValidationErrorMessage message={errors.title.message} />}
      </div>

      <div className='flowOfDay'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>当日のタイムスケジュールを入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクのタイムスケジュールを入力してください</p>
        <textarea
          rows={15}
          placeholder={flowOfDayPlaceholderText}
          className='p-1 w-100 rounded border border-secondary'
          {...register('flowOfDay', {
            required: 'タイムスケジュールは必須です'
          })}
        />
        {errors.flowOfDay && errors.flowOfDay.message && <ValidationErrorMessage message={errors?.flowOfDay?.message} />}
      </div>

      <div className='description'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>レクの内容を入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>どんな内容で、どんな体験ができるのか分かりやすく入力してください</p>
        <textarea
          rows={15}
          placeholder={descriptionPlaceholderText}
          className='p-1 w-100 rounded border border-secondary'
          maxLength={500}
          {...register('description', { maxLength: 500 })}
          onChange={(e) => setDescription(e.target.value)}
        />
        <p className='small my-0'>{description.length}/500文字まで</p>
      </div>

      <div className='category'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>レクのカテゴリーを選択</h5>
          <Essential />
        </div>
        <p className='small my-0'>プログラムに合うカテゴリーを選んでください</p>
        <select
          className='p-2 w-100 rounded border border-secondary'
          placeholder='選択してください'
          {...register('category', { required: 'カテゴリーは必須です' })}
        >
          <option></option>
          {config?.categories.map((category) => (
            <option key={category.name} value={category.enumKey} selected={getValues('category') === category.enumKey}>
              {category.name}
            </option>
          ))}
        </select>
        {errors.category?.message && <ValidationErrorMessage message={errors?.category?.message} />}
      </div>

      {recreation !== undefined && recreation?.kind.key === 'visit' && (
        <div className='area'>
          <div className='d-flex mt-4'>
            <h5 className='text-black font-weight-bold'>受付可能エリアを選択</h5>
            <Essential />
          </div>

          <p className='small my-0'>レクの受付可能エリア（都道府県）を選択してください</p>
          {recreation?.prefectures?.map((prefecture) => (
            <PrefectureItem
              key={prefecture.id}
              prefecture={prefecture}
              handleUpdate={handleUpdatePrefecture}
              handleRemove={handleRemove}
              prefectures={config?.prefectures ?? []}
            />
          ))}
          <div className={'question-add-action-wrapper'}>
            {isSending ? (
              <LoadingIndicator />
            ) : (
              <button
                type='button'
                className='text-primary bg-white border-0 font-weight-bold my-1'
                onClick={() => handleAddPrefecture('北海道')}
              >
                ＋複数エリアを追加
              </button>
            )}
          </div>
        </div>
      )}

      <div className='limit_on_the_number_of_people position-relative'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>参加人数制限を設定</h5>
          <Essential />
        </div>
        <p className='small my-0'>レクに参加できる人数制限を設定することができます</p>
        <input type='radio' id='numberOfFacilitiesTrue' name='number_of_facilities' onClick={() => setShow(true)} />
        <label htmlFor='numberOfFacilitiesTrue' onClick={() => setShow(true)}>
          あり
        </label>
        <br />
        <input type='radio' id='numberOfFacilitiesFalse' name='number_of_facilities' onClick={() => setShow(false)} />
        <label htmlFor='numberOfFacilitiesFalse' onClick={() => setShow(false)}>
          なし
        </label>
        {show && (
          <>
            <p className='small my-0'>何人まで参加できますか？</p>
            <input
              type='text'
              className='p-2 w-100 rounded border border-secondary'
              {...register('capacity', { required: '参加人数制限は必須です' })}
            />
          </>
        )}
        {errors.capacity && errors.capacity.message && <ValidationErrorMessage message={errors?.capacity?.message} />}
      </div>
    </div>
  );
};
