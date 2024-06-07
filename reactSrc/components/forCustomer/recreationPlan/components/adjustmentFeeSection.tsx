import React from 'react';

interface Props {
  adjustmentFee: number;
}

export const AdjustmentFeeSection: React.FC<Props> = ({ adjustmentFee }) => {
  return (
    <div className='row'>
      <div className='col-3'>
        <p>調整費</p>
      </div>
      <div className='col-9'>
        <div className='row'>
          <div className='col-6 align-items-center'>
            <p>オプション</p>
          </div>
          <div className='col-6 align-items-center d-flex justify-content-end'>
            <p>¥{adjustmentFee.toLocaleString()}</p>
          </div>
        </div>
      </div>
    </div>
  );
};
