import { Api } from '@/infrastructure';
import { Profile } from '@/types';
import React, { useEffect, useState } from 'react';
import { UseFormGetValues, UseFormRegister } from 'react-hook-form';
import { RecreationFormValues } from './recreationNewForm';

type Props = {
  getValues: UseFormGetValues<RecreationFormValues>;
  register: UseFormRegister<RecreationFormValues>;
};

export const ThirdStep: React.FC<Props> = (props) => {
  const { getValues, register } = props;
  // TODO(okubo): Profileの型も追加しておく
  const [profiles, setProfiles] = useState<Array<Profile>>([]);
  useEffect(() => {
    (async () => {
      try {
        const profilesData = await Api.get<Array<Profile>>(
          `/profiles`,
          'partner'
        );
        console.log('profilesData', profilesData.data);
        setProfiles(profilesData.data);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, []);
  return (
    <div>
      <div className='d-flex'>
        <h5 className='text-black font-weight-bold'>プロフィールを選択</h5>
      </div>
      <hr className='my-2' />

      <div className='mt-4'>
        <h5 className='text-black font-weight-bold'>
          レクに表示するプロフィールを選択
        </h5>
      </div>
      <p className='small my-0'>
        プロフィールを登録していない場合は
        <span>
          <a className='text-primary' href='/partners/profiles/new'>
            新規プロフィール
          </a>
        </span>
        を登録してください。
      </p>
      <p>
        戻るボタンを使うと記入内容が消える場合がありますのでご注意ください。
      </p>
      {profiles.map((profile: Profile, i) => (
        <div key={i}>
          <input
            type='radio'
            id={`profileId${i}`}
            value={profile.id}
            {...register('profileId')}
            defaultChecked={profile.id === getValues('profileId')}
          />
          <label htmlFor={`profileId${i}`}>{profile.name}</label>
        </div>
      ))}
    </div>
  );
};
