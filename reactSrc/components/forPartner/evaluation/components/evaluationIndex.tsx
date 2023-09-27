import { LoadingContainer } from '@/components/shared';
import { Evaluation } from '@/types';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { EvaluationItem } from './evaluationItem';
import { useEvaluation } from '../hooks';

const EvaluationIndex: React.FC = () => {
  const [evaluations, setEvaluations] = useState<Array<Evaluation>>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { fetchEvaluations } = useEvaluation();
  const id = window.location.pathname.split('/')[3];

  useEffect(() => {
    (async () => {
      if (!id) return;
      try {
        const fetchedEvaluations = await fetchEvaluations(Number(id));
        setEvaluations(fetchedEvaluations);
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, [fetchEvaluations, id]);

  if (isLoading) {
    return <LoadingContainer />;
  }

  return (
    <div>
      {evaluations.length ? (
        evaluations.map((evaluation) => (
          <EvaluationItem key={evaluation.id} evaluation={evaluation} />
        ))
      ) : (
        <div className='m-3'>
          <p>まだ口コミはありません</p>
        </div>
      )}
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#evaluationIndex');
  if (elm) {
    const root = createRoot(elm);
    root.render(<EvaluationIndex />);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#evaluationIndex');
  if (elm) {
    const root = createRoot(elm);
    root.render(<EvaluationIndex />);
  }
});
