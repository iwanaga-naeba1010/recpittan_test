import { Api } from "@/infrastructure";
import { Recreation } from "@/types";

type UseRecreationUpdateHook = {
  updateRecreation: (id: string, requestBody: { [key: string]: Record<string, unknown> }) => Promise<Recreation>;
};

export const useRecreationEdit = (): UseRecreationUpdateHook => {
  const updateRecreation = async (id: string, requestBody: { [key: string]: Record<string, unknown> }): Promise<Recreation> => {
    const response = await Api.patch<Recreation>(`/recreations/${id}`, 'partner', requestBody);
    return response.data;
  }

  return {
    updateRecreation,
  }
}
