import { Api } from '@/infrastructure';
import { Bank, BankAccount } from '@/types';
import { useCallback } from 'react';

type BankAccountRequestBody = {
  [key: string]: Record<string, unknown>;
};

type UseBankAccountHook = {
  fetchBankAccount: (id: string) => Promise<BankAccount>;
  createBankAccount: (requestBody: BankAccountRequestBody) => Promise<Bank>;
  updateBankAccount: (
    id: string,
    requestBody: BankAccountRequestBody
  ) => Promise<Bank>;
};

export const useBankAccount = (): UseBankAccountHook => {
  const fetchBankAccount = useCallback(async (): Promise<BankAccount> => {
    const response = await Api.get<BankAccount>(`bank_account`, 'partner');
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
    id: string,
    requestBody: BankAccountRequestBody
  ): Promise<Bank> => {
    const response = await Api.patch<Bank>(
      `bank_accounts/${id}`,
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
