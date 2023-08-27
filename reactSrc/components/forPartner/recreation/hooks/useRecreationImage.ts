import { Api } from "@/infrastructure";
import { RecreationImage } from '@/types/recreationImage';

type UseRecreationCreateImagesHook = {
  createRecreationImage: (recreationId: number, requestBody: { [key: string]: Record<string, unknown> }) => Promise<RecreationImage>;
};

export const useRecreationCreateImage = (): UseRecreationCreateImagesHook => {
  const createRecreationImage = async (recreationId: number, requestBody: { [key: string]: Record<string, unknown> }): Promise<RecreationImage> => {
    const response = await Api.post<RecreationImage>(
      `recreations/${recreationId}/recreation_images`,
      'partner',
      requestBody
    );
    return response.data;
  }

  return {
    createRecreationImage,
  }
}

type UseRecreationDeleteImageHook = {
  deleteRecreationImage: (recreationId: number, recreationImageId: number) => Promise<void>;
};

export const useRecreationDeleteImage = (): UseRecreationDeleteImageHook => {
  const deleteRecreationImage = async (recreationId: number, recreationImageId: number): Promise<void> => {
    await Api.delete(`recreations/${recreationId}/recreation_images/${recreationImageId}`, "partner");
  }

  return {
    deleteRecreationImage,
  }
}
