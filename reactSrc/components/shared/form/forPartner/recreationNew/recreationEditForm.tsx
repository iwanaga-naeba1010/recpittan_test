import { Recreation } from '@/types';
import React, { useState } from 'react';
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

  const [currentStep, setCurrentStep] = useState<number>(0);
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

  const handleNext = () => {
    const arr = [
      'title',
      'secondTitle',
      'minutes',
      'price',
      'description',
      'flowOfDay',
      'capacity',
      'materialPrice',
      'materialAmount',
      'extraInformation',
      'youtubeId',
      'borrowItem',
      'additionalFacilityFee',
      'imageUrl',
      'prefectures',
      'category',
      'profile',
      'userId'
    ];
    arr.map((str) => console.log(`${str} is`, getValues(str as any)));
    setCurrentStep(currentStep + 1);
  };

  return (
    <div>
      <form className='recreation' onSubmit={handleSubmit(onSubmit)}>
        {kind === 'title' && (
          <FirstStep
            handleNext={() => null}
            register={register}
            getValues={getValues}
            setValue={setValue}
            errors={errors}
          />
        )}
        {kind === 'price' && (
          <SecondStep handleNext={handleNext} handlePrev={() => null} getValues={getValues} register={register} />
        )}

        {kind === 'price' && <ThirdStep handleNext={handleNext} handlePrev={() => null} register={register} />}

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
