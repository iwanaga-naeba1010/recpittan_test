import { Api } from "@/infrastructure";
import { Evaluation } from "@/types";

type UseEvaluationHook = {
  fetchEvaluation: (recreationId: number) => Promise<Evaluation>;
};

export const useEvaluation = (): UseEvaluationHook => {
  const fetchEvaluation = async (recreationId: number): Promise<Evaluation> => {
    return (await Api.get<Evaluation>( `/recreations/${recreationId}/evaluation`, "customer")).data;
  };
  return {
    fetchEvaluation,
  };
}
