import { Api } from '@/infrastructure';
import { Bank, BankAccount } from '@/types';
import { useCallback } from 'react';

type BankAccountRequestBody = {
  [key: string]: Record<string, unknown>;
};

type UseBankAccountHook = {
  fetchBankAccount: () => Promise<BankAccount>;
  createBankAccount: (requestBody: BankAccountRequestBody) => Promise<Bank>;
  updateBankAccount: (requestBody: BankAccountRequestBody) => Promise<Bank>;
};

export const useBankAccount = (): UseBankAccountHook => {
  const fetchBankAccount = useCallback(async (): Promise<BankAccount> => {
    const response = await Api.get<BankAccount>('bank_accounts', 'partner');
    return response.data;
  }, []);

  const createBankAccount = async (
    requestBody: BankAccountRequestBody
  ): Promise<Bank> => {
    const response = await Api.post<Bank>(
      'bank_accounts',
      'partner',
      requestBody
    );
    return response.data;
  };

  const updateBankAccount = async (
    requestBody: BankAccountRequestBody
  ): Promise<Bank> => {
    const response = await Api.patch<Bank>(
      'bank_accounts',
      'partner',
      requestBody
    );
    return response.data;
  };

  return {
    fetchBankAccount,
    createBankAccount,
    updateBankAccount,
  };
};
