import React from 'react';
import { FavoriteHeartIcon } from './favoriteHeartIcon';

type Props = {
  onClick?: () => void;
};

type FavoriteIconProps = {
  isFavorite: boolean;
};

export const FavoriteIcon: React.FC<Props & FavoriteIconProps> = ({ onClick, isFavorite }) => {
  const handleClick = onClick || (() => {
    console.log('onClick is not defined');
  });

  return (
    <>
      <FavoriteHeartIcon 
        isFavorite={isFavorite}
        onClick={handleClick}
        width="20"
        height="20"
      />
    </>
  );
};
