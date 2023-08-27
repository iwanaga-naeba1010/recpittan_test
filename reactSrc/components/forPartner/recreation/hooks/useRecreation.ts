import { Api } from "@/infrastructure";
import { Recreation } from "@/types";

type UseRecreationHook = {
  fetchRecreation: (id: string) => Promise<Recreation>;
};

export const useRecreation = (): UseRecreationHook => {
  const fetchRecreation = async (id: string): Promise<Recreation> => {
    const response = await Api.get<Recreation>(`/recreations/${id}`, 'partner');
    return response.data;
  }

  return {
    fetchRecreation,
  }
}

type UseRecreationUpdateHook = {
  updateRecreation: (id: string, requestBody: { [key: string]: Record<string, unknown> }) => Promise<Recreation>;
};

export const UseRecreationUpdate = (): UseRecreationUpdateHook => {
  const updateRecreation = async (id: string, requestBody: { [key: string]: Record<string, unknown> }): Promise<Recreation> => {
    const response = await Api.patch<Recreation>(`/recreations/${id}`, 'partner', requestBody);
    return response.data;
  }

  return {
    updateRecreation,
  }
}
