import { Evaluation, EvaluationReply } from '@/types';
import React, { useState } from 'react';

type Props = {
  evaluation: Evaluation;
};

export const EvaluationItem: React.FC<Props> = (props) => {
  const { evaluation } = props;
  const [replyText, setReplyText] = useState('');
  const [reply, setReply] = useState<EvaluationReply | null>(null);

  const handleSubmit = async () => {
    const response = await fetch(`/api_partner/recreations/${evaluation.report.order.recreation.id}/evaluation_replies`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ 
        evaluation_reply: {
          message: replyText,
          evaluation_id: evaluation.id
        }
      }),
    });

    if (!response.ok) {
      console.error('Request failed');
    } else {
      const replyData = await response.json() as EvaluationReply;
      setReply(replyData);
      console.log('Request succeeded');
    }

    setReplyText('');
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
          <p>返信: {reply ? reply.message : (evaluation.evaluationReply?.message || '')}</p>
        </>
      ) : (
        <>
          <hr />
          <div className='row m-0'>
            <input 
              className='col-10 border rounded' 
              type="text" 
              value={replyText}
              onChange={(e) => setReplyText(e.target.value)}
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
