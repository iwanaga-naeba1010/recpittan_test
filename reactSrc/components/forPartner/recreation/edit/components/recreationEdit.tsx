import { FormKind, RecreationEditForm, RecreationFormValues } from '@/components/shared/form';
import { Error, LoadingContainer } from '@/components/shared/parts';
import { Api } from '@/infrastructure';
import { Recreation } from '@/types';
import { RecreationImage } from '@/types/recreationImage';
import { getQueryStringValueByKey, isEmpty } from '@/utils';
import axios, { AxiosError } from 'axios';
import React, { useEffect, useState } from 'react';
import { createRoot } from 'react-dom/client';
import { useRecreation, UseRecreationUpdate } from '../../hooks';

export type UseFile = {
  handleFileAdd: (files: FileList | null, kind: string) => void;
  handleFileDelete: (id: number) => Promise<void>;
  isLoading: boolean;
};

const RecreationEdit: React.FC = () => {
  const [errors, setErrors] = useState<Array<string>>([]);
  const [recreation, setRecreation] = useState<Recreation>();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isFileLoading, setIsFileLoading] = useState<boolean>(false);
  const id = window.location.pathname.split('/')[3];
  const formKind = getQueryStringValueByKey('formKind') as FormKind;
  const { fetchRecreation } = useRecreation();
  const { updateRecreation } = UseRecreationUpdate();

  useEffect(() => {
    (async () => {
      if (id === undefined) return;
      try {
        const recreationResponse = await fetchRecreation(id);
        console.log(recreationResponse);
        setRecreation({ ...recreationResponse });
        setIsLoading(false);
      } catch (e) {
        console.warn('error is', e);
      }
    })();
  }, [fetchRecreation, id]);

  const handleFileAdd = (files: FileList | null, kind = 'slider') => {
    if (!files || files.length <= 0) return;
    if (!recreation) return;
    const file = files[0];
    const reader = new FileReader();
    reader.onload = async (event) => {
      if (event.target?.result && typeof event.target?.result === 'string') {
        const requestBody: { [key: string]: Record<string, unknown> } = {
          recreationImage: {
            image: event.target?.result,
            filename: file.name,
            kind: kind
          }
        };
        setIsFileLoading(true);
        const createdImage = await Api.post<RecreationImage>(
          `recreations/${recreation.id}/recreation_images`,
          'partner',
          requestBody
        );
        setRecreation({ ...recreation, images: [...recreation.images, createdImage.data] });
        setIsFileLoading(false);
      }
    };
    reader.readAsDataURL(file);
  };

  const handleFileDelete = async (id: number): Promise<void> => {
    if (!recreation) return;
    try {
      await Api.delete(`recreations/${recreation.id}/recreation_images/${id}`, 'partner', {});
      setRecreation({ ...recreation, images: recreation.images.filter((recreation) => recreation.id !== id) });
    } catch (e) {
      console.log(e);
    }
  };

  const onSubmit = async (values: RecreationFormValues): Promise<void> => {
    setErrors([]);
    if (!recreation) return;
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
      await updateRecreation(id, requestBody);
      const noticeText = 'レクを更新しました！';
      window.location.href = `/partners/recreations/${id}?notice=${noticeText}`;
      // TODO(okubo): redirectによる画面遷移
      //
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

  if (isLoading) {
    return <LoadingContainer />;
  }
  if (!recreation) {
    return <></>;
  }
  return (
    <div>
      {!isEmpty(errors) && <Error errors={errors} />}
      <RecreationEditForm
        kind={formKind}
        recreation={recreation}
        setRecreation={setRecreation}
        onSubmit={onSubmit}
        useFile={{ handleFileAdd, handleFileDelete, isLoading: isFileLoading }}
      />
    </div>
  );
};

// NOTE: 画面遷移した時用
document.addEventListener('turbolinks:load', () => {
  const elm = document.querySelector('#recreationEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationEdit />);
  }
});

// NOTE: リフレッシュした時用
$(document).ready(() => {
  const elm = document.querySelector('#recreationEdit');
  if (elm) {
    const root = createRoot(elm);
    root.render(<RecreationEdit />);
  }
});
