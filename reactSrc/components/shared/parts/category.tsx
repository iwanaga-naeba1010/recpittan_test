import React from 'react';

type Props = {
  id: number;
  name: string;
};

export const Category: React.FC<Props> = (props) => {
  const { id, name } = props;

  const colorByName = (categoryName: string): string => {
    switch (categoryName) {
      case '音楽':
        return '#F24051';
      case '健康':
        return '#95C15D';
      case '趣味':
        return '#8C428C';
      case '創作':
        return '#4276FC';
      case '旅行':
        return '#FE607D';
      case '飲食':
        return '#F3B30C';
      case 'イベント':
        return '#FD7E14';
      case 'その他':
        return '#339999';
    }
  };

  return (
    <a
      className='category-label event'
      style={{ marginRight: '4px', backgroundColor: colorByName(name) }}
      href={`/customers/recreations?q%5Bcategory_eq%5D=${id}`}
    >
      {name}
    </a>
  );
};
