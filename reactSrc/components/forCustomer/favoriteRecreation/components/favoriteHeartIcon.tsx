import React from 'react';

type FavoriteHeartIconProps = {
  isFavorite: boolean;
  onClick: () => void;
  width: string;
  height: string;
};

export const FavoriteHeartIcon: React.FC<FavoriteHeartIconProps> = ({
  isFavorite,
  onClick,
  width = '20',
  height = '20',
}) => {
  const imgSrc = isFavorite ? '/favorite.svg' : '/not_favorite.svg';

  return (
    <div onClick={onClick} style={{ cursor: 'pointer' }}>
      <img src={imgSrc} alt='Heart Icon' width={width} height={height} />
    </div>
  );
};
