import { Api } from "@/infrastructure";
import { Recreation } from "@/types";
import { useCallback } from 'react';

type RecreationRequestBody = {
  [key: string]: Record<string, unknown>;
};

// Provides functionality to fetch a list of recreations.
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

// Provides functionality to fetch details of a specific recreation by ID.
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

// Provides functionality to create a new recreation entry.
type UseRecreationCreateHook = {
  createRecreation: (requestBody: RecreationRequestBody) => Promise<Recreation>;
};

export const useRecreationCreate = (): UseRecreationCreateHook => {
  const createRecreation = async (requestBody: RecreationRequestBody): Promise<Recreation> => {
    const response = await Api.post<Recreation>('recreations', 'partner', requestBody);
    return response.data;
  }

  return {
    createRecreation,
  }
}

// Provides functionality to update an existing recreation entry by ID.
type UseRecreationUpdateHook = {
  updateRecreation: (id: string, requestBody: RecreationRequestBody) => Promise<Recreation>;
};

export const useRecreationUpdate = (): UseRecreationUpdateHook => {
  const updateRecreation = async (id: string, requestBody: RecreationRequestBody): Promise<Recreation> => {
    const response = await Api.patch<Recreation>(`recreations/${id}`, 'partner', requestBody);
    return response.data;
  }

  return {
    updateRecreation,
  }
}
