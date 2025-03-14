import React from 'react';

type Props = {
  id: number;
  name: string;
};

export const Tag: React.FC<Props> = (props) => {
  const { id, name } = props;
  return (
    <a
      className='my-1 px-1 tag-label font-weight-bold d-inline-block'
      style={{ marginRight: '4px' }}
      href={`/customers/recreations?q%5Btags_id_eq%5D=${id}`}
    >
      {name}
    </a>
  );
};
