import { Api } from "@/infrastructure";
import { Recreation } from "@/types";
import { useCallback } from 'react';

type UseRecreationsHook = {
  fetchRecreations: () => Promise<Array<Recreation>>;
};

export const useRecreations = (): UseRecreationsHook => {
  const fetchRecreations = async (): Promise<Array<Recreation>> => {
    const response = await Api.get<{ [key: string]: Recreation }>('recreations', 'partner');
    return Object.values(response.data);
  }

  return {
    fetchRecreations,
  }
}

type UseRecreationHook = {
  fetchRecreation: (id: string) => Promise<Recreation>;
};

export const useRecreation = (): UseRecreationHook => {
  const fetchRecreation = useCallback(async (id: string): Promise<Recreation> => {
    const response = await Api.get<Recreation>(`recreations/${id}`, 'partner');
    return response.data;
  }, []);

  return {
    fetchRecreation,
  };
}

type UseRecreationCreateHook = {
  createRecreation: (requestBody: { [key: string]: Record<string, unknown> }) => Promise<Recreation>;
};

export const UseRecreationCreate = (): UseRecreationCreateHook => {
  const createRecreation = async (requestBody: { [key: string]: Record<string, unknown> }): Promise<Recreation> => {
    const response = await Api.post<Recreation>('recreations', 'partner', requestBody);
    return response.data;
  }

  return {
    createRecreation,
  }
}

type UseRecreationUpdateHook = {
  updateRecreation: (id: string, requestBody: { [key: string]: Record<string, unknown> }) => Promise<Recreation>;
};

export const UseRecreationUpdate = (): UseRecreationUpdateHook => {
  const updateRecreation = async (id: string, requestBody: { [key: string]: Record<string, unknown> }): Promise<Recreation> => {
    const response = await Api.patch<Recreation>(`recreations/${id}`, 'partner', requestBody);
    return response.data;
  }

  return {
    updateRecreation,
  }
}
