import { Api } from '@/infrastructure';
import { RecreationPlan } from '@/types';

type UseRecreationPlanHook = {
  fetchRecreationPlan: (id: string) => Promise<RecreationPlan>;
};

export const useRecreationPlan = (): UseRecreationPlanHook => {
  const fetchRecreationPlan = async (id: string): Promise<RecreationPlan> => {
    const response = await Api.get<RecreationPlan>(
      `recreation_plans/${id}`,
      'customer'
    );
    return response.data;
  };

  return { fetchRecreationPlan };
};
