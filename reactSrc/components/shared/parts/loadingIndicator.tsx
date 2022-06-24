import React from 'react';

type Props = {
  height?: number;
  width?: number;
};

export const LoadingIndicator: React.FC<Props> = (props) => {
  const { height = 50, width = 50 } = props;

  return <img height={height} width={width} src='/loading.svg' decoding="async"/>;
};

export const LoadingContainer: React.FC = () => {
  return (
    <div className='container'>
      <div className='d-flex justify-content-center'>
        <LoadingIndicator />
      </div>
    </div>
  );
};
