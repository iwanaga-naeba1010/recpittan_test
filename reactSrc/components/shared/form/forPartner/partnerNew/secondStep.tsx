import React from 'react';
import { useFormContext } from 'react-hook-form';
import { PartnerInformationForm } from './partnerInformationForm';

export const SecondStep: React.FC = () => {
  const {
    formState: { errors },
  } = useFormContext();

  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-50 bg-black'></div>
      </div>
      <div className='p-3'>
        {Object.keys(errors).length > 0 && (
          <div className='alert alert-danger'>
            <ul>
              {errors.username && <li>{errors.username.message as string}</li>}
              {errors.usernameKana && <li>{errors.usernameKana.message as string}</li>}
              {errors.phoneNumber && <li>{errors.phoneNumber.message as string}</li>}
              {errors.postalCode && <li>{errors.postalCode.message as string}</li>}
              {errors.prefecture && <li>{errors.prefecture.message as string}</li>}
              {errors.city && <li>{errors.city.message as string}</li>}
              {errors.address1 && <li>{errors.address1.message as string}</li>}
            </ul>
          </div>
        )}
        <PartnerInformationForm />
      </div>
    </>
  );
};
