import { Api } from '@/infrastructure';
import { RecreationImage } from '@/types/recreationImage';

type UseRecreationImagesHook = {
  createRecreationImage: (
    recreationId: number,
    requestBody: { [key: string]: Record<string, unknown> }
  ) => Promise<RecreationImage>;
  deleteRecreationImage: (
    recreationId: number,
    recreationImageId: number
  ) => Promise<void>;
  changeTitleRecreationImage: (
    recreationId: number,
    recreationImageId: number,
    requestBody: { [key: string]: Record<string, unknown> }
  ) => Promise<void>;
};

export const useRecreationImage = (): UseRecreationImagesHook => {
  const createRecreationImage = async (
    recreationId: number,
    requestBody: { [key: string]: Record<string, unknown> }
  ): Promise<RecreationImage> => {
    const response = await Api.post<RecreationImage>(
      `recreations/${recreationId}/recreation_images`,
      'partner',
      requestBody
    );
    return response.data;
  };
  const deleteRecreationImage = async (
    recreationId: number,
    recreationImageId: number
  ): Promise<void> => {
    await Api.delete(
      `recreations/${recreationId}/recreation_images/${recreationImageId}`,
      'partner'
    );
  };

  const changeTitleRecreationImage = async (
    recreationId: number,
    recreationImageId: number,
    requestBody: { [key: string]: Record<string, unknown> }
  ): Promise<void> => {
    await Api.patch(
      `recreations/${recreationId}/recreation_images/${recreationImageId}/change_title`,
      'partner',
      requestBody
    );
  };

  const downloadRecreationImage = async (imageUrl: string): Promise<void> => {
    return await Api.get<Blob>(
      `recreation_images/download`,
      'partner',
      { url: imageUrl },
      'blob'
    );
  };

  return {
    createRecreationImage,
    deleteRecreationImage,
    downloadRecreationImage,
    changeTitleRecreationImage,
  };
};
