import { Api } from '@/infrastructure';
import { Partner } from '@/types';

type PartnerRequestBody = {
  [key: string]: Record<string, unknown>;
};

type UsePartnersHook = {
  createUser: (requestBody: PartnerRequestBody) => Promise<Partner>;
};

export const usePartner = (): UsePartnersHook => {
  const createUser = async (
    requestBody: PartnerRequestBody
  ): Promise<Partner> => {
    const response = await Api.post<Partner>(
      'registrations',
      'partner',
      requestBody
    );
    return response.data;
  };

  return {
    createUser,
  };
};
