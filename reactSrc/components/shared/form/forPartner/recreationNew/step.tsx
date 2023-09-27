import React from 'react';
import { StepItem } from './stepItem';

type Props = {
  totalCounts: number;
  activeStep: number;
};

export const Step: React.FC<Props> = ({ totalCounts, activeStep }) => {
  return (
    <div className='d-flex'>
      {[...Array(totalCounts)].map((_, step) =>
        step === activeStep ? (
          <p
            key={step}
            className='px-1 small text-black font-weight-bold border border-2 border-dark rounded-pill'
          >
            ステップ{step + 1}
          </p>
        ) : (
          <StepItem currentStep={step + 1} key={step} />
        )
      )}
    </div>
  );
};
