import { Recreation } from '@/types';
import React, { useState } from 'react';
import { useForm } from 'react-hook-form';
import { FirstStep } from './firstStep';
import { FourthStep } from './fourthStep';
import { SecondStep } from './secondStep';
import { ThirdStep } from './thirdStep';

type Props = {
  onSubmit: (values: RecreationFormValues) => Promise<void>;
};

// TODO(okubo): どれかの値が原因でonsubmitがエラーになる可能性あり
export type RecreationFormValues = Pick<
  Recreation,
  | 'title'
  | 'secondTitle'
  | 'minutes'
  | 'price'
  | 'materialPrice'
  | 'description'
  | 'flowOfDay'
  | 'capacity'
  | 'extraInformation'
  | 'youtubeId'
  | 'borrowItem'
  | 'additionalFacilityFee'
  | 'imageUrl'
  | 'prefectures'
  | 'category'
  // | 'profile'
  | 'userId'
> & { kind: string; tags: Array<string>; targets: Array<string>; profileId: number };

export const RecreationNewForm: React.FC<Props> = (props) => {
  const { onSubmit } = props;

  const [currentStep, setCurrentStep] = useState<number>(0);
  const {
    register,
    handleSubmit,
    getValues,
    formState: { errors }
  } = useForm<RecreationFormValues>({
    mode: 'onChange',
    defaultValues: {
      title: '',
      secondTitle: '',
      minutes: 30,
      price: 5000,
      materialPrice: 0,
      description: '',
      flowOfDay: '',
      capacity: 0,
      extraInformation: '',
      youtubeId: '',
      borrowItem: '',
      additionalFacilityFee: 0,
      category: 'event',
      prefectures: [],
      kind: 'online'
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
  const handlePrev = () => setCurrentStep(currentStep - 1);

  return (
    <div>
      <form className='recreation' onSubmit={handleSubmit(onSubmit)}>
        {currentStep === 0 && <FirstStep handleNext={handleNext} register={register} getValues={getValues} errors={errors} />}
        {currentStep === 1 && <SecondStep handleNext={handleNext} handlePrev={handlePrev} register={register} />}
        {currentStep === 2 && <ThirdStep handleNext={handleNext} handlePrev={handlePrev} register={register} />}
        {currentStep === 3 && <FourthStep handleNext={handleNext} handlePrev={handlePrev} />}
      </form>
    </div>
  );
};
