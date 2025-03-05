import { UseFile } from '@/components/forPartner';
import { Recreation } from '@/types';
import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { FirstStep } from './firstStep';
import { RecreationFormValues } from './recreationNewForm';
import { SecondStep } from './secondStep';
import { ThirdStep } from './thirdStep';
import { ImageStep } from './imageStep';

export type FormKind = 'title' | 'price' | 'profile' | 'file';

type Props = {
  kind: FormKind;
  onSubmit: (values: RecreationFormValues) => Promise<void>;
  recreation: Recreation;
  setRecreation: React.Dispatch<React.SetStateAction<Recreation | undefined>>;
  useFile: UseFile;
};

export const RecreationEditForm: React.FC<Props> = (props) => {
  const { kind, onSubmit, recreation, setRecreation, useFile } = props;

  const {
    register,
    handleSubmit,
    getValues,
    setValue,
    formState: { errors },
  } = useForm<RecreationFormValues>({
    mode: 'onChange',
    defaultValues: {
      id: recreation.id,
      title: recreation.title,
      secondTitle: recreation.secondTitle,
      minutes: recreation.minutes,
      price: recreation.price,
      amount: recreation.amount,
      materialPrice: recreation.materialPrice,
      description: recreation.description,
      flowOfDay: recreation.flowOfDay,
      capacity: recreation.capacity,
      extraInformation: recreation.extraInformation,
      youtubeId: recreation.youtubeId,
      borrowItem: recreation.borrowItem,
      bringYourOwnItem: recreation.bringYourOwnItem,
      additionalFacilityFee: recreation.additionalFacilityFee,
      category: recreation.category.key,
      prefectures: recreation.prefectures.map((pref) => ({
        id: pref.id,
        name: pref.name,
      })),
      kind: recreation.kind.key,
      profileId: recreation.profile.id,
      isWithholdingTax: recreation.isWithholdingTax,
    },
  });

  useEffect(() => {
    setValue(
      'prefectures',
      recreation.prefectures.map((pref) => ({
        id: pref.id,
        name: pref.name,
      }))
    );
  }, [recreation.prefectures, setValue]);

  return (
    <div>
      <form className='recreation' onSubmit={handleSubmit(onSubmit)}>
        {kind === 'title' && (
          <FirstStep
            register={register}
            getValues={getValues}
            setValue={setValue}
            recreation={recreation}
            setRecreation={setRecreation}
            errors={errors}
          />
        )}
        {kind === 'price' && (
          <SecondStep
            getValues={getValues}
            register={register}
            recreation={recreation}
          />
        )}
        {kind === 'profile' && (
          <ThirdStep register={register} getValues={getValues} />
        )}
        {kind === 'file' && (
          <ImageStep
            register={register}
            useFile={useFile}
            recreation={recreation}
          />
        )}
        <button
          type='submit'
          className='my-3 py-2 w-100 rounded text-white font-weight-bold bg-primary border border-primary'
        >
          保存する
        </button>
      </form>
    </div>
  );
};
