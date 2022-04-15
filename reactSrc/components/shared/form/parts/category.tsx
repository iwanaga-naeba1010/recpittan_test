import React from 'react';

type Props = {
  id: number;
  name: string;
}

export const Category: React.FC<Props> = (props) => {
  const { id, name } = props;
  return (
    <a
      className="category-label event"
      style={{marginRight: '4px', backgroundColor: '#F24051'}}
      href={`/customers/recreations?q%5Bcategory_eq%5D=${id}`}
    >
      {name}
    </a>
  )
}

