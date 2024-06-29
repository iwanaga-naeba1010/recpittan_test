import { Api } from '@/infrastructure';
import { recreationPlanEstimate } from '@/types';

type UseRecreationPlanEstimateHook = {
  postRecreationPlanEstimate: (
    startMonth: number,
    numberOfPeople: number,
    transportationExpenses: number,
    recreationPlanId: number
  ) => Promise<{ data: recreationPlanEstimate; redirectUrl: string }>;
};

export const useRecreationPlanEstimate = (): UseRecreationPlanEstimateHook => {
  const postRecreationPlanEstimate = async (
    startMonth: number,
    numberOfPeople: number,
    transportationExpenses: number,
    recreationPlanId: number
  ): Promise<{ data: recreationPlanEstimate; redirectUrl: string }> => {
    const data = {
      recreationPlanEstimate: {
        startMonth,
        numberOfPeople,
        transportationExpenses,
        recreationPlanId,
      },
    };

    const response = await Api.post<{
      recreationPlanEstimate: recreationPlanEstimate;
      redirectUrl: string;
    }>(`recreation_plan_estimates`, 'customer', data);

    return {
      data: response.data.recreationPlanEstimate,
      redirectUrl: response.data.redirectUrl,
    };
  };

  return {
    postRecreationPlanEstimate,
  };
};
