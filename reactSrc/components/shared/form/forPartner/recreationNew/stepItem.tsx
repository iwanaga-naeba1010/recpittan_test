import React from 'react';

type Props = {
  currentStep: number;
};
export const StepItem: React.FC<Props> = (props) => {
  const { currentStep } = props;
  return (
    <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>
      {currentStep}
    </p>
  );
};
