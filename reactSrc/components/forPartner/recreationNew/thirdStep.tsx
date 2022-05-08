import React from 'react';

type Props = {
  handleNext: () => void;
  handlePrev: () => void;
};

export const ThirdStep: React.FC<Props> = (props) => {
  const { handleNext, handlePrev } = props;
  return (
    <div>
      <div className='d-flex'>
        <p className='px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>✔︎</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>✔︎</p>
        <p className='ms-1 px-1 small text-black font-weight-bold border border-2 border-dark rounded-pill'>ステップ3</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>4</p>
      </div>

      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>プロフィールを選択</h5>
      </div>
      <hr className='my-2'/>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクに表示するプロフィールを選択</h5>
      </div>
      <p className='small my-0'>プロフィールを登録していない場合は<span><a className='text-primary'>新規プロフィール</a></span>を登録してください。</p>
      <input type='radio' id='true' name="number_restriction" />
      <label htmlFor='true'>プロフィールA</label>
      <br />

      <button type='button' className="my-3 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary" onClick={handleNext}>次へ</button>
      <button type='button' className="w-100 rounded text-primary font-weight-bold bg-white border border-white" onClick={handlePrev}>＜戻る</button>
    </div>
  );
};
