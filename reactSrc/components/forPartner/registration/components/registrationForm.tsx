import React from 'react';
import ReactDOM from 'react-dom/client'; // Import ReactDOM with createRoot
import {
  PartnerNewForm,
} from '@/components/shared/form'; // Import PartnerNewForm

const RegistrationForm: React.FC = () => {
  return (
    <div className='h-100'>
      <div>
        <p>あともう少しです！</p>
        <p>おめでとうございます！あなたは審査を通過しましたのでサービスへ新規登録をお願いします。</p>
      </div>
      <PartnerNewForm />
    </div>
  );
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
