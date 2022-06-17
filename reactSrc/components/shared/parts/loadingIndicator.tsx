import React from 'react';
import { TailSpin } from 'react-loader-spinner';

type Props = {
  height?: number;
  width?: number;
};

export const LoadingIndicator: React.FC<Props> = (props) => {
  const { height = 50, width = 50 } = props;

  return <TailSpin height={height} width={width} color='#f5a726' />;
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
