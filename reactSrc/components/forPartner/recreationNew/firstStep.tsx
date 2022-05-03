import { Essential } from '@/components/shared/parts/essential';
import React from 'react';

type Props = {
  handleNext: () => void;
};

export const FirstStep: React.FC<Props> = (props) => {
  const { handleNext } = props;
  return (
    <div>
      <div className='d-flex'>
        <p className='px-1 small text-black font-weight-bold border border-2 border-dark rounded-pill'>ステップ１</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>2</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>3</p>
        <p className='ms-1 px-1 small text-secondary font-weight-bold border border-2 border-secondary rounded-circle'>4</p>
      </div>

      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>レクの基本情報を入力</h5>
      </div>
      <hr className='my-2'/>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>レクの形式を選択</h5>
        < Essential/>
      </div>
      <p className='small my-0'>登録するレクの形式を選択してください。 郵送レクは材料を渡して当日は施設の方々だけで実施する形式です</p>
      <input type='radio' id='online' name="format_restriction" />
      <label htmlFor='online'>オンラインでレクを実施</label>
      <br />
      <input type='radio' id='offline' name="format_restriction" />
      <label htmlFor='offline'>オフライン（現地）でレクを実施</label>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>タイトルを入力</h5>
        < Essential/>
      </div>
      <p className='small my-0'>レクの分かりやすいタイトルを入力してください</p>
      <input type='text' className='p-2 w-100 rounded border border-secondary' placeholder='タイトルを入力'></input>
      <p className='small my-0'>0/50文字まで</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>サブタイトルを入力</h5>
        < Essential/>
      </div>
      <p className='small my-0'>レクのサブタイトルを入力してください</p>
      <input type='text' className='p-2 w-100 rounded border border-secondary' placeholder='サブタイトルを入力'></input>
      <p className='small my-0'>0/50文字まで</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>所要時間を入力</h5>
        < Essential/>
      </div>
      <p className='small my-0'>レクに必要な時間を入力してください</p>
      <select className='p-2 w-100 rounded border border-secondary'></select>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>当日のタイムスケジュールを入力</h5>
        < Essential/>
      </div>
      <p className='small my-0'>レクのタイムスケジュールを入力してください</p>
      <input type='text' className='w-100 rounded border border-secondary'></input>

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>レクの内容を入力</h5>
      </div>
      <p className='small my-0'>どんな内容で、どんな体験ができるのか分かりやすく入力してください</p>
      <input type='text' className='w-100 rounded border border-secondary'></input>
      <p className='small my-0'>0/500文字まで</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>レクのカテゴリーを選択</h5>
        < Essential/>
      </div>
      <p className='small my-0'>レクのタイムスケジュールを入力してください</p>
      <select className='p-2 w-100 rounded border border-secondary' placeholder='選択してください'></select>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>受付可能エリアを選択</h5>
        < Essential/>
      </div>
      <p className='small my-0'>レクの受付可能エリア（都道府県）を選択してください</p>
      <select className='p-2 w-100 rounded border border-secondary' placeholder='選択してください'></select>
      <p className='text-primary font-weight-bold my-1'>＋複数エリアを追加</p>

      <div className='d-flex mt-4'>
        <h5 className='text-black font-weight-bold'>参加人数制限を設定</h5>
        < Essential/>
      </div>
      <p className='small my-0'>レクのに参加できる人数に制限を設定することができます</p>
      <input type='radio' id='true' name="number_restriction" />
      <label htmlFor='true'>あり</label>
      <br />
      <input type='radio' id='false' name="number_restriction" />
      <label htmlFor='false'>なし</label>
      <p className='small my-0'>何人まで参加できますか？</p>
      <input type='text' className='p-2 w-100 rounded border border-secondary'></input>
      <br />
      <button type='button' className="my-3 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary" onClick={handleNext}>次へ</button>
    </div>
  );
};
