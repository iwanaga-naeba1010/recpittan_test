import { FormKind, RecreationEditForm, RecreationFormValues } from '@/components/shared/form';
import { Error, LoadingContainer } from '@/components/shared/parts';
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
        title: values.title || recreation.title,
        secondTitle: values.secondTitle || recreation.secondTitle,
        minutes: values.minutes || recreation.minutes,
        description: values.description || recreation.description,
        price: values.price || recreation.price,
        kind: values.kind || recreation.kind,
        flowOfDay: values.flowOfDay || recreation.flowOfDay,
        capacity: values.capacity || recreation.capacity,
        materialPrice: values.materialPrice || recreation.materialPrice,
        extraInformation: values.extraInformation || recreation.extraInformation,
        youtubeId: values.youtubeId || recreation.youtubeId,
        borrowItem: values.borrowItem || recreation.borrowItem,
        bringYourOwnItem: '', // TODO(okubo): 追加が必要
        additionalFacilityFee: values.additionalFacilityFee || recreation.additionalFacilityFee,
        imageUrl: values.imageUrl,
        category: values.category || recreation.category.key, // NOTE(okubo): idじゃないと保存できない
        userId: recreation.userId,
        status: 'in_progress',
        recreationProfileAttributes: { profileId: values.profileId },
        recreationPrefecturesAttributes: values.prefectures.map((p) => ({ name: p }))
      }
    };

    console.log(requestBody);

    try {
      await Api.patch(`recreations/${id}`, 'partner', requestBody);
      const noticeText = 'レクを更新しました！';
      window.location.href = `/partners/recreations/${id}?notice=${noticeText}`;
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
    return <LoadingContainer />;
  }

  return (
    <div>
      {!isEmpty(errors) && <Error errors={errors} />}
      <RecreationEditForm kind={formKind} recreation={recreation} setRecreation={setRecreation} onSubmit={onSubmit} />
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
