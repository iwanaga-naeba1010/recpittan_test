import { LoadingContainer } from '@/components/shared';
import { FavoriteRecreation } from '@/types';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { useFavoriteRecreations } from '../hooks';
import { RecreationItem } from './recreationItem';

const FavoriteRecreationIndex: React.FC = () => {
  const [favoriteRecreations, setFavoriteRecreations] = useState<
    Array<FavoriteRecreation>
  >([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const { fetchFavoriteRecreations, deleteFavoriteRecreation } =
    useFavoriteRecreations();

  useEffect(() => {
    (async () => {
      try {
        const fetchedFavoriteRecreations = await fetchFavoriteRecreations();
        setFavoriteRecreations(fetchedFavoriteRecreations);
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, [fetchFavoriteRecreations]);

  if (isLoading) {
    return <LoadingContainer />;
  }

  console.log(favoriteRecreations);

  return (
    <div>
      {favoriteRecreations.length ? (
        <article className='container pt-4 px-0'>
          <div className='row'>
            {favoriteRecreations.map((favoriteRecreation) => (
              <RecreationItem
                key={favoriteRecreation.id}
                favoriteRecreation={favoriteRecreation}
                recreation={favoriteRecreation.recreation}
                deleteFavoriteRecreation={deleteFavoriteRecreation}
                setFavoriteRecreations={setFavoriteRecreations}
                fetchFavoriteRecreations={fetchFavoriteRecreations}
              />
            ))}
          </div>
        </article>
      ) : (
        <div className='m-3'>
          <p>お気に入りにしたレクはありません</p>
        </div>
      )}
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#favoriteRecreationIndex');
  if (elm) {
    const root = createRoot(elm);
    root.render(<FavoriteRecreationIndex />);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#favoriteRecreationIndex');
  if (elm) {
    const root = createRoot(elm);
    root.render(<FavoriteRecreationIndex />);
  }
});
