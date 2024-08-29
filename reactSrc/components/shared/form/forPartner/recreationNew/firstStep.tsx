import { ValidationErrorMessage } from '@/components/shared/parts';
import { Essential } from '@/components/shared/parts/essential';
import { Api } from '@/infrastructure';
import { Recreation } from '@/types';
import React, { useEffect, useState } from 'react';
import {
  FieldErrors,
  UseFormGetValues,
  UseFormRegister,
} from 'react-hook-form';
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
  setRecreation?: React.Dispatch<React.SetStateAction<Recreation | undefined>>;
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
  const { register, getValues, recreation, errors } = props;
  const [config, setConfig] = useState<Config>();
  const [show, setShow] = useState(false);
  const [title, setTitle] = useState<string>(getValues('title'));
  const [secondTitle, setSecondTitle] = useState<string>(
    getValues('secondTitle')
  );
  const [description, setDescription] = useState<string>(
    getValues('description')
  );
  const [selectedKind, setSelectedKind] = useState<string>(() => {
    return recreation?.kind?.key || 'visit';
  });
  const [selectedPrefectures, setSelectedPrefectures] = useState<string[]>([]);
  const [newPrefecture, setNewPrefecture] = useState<string>('');

  // recreationが存在する場合にselectedPrefecturesを初期化
  useEffect(() => {
    if (recreation?.prefectures) {
      const initialPrefectures = recreation.prefectures.map(
        (prefecture) => prefecture.name
      );
      setSelectedPrefectures(initialPrefectures);
    }
  }, [recreation]);

  const handleAddPrefecture = () => {
    if (newPrefecture && !selectedPrefectures.includes(newPrefecture)) {
      setSelectedPrefectures([...selectedPrefectures, newPrefecture]);
      setNewPrefecture('');
    }
  };

  const handleRemovePrefecture = (prefecture: string) => {
    setSelectedPrefectures(selectedPrefectures.filter((p) => p !== prefecture));
  };

  useEffect(() => {
    const capacityValue = getValues('capacity');
    setShow(capacityValue > 0);
  }, [getValues]);

  useEffect(() => {
    (async () => {
      try {
        const recreationConfig = await Api.get<Config>(
          `/recreations/config_data`,
          'partner'
        );
        setConfig(recreationConfig.data);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, []);

  const handleKindChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSelectedKind(e.target.value);
  };

  const isVisitSelected = selectedKind === 'visit';

  if (!config) {
    return <></>;
  }

  return (
    <div>
      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>レクの基本情報を入力</h5>
      </div>
      <hr className='my-2' />

      <div className='isVisit'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>レクの形式を選択</h5>
          <Essential />
        </div>
        <p className='small my-0'>
          登録するレクの形式を選択してください。
          郵送レクは材料を渡して当日は施設の方々だけで実施する形式です
        </p>
        {config.kind.map((kind) => (
          <div key={kind.name}>
            <input
              type='radio'
              id={`kind${kind.enumKey}`}
              value={kind.enumKey}
              {...register('kind')}
              defaultChecked={selectedKind === kind.enumKey}
              onChange={handleKindChange}
              name='kind'
            />
            <label htmlFor={`kind${kind.enumKey}`}>
              {kind.name}でレクを実施
            </label>
          </div>
        ))}
      </div>

      <div>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>タイトルを入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>
          レクの分かりやすいタイトルを入力してください(オンラインの記載は必要ありません)
        </p>
        <input
          className='p-2 w-100 rounded border border-secondary'
          placeholder='ピアノと歌のジャズコンサート'
          maxLength={42}
          {...register('title', {
            required: 'タイトルは必須です',
            maxLength: 42,
          })}
          onChange={(e) => setTitle(e.target.value)}
        />
        {errors.title && errors.title.message && (
          <ValidationErrorMessage message={errors.title.message} />
        )}
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
            maxLength: 35,
          })}
          onChange={(e) => setSecondTitle(e.target.value)}
        />
        {errors.secondTitle && errors.secondTitle.message && (
          <ValidationErrorMessage message={errors.secondTitle.message} />
        )}
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
            required: '所要時間は必須です',
          })}
        >
          <option></option>
          {config.minutes.map((minute: number) => (
            <option
              key={minute}
              value={minute}
              selected={getValues('minutes') === minute}
            >
              {minute}分
            </option>
          ))}
        </select>
        {errors.title && errors.title.message && (
          <ValidationErrorMessage message={errors.title.message} />
        )}
      </div>

      <div className='flowOfDay'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>
            当日のタイムスケジュールを入力
          </h5>
          <Essential />
        </div>
        <p className='small my-0'>レクのタイムスケジュールを入力してください</p>
        <textarea
          rows={15}
          placeholder={flowOfDayPlaceholderText}
          className='p-1 w-100 rounded border border-secondary'
          {...register('flowOfDay', {
            required: 'タイムスケジュールは必須です',
          })}
        />
        {errors.flowOfDay && errors.flowOfDay.message && (
          <ValidationErrorMessage message={errors?.flowOfDay?.message} />
        )}
      </div>

      <div className='description'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>レクの内容を入力</h5>
          <Essential />
        </div>
        <p className='small my-0'>
          どんな内容で、どんな体験ができるのか分かりやすく入力してください
        </p>
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
          <h5 className='text-black font-weight-bold'>
            レクのカテゴリーを選択
          </h5>
          <Essential />
        </div>
        <p className='small my-0'>プログラムに合うカテゴリーを選んでください</p>
        <select
          className='p-2 w-100 rounded border border-secondary'
          {...register('category', { required: 'カテゴリーは必須です' })}
        >
          <option value='' disabled selected>
            選択してください
          </option>
          {config.categories.map((category) => (
            <option key={category.enumKey} value={category.enumKey}>
              {category.name}
            </option>
          ))}
        </select>
        {errors.category?.message && (
          <ValidationErrorMessage message={errors?.category?.message} />
        )}
      </div>

      {isVisitSelected && (
        <div className='area'>
          <div className='d-flex mt-4'>
            <h5 className='text-black font-weight-bold'>
              受付可能エリアを選択
            </h5>
            <Essential />
          </div>

          <p className='small my-0'>
            レクの受付可能エリア（都道府県）を選択してください
          </p>

          <div>
            <select
              className='p-2 w-100 rounded border border-secondary'
              value={newPrefecture}
              onChange={(e) => setNewPrefecture(e.target.value)}
            >
              <option value='' disabled>
                都道府県を選択
              </option>
              {config.prefectures.map((prefecture) => (
                <option key={prefecture} value={prefecture}>
                  {prefecture}
                </option>
              ))}
            </select>
          </div>

          <div className={'question-add-action-wrapper'}>
            <button
              type='button'
              className='text-primary bg-white border-0 font-weight-bold my-1'
              onClick={handleAddPrefecture}
            >
              ＋複数エリアを追加
            </button>
          </div>

          <div className='selected-prefectures'>
            {selectedPrefectures.map((prefecture) => (
              <div
                key={prefecture}
                className='d-flex justify-content-between align-items-center'
              >
                <span>{prefecture}</span>
                <button
                  type='button'
                  className='text-danger bg-white border-0 font-weight-bold my-1'
                  onClick={() => handleRemovePrefecture(prefecture)}
                >
                  削除
                </button>
              </div>
            ))}
          </div>

          {selectedPrefectures.map((prefecture, index) => (
            <input
              key={index}
              type='hidden'
              value={prefecture}
              {...register(`prefectures.${index}` as const)}
            />
          ))}
        </div>
      )}

      <div className='limit_on_the_number_of_people position-relative'>
        <div className='d-flex mt-4'>
          <h5 className='text-black font-weight-bold'>参加人数制限を設定</h5>
          <Essential />
        </div>
        <p className='small my-0'>
          レクに参加できる人数制限を設定することができます
        </p>
        <input
          type='radio'
          id='numberOfFacilitiesTrue'
          name='number_of_facilities'
          onChange={() => setShow(true)}
          checked={show}
        />
        <label htmlFor='numberOfFacilitiesTrue'>あり</label>
        <br />
        <input
          type='radio'
          id='numberOfFacilitiesFalse'
          name='number_of_facilities'
          onChange={() => setShow(false)}
          checked={!show}
        />
        <label htmlFor='numberOfFacilitiesFalse'>なし</label>
        {/* falseならvalueは0 */}
        {show && (
          <>
            <p className='small my-0'>何人まで参加できますか？</p>
            <input
              type='text'
              className='p-2 w-100 rounded border border-secondary'
              {...register('capacity', { required: '参加人数制限は必須です' })}
            />
            {errors.capacity && errors.capacity.message && (
              <ValidationErrorMessage message={errors.capacity.message || ''} />
            )}
          </>
        )}

        {errors.capacity && errors.capacity.message && (
          <ValidationErrorMessage message={errors?.capacity?.message} />
        )}
      </div>
    </div>
  );
};
