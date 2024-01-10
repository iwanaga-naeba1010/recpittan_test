import { Api } from '@/infrastructure';
import { UserRecreationPlan } from '@/types';

type UseUserRecreationPlanHook = {
  postUserRecreationPlan: (
    recreationPlanId: number
  ) => Promise<{ data: UserRecreationPlan; redirectUrl: string }>;
};

export const useUserRecreationPlan = (): UseUserRecreationPlanHook => {
  const postUserRecreationPlan = async (
    recreationPlanId: number
  ): Promise<{ data: UserRecreationPlan; redirectUrl: string }> => {
    const data = {
      user_recreation_plan: {
        recreation_plan_id: recreationPlanId,
      },
    };

    const response = await Api.post<{
      userRecreationPlan: UserRecreationPlan;
      redirectUrl: string;
    }>(`user_recreation_plans`, 'customer', data);

    return {
      data: response.data.userRecreationPlan,
      redirectUrl: response.data.redirectUrl,
    };
  };

  return {
    postUserRecreationPlan,
  };
};
