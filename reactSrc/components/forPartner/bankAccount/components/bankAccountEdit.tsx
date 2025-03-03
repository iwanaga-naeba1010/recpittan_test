import { createRoot } from 'react-dom/client';
import React, { useEffect, useState } from 'react';
import { useForm, FormProvider } from 'react-hook-form';
import { useBankAccount } from '../hook/useBankAccount';
import BankAccountForm from './BankAccountForm';

const BankAccountEdit: React.FC = () => {
  const methods = useForm();
  const { fetchBankAccount, updateBankAccount } = useBankAccount();
  const [initialData, setInitialData] = useState<any>(null);
  const [isUpdating, setIsUpdating] = useState(false);

  const loadBankAccount = async () => {
    setIsUpdating(true);
    const bankAccount = await fetchBankAccount();
    setInitialData(bankAccount);
    setIsUpdating(false);
  };

  useEffect(() => {
    loadBankAccount();
  }, []);

  const onSubmit = async (data: any) => {
    try {
      await updateBankAccount({ bank_account: data });
      alert('銀行口座情報を更新しました!');
      await loadBankAccount();
    } catch (error) {
      console.error(error);
      alert('銀行口座情報の更新に失敗しました');
    }
  };

  if (!initialData || isUpdating) return <div>Loading...</div>;

  return (
    <FormProvider {...methods}>
      <BankAccountForm onSubmit={onSubmit} initialData={initialData} />
    </FormProvider>
  );
};

const App: React.FC = () => {
  return <BankAccountEdit />;
};

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#bankAccountEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});

$(document).ready(() => {
  const elm = document.querySelector('#bankAccountEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<App />);
  }
});
