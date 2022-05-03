import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import { FirstStep } from './firstStep';
import { SecondStep } from './secondStep';
import { ThirdStep } from './thirdStep';
import { FourthStep } from './fourthStep';

const RecreationNew: React.FC = () => {
  const [currentStep, setCurrentStep] = useState<number>(0);

  const handleNext = () => setCurrentStep(currentStep + 1);
  const handlePrev = () => setCurrentStep(currentStep - 1);

  return (
    <div>
      {currentStep === 0 && <FirstStep handleNext={handleNext} />}
      {currentStep === 1 && <SecondStep handleNext={handleNext} handlePrev={handlePrev} />}
      {currentStep === 2 && <ThirdStep handleNext={handleNext} handlePrev={handlePrev} />}
      {currentStep === 3 && <FourthStep handleNext={handleNext} handlePrev={handlePrev} />}
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#recreationNew');
  if (elm) {
    ReactDOM.render(<RecreationNew />, elm);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#recreationNew');
  if (elm) {
    ReactDOM.render(<RecreationNew />, elm);
  }
});
