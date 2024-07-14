import { Api } from '@/infrastructure';
import { Bank } from '@/types';
import { useCallback } from 'react';

type BankAccountRequestBody = {
  [key: string]: Record<string, unknown>;
};

type UseBankAccountHook = {
  fetchBankAccount: (id: string) => Promise<Bank>;
  createBankAccount: (requestBody: BankAccountRequestBody) => Promise<Bank>;
  updateBankAccount: (
    id: string,
    requestBody: BankAccountRequestBody
  ) => Promise<Bank>;
};

export const useBankAccount = (): UseBankAccountHook => {
  const fetchBankAccount = useCallback(async (id: string): Promise<Bank> => {
    const response = await Api.get<Bank>(`bank_account/${id}`, 'partner');
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
      `bank_account/${id}`,
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
