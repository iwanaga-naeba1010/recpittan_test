import { Recreation } from '@/types';
import React from 'react';
import { useForm } from 'react-hook-form';
import { FirstStep } from './firstStep';
import { RecreationFormValues } from './recreationNewForm';
import { SecondStep } from './secondStep';
import { ThirdStep } from './thirdStep';

export type FormKind = 'title' | 'price' | 'profile';

type Props = {
  kind: FormKind;
  onSubmit: (values: RecreationFormValues) => Promise<void>;
  recreation: Recreation;
};

export const RecreationEditForm: React.FC<Props> = (props) => {
  const { kind, onSubmit, recreation } = props;

  const {
    register,
    handleSubmit,
    getValues,
    setValue,
    formState: { errors }
  } = useForm<RecreationFormValues>({
    mode: 'onChange',
    defaultValues: {
      id: recreation.id,
      title: recreation.title,
      secondTitle: recreation.secondTitle,
      minutes: recreation.minutes,
      price: recreation.price,
      materialPrice: recreation.materialPrice,
      description: recreation.description,
      flowOfDay: recreation.flowOfDay,
      capacity: recreation.capacity,
      extraInformation: recreation.extraInformation,
      youtubeId: recreation.youtubeId,
      borrowItem: recreation.borrowItem,
      additionalFacilityFee: recreation.additionalFacilityFee,
      category: recreation.category.key,
      prefectures: [],
      kind: recreation.kind.key,
      profileId: recreation.profile.id
    }
  });

  return (
    <div>
      <form className='recreation' onSubmit={handleSubmit(onSubmit)}>
        {kind === 'title' && (
          <FirstStep register={register} getValues={getValues} setValue={setValue} errors={errors} />
        )}
        {kind === 'price' && (
          <SecondStep getValues={getValues} register={register} recreation={recreation} />
        )}
        {kind === 'profile' && <ThirdStep register={register} getValues={getValues} />}
        <button
          type='submit'
          className='my-3 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
        >
          保存する
        </button>
      </form>
    </div>
  );
};
