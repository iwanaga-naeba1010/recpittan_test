import { Api } from '@/infrastructure';
import { UserRecreationPlan } from '@/types';

type UseUserRecreationPlanHook = {
  postUserRecreationPlan: (
    recreationPlanId: number,
  ) => Promise<UserRecreationPlan>;
};

export const useUserRecreationPlan = (): UseUserRecreationPlanHook => {
  const postUserRecreationPlan = async (
    recreationPlanId: number,
  ): Promise<UserRecreationPlan> => {
    const data = {
      user_recreation_plan: {
        recreation_plan_id: recreationPlanId,
      },
    };

    const response = await Api.post<UserRecreationPlan>(
      `user_recreation_plans`,
      'customer',
      data
    );
    return response.data;
  };

  return {
    postUserRecreationPlan,
  };
};
