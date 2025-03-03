import { createRoot } from 'react-dom/client';
import React from 'react';
import { useForm, FormProvider } from 'react-hook-form';
import { useBankAccount } from '../hook/useBankAccount';
import BankAccountForm from './BankAccountForm';

const BankAccountNew: React.FC = () => {
  const methods = useForm();
  const { createBankAccount } = useBankAccount();

  const onSubmit = async (data: any) => {
    try {
      await createBankAccount({ bank_account: data });
      alert('銀行口座を作成しました!');
      window.location.href = `/partners/bank_accounts/edit`; 
    } catch (error) {
      console.error(error);
      alert('銀行口座の作成に失敗しました');
      throw new Error(String(error));
    }
  };

  return (
    <FormProvider {...methods}>
      <BankAccountForm onSubmit={onSubmit} />
    </FormProvider>
  );
};

const App: React.FC = () => {
  return <BankAccountNew />;
};

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#bankAccountNew');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});

$(document).ready(() => {
  const elm = document.querySelector('#bankAccountNew');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});
