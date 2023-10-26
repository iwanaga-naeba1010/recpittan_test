import React, { useState } from 'react';

type Props = {
  message: string;
};

export const SuccessFlash: React.FC<Props> = (props) => {
  const { message } = props;
  const [isShow, setIsShow] = useState<boolean>(true);

  if (!isShow) {
    return <></>;
  }
  return (
    <div
      className='alert alert-success alert-dismissible fade show'
      role='alert'
    >
      {message}
      <button
        type='button'
        className='btn-close'
        data-bs-dismiss='alert'
        aria-label='Close'
        onClick={() => setIsShow(false)}
      ></button>
    </div>
  );
};
