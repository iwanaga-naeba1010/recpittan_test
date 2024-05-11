import { Api } from '@/infrastructure';
import { recreationPlanEstimate } from '@/types';

type UseRecreationPlanEstimateHook = {
  postRecreationPlanEstimate: (
    startMonth: number,
    estimate_number: string,
    number_of_people: number,
    transportation_expenses: number,
    recreationPlanId: number
  ) => Promise<{ data: recreationPlanEstimate; redirectUrl: string }>;
};

export const useRecreationPlanEstimate = (): UseRecreationPlanEstimateHook => {
  const postRecreationPlanEstimate = async (
    startMonth: number,
    estimate_number: string,
    number_of_people: number,
    transportation_expenses: number,
    recreationPlanId: number
  ): Promise<{ data: recreationPlanEstimate; redirectUrl: string }> => {
    const data = {
      recreation_plan_estimate: {
        startMonth: startMonth,
        estimate_number: estimate_number,
        number_of_people: number_of_people,
        transportation_expenses: transportation_expenses,
        recreation_plan_id: recreationPlanId,
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
