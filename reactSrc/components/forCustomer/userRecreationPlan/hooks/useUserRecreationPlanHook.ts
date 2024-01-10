import { Api } from '@/infrastructure';
import { UserRecreationPlan } from '@/types';

type UseUserRecreationPlanHook = {
  fetchUserRecreationPlan: (id: number) => Promise<UserRecreationPlan>;
};

export const useUserRecreationPlan = (): UseUserRecreationPlanHook => {
  const fetchUserRecreationPlan = async (
    id: number
  ): Promise<UserRecreationPlan> => {
    const response = await Api.get<UserRecreationPlan>(
      `user_recreation_plans/${id}`,
      'customer'
    );
    return response.data;
  };

  return { fetchUserRecreationPlan };
};
