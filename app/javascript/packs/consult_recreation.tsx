/**
 * Orderのprefecture/cityのform
 */

import React, { useEffect } from 'react';
import ReactDOM from 'react-dom'
import { get, post } from '../utils/requests/base';

interface Props {
  recreationId: number;
}
const App: React.FC<Props> = ({ recreationId }): JSX.Element => {
  useEffect(() => {
    // $('co/ntact-price-modal').modal();
  }, []);
  
  const handleSend = async (): Promise<void> => {
    const token = document.querySelector('[name=csrf-token]').getAttribute('content');
    try {
      const response: any = await post(`/api/slack_notifiers`, { recreation_id: recreationId }, { 'X-CSRF-TOKEN': token });
      $('#priceModalTrigger').trigger('click');
    } catch (e) {
      console.log(e);
    }
  }
  return (
    <>
      <button
        type="button"
        role="button"
        className="btn-cpr"
        onClick={handleSend}
      >
        相談・依頼する
      </button>
    </>
  );
}

document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#ConsultRecreation');
  const recreationId = JSON.parse(elm.getAttribute('data-recreationId'));
  console.log(recreationId);

  if (elm) {
    ReactDOM.render(
      <App recreationId={recreationId} />,
      elm,
    )
  }
})
