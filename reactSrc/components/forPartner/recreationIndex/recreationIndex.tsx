import {LoadingContainer} from '@/components/shared';
import { Api } from '@/infrastructure';
import { Recreation } from '@/types';
import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom';
import { RecreationItem } from './recreationItem';

const RecreationIndex: React.FC = () => {
  const [recreations, setRecreations] = useState<Array<Recreation>>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  useEffect(() => {
    (async () => {
      try {
        const recreationsResponse = await Api.get<Array<Recreation>>('/recreations', 'partner');
        setRecreations([...recreationsResponse.data]);
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, []);


  if (isLoading) {
    return <LoadingContainer />;
  }

  return (
    <div>
      {recreations?.length > 0 ? (
        recreations?.map((recreation) => <RecreationItem key={recreation.id} recreation={recreation} />)
      ) : (
        <div className='m-3'>
          <p>まだ登録中のレクはありません</p>
        </div>
      )}
      <div className='m-3'>
        <a href='/partners/recreations/new' className='btn btn-primary btn-lg btn-block w-100 p-3 mb-2 text-white'>
          新規レクを追加
        </a>
      </div>
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#recreationIndex');
  if (elm) {
    ReactDOM.render(<RecreationIndex />, elm);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#recreationIndex');
  if (elm) {
    ReactDOM.render(<RecreationIndex />, elm);
  }
});
