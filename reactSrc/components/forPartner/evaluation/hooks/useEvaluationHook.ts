import { Api } from '@/infrastructure';
import { Evaluation } from '@/types';

type UseEvaluationHook = {
  fetchEvaluations: (recreationId: number) => Promise<Array<Evaluation>>;
};

export const useEvaluation = (): UseEvaluationHook => {
  const fetchEvaluations = async (
    recreationId: number
  ): Promise<Array<Evaluation>> => {
    const response = await Api.get<Array<Evaluation>>(
      `recreations/${recreationId}/evaluations`,
      'partner'
    );
    return response.data;
  };

  return { fetchEvaluations };
};
