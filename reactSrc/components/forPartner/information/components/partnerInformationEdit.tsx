import { createRoot } from 'react-dom/client';
import React, { useEffect } from 'react';
import { useForm, FormProvider, useFormContext } from 'react-hook-form';
import { usePartnerInformation } from '../hook/usePartnerInformation';
import { PartnerInformationForm } from '../../../shared/form/forPartner/partnerNew/partnerInformationForm';

export const InformationEdit: React.FC = () => {
  const {
    formState: { errors },
    handleSubmit,
    setValue,
  } = useFormContext();

  const { fetchPartnerInformation, updatePartnerInformation } =
    usePartnerInformation();

  useEffect(() => {
    const f = async () => {
      const id = window.location.pathname.split('/')[3];
      const partnerInformation = await fetchPartnerInformation(id);
      setValue('userName', partnerInformation.username);
      setValue('userNameKana', partnerInformation.usernameKana);
      setValue('phoneNumber', partnerInformation.partnerInfo.phoneNumber);
      setValue('postalCode', partnerInformation.partnerInfo.postalCode);
      setValue('prefecture', partnerInformation.partnerInfo.prefecture);
      setValue('city', partnerInformation.partnerInfo.city);
      setValue('address1', partnerInformation.partnerInfo.address1);
      setValue('address2', partnerInformation.partnerInfo.address2);
      setValue('companyName', partnerInformation.partnerInfo.companyName);
    };
    f();
  }, [fetchPartnerInformation, setValue]);

  const onSubmit = async (data: any) => {
    const id = window.location.pathname.split('/')[3];
    const requestBody = {
      user: {
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

    try {
      await updatePartnerInformation(id, requestBody);
      alert('パートナー情報を更新しました！');
    } catch (error) {
      alert('情報の更新に失敗しました');
      throw new Error(String(error));
    }
  };

  return (
    <>
      <div className='progress-bar w-100'>
        <div className='bar h-100 w-50 bg-black'></div>
      </div>
      <div className='partner-information p-3'>
        {Object.keys(errors).length > 0 && (
          <div className='alert alert-danger'>
            <ul>
              {errors.userName && <li>{errors.userName.message as string}</li>}
              {errors.userNameKana && (
                <li>{errors.userNameKana.message as string}</li>
              )}
              {errors.phoneNumber && (
                <li>{errors.phoneNumber.message as string}</li>
              )}
              {errors.postalCode && (
                <li>{errors.postalCode.message as string}</li>
              )}
              {errors.prefecture && (
                <li>{errors.prefecture.message as string}</li>
              )}
              {errors.city && <li>{errors.city.message as string}</li>}
              {errors.address1 && <li>{errors.address1.message as string}</li>}
            </ul>
          </div>
        )}
        <form onSubmit={handleSubmit(onSubmit)}>
          <PartnerInformationForm />
          <div className='mt-2'>
            <button
              type='submit'
              className='w-100 py-2 rounded text-white font-weight-bold bg-primary border border-primary'
            >
              保存する
            </button>
          </div>
        </form>
      </div>
    </>
  );
};

const App: React.FC = () => {
  const methods = useForm();

  return (
    <FormProvider {...methods}>
      <InformationEdit />
    </FormProvider>
  );
};

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#partnerInformationEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});

$(document).ready(() => {
  const elm = document.querySelector('#partnerInformationEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});
