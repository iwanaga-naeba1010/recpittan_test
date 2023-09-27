import React from 'react';

type Props = {
  onClick?: () => void;
};

type FavoriteIconProps = {
  isFavorited: boolean;
};

export const FavoriteIcon: React.FC<Props & FavoriteIconProps> = ({
  onClick,
  isFavorited,
}) => {
  const fillColor = isFavorited ? 'rgb(255, 48, 64)' : 'none';
  const strokeColor = isFavorited ? 'rgb(255, 48, 64)' : '#6C757D';

  return (
    <div onClick={onClick} style={{ cursor: 'pointer' }}>
      <svg
        width='20'
        height='20'
        version='1.0'
        xmlns='http://www.w3.org/2000/svg'
        viewBox='0 0 1280.000000 1244.000000'
      >
        <g transform='translate(0.000000,1244.000000) scale(0.100000,-0.100000)'>
          <path
            d='M3595 10494 c-16 -2 -73 -9 -125 -15 -785 -89 -1525 -534 -1950 -1172 -505 -756 -581 -1802 -203 -2762 234 -592 615 -1136 1223 -1746 440 -440 761 -713 1790 -1521 723 -568 973 -780 1280 -1088 285 -285 475 -527 591 -753 24 -48 46 -87 49 -87 3 0 20 29 38 65 150 304 458 666 907 1066 253 225 441 378 1130 919 900 707 1207 970 1640 1404 468 469 775 866 1023 1321 414 761 537 1622 342 2391 -112 440 -324 822 -635 1143 -523 540 -1245 841 -2014 841 -899 0 -1671 -412 -2116 -1130 -112 -182 -234 -457 -288 -651 -21 -74 -37 -101 -37 -61 0 45 -109 334 -184 487 -367 749 -1011 1208 -1876 1335 -75 11 -528 22 -585 14z'
            fill={fillColor}
            stroke={strokeColor}
            strokeWidth='800'
          />
        </g>
      </svg>
    </div>
  );
};
