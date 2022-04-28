/**
 * 料金表示がない場合、slackに通知送るので、その処理
 */

import React from 'react';
import ReactDOM from 'react-dom';
import { post } from '../utils/requests/base';

interface Props {
  recreationId: number;
}

const App: React.FC<Props> = ({ recreationId }): JSX.Element => {
  const handleSend = async (): Promise<void> => {
    const token = document.querySelector('[name=csrf-token]').getAttribute('content');
    try {
      await post(`/api/slack_notifiers`, { recreation_id: recreationId }, { 'X-CSRF-TOKEN': token });
      $('#priceModalTrigger').trigger('click');
    } catch (e) {
      console.log(e);
    }
  };
  return (
    <>
      <button type='button' role='button' className='btn-cpr' onClick={handleSend}>
        相談・依頼する
      </button>
    </>
  );
};

document.addEventListener('turbolinks:load', () => {
  console.log('hogehogehoge!!!!!');
  // console.log('window is', window.location.pathname.match(/\/customers\/recreations\/[0-9]/));
  const isRecreationShowPage = /\/customers\/recreations\/[0-9]/.exec(window.location.pathname)
  console.log('isRecreationShowPage is ', isRecreationShowPage);
  if (isRecreationShowPage !== null) {
    const elm = document.querySelector('#ConsultRecreation');
    const recreationId = window.location.pathname.split('/')[3];
    console.log(window.location.pathname.split('/')[3]);
    // const recreationId = JSON.parse(elm?.getAttribute('data-recreationId'));

    if (elm && recreationId) {
      ReactDOM.render(<App recreationId={Number(recreationId)} />, elm);
    }
  }
});
