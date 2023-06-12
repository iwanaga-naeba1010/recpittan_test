import { LoadingContainer } from '@/components/shared';
import { Api } from '@/infrastructure';
import { Recreation } from '@/types';
import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom';
import { RecreationItem } from './recreationItem';

const RecreationShow: React.FC = () => {
  const [recreation, setRecreation] = useState<Recreation>();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const id = window.location.pathname.split('/')[3];

  useEffect(() => {
    (async () => {
      if (id === undefined) return;
      try {
        const recreationResponse = await Api.get<Recreation>(`recreations/${id}`, 'partner');
        setRecreation({ ...recreationResponse.data });
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, []);

  if (isLoading) {
    return <LoadingContainer />;
  }
  if (!recreation) {
    return <></>;
  }

  return (
    <div className='body bg-white p-3 mb-3'>
      {/* 修正リンクに変更する */}
      <RecreationItem
        title='レクの基本情報'
        content={recreation.title}
        url={`/partners/recreations/${id}/edit?formKind=title`}
      />
      <RecreationItem
        title='金額・メディア・その他の情報'
        content={recreation.title}
        url={`/partners/recreations/${id}/edit?formKind=price`}
      />
      <RecreationItem
        title='レクに表示するプロフィール'
        content={recreation.title}
        url={`/partners/recreations/${id}/edit?formKind=profile`}
      />
      <RecreationItem
        title='このレクの口コミ一覧'
        content={recreation.title}
        url={`/partners/recreations/${id}/evaluations`}
      />
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#recreationShow');
  if (elm) {
    ReactDOM.render(<RecreationShow />, elm);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#recreationShow');
  if (elm) {
    ReactDOM.render(<RecreationShow />, elm);
  }
});
