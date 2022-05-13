import React from 'react';

type Props = {
  message: string;
};

export const ValidationErrorMessage: React.FC<Props> = (props) => {
  const { message } = props;
  return <p className='small text-danger'>{message}</p>;
};
