import {
  RecreationFormValues,
  RecreationNewForm,
} from '@/components/shared/form';
import { Error } from '@/components/shared/parts';
import { isEmpty } from '@/utils';
import axios, { AxiosError } from 'axios';
import React, { useState } from 'react';
import { createRoot } from 'react-dom/client';
import { useRecreations } from '../../hooks';

const RecreationNew: React.FC = () => {
  const [errors, setErrors] = useState<Array<string>>([]);
  const { createRecreation } = useRecreations();

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
        bringYourOwnItem: values.bringYourOwnItem,
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
        recreationPrefecturesAttributes: values.prefectures.map((p) => ({
          name: p,
        })),
      },
    };

    try {
      const createdRecreation = await createRecreation(requestBody);
      const noticeText =
        'レクを追加しました！レク画像・ファイルを追加より画像のアップをお願いします。';
      window.location.href = `/partners/recreations/${createdRecreation.id}?notice=${noticeText}`;
    } catch (e) {
      if (axios.isAxiosError(e)) {
        const axiosError = e as AxiosError<Array<string>>;
        if (axiosError.response) {
          setErrors(axiosError.response.data);
          console.log(axiosError.response.data);
        }
      }
    }
  };

  return (
    <div>
      {!isEmpty(errors) && <Error errors={errors} />}
      <RecreationNewForm onSubmit={onSubmit} />
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#recreationNew');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationNew />);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#recreationNew');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationNew />);
  }
});
