import React, { useState } from 'react';
import { FirstStep } from './firstStep';
import { SecondStep } from './secondStep';
import { ThirdStep } from './thirdStep';

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

  const renderStepNavigation = () => {
    switch (currentStep) {
      case 0:
        return (
          <div className='px-3 border border-top'>
            <button
              type='button'
              disabled={disabled}
              className='my-4 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
              onClick={handleNext}
            >
              次へ進む
            </button>
          </div>
        );
      case 1:
        return (
          <div className='row p-3 border border-top'>
            <div className='col-3'>
              <button
                type='button'
                className='py-2 w-100 rounded text-primary font-weight-bold bg-white border border-white'
                onClick={handlePrev}
              >
                戻る
              </button>
            </div>
            <div className='col-9'>
              <button
                type='button'
                disabled={disabled}
                className='py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
                onClick={handleNext}
              >
                次へ進む
              </button>
            </div>
          </div>
        );
      case 2:
        return (
          <div className='row p-3 border border-top'>
            <div className='col-3'>
              <button
                type='button'
                className='py-2 w-100 rounded text-primary font-weight-bold bg-white border border-white'
                onClick={handlePrev}
              >
                戻る
              </button>
            </div>
            <div className='col-9'>
              <a href="/partners/registrations/complete">
                <button
                  type='button'
                  disabled={disabled}
                  className='py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
                >
                  登録を完了する
                </button>
              </a>
            </div>
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <div>
      <div className='header bg-white'>
        <h2 className='text-black text-center font-weight-bold p-2 border-bottom'>
          新規登録
        </h2>
      </div>
      <form className='partner-registration'>
        {currentStep === 0 && <FirstStep />}
        {currentStep === 1 && <SecondStep />}
        {currentStep === 2 && <ThirdStep />}

        {renderStepNavigation()}
      </form>
    </div>
  );
};
