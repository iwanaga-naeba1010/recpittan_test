import { FormKind, RecreationEditForm, RecreationFormValues } from '@/components/shared/form';
import { Error } from '@/components/shared/parts';
import { Api } from '@/infrastructure';
import { Recreation } from '@/types';
import { getQeuryStringValueByKey, isEmpty } from '@/utils';
import axios, { AxiosError } from 'axios';
import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom';

const RecreationEdit: React.FC = () => {
  const [errors, setErrors] = useState<Array<string>>([]);
  const [recreation, setRecreation] = useState<Recreation>(undefined);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const id = window.location.pathname.split('/')[3];
  const formKind = getQeuryStringValueByKey('formKind') as FormKind;

  useEffect(() => {
    (async () => {
      if (id === undefined) return;
      try {
        const recreaionResponse = await Api.get<Recreation>(`/recreations/${id}`, 'partner');
        console.log(recreaionResponse);
        setRecreation({ ...recreaionResponse.data });
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, [id]);

  const onSubmit = async (values: RecreationFormValues): Promise<void> => {
    setErrors([]);
    const requestBody: { [key: string]: Record<string, unknown> } = {
      recreation: {
        title: values.title,
        secondTitle: values.secondTitle,
        minutes: values.minutes,
        description: values.description,
        price: values.price,
        kind: values.kind,
        flowOfDay: values.flowOfDay,
        capacity: values.capacity || 0,
        materialPrice: values.materialPrice,
        extraInformation: values.extraInformation,
        youtubeId: values.youtubeId,
        borrowItem: values.borrowItem,
        bringYourOwnItem: '', // TODO(okubo): 追加が必要
        additionalFacilityFee: values.additionalFacilityFee,
        imageUrl: values.imageUrl,
        // prefectures: values.prefectures,
        category: values.category, // NOTE(okubo): idじゃないと保存できない
        // categoryId: values.categoryId,
        userId: values.userId,
        status: 'in_progress',
        // tags: values.tags,
        // targets: values.targets
        recreationProfileAttributes: { profileId: values.profileId },
        recreationPrefecturesAttributes: values.prefectures.map((p) => ({ name: p }))
      }
    };

    try {
      await Api.patch(`recreations/${id}`, 'partner', requestBody);
      window.location.href = '/partners/recreations';
      // TODO(okubo): redirectによる画面遷移
      //
    } catch (e) {
      if (axios.isAxiosError(e)) {
        setErrors((e as AxiosError<Array<string>>).response.data);
        console.log(e.response.data);
      }
    }
  };

  if (isLoading) {
    return <>読み込み中....</>;
  }

  return (
    <div>
      ugoita!
      {!isEmpty(errors) && <Error errors={errors} />}
      <RecreationEditForm kind={formKind} recreation={recreation} onSubmit={onSubmit} />
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#recreationEdit');
  if (elm) {
    ReactDOM.render(<RecreationEdit />, elm);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#recreationEdit');
  if (elm) {
    ReactDOM.render(<RecreationEdit />, elm);
  }
});
