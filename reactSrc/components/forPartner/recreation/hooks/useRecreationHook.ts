import { Api } from '@/infrastructure';
import { Recreation } from '@/types';
import { useCallback } from 'react';

type RecreationRequestBody = {
  [key: string]: Record<string, unknown>;
};

// Provides functionality to fetch a list of recreations.
type UseRecreationsHook = {
  fetchRecreation: (id: string) => Promise<Recreation>;
  fetchRecreations: () => Promise<Array<Recreation>>;
  createRecreation: (requestBody: RecreationRequestBody) => Promise<Recreation>;
  updateRecreation: (
    id: string,
    requestBody: RecreationRequestBody
  ) => Promise<Recreation>;
};

export const useRecreations = (): UseRecreationsHook => {
  const fetchRecreation = useCallback(
    async (id: string): Promise<Recreation> => {
      const response = await Api.get<Recreation>(
        `recreations/${id}`,
        'partner'
      );
      return response.data;
    },
    []
  );
  const fetchRecreations = async (): Promise<Array<Recreation>> => {
    const response = await Api.get<Array<Recreation>>(`recreations`, 'partner');
    return response.data;
  };
  const createRecreation = async (
    requestBody: RecreationRequestBody
  ): Promise<Recreation> => {
    const response = await Api.post<Recreation>(
      'recreations',
      'partner',
      requestBody
    );
    return response.data;
  };
  const updateRecreation = async (
    id: string,
    requestBody: RecreationRequestBody
  ): Promise<Recreation> => {
    const response = await Api.patch<Recreation>(
      `recreations/${id}`,
      'partner',
      requestBody
    );
    return response.data;
  };

  return {
    fetchRecreation,
    fetchRecreations,
    createRecreation,
    updateRecreation,
  };
};
