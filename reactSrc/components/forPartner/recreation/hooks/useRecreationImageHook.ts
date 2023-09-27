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

  return {
    createRecreationImage,
    deleteRecreationImage,
  };
};
