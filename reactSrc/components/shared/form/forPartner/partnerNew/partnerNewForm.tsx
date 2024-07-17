import React, { useState } from 'react';
import { useForm, FormProvider } from 'react-hook-form';
import { FirstStep } from './firstStep';
import { SecondStep } from './secondStep';

export const PartnerNewForm: React.FC = () => {
  const [currentStep, setCurrentStep] = useState<number>(0);
  const methods = useForm({
    defaultValues: {
      email: '',
      password: '',
      confirmPassword: '',
      name: '',
      nameKana: '',
      phoneNumber: '',
      postalCode: '',
      prefecture: '',
      city: '',
      address1: '',
      address2: '',
      companyName: '',
      bankName: '',
      bankCode: '',
      branchName: '',
      branchCode: '',
      accountType: '',
      accountHolderName: '',
    },
  });

  const handleNext = async () => {
    const isValid = await methods.trigger();
    if (isValid) {
      setCurrentStep(currentStep + 1);
    }
  };

  const handlePrev = () => setCurrentStep(currentStep - 1);

  const handleSubmit = async (data: any) => {
    try {
      // First step endpoint
      const firstResponse = await fetch('/api/first_step_endpoint', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: data.email,
          password: data.password,
          confirmPassword: data.confirmPassword,
        }),
      });

      if (!firstResponse.ok) {
        throw new Error('First step submission failed');
      }

      // Second step endpoint
      const secondResponse = await fetch('/api/second_step_endpoint', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          name: data.name,
          nameKana: data.nameKana,
          phoneNumber: data.phoneNumber,
          postalCode: data.postalCode,
          prefecture: data.prefecture,
          city: data.city,
          address1: data.address1,
          address2: data.address2,
          companyName: data.companyName,
        }),
      });

      if (!secondResponse.ok) {
        throw new Error('Second step submission failed');
      }

      // Third step endpoint
      const thirdResponse = await fetch('/api/third_step_endpoint', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          bankName: data.bankName,
          bankCode: data.bankCode,
          branchName: data.branchName,
          branchCode: data.branchCode,
          accountType: data.accountType,
          accountHolderName: data.accountHolderName,
        }),
      });

      if (!thirdResponse.ok) {
        throw new Error('Third step submission failed');
      }

      // 全てのリクエストが成功した場合の処理
      console.log('All steps submitted successfully');
    } catch (error) {
      // エラーハンドリング
      console.error(error);
    }
  };

  const renderStepNavigation = () => {
    switch (currentStep) {
      case 0:
        return (
          <div className='px-3 border border-top'>
            <button
              type='button'
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
                type='submit'
                className='py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
              >
                登録を完了する
              </button>
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
      <FormProvider {...methods}>
        <form
          className='partner-registration'
          onSubmit={methods.handleSubmit(handleSubmit)}
        >
          {currentStep === 0 && <FirstStep />}
          {currentStep === 1 && <SecondStep />}

          {renderStepNavigation()}
        </form>
      </FormProvider>
    </div>
  );
};
