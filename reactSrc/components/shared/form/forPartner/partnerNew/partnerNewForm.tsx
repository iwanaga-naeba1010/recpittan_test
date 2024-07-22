import React, { useState } from 'react';
import { useForm, FormProvider } from 'react-hook-form';
import { FirstStep } from './firstStep';
import { SecondStep } from './secondStep';
import { usePartner } from '../../../../forPartner/registration/hooks/usePartnerHook';

export const PartnerNewForm: React.FC = () => {
  const [currentStep, setCurrentStep] = useState<number>(0);
  const methods = useForm({
    defaultValues: {
      email: '',
      password: '',
      passwordConfirmation: '',
      userName: '',
      userNameKana: '',
      phoneNumber: '',
      postalCode: '',
      prefecture: '',
      city: '',
      address1: '',
      address2: '',
      companyName: '',
    },
  });

  const { createUser } = usePartner();

  const handleNext = async () => {
    const isValid = await methods.trigger();
    if (isValid) {
      setCurrentStep(currentStep + 1);
    }
  };

  const handlePrev = () => setCurrentStep(currentStep - 1);
  const handleSubmit = async (data: any) => {
    try {
      const requestBody = {
        user: {
          email: data.email,
          password: data.password,
          confirmPassword: data.confirmPassword,
          username: data.userName,
          username_kana: data.userNameKana,
          partner_info_attributes: {
            phone_number: data.phoneNumber,
            postal_code: data.postalCode,
            prefecture: data.prefecture,
            city: data.city,
            address1: data.address1,
            address2: data.address2,
            company_name: data.companyName,
          },
        },
      };

      const user = await createUser(requestBody);
      console.log('User created successfully', user);
      window.location.href = '/partners/registrations/complete';
    } catch (error) {
      console.error('User creation failed', error);
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
