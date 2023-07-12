import { Evaluation } from '@/types';
import React from 'react';

type Props = {
  evaluation: Evaluation;
};

export const EvaluationItem: React.FC<Props> = (props) => {
  const { evaluation } = props;

  return (
    <div className='my-2 border-bottom p-3'>
      <div>
        <p>投稿者: {evaluation.report.order.user.company.facilityName}</p>
        <p>本文: {evaluation.message}</p>
      </div>
    </div>
  );
};
