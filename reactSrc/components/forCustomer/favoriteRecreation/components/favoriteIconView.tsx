import React, { useEffect } from 'react';
import { createRoot } from 'react-dom/client';
import { useFavoriteRecreations } from '../hooks';
import { FavoriteHeartIcon } from './favoriteHeartIcon';

const FavoriteIconView: React.FC<{ recreationId: number }> = ({
  recreationId,
}) => {
  const [isFavorite, setIsFavorite] = React.useState<boolean>(false);
  const [favoriteId, setFavoriteId] = React.useState<number | null>(null);
  const [refreshCount, setRefreshCount] = React.useState<number>(0);
  const {
    createFavoriteRecreation,
    deleteFavoriteRecreation,
    fetchFavoriteRecreation,
  } = useFavoriteRecreations();

  useEffect(() => {
    const checkIsFavorite = async () => {
      try {
        const response = await fetchFavoriteRecreation(recreationId);
        setIsFavorite(response.isFavorite);
        if (response.isFavorite) {
          setFavoriteId(response.id);
        }
      } catch (error) {
        console.error(error);
      }
    };
    checkIsFavorite();
  }, [recreationId, fetchFavoriteRecreation, refreshCount]);

  const handleClick = async (): Promise<void> => {
    if (isFavorite && favoriteId) {
      await deleteFavoriteRecreation(favoriteId);
      setIsFavorite(false);
      setRefreshCount((prev) => prev + 1);
    } else {
      await createFavoriteRecreation(recreationId);
      setIsFavorite(true);
      setRefreshCount((prev) => prev + 1);
    }
  };

  return <FavoriteHeartIcon isFavorite={isFavorite} onClick={handleClick} />;
};

document.addEventListener('turbolinks:load', () => {
  const elements = document.querySelectorAll('[id^=favoriteIcon_]');
  elements.forEach((elm) => {
    const idStr = elm.id.replace('favoriteIcon_', '');
    const id = parseInt(idStr, 10);
    const root = createRoot(elm);
    root.render(<FavoriteIconView recreationId={id} />);
  });
});

$(document).ready(() => {
  const elements = document.querySelectorAll('[id^=favoriteIcon_]');
  elements.forEach((elm) => {
    const idStr = elm.id.replace('favoriteIcon_', '');
    const id = parseInt(idStr, 10);
    const root = createRoot(elm);
    root.render(<FavoriteIconView recreationId={id} />);
  });
});
