import React from 'react';

type Props = {
  errors: Array<string>;
};

export const Error: React.FC<Props> = (props) => {
  const { errors } = props;
  return (
    <div className='alert alert-danger' role='alert'>
      <ul>
        {errors.map((error,i) => (
          <li key={i}>{error}</li>
        ))}
      </ul>
    </div>
  );
};
