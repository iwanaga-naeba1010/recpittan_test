/**
 * 料金表示がない場合、slackに通知送るので、その処理
 */

import React from 'react';
import { createRoot } from 'react-dom/client';
import { post } from '../utils/requests/base';

interface Props {
  recreationId: number;
}

const App: React.FC<Props> = ({ recreationId }): JSX.Element => {
  const handleSend = async (): Promise<void> => {
    const tokenElement = document.querySelector('[name=csrf-token]');
    const token = tokenElement?.getAttribute('content') || '';
    try {
      await post(
        `/api/slack_notifiers`,
        { recreation_id: recreationId },
        { 'X-CSRF-TOKEN': token }
      );
      $('#priceModalTrigger').trigger('click');
    } catch (e) {
      console.log(e);
    }
  };
  return (
    <>
      <button
        type='button'
        role='button'
        className='btn-cpr'
        onClick={handleSend}
      >
        相談・依頼する
      </button>
    </>
  );
};

document.addEventListener('turbolinks:load', () => {
  const isRecreationShowPage = /\/customers\/recreations\/[0-9]/.exec(
    window.location.pathname
  );
  console.log('isRecreationShowPage is ', isRecreationShowPage);
  if (isRecreationShowPage !== null) {
    const elm = document.querySelector('#ConsultRecreation');
    const recreationId = window.location.pathname.split('/')[3];
    console.log(window.location.pathname.split('/')[3]);

    if (elm && recreationId) {
      const root = createRoot(elm);
      root.render(<App recreationId={Number(recreationId)} />);
    }
  }
});
