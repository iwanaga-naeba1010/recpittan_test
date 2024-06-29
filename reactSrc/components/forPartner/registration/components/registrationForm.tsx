import React from 'react';
import ReactDOM from 'react-dom/client'; // Import ReactDOM with createRoot
import { PartnerNewForm } from '@/components/shared/form'; // Import PartnerNewForm

const RegistrationForm: React.FC = () => {
  return <PartnerNewForm />;
};

// Event listener for page transitions with turbolinks
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#registrationForm');
  if (elm) {
    const root = ReactDOM.createRoot(elm);
    root.render(<RegistrationForm />);
  }
});

// Event listener for page refreshes
$(document).ready(() => {
  const elm = document.querySelector('#registrationForm');
  if (elm) {
    const root = ReactDOM.createRoot(elm);
    root.render(<RegistrationForm />);
  }
});
