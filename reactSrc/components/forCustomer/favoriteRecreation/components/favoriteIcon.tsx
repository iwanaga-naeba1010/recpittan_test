import React from 'react';
import { FavoriteHeartIcon } from './favoriteHeartIcon';

type Props = {
  onClick: () => void;
};

type FavoriteIconProps = {
  isFavorite: boolean;
};

export const FavoriteIcon: React.FC<Props & FavoriteIconProps> = ({
  onClick,
  isFavorite,
}) => {
  return (
    <FavoriteHeartIcon
      isFavorite={isFavorite}
      onClick={onClick}
      width='20'
      height='20'
    />
  );
};
