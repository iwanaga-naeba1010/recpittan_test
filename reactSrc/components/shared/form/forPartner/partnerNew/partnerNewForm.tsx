import React, { useState } from 'react';
import { FirstStep } from './firstStep';
import { FourthStep } from './fourthStep';
import { SecondStep } from './secondStep';
import { ThirdStep } from './thirdStep';
import { FifthStep } from './fifthStep';

// type Props = {
//   onSubmit: (values: RecreationFormValues) => Promise<void>;
// };

export const PartnerNewForm: React.FC = () => {
  const [currentStep, setCurrentStep] = useState<number>(0);
  // const [disabled, setDisabled] = useState<boolean>(true);
  const handleNext = () => {
    setCurrentStep(currentStep + 1);
  };
  const handlePrev = () => setCurrentStep(currentStep - 1);

  // const validate = (keys: Array<string>) => {
  // TODO(okubo): 1.stepに合わせて該当のstepの中身のkeyを渡す
  // TODO(okubo): 2.それぞれの値をgetValuesで取得し、setValueで代入
  // TODO(okubo): 3.代入することでおそらくvalidationエラーが発火するかと思う
  // TODO(okubo): 4.エラーが出たらdisabledがtrueになるので、そこで制御できるかも？
  //}

  const disabled = false;

  return (
    <div>
      <div className="header bg-white">
        <h2 className="text-black text-center font-weight-bold p-2 border-bottom">新規登録</h2>
      </div>
      <form className='partner-registration'>
        {currentStep === 0 && (
          <FirstStep />
        )}
        {currentStep === 1 && (
          <SecondStep />
        )}
        {currentStep === 2 && (
          <ThirdStep />
        )}
        {currentStep === 3 && <FourthStep />}
        {currentStep === 4 && <FifthStep />}

        {currentStep !== 4 && currentStep !== 3 && (
          <div className='px-3'>
            <button
              type='button'
              disabled={disabled}
              className='my-4 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
              onClick={handleNext}
            >
              次へ進む
            </button>
          </div>
        )}
        {currentStep === 3 && (
          <div className='px-3'>
            <button
              type='submit'
              disabled={disabled}
              className='mt-2 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
              onClick={handleNext}
            >
              学習コンテンツに進む(外部サイト)
            </button>
          </div>
        )}
        {currentStep !== 0 && (
          <div className='px-3'>
            <button
              type='button'
              className='w-100 rounded text-primary font-weight-bold bg-white border border-white'
              onClick={handlePrev}
            >
              ＜戻る
            </button>
          </div>
        )}
      </form>
    </div>
  );
};
