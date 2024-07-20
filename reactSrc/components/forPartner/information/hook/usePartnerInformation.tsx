import { Api } from '@/infrastructure';
import { Partner } from '@/types';
import { useCallback } from 'react';

type PartnerRequestBody = {
  [key: string]: Record<string, unknown>;
};

type UsePartnerInformationHook = {
  fetchPartnerInformation: (id: string) => Promise<Partner>;
  updatePartnerInformation: (
    id: string,
    requestBody: PartnerRequestBody
  ) => Promise<Partner>;
};

export const usePartnerInformation = (): UsePartnerInformationHook => {
  const fetchPartnerInformation = useCallback(
    async (id: string): Promise<Partner> => {
      const response = await Api.get<Partner>(
        `partner_information/${id}`,
        'partner'
      );
      return response.data;
    },
    []
  );

  const updatePartnerInformation = async (
    id: string,
    requestBody: PartnerRequestBody
  ): Promise<Partner> => {
    const response = await Api.patch<Partner>(
      `partner_information/${id}`,
      'partner',
      requestBody
    );
    return response.data;
  };

  return {
    fetchPartnerInformation,
    updatePartnerInformation,
  };
};
