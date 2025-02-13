import React from 'react';

type FavoriteHeartIconProps = {
  isFavorite: boolean;
  onClick: React.MouseEventHandler<HTMLDivElement>;
};

export const FavoriteHeartIcon: React.FC<FavoriteHeartIconProps> = ({
  isFavorite,
  onClick,
}) => {
  const imgSrc = isFavorite ? '/favorite.svg' : '/not_favorite.svg';
  return (
    <div onClick={onClick} style={{ cursor: 'pointer' }}>
      <img src={imgSrc} alt='Heart Icon' />
    </div>
  );
};
