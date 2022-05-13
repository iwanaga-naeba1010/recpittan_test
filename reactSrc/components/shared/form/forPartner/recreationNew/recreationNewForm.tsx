import { Error } from '@/components/shared/parts';
import { Recreation } from '@/types';
import { isEmpty } from '@/utils';
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
  | 'description'
  | 'flowOfDay'
  | 'capacity'
  | 'materialPrice'
  | 'materialAmount'
  | 'extraInformation'
  | 'youtubeId'
  | 'borrowItem'
  | 'additionalFacilityFee'
  | 'imageUrl'
  | 'prefectures'
  | 'category'
  | 'categoryId'
  | 'profile'
  | 'userId'
> & { kind: string; tags: Array<string>; targets: Array<string> };

export const RecreationNewForm: React.FC<Props> = (props) => {
  const { onSubmit } = props;

  const [currentStep, setCurrentStep] = useState<number>(0);
  const handleNext = () => setCurrentStep(currentStep + 1);
  const handlePrev = () => setCurrentStep(currentStep - 1);
  const { register, handleSubmit, getValues } = useForm<RecreationFormValues>({
    mode: 'onChange',
    defaultValues: { prefectures: [] }
  });
  const [errors, setErrors] = useState<Array<string>>([]);

  return (
    <div>
      {!isEmpty(errors) && <Error errors={errors} />}
      <form className='recreation' onSubmit={handleSubmit(onSubmit)}>
        {currentStep === 0 && <FirstStep handleNext={handleNext} register={register} getValues={getValues} />}
        {currentStep === 1 && <SecondStep handleNext={handleNext} handlePrev={handlePrev} register={register} />}
        {currentStep === 2 && <ThirdStep handleNext={handleNext} handlePrev={handlePrev} register={register} />}
        {currentStep === 3 && <FourthStep handleNext={handleNext} handlePrev={handlePrev} />}
      </form>
    </div>
  );
};
