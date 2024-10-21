import React from 'react';

type Props = {
  title: string;
  url: string;
};

export const RecreationItem: React.FC<Props> = (props) => {
  const { title, url } = props;
  return (
    <a href={url}>
      <div className='d-flex bd-highlight border-bottom'>
        <div className='py-2 w-100 bd-highlight'>
          <div>{title}</div>
        </div>
        <div className='py-2 flex-shrink-1 bd-highlight'>
          <i className='fas fa-chevron-right'></i>
        </div>
      </div>
    </a>
  );
};
