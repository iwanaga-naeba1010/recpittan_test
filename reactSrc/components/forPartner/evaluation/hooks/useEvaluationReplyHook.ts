import { Api } from '@/infrastructure';
import { EvaluationReply } from '@/types';

type UseEvaluationRepliesHook = {
  postEvaluationReply: (
    evaluationId: number,
    message: string
  ) => Promise<EvaluationReply>;
};

export const useEvaluationReply = (): UseEvaluationRepliesHook => {
  const postEvaluationReply = async (
    evaluationId: number,
    message: string
  ): Promise<EvaluationReply> => {
    const data = {
      evaluation_reply: {
        message,
        evaluation_id: evaluationId,
      },
    };

    const response = await Api.post<EvaluationReply>(
      `/recreations/${evaluationId}/evaluation_replies`,
      'partner',
      data
    );
    return response.data;
  };

  return {
    postEvaluationReply,
  };
};
