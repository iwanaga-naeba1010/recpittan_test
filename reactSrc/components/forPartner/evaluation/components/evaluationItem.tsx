import { Evaluation, EvaluationReply } from '@/types';
import React, { useState } from 'react';
import { useEvaluationReply } from '../hooks';

type Props = {
  evaluation: Evaluation;
};

export const EvaluationItem: React.FC<Props> = (props) => {
  const { evaluation } = props;
  const { postEvaluationReply } = useEvaluationReply();
  const [replyText, setReplyText] = useState('');
  const [reply, setReply] = useState<EvaluationReply | null>(null);
  const handleSubmit = async (): Promise<void> => {
    if (replyText.trim() === '') {
      alert('入力してください');
      return;
    }

    try {
      const replyData = await postEvaluationReply(evaluation.id, replyText);
      setReply(replyData);
      setReplyText('');
    } catch (e) {
      if (e instanceof Error) {
        throw new Error(e.message);
      } else {
        throw new Error('An unexpected error occurred.');
      }
    }
  };

  return (
    <div className='my-2 border-bottom p-3'>
      <div>
        <p>投稿者: {evaluation.report.order.user.company.facilityName}</p>
        <p>本文: {evaluation.message}</p>
      </div>
      {reply || evaluation.evaluationReply ? (
        <>
          <hr />
          <p>
            返信:{' '}
            {reply ? reply.message : evaluation.evaluationReply?.message || ''}
          </p>
        </>
      ) : (
        <>
          <hr />
          <div className='row m-0'>
            <input
              className='col-10 border rounded'
              type='text'
              value={replyText}
              onChange={(e) => setReplyText(e.target.value)}
              required
            />
            <button
              className='col-1 ms-1 btn bg-primary text-white fw-bold'
              onClick={handleSubmit}
            >
              送信
            </button>
          </div>
        </>
      )}
    </div>
  );
};
