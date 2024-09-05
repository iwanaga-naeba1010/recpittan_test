import { Recreation } from '@/types';
import React, { useState } from 'react';
import { useForm } from 'react-hook-form';
import { FirstStep } from './firstStep';
import { FourthStep } from './fourthStep';
import { SecondStep } from './secondStep';
import { Step } from './step';
import { ThirdStep } from './thirdStep';

type Props = {
  onSubmit: (values: RecreationFormValues) => Promise<void>;
};

export type RecreationFormValues = Pick<
  Recreation,
  | 'id'
  | 'title'
  | 'secondTitle'
  | 'minutes'
  | 'price'
  | 'amount'
  | 'materialPrice'
  | 'description'
  | 'flowOfDay'
  | 'capacity'
  | 'extraInformation'
  | 'youtubeId'
  | 'borrowItem'
  | 'bringYourOwnItem'
  | 'additionalFacilityFee'
  | 'imageUrl'
  | 'prefectures'
  | 'userId'
> & {
  kind: string;
  category: string;
  tags: Array<string>;
  targets: Array<string>;
  profileId: number;
};

export const RecreationNewForm: React.FC<Props> = (props) => {
  const { onSubmit } = props;
  const [currentStep, setCurrentStep] = useState<number>(0);
  const {
    register,
    handleSubmit,
    getValues,
    setValue,
    formState: { errors },
  } = useForm<RecreationFormValues>({
    mode: 'onChange',
    reValidateMode: 'onChange',
    defaultValues: {
      title: '',
      secondTitle: '',
      minutes: 30,
      price: 5000,
      amount: 0,
      materialPrice: 0,
      description: '',
      flowOfDay: '',
      capacity: 0,
      extraInformation: '',
      youtubeId: '',
      borrowItem: '',
      bringYourOwnItem: '',
      additionalFacilityFee: 1000,
      category: 'event',
      prefectures: [],
      kind: 'online',
    },
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
      'bringYourOwnItem',
      'additionalFacilityFee',
      'imageUrl',
      'prefectures',
      'category',
      'profile',
      'userId',
    ];
    arr.map((str) => console.log(`${str} is`, getValues(str as any)));
    setCurrentStep(currentStep + 1);
  };

  const handlePrev = () => setCurrentStep(currentStep - 1);

  // const validate = (keys: Array<string>) => {
  // TODO(okubo): 1.stepに合わせて該当のstepの中身のkeyを渡す
  // TODO(okubo): 2.それぞれの値をgetValuesで取得し、setValueで代入
  // TODO(okubo): 3.代入することでおそらくvalidationエラーが発火するかと思う
  // TODO(okubo): 4.エラーが出たらdisabledがtrueになるので、そこで制御できるかも？
  //}

  const disabled =
    errors?.kind !== undefined ||
    errors?.title !== undefined ||
    errors?.secondTitle !== undefined;
  console.log('disabled is ', disabled);

  return (
    <div>
      <form className='recreation' onSubmit={handleSubmit(onSubmit)}>
        <Step totalCounts={4} activeStep={currentStep} />
        {currentStep === 0 && (
          <FirstStep
            register={register}
            getValues={getValues}
            setValue={setValue}
            errors={errors}
          />
        )}
        {currentStep === 1 && (
          <SecondStep getValues={getValues} register={register} />
        )}
        {currentStep === 2 && (
          <ThirdStep register={register} getValues={getValues} />
        )}
        {currentStep === 3 && <FourthStep getValues={getValues} />}

        {currentStep !== 3 && (
          <button
            type='button'
            disabled={disabled}
            className='my-4 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
            onClick={handleNext}
          >
            次へ
          </button>
        )}
        {currentStep === 3 && (
          <button
            type='submit'
            className='mt-2 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
          >
            申請する
          </button>
        )}
        {currentStep !== 0 && (
          <button
            type='button'
            className='w-100 rounded text-primary font-weight-bold bg-white border border-white'
            onClick={handlePrev}
          >
            ＜戻る
          </button>
        )}
      </form>
    </div>
  );
};
